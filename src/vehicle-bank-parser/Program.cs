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
        List<string> t = new List<string>(tags.Split(new char[] { ' ', '\t', '\n', '\r' }, StringSplitOptions.RemoveEmptyEntries));
        if (t.Contains("lightTank"))
            return "LT";
        if (t.Contains("mediumTank"))
            return "MT";
        if (t.Contains("heavyTank"))
            return "HT";
        if (t.Contains("AT-SPG"))
            return "TD";
        if (t.Contains("SPG"))
            return "SPG";
        throw new Exception("Cannot find vehicle class:\n  " + tags);
    }

    static void Main(string[] args)
    {
        try
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

            // sort order: level -> type -> nation -> name
            vehicles.Sort((a, b) =>
            {
                var n = a.level - b.level;
                if (n != 0)
                    return n;
                n = Defines.TYPES.IndexOf(a.type) - Defines.TYPES.IndexOf(b.type);
                if (n != 0)
                    return n;
                n = Defines.COUNTRIES.IndexOf(a.nation) - Defines.COUNTRIES.IndexOf(b.nation);
                if (n != 0)
                    return n;
                return String.Compare(a.name, b.name, true);
            });

            Export.generateAS2code(vehicles);
        }
        catch (Exception ex)
        {
            Console.WriteLine("Error:\n" + ex.ToString());
        }
    }
}
