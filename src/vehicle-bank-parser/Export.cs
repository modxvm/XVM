﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.IO;

static class Export
{
    /**
     * Metaprogramming.
     * Make actionscript 2 code file with predefined array of obtained name\hp\turret data.
     */

    //private const string EXPORT_FILEPATH = @"C:\temp\TurretStatusDatabase.as";
    private const string EXPORT_FILEPATH = @"D:\xvm\src\xvm\src\wot\VehicleMarkersManager\components\TurretStatusDatabase.as";

    public static void AS2(List<Vehicle> vehList)
    {
        StreamWriter file = new StreamWriter(EXPORT_FILEPATH, false, Encoding.GetEncoding(1250));

        //StreamWriter file = new StreamWriter(EXPORT_FILEPATH);

        writeHeader(file);
        writeCsv(file, vehList);
        writeFooter(file);
        
        file.Close();
    }

    private static void writeHeader(StreamWriter file)
    {
        file.WriteLine(
@"/** 
* This file is automatically generated by VehicleBankParser program.
* Data extracted from WoT version 0.8.0
*/
        
class wot.VehicleMarkersManager.components.TurretStatusDatabase
{
    /**
    * Vehicles in list has two turret modules.
    * Format:
    * vehicel name, stock max hp, turret status
    * Turret status: 2 - unable to mount top gun to stock turret, 1 - able
    */
        
    private static var db:Array;

    public static function getDb():Array
    {
        if(db == null)
        {
            db = new Array();");
    }
            
    private static void writeCsv(StreamWriter file, List<Vehicle> vehList)
    {
        foreach (Vehicle veh in vehList)
            file.WriteLine("            db[\"" + veh.name + "\"] = new Array(" + veh.hpstock + ", " + veh.status + ");");
        //         = new Array()

    }

    private static void writeFooter(StreamWriter file)
    {
file.WriteLine(@"
        }
        return db;
    }
}
    ");
    }
}

