using System;
using System.Collections.Generic;
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

    public const String TYPE_LT = "LT";
    public const String TYPE_MT = "MT";
    public const String TYPE_HT = "HT";
    public const String TYPE_TD = "TD";
    public const String TYPE_SPG = "SPG";

    public int vid;
    public int tankId;
    public string name;
    public string nation;
    public int level;
    private string type;
    public bool premium;
    public int hpstock;
    public int hptop;
    public short status;
    public string shortUserString;

    /*
     * Tanks are subset of Vehicles.
     * Tanks has turrets rotation and are subject of interest.
     */

    public Vehicle(XmlNode vdata)
    {
        VehicleXmlParser parser = new VehicleXmlParser(vdata);
        hpstock = parser.getHpStock();
        hptop = parser.getHpTop();
        status = defineStatus(parser);
    }

    public void setType(string tags)
    {
        List<string> t = new List<string>(tags.Split(new char[] { ' ', '\t', '\n', '\r' }, StringSplitOptions.RemoveEmptyEntries));

        if (t.Contains("lightTank"))
            type = TYPE_LT;
        else if (t.Contains("mediumTank"))
            type = TYPE_MT;
        else if (t.Contains("heavyTank"))
            type = TYPE_HT;
        else if (t.Contains("AT-SPG"))
            type = TYPE_TD;
        else if (t.Contains("SPG"))
            type = TYPE_SPG;
        else throw new Exception("Cannot find vehicle class:\n  " + tags);
    }

    public String getType()
    {
        return type;
    }

    private short defineStatus(VehicleXmlParser parser)
    {
        if (parser.hasOnlyOneTurret())
            return ONLY_ONE_TURRET;

        /**
         * Some britain SPGs has absolutely two equal turrets but one of them is not used by WG interface.
         * WG screwed up again.
         * Ignore this turret.
         * 
         * As for 10 aug 2013 the screwed SPGs are:
         * gb27_sexton, amx_ob_am105, gb77_fv304, su14_1, gb29_crusader_5inch
         */
        if (parser.turretsHasEqualHP())
            return ONLY_ONE_TURRET;

        if (parser.turretUnlocksSomething())
        {
            XmlNodeList unlocks = parser.getSecondTurretUnlocks();
            List<XmlNode> guns = parser.separateGuns(unlocks);
            int maxUnlockedGunCost = parser.mostExpensive(guns);
            int chassisCost = parser.getChassisCost();
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
