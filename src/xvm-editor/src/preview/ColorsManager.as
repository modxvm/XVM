package preview
{

import com.xvm.Config;

public class ColorsManager
{
    /**
     * Return vehicle marker frame name for current state
     *
     * VehicleMarkerAlly should contain 4 named frames:
     *   - green - normal ally
     *   - gold - squad mate
     *   - blue - teamkiller
     * VehicleMarkerEnemy should contain 2 named frames:
     *   - red - normal enemy
     * @param	entityName EntityName
     * @param	isColorBlindMode CB mode flag
     * @return	name of marker frame
     */
    public static function getMarkerColorAlias(entityName:String):String
    {
        //if (m_entityName != "ally" && m_entityName != "enemy" && m_entityName != "squadman" && m_entityName != "teamKiller")
        //  Logger.add("m_entityName=" + m_entityName);
        if (entityName == "ally")
            return "green";
        if (entityName == "squadman")
            return "gold";
        if (entityName == "teamKiller")
            return "blue";
        if (entityName == "enemy")
            return "red";

        // if not found (node is not implemented), return inverted enemy color (for debug only)
        // TODO: throw error may be better?
        return "purple";
    }

    /**
     * Get system color value for current state
     */
    public static function getSystemColor(entityName:String, isDead:Boolean, isBlowedUp:Boolean):Number
    {
        var key: String = entityName + "_";
        key += !isDead ? "alive" : isBlowedUp ? "blowedup" : "dead";
        //com.xvm.Logger.add("getSystemColor():" + key + " " + Config.s_config.colors.system[key]);
        return parseInt(Config.config.colors.system[key]);
    }

    public static function getDamageSystemColor(damageSource:String, damageDest:String, damageType:String,
        isDead:Boolean, isBlowedUp:Boolean):Number
    {
        switch (damageType)
        {
            case "world_collision":
            case "death_zone":
            case "drowning":
                return parseInt(Config.config.colors.dmg_kind[damageType]);

            case "attack":
            case "fire":
            case "ramming":
            default:
                var key:String = damageSource + "_" + damageDest + "_";
                key += !isDead ? "hit" : isBlowedUp ? "blowup" : "kill";
                return parseInt(Config.config.colors.damage[key]);
        }
    }
}

}
