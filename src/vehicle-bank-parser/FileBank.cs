using System;
using System.IO;
using System.Collections.Generic;
using RT.Util.Json;

class FileBank
{
    /**
     * Stores all country/*.xml files data decoded to JsonDict
     * Author: ilitvinov87@gmail.com
     */
    
    private const String VEHICLE_DIR_PATH = @"res\scripts\item_defs\vehicles\";
    private const String GAME_PATH = @"D:\Program Files\World_of_Tanks\";
    static readonly String[] COUNTRIES = new String[] { "ussr", "germany", "usa", "france", "china", "uk" };

    private List<JsonDict> files = new List<JsonDict>();

    public FileBank()
    {
        foreach (string onefile in fileList())
            saveToState(decode(onefile));
    }

    public List<JsonDict> getBank()
    {
        return files;
    }

    private string[] fileList()
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

    private List<string> countryPathList()
    {
        List<string> pathList = new List<string>();
        foreach ( string country in COUNTRIES)
            pathList.Add(Path.Combine(GAME_PATH, VEHICLE_DIR_PATH, country));
        
        // returns *\vehicles\ussr, *\vehicles\germany, *\vehicles\usa
        return pathList;
    }

    private JsonDict decode(string file)
    {
        return BxmlReader.ReadFile(file);
    }

    private void saveToState(JsonDict dict)
    {
        files.Add(dict);
    }
}
