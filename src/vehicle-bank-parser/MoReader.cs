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
using System.Text.RegularExpressions;
using System.Xml;

namespace TankDataConverter
{
    static class MoReader
    {
        public static IDictionary<string, string> ReadFile(string filename)
        {
            using (var reader = new BinaryReader(File.Open(filename, FileMode.Open, FileAccess.Read, FileShare.Read)))
                return ReadFile(reader);
        }

        public static IDictionary<string, string> ReadFile(BinaryReader reader)
        {
            if (reader.ReadUInt32() != 0x950412DE)
                throw new Exception("This file does not look like a valid .mo file");
            reader.BaseStream.Position = 8;
            int entries = reader.ReadInt32();
            int unknown1 = reader.ReadInt32();
            int unknown2 = reader.ReadInt32();
            int unknown3 = reader.ReadInt32();
            int unknown4 = reader.ReadInt32();
            var result = new Dictionary<string, string>();
            for (int i = 0; i < entries; i++)
            {
                var key = readString(reader, 28 + 8 * i);
                var value = readString(reader, 28 + 8 * (i + entries));
                result[key] = value;
            }
            return result;
        }

        private static string readString(BinaryReader reader, int offset)
        {
            reader.BaseStream.Position = offset;
            int count = reader.ReadInt32();
            reader.BaseStream.Position = reader.ReadInt32();
            return Encoding.UTF8.GetString(reader.ReadBytes(count));
        }
    }
}
