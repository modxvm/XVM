/**
* Based on WoTModTools by katzsmile
* https://github.com/katzsmile/WoTModTools
*/
using System;
using System.Collections.Generic;
using System.IO;
using System.Xml;
using Packed_Section_Reader;

public partial class BxmlReader
{
    public string PackedFileName = "";
    public XmlDocument xDoc;

    public BxmlReader(string args)
    {
        readFile(args);
    }
    
    public XmlDocument getFile()
    {
        return xDoc;
    }

    private void readFile(string file)
    {
        xDoc = new XmlDocument();
        PackedFileName = Path.GetFileName(file);
        PackedFileName = PackedFileName.ToLower();
        FileStream F = new FileStream(file, FileMode.Open, FileAccess.Read);
        BinaryReader reader = new BinaryReader(F);
        Int32 head = reader.ReadInt32();

        if (head == Packed_Section.Packed_Header)
            DecodePackedFile(reader);
        else
            throw new IOException("Invalid header");

        reader.Close();
        F.Close();
    }

    private void DecodePackedFile(BinaryReader reader)
    {
        reader.ReadSByte();
        Packed_Section packedSection = new Packed_Section();

        List<string> dictionary = packedSection.readDictionary(reader);
        XmlNode xmlroot = xDoc.CreateNode(XmlNodeType.Element, PackedFileName, "");

        packedSection.readElement(reader, xmlroot, xDoc, dictionary);
        xDoc.AppendChild(xmlroot);
    }
}

