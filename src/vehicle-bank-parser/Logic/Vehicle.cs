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
    * Top turret secondChassis new gun.
    * Player with stock turret can not mount top gun.
    * High vulnerability.
    */
    public const short STOCK_TURRET_NO_TOP_GUN = 2;

    public string name;
    public int hpstock;
    public int hptop;
    public short status;

    private VehicleXmlParser vehParser;

    /*
     * Tanks are subset of Vehicles.
     * Tanks has turrets rotation and are subject of interest.
     */

    public Vehicle(XmlNode vehicleXml)
    {
        vehParser = new VehicleXmlParser(vehicleXml);

        name = vehParser.getVehicleName();
        hpstock = vehParser.getHpStock();
        hptop = vehParser.getHpTop();
        status = defineStatus();
    }

    private short defineStatus()
    {
        if (vehParser.hasOnlyOneTurret())
            return ONLY_ONE_TURRET;

        if (vehParser.turretUnlocksSomething())
        {
            XmlNodeList unlocks = vehParser.getSecondTurretUnlocks();
            List<XmlNode> guns = vehParser.separateGuns(unlocks);
            int maxUnlockedGunCost = vehParser.mostExpensive(guns);
            int chassisCost = vehParser.getChassisCost();
            return unlockedGunIsTotalCrap(maxUnlockedGunCost, chassisCost);
        }

        return STOCK_TURRET_TOP_GUN_POSSIBLE;
    }

    private short unlockedGunIsTotalCrap(int maxUnlockedGunCost, int chassisCost)
    {
        // Looks like only Patton and Pershing are affected by this. Could be done manually.
        // Now have to switch T-50-2 manually to status-2
        if (chassisCost > maxUnlockedGunCost * 4)
            /*
             * *3 <- low level tanks have top guns cost much less than chassis
             * if Gun unlocked by second turret is crap -> top gun is possible to mount at stock turret
             */
            return STOCK_TURRET_TOP_GUN_POSSIBLE;

        return STOCK_TURRET_NO_TOP_GUN;
    }
}
