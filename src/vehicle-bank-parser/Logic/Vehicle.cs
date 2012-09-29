using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Xml;

class Vehicle
{
   /**
    * Can not define rootNode modules vulnerability status.
    * This type of vehicles are not a subject of interest.
    */
    public const short ONLY_ONE_TURRET = 0;

   /**
    * Top turret does not unlock new gun.
    * Player with stock turret can mount top gun.
    * Low vulnerability.
    */
    public const short STOCK_TURRET_TOP_GUN_POSSIBLE = 1;

   /**
    * Top turret unlocks new gun.
    * Player with stock turret can not mount top gun.
    * High vulnerability.
    */
    public const short STOCK_TURRET_NO_TOP_GUN = 2;

    public string name;
    public int hpstock;
    public short status;

    private VehicleXmlParser vehicleParser;

    /*
     * Tanks are subset of Vehicles.
     * Tanks has turrets rotation and are subject of interest. 
     */

    public Vehicle(XmlNode vehicleXml)
    {
        vehicleParser = new VehicleXmlParser(vehicleXml);

        name = vehicleParser.getVehicleName();
        hpstock = vehicleParser.getHpStock();
        status = defineStatus();
    }

    private short defineStatus()
    {
        if (vehicleParser.hasOnlyOneTurret())
            return ONLY_ONE_TURRET;

        if (vehicleParser.turretUnlocksSomeGun())
            return unlockedGunIsTotalCrap();
        
        return STOCK_TURRET_TOP_GUN_POSSIBLE;
    }

    private short unlockedGunIsTotalCrap()
    {
        // Looks like only Patton and Pershing are affected by this. Could be done manually.
        // Now have to switch T-50-2 manually to status-2
        if (vehicleParser.getChassisCost() > vehicleParser.getUnlockedGunCost() * 4)
            /*
             * *3 <- low level tanks have top guns cost much less than chassis
             * if Gun unlocked by second turret is crap -> top gun is possible to mount at stock turret
             */
            return STOCK_TURRET_TOP_GUN_POSSIBLE;
        
        return STOCK_TURRET_NO_TOP_GUN;
    }
}

