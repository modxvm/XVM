using System;
using System.Diagnostics;
using System.Collections.Generic;
using System.Xml;

class Program
{
    /**
     * Program purpose:
     *  Get vehicleList xmlNodeVehicleList with secondary turret modules equippable and corresponding HP.
     *  List is then used in XVM to add stock\top turret tank marker.
     * Author: ilitvinov87@gmail.com
     */

    static void Main(string[] args)
    {
        FileBank.readXmlFiles();
        FileBank.removeNonVehicleNodes();


        List<Vehicle> vehicles = new List<Vehicle>();
        foreach (XmlNode vehicleXml in FileBank.xmlNodeVehicleList())
            vehicles.Add(new Vehicle(vehicleXml));

        /*
         * Tanks are subset of Vehicles.
         * Tanks has turrets rotation and are subject of interest. 
         */
        List<Vehicle> tanks = new List<Vehicle>();
        foreach (Vehicle veh in vehicles)
        {
            // Manually switch T-50-2 status
            if (veh.name == "t_50_2")
                veh.status = Vehicle.STOCK_TURRET_NO_TOP_GUN;

            //if (veh.status != Vehicle.ONLY_ONE_TURRET)
            tanks.Add(veh);
        }

        Export.generateAS2code(tanks);
 
    }
}
