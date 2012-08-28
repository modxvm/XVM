using System;
using System.Diagnostics;
using System.Collections.Generic;

class Program
{
    /**
     * Program purpose:
     *  Get vehicleList list with secondary turret modules equippable and corresponding HP.
     *  List is then used in XVM to add stock\top turret tank marker.
     * Author: ilitvinov87@gmail.com
     */

    static void Main(string[] args)
    {
        FileBank.readXmlFiles();
        DeleteNonVehicleFiles.modify(FileBank.list());
        List<Vehicle> vehicles = Parser.parseFiles(FileBank.list());

        //"\"crew\":"
        // - Define stock\top vehicleList + max hitpoints
            
        // Make CSV bank
    }
}
