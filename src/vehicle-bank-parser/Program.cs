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
        Export.AS2(Parser.parseFiles(FileBank.list()));
    }
}
