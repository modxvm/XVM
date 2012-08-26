/**
 * Based on Tank Icon Maker by Roman Starkov
 * https://bitbucket.org/rstarkov/tankdataconverter
 * GPLv3
 */
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using RT.Util.Json;

namespace TankDataConverter
{
    static class BxmlReader
    {
        public static JsonDict ReadFile(string filename)
        {
            using (var reader = new BinaryReader(File.Open(filename, FileMode.Open, FileAccess.Read, FileShare.Read)))
                return ReadFile(reader);
        }

        public static JsonDict ReadFile(BinaryReader reader)
        {
            if (reader.ReadUInt32() != 0x62A14E45)
                throw new Exception("This file does not look like a valid binary-xml file");

            reader.ReadByte(); // a 0 byte

            var strings = new List<string>();
            while (true)
            {
                var sb = new StringBuilder();
                while (true)
                {
                    var b = reader.ReadByte();
                    if (b == 0)
                        break;
                    else if ((b & 0x80) == 0)
                        sb.Append((char) b);
                    else if ((b & 0xE0) == 0xC0)
                        sb.Append((char) (((b & 0x1F) << 6) | (reader.ReadByte() & 0x3F)));
                    else if ((b & 0xF0) == 0xE0)
                        sb.Append((char) (((b & 0x0F) << 12) | ((reader.ReadByte() & 0x3F) << 6) | (reader.ReadByte() & 0x3F)));
                }
                if (sb.Length == 0)
                    break;
                strings.Add(sb.ToString());
            }

            return readDict(reader, strings);
        }

        private enum type { Dict = 0, String = 1, Int = 2, Floats = 3, Bool = 4, Base64 = 5 }

        private static JsonDict readDict(BinaryReader reader, List<string> strings)
        {
            int childCount = reader.ReadInt16();

            int endAndType = reader.ReadInt32();
            var lengthSelf = endAndType & 0x0fffffff;
            var typeSelf = (type) (endAndType >> 28);
            if (typeSelf == type.Dict)
                throw new Exception();

            int prevEnd = lengthSelf;
            var children = Enumerable.Range(0, childCount).Select(_ =>
            {
                var name = strings[reader.ReadInt16()];
                endAndType = reader.ReadInt32();
                var end = endAndType & 0x0fffffff;
                var length = end - prevEnd;
                prevEnd = end;
                return new { name, length, type = (type) (endAndType >> 28) };
            }).ToArray();

            var result = new JsonDict();
            if (lengthSelf > 0 || typeSelf != type.String)
                result[""] = readData(reader, strings, typeSelf, lengthSelf);

            foreach (var child in children)
                result[child.name] = readData(reader, strings, child.type, child.length);

            return result;
        }

        private static JsonValue readData(BinaryReader reader, List<string> strings, type type, int length)
        {
            switch (type)
            {
                case type.Dict:
                    return readDict(reader, strings);
                case type.String:
                    return new JsonString(new string(reader.ReadChars(length), 0, length));
                case type.Int:
                    switch (length)
                    {
                        case 0:
                            return new JsonNumber(0);
                        case 1:
                            return new JsonNumber(reader.ReadSByte());
                        case 2:
                            return new JsonNumber(reader.ReadInt16());
                        case 4:
                            return new JsonNumber(reader.ReadInt32());
                        default:
                            throw new Exception();
                    }
                case type.Floats:
                    var floats = new List<JsonNumber>();
                    for (int i = 0; i < length / 4; i++)
                        floats.Add(reader.ReadSingle());
                    if (floats.Count == 1)
                        return floats[0];
                    else
                        return new JsonList(floats);
                case type.Bool:
                    bool value = length == 1;
                    if (value && reader.ReadSByte() != 1)
                        throw new Exception("Boolean error");
                    return new JsonBool(value);
                case type.Base64:
                    var b64 = Convert.ToBase64String(reader.ReadBytes(length)); // weird one: bytes -> base64 where the base64 looks like a normal string
                    return new JsonString(b64);
                default:
                    throw new Exception("Unknown type");
            }
        }
    }
}
