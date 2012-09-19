/**
 * Helper class with various xvm-related static functions
 */
import wot.utils.Config;

class wot.VehicleMarkersManager.XvmHelper
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
    static public function getMarkerColorAlias(entityName, isColorBlindMode):String
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
    static public function getSystemColor(entityName:String, isDead:Boolean, isBlowedUp:Boolean, isColorBlindMode:Boolean):Number
    {
        var systemColorName: String = entityName + "_";
        systemColorName += !isDead ? "alive_" : isBlowedUp ? "blowedup_" : "dead_";
        systemColorName += isColorBlindMode ? "blind" : "normal";
        return Config.s_config.colors.system[systemColorName];
    }
}
