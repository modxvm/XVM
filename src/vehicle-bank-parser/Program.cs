using System;
using System.Collections.Generic;
using System.IO;
using System.Xml;
using VehicleBankParser.Properties;
using VehicleBankParser.Renderers;
using System.Globalization;
using VehicleBankParser.Utils;

class Program
{
    /**
     * Program purpose:
     *  Get vehicleList xmlNodeVehicleList with secondary turret modules equippable and corresponding HP.
     *  List is then used in XVM to add stock\top turret tank marker.
     * Author: ilitvinov87@gmail.com
     * Author: maca.pavel@gmail.com
     */

    private const string VEHICLE_DIR_PATH = "res\\scripts\\item_defs\\vehicles\\";

    static void Main()
    {
        try
        {
            if (!Directory.Exists(Settings.Default.GAME_PATH))
            {
                throw new FileNotFoundException("Specify correct WoT root folder");
            }

            List<Vehicle> vehicles = new List<Vehicle>();
            foreach (string country in Defines.COUNTRIES)
            {
                vehicles.AddRange(ListXmlParser.getVehicleByNation(country));
            }

            Export exporter = new Export(vehicles);
            exporter.genVehicleInfoData2();
            exporter.genVehicleInfoData2AS3();
            exporter.genVehicleNames();
            exporter.genVehicleInfo();
            //exporter.genVehicleInfoData(); need resolve sortNames & special matchmaking definition
        }
        catch (Exception ex)
        {
            Console.WriteLine("Error:\n" + ex);
        }

        #if DEBUG
                Console.WriteLine("Press any key to close...");
                Console.ReadKey();
        #endif
    }
}
