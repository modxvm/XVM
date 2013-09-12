/**
 * XVM
 * @author Maxim Schedriviy <m.schedriviy@gmail.com>
 */
package com.xvm.utils
{
    import com.xvm.*;
    import com.xvm.vehinfo.VehicleInfo;
    import org.idmedia.as3commons.util.StringUtils;

    public class MacrosUtil
    {
        public static function GetDynamicColorValueInt(type:Number, value:Number, darker:Boolean = false):int
        {
            return parseInt(GetDynamicColorValue(type, value, "0x", darker));
        }

        public static function GetDynamicColorValue(type:Number, value:Number, prefix:String = '#', darker:Boolean = false):String
        {
            if (isNaN(value))
                return "";

            var cfg_root:Object = Config.config.colors;
            var cfg:Array;
            switch (type)
            {
                case Defines.DYNAMIC_COLOR_HP:              cfg = cfg_root.hp; break;
                case Defines.DYNAMIC_COLOR_HP_RATIO:        cfg = cfg_root.hp_ratio; break;
                case Defines.DYNAMIC_COLOR_EFF:             cfg = cfg_root.eff; break;
                case Defines.DYNAMIC_COLOR_E:               cfg = cfg_root.e; break;
                case Defines.DYNAMIC_COLOR_WN:              cfg = cfg_root.wn; break;
                case Defines.DYNAMIC_COLOR_X:               cfg = cfg_root.x; break;
                case Defines.DYNAMIC_COLOR_RATING:          cfg = cfg_root.rating; break;
                case Defines.DYNAMIC_COLOR_KB:              cfg = cfg_root.kb; break;
                case Defines.DYNAMIC_COLOR_AVGLVL:          cfg = cfg_root.avglvl; break;
                case Defines.DYNAMIC_COLOR_TBATTLES:        cfg = cfg_root.t_battles; break;
                case Defines.DYNAMIC_COLOR_TDB:             cfg = cfg_root.tdb; break;
                case Defines.DYNAMIC_COLOR_TDV:             cfg = cfg_root.tdv; break;
                case Defines.DYNAMIC_COLOR_TFB:             cfg = cfg_root.tfb; break;
                case Defines.DYNAMIC_COLOR_TSB:             cfg = cfg_root.tsb; break;
                default: return "";
            }

            var cfg_len:int = cfg.length;
            for (var i:int = 0; i < cfg_len; ++i)
            {
                var cvalue:int = cfg[i].value;
                var color:int = Utils.toInt(cfg[i].color, 0xFFFFFF);
                if (value < cvalue)
                {
                    if (darker)
                        color = GraphicsUtil.darkenColor(color, 50);
                    return prefix + StringUtils.leftPad(color.toString(16), 6, "0");
                }
            }

            return "";
        }

        public static function GetDynamicAlphaValue(type:Number, value:Number):Number
        {
            if (isNaN(value))
                return 100;

            var cfg_root:Object = Config.config.alpha;
            var cfg:Array;
            switch (type)
            {
                case Defines.DYNAMIC_ALPHA_HP:              cfg = cfg_root.hp; break;
                case Defines.DYNAMIC_ALPHA_HP_RATIO:        cfg = cfg_root.hp_ratio; break;
                case Defines.DYNAMIC_ALPHA_EFF:             cfg = cfg_root.eff; break;
                case Defines.DYNAMIC_ALPHA_E:               cfg = cfg_root.e; break;
                case Defines.DYNAMIC_ALPHA_WN:              cfg = cfg_root.wn; break;
                case Defines.DYNAMIC_ALPHA_X:               cfg = cfg_root.x; break;
                case Defines.DYNAMIC_ALPHA_RATING:          cfg = cfg_root.rating; break;
                case Defines.DYNAMIC_ALPHA_KB:              cfg = cfg_root.kb; break;
                case Defines.DYNAMIC_ALPHA_AVGLVL:          cfg = cfg_root.avglvl; break;
                case Defines.DYNAMIC_ALPHA_TBATTLES:        cfg = cfg_root.t_battles; break;
                case Defines.DYNAMIC_ALPHA_TDB:             cfg = cfg_root.tdb; break;
                case Defines.DYNAMIC_ALPHA_TDV:             cfg = cfg_root.tdv; break;
                case Defines.DYNAMIC_ALPHA_TFB:             cfg = cfg_root.tfb; break;
                case Defines.DYNAMIC_ALPHA_TSB:             cfg = cfg_root.tsb; break;
              default: return 100;
            }

            var cfg_len:int = cfg.length;
            for (var i:int = 0; i < cfg_len; ++i)
            {
                var avalue:Number = cfg[i].value;
                var alpha:Number = cfg[i].alpha;
                if (value < avalue)
                    return alpha;
            }

            return 100;
        }

        public static function GetVTypeColorValue(icon:String, vtype:String, prefix:String = '#', darker:Boolean = false):String
        {
            try
            {
                var premium:Boolean = Config.config.colors.vtype.usePremiumColor == true;
                if (!vtype || premium)
                {
                    var vi2:Object = VehicleInfo.getInfo2ByIcon(icon);
                    if (vi2 != null)
                        vtype = (premium && vi2.premium == 1) ? "premium" : vi2.type;
                }
                if (!vtype || !Config.config.colors.vtype[vtype])
                    return null;
                var value:int = Utils.toInt(Config.config.colors.vtype[vtype], -1);
                if (value < 0)
                    return null;
                return prefix + StringUtils.leftPad(value.toString(16), 6, "0");
            }
            catch (ex:Error)
            {
                //Logger.add(ex.getStackTrace());
            }
            return null;
        }

        public static function GetDmgSrcColorValue(damageSource:String, damageDest:String, isDead:Boolean, isBlowedUp:Boolean, prefix:String = '#'):String
        {
            try
            {
                if (!damageSource || !damageDest)
                    return null;
                var key:String = damageSource + "_" + damageDest + "_";
                key += !isDead ? "hit" : isBlowedUp ? "blowup" : "kill";
                if (!Config.config.colors.damage[key])
                    return null;
                var value:int = Utils.toInt(Config.config.colors.damage[key], -1);
                if (value < 0)
                    return null;
                return prefix + StringUtils.leftPad(value.toString(16), 6, "0");
            }
            catch (ex:Error)
            {
                //Logger.add(ex.getStackTrace());
            }
            return null;
        }

        public static function GetDmgKindValue(dmg_kind:String, prefix:String = '#'):String
        {
            try
            {
                if (!dmg_kind || !Config.config.colors.dmg_kind[dmg_kind])
                    return null;
                var value:int = Utils.toInt(Config.config.colors.dmg_kind[dmg_kind], -1);
                if (value < 0)
                    return null;
                return prefix + StringUtils.leftPad(value.toString(16), 6, "0");
            }
            catch (ex:Error)
            {
                //Logger.add(ex.getStackTrace());
            }
            return null;
        }

        /**
         * Get system color value for current state
         */
        public static function GetSystemColor(entityName:String, isDead:Boolean, isBlowedUp:Boolean):Number
        {
            var key:String = entityName + "_";
            key += !isDead ? "alive" : isBlowedUp ? "blowedup" : "dead";
            //com.xvm.Logger.add("getSystemColor():" + key + " " + Config.s_config.colors.system[key]);
            return parseInt(Config.config.colors.system[key]);
        }

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
/*        public static function getMarkerColorAlias(entityName):String
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

        public static function getDamageSystemColor(damageSource:String, damageDest:String, damageType:String,
            isDead:Boolean, isBlowedUp:Boolean):Number
        {
            switch (damageType)
            {
                case "world_collision":
                case "death_zone":
                case "drowning":
                    return parseInt(Config.s_config.colors.dmg_kind[damageType]);

                case "attack":
                case "fire":
                case "ramming":
                default:
                    var key:String = damageSource + "_" + damageDest + "_";
                    key += !isDead ? "hit" : isBlowedUp ? "blowup" : "kill";
                    return parseInt(Config.s_config.colors.damage[key]);
            }
        }
*/
    }
}
