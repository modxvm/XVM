using System;
using System.Collections.Generic;
using System.Xml;
using System.Diagnostics;

class DeleteNonVehicleFiles
{
    /**
     * Remove non vehicle nodeFiles from list
     */
    public static void modify(List<XmlNode> files)
    {
        for (int i = 0; i < files.Count; i++)
            // FirstChild is empty - "", Next is <crew>
            if (files[i].FirstChild.NextSibling.Name != "crew")
                files.RemoveAt(i--); // list numeration changes -> decrement
    }
}