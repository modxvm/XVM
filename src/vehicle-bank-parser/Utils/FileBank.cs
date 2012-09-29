using System;
using System.Collections.Generic;
using System.IO;
using System.Xml;

static class FileBank
{
    /**
     * Stores all country/*.xml nodeFiles data decoded and parsed
     * Author: ilitvinov87@gmail.com
     */

    private const String VEHICLE_DIR_PATH = @"res\scripts\item_defs\vehicles\";
    private const String GAME_PATH = @"D:\WoT\";
    private static readonly String[] COUNTRIES = new String[] { "ussr", "germany", "usa", "france", "china", "uk" };

    private static List<XmlNode> nodeFiles = new List<XmlNode>();

    public static void readXmlFiles()
    {
        foreach (string onefile in fileList())
            saveToState(decode(onefile));

        sortBank(); // to simplify debug
    }

    public static void removeNonVehicleNodes()
    {
        for (int i = 0; i < nodeFiles.Count; i++)
            // FirstChild is empty - "", Next is <crew>
            if (nodeFiles[i].FirstChild.NextSibling.Name != "crew")
                nodeFiles.RemoveAt(i--); // xmlNodeVehicleList numeration changes -> decrement
    }

    public static List<XmlNode> xmlNodeVehicleList()
    {
        return nodeFiles;
    }

    // Internals

    private static string[] fileList()
    {
        List<string> fullList = new List<string>();
        foreach (string countryPath in countryPathList())
        {
            string[] listForOneCountry = Directory.GetFiles(countryPath, "*.xml");
            foreach (string onefile in listForOneCountry)
                fullList.Add(onefile);
        }
        return fullList.ToArray();
    }

    private static List<string> countryPathList()
    {
        List<string> pathList = new List<string>();
        foreach ( string country in COUNTRIES)
            pathList.Add(Path.Combine(GAME_PATH, VEHICLE_DIR_PATH, country));
        
        // returns *\vehicles\ussr, *\vehicles\germany, *\vehicles\usa
        return pathList;
    }

    private static XmlNode decode(string file)
    {
        BxmlReader reader = new BxmlReader(file);
        return reader.getFile().DocumentElement;
    }

    private static void saveToState(XmlNode file)
    {
        nodeFiles.Add(file);
    }

    private static void sortBank()
    { 
        nodeFiles.Sort(compareByFirstTag);
    }

    private static int compareByFirstTag(XmlNode x, XmlNode y)
    {
        return x.Name.CompareTo(y.Name);
    }
}
