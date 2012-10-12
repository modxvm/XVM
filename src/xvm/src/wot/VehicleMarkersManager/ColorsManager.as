/**
 * ...
 * @author Maxim Schedriviy
 */
import wot.utils.Config;
import net.wargaming.managers.ColorSchemeManager;

class wot.VehicleMarkersManager.ColorsManager
{
    public static var isColorBlindMode:Boolean = false;

    /**
     * Initialize WoT colors manager for detecting color blind mode
     */
    public static function initialize()
    {
        if (_instance == null)
            _instance = new ColorsManager();
    }

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

    // PRIVATE
    
    private static var _instance = null;

    private function ColorsManager()
    {
        ColorSchemeManager.initialize();
        ColorSchemeManager.instance.addChangeCallBack(this, "onChange")
        ColorSchemeManager.instance.update();
    }

    private function onChange()
    {
        //wot.utils.Logger.addObject(ColorSchemeManager._colors, "colors", 4);
        isColorBlindMode = ColorSchemeManager._colors.vm_enemy.aliasColor == "purple";
        //wot.utils.Logger.add("CB:" + isColorBlindMode);
    }
}