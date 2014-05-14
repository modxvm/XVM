using System;
using System.Collections.Generic;
using System.IO;
using System.Xml;
using VehicleBankParser.Properties;

namespace VehicleBankParser.Utils
{
    class ListXmlParser
    {
        private const string VEHICLE_DIR_PATH = "res\\scripts\\item_defs\\vehicles\\";

        /**
         * Parse Vehicles from list.xml
         */
        public static List<Vehicle> getVehicleByNation(String country)
        {
            String fPath = Path.Combine(Settings.Default.GAME_PATH, VEHICLE_DIR_PATH, country, "list.xml");

            XmlNodeList nodes = decodeXml(fPath).ChildNodes;

            List<Vehicle> vehicles = new List<Vehicle>();

            /** Process vehicles */
            foreach (XmlNode node in nodes)
            {
                Vehicle veh = getVehicle(node, country);
                if (veh != null)
                {
                    vehicles.Add(veh);
                }
            }
            return vehicles;
        }

        /**
         * Parse vehicle.xml 
         */
        private static Vehicle getVehicle(XmlNode node, String country)
        {
            XmlNode tags = node.SelectSingleNode("tags");
            if (tags == null)
            {
                Console.WriteLine("Skipping \"" + node.Name + "\", missing 'tags' node");
                return null;
            }


            if (tags.InnerText.Contains("observer"))
            {
                Console.WriteLine("Skipping \"" + node.Name + "\" - observer");
                return null;
            }

            XmlNode tankId = node.SelectSingleNode("id");
            if (tankId == null)
            {
                Console.WriteLine("Skipping \"" + node.Name + "\", missing 'id' node");
                return null;
            }

            XmlNode level = node.SelectSingleNode("level");
            if (level == null)
            {
                Console.WriteLine("Skipping \"" + node.Name + "\", missing 'level' node");
                return null;
            }

            XmlNode price = node.SelectSingleNode("price");
            if (price == null)
            {
                Console.WriteLine("Skipping \"" + node.Name + "\", missing 'price' node");
                return null;
            }

            XmlNode shortUserString = node.SelectSingleNode("shortUserString");
            if (shortUserString == null)
            {

                shortUserString = node.SelectSingleNode("userString");

                if (shortUserString == null)
                {
                    Console.WriteLine("Skipping \"" + node.Name + "\",  missing 'userString' and 'shortUserString' node");
                    return null;
                }
            }
            /*
            else
            {
                //TODO: issue #484 https://code.google.com/p/wot-xvm/issues/detail?id=484
                String s = shortUserString.InnerText;
                String l = node.SelectSingleNode("userString").InnerText;


                if (s.Remove(s.LastIndexOf("_short"), 6) != l)
                {
                    Console.WriteLine("short: " + shortUserString.InnerText);
                    Console.WriteLine("long: " + node.SelectSingleNode("userString").InnerText);
                }
            }*/

            /** Load vehicle xml */
            XmlNode vdata = decodeXml(Path.Combine(Settings.Default.GAME_PATH, VEHICLE_DIR_PATH, country, node.Name + ".xml"));
            if (vdata == null)
            {
                Console.WriteLine("Skipping \"" + node.Name + "\", can't decode vehicle .xml");
                return null;
            }


            Vehicle vehicle = new Vehicle(vdata)
            {
                vid = (int.Parse(tankId.InnerText) << 8) + (Array.IndexOf(Defines.COUNTRIES, country) << 4),
                tankId = int.Parse(tankId.InnerText),
                name = node.Name,
                nation = country,
                level = int.Parse(level.InnerText),
                premium = price.InnerXml.ToLower().Contains("<gold>"),
                shortUserString = shortUserString.InnerText,
            };
            vehicle.setType(tags.InnerText);

            return vehicle;
        }

        private static XmlNode decodeXml(String file)
        {
            if (!File.Exists(file))
            {
                throw new Exception("decodeXml: Can't find file to decode");
            }
            BxmlReader reader = new BxmlReader(file);
            return reader.getFile().DocumentElement;
        }
    }
}
