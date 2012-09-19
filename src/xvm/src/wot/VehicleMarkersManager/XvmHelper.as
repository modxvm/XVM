/**
 * Helper class with various xvm-related static functions
 */
import wot.utils.Config;
import wot.VehicleMarkersManager.ErrorHandler;

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
        var systemColorName: String = entityName + "_";
        systemColorName += !isDead ? "alive_" : isBlowedUp ? "blowedup_" : "dead_";
        systemColorName += isColorBlindMode ? "blind" : "normal";
        return Config.s_config.colors.system[systemColorName];
    }

    /**
     * Create TextFormat based on config
     */
    public static function createNewTextFormat(config_font: Object): TextFormat
    {
        try
        {
            if (!config_font)
                return null;

            return new TextFormat(
                config_font.name || "$FieldFont",
                config_font.size || 13,
                0x000000,
                config_font.bold,
                config_font.italic,
                false, null, null,
                config_font.align || "center",
                0, 0, 0, 0);
        }
        catch (e)
        {
            ErrorHandler.setText("ERROR: XVMCreateNewTextFormat():" + String(e));
        }

        return null;
    }
}
