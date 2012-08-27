using System;
using System.Collections.Generic;
using System.Xml;
using System.Diagnostics;

class Filter
{
    static List<XmlDocument> files;

    //[PermissionSetAttribute(SecurityAction.InheritanceDemand, Name = "FullTrust")]
    //public virtual XmlNode ReadNode(XmlReader reader);

    public static void process(FileBank bank)
    {
        files = bank.getBank();
        for (int i = 0; i < files.Count; i++)
            if (!isVehicle(files[i]) || !hasTwoTurrets(files[i]))
                files.RemoveAt(i);
    }
    
    // Keep vehicle files only
    private static Boolean isVehicle(XmlDocument file)
    {
        return file.FirstChild.FirstChild.NextSibling.Name == "crew";
    }

    // Keep vehicles two turret modules
    private static Boolean hasTwoTurrets(XmlDocument file)
    {
        //JsonValue turrets0 = dict.AsDict("turrets0");
        return true;
    }
}