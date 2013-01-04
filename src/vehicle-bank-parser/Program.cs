using System;
using System.Collections.Generic;
using System.IO;
using System.Xml;
using VehicleBankParser.Properties;

class Program
{
    /**
     * Program purpose:
     *  Get vehicleList xmlNodeVehicleList with secondary turret modules equippable and corresponding HP.
     *  List is then used in XVM to add stock\top turret tank marker.
     * Author: ilitvinov87@gmail.com
     */

    public static XmlNode decode(string file)
    {
        BxmlReader reader = new BxmlReader(file);
        return reader.getFile().DocumentElement;
    }

    private static string getVehicleType(string tags)
    {
        if (tags.Contains("lightTank"))
            return "LT";
        if (tags.Contains("mediumTank"))
            return "MT";
        if (tags.Contains("heavyTank"))
            return "HT";
        if (tags.Contains("AT-SPG"))
            return "TD";
        if (tags.Contains("SPG"))
            return "SPG";
        throw new Exception("Cannot find vehicle class:\n  " + tags);
    }

    static void Main(string[] args)
    {
        List<Vehicle> vehicles = new List<Vehicle>();
        foreach (string country in Defines.COUNTRIES)
        {
            string fn = Path.Combine(Settings.Default.GAME_PATH,
                Settings.Default.VEHICLE_DIR_PATH, country, "list.xml");
            XmlNodeList nodes = decode(fn).ChildNodes;
            foreach (XmlNode node in nodes)
            {
                XmlNode tags = node.SelectSingleNode("tags");
                if (tags == null)
                    continue;
                if (tags.InnerText.Contains("observer"))
                    continue;
                XmlNode level = node.SelectSingleNode("level");
                if (level == null)
                    continue;

                XmlNode vdata = decode(Path.Combine(Settings.Default.GAME_PATH,
                    Settings.Default.VEHICLE_DIR_PATH, country, node.Name + ".xml"));
                if (vdata == null)
                    continue;

                Vehicle vehicle = new Vehicle(vdata)
                {
                    name = node.Name,
                    nation = country,
                    level = int.Parse(level.InnerText),
                    type = getVehicleType(tags.InnerText),
                };
                vehicles.Add(vehicle);
            }
        }

        vehicles.Sort((a, b) =>
        {
            var n = a.level - b.level;
            if (n != 0)
                return n;
            n = String.Compare(a.nation, b.nation, true);
            if (n != 0)
                return n;
            return String.Compare(a.name, b.name, true);
        });

        Export.generateAS2code(vehicles);
    }
}
