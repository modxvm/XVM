package preview
{

import utils.Config;

public class ColorsManager
{
    /**
     * Return vehicle marker frame name for current state
     *
     * VehicleMarkerAlly should contain 4 named frames:
     *   - green - normal ally
     *   - gold - squad mate
     *   - blue - teamkiller
     *   - yellow - squad mate in color blind mode
     * VehicleMarkerEnemy should contain 2 named frames:
     *   - red - normal enemy
     *   - purple - enemy in color blind mode
     * @param	entityName EntityName
     * @param	isColorBlindMode CB mode flag
     * @return	name of marker frame
     */
    public static function getMarkerColorAlias(entityName, isColorBlindMode):String
    {
        //if (m_entityName != "ally" && m_entityName != "enemy" && m_entityName != "squadman" && m_entityName != "teamKiller")
        //  Logger.add("m_entityName=" + m_entityName);
        if (entityName == "ally")
            return "green";
        if (entityName == "squadman")
            return isColorBlindMode ? "yellow" : "gold";
        if (entityName == "teamKiller")
            return "blue";
        if (entityName == "enemy")
            return isColorBlindMode ? "purple" : "red";

        // if not found (node is not implemented), return inverted enemy color (for debug only)
        // TODO: throw error may be better?
        return isColorBlindMode ? "red" : "purple";
    }

    /**
     * Get system color value for current state
     */
    public static function getSystemColor(entityName:String, isDead:Boolean, isBlowedUp:Boolean, isColorBlindMode:Boolean):Number
    {
        var key: String = entityName + "_";
        key += !isDead ? "alive_" : isBlowedUp ? "blowedup_" : "dead_";
        key += isColorBlindMode ? "blind" : "normal";
        return parseInt(Config.s_config.colors.system[key]);
    }

    public static function getDamageSystemColor(damageSource:String, damageDest:String,
        isDead:Boolean, isBlowedUp:Boolean):Number
    {
        var key:String = damageSource + "_" + damageDest + "_";
        key += !isDead ? "hit" : isBlowedUp ? "blowup" : "kill";
        return parseInt(Config.s_config.colors.damage[key]);
    }
}

}
