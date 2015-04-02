/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.utils
{
    import com.xvm.*;
    import com.xvm.types.cfg.*;
    import com.xvm.types.veh.*;
    import org.idmedia.as3commons.util.*;

    public class MacrosUtil
    {
        public static function GetDynamicColorValueInt(type:Number, value:Number, darker:Boolean = false):int
        {
            return parseInt(GetDynamicColorValue(type, value, "0x", darker));
        }

        public static function GetDynamicColorValue(type:Number, value:Number, prefix:String = '#', darker:Boolean = false):String
        {
            if (isNaN(value))
                return null;

            var cfg_root:CColors = Config.config.colors;
            var cfg:Array;
            switch (type)
            {
                case Defines.DYNAMIC_COLOR_HP:              cfg = cfg_root.hp; break;
                case Defines.DYNAMIC_COLOR_HP_RATIO:        cfg = cfg_root.hp_ratio; break;
                case Defines.DYNAMIC_COLOR_EFF:             cfg = cfg_root.eff; break;
                case Defines.DYNAMIC_COLOR_E:               cfg = cfg_root.e; break;
                case Defines.DYNAMIC_COLOR_WN6:             cfg = cfg_root.wn6; break;
                case Defines.DYNAMIC_COLOR_WN8:             cfg = cfg_root.wn8; break;
                case Defines.DYNAMIC_COLOR_WGR:             cfg = cfg_root.wgr; break;
                case Defines.DYNAMIC_COLOR_X:               cfg = cfg_root.x; break;
                case Defines.DYNAMIC_COLOR_RATING:          cfg = cfg_root.winrate; break;
                case Defines.DYNAMIC_COLOR_KB:              cfg = cfg_root.kb; break;
                case Defines.DYNAMIC_COLOR_AVGLVL:          cfg = cfg_root.avglvl; break;
                case Defines.DYNAMIC_COLOR_TBATTLES:        cfg = cfg_root.t_battles; break;
                case Defines.DYNAMIC_COLOR_TDB:             cfg = cfg_root.tdb; break;
                case Defines.DYNAMIC_COLOR_TDV:             cfg = cfg_root.tdv; break;
                case Defines.DYNAMIC_COLOR_TFB:             cfg = cfg_root.tfb; break;
                case Defines.DYNAMIC_COLOR_TSB:             cfg = cfg_root.tsb; break;
                case Defines.DYNAMIC_COLOR_WN8EFFD:         cfg = cfg_root.wn8effd; break;
                case Defines.DYNAMIC_COLOR_DAMAGERATING:    cfg = cfg_root.damageRating; break;
                case Defines.DYNAMIC_COLOR_HITSRATIO:       cfg = cfg_root.hitsRatio; break;
                case Defines.DYNAMIC_COLOR_WINCHANCE:       cfg = cfg_root.winChance; break;

                default: return null;
            }

            var color:int;
            var cfg_len:int = cfg.length;
            for (var i:int = 0; i < cfg_len; ++i)
            {
                var cvalue:Number = cfg[i].value;
                color = Utils.toInt(cfg[i].color, 0xFFFFFF);
                if (value < cvalue)
                    break;
            }

            if (darker)
                color = GraphicsUtil.darkenColor(color, 50);
            return prefix + StringUtils.leftPad(color.toString(16), 6, "0");
        }

        public static function GetDynamicAlphaValue(type:Number, value:Number):Number
        {
            if (isNaN(value))
                return NaN;

            var cfg_root:CAlpha = Config.config.alpha;
            var cfg:Array;
            switch (type)
            {
                case Defines.DYNAMIC_ALPHA_HP:              cfg = cfg_root.hp; break;
                case Defines.DYNAMIC_ALPHA_HP_RATIO:        cfg = cfg_root.hp_ratio; break;
                case Defines.DYNAMIC_ALPHA_EFF:             cfg = cfg_root.eff; break;
                case Defines.DYNAMIC_ALPHA_E:               cfg = cfg_root.e; break;
                case Defines.DYNAMIC_ALPHA_WN6:             cfg = cfg_root.wn6; break;
                case Defines.DYNAMIC_ALPHA_WN8:             cfg = cfg_root.wn8; break;
                case Defines.DYNAMIC_ALPHA_WGR:             cfg = cfg_root.wgr; break;
                case Defines.DYNAMIC_ALPHA_X:               cfg = cfg_root.x; break;
                case Defines.DYNAMIC_ALPHA_RATING:          cfg = cfg_root.winrate; break;
                case Defines.DYNAMIC_ALPHA_KB:              cfg = cfg_root.kb; break;
                case Defines.DYNAMIC_ALPHA_AVGLVL:          cfg = cfg_root.avglvl; break;
                case Defines.DYNAMIC_ALPHA_TBATTLES:        cfg = cfg_root.t_battles; break;
                case Defines.DYNAMIC_ALPHA_TDB:             cfg = cfg_root.tdb; break;
                case Defines.DYNAMIC_ALPHA_TDV:             cfg = cfg_root.tdv; break;
                case Defines.DYNAMIC_ALPHA_TFB:             cfg = cfg_root.tfb; break;
                case Defines.DYNAMIC_ALPHA_TSB:             cfg = cfg_root.tsb; break;
                default: return NaN;
            }

            var cfg_len:int = cfg.length;
            for (var i:int = 0; i < cfg_len; ++i)
            {
                var avalue:Number = cfg[i].value;
                var alpha:Number = cfg[i].alpha;
                if (value < avalue)
                    return alpha;
            }

            return NaN;
        }

        public static function GetVClassColorValue(vdata:VehicleData, prefix:String = '#', darker:Boolean = false):String
        {
            try
            {
                if (vdata == null)
                    return null;
                var usePremium:Boolean = Config.config.colors.vtype.usePremiumColor == true;
                var vtype:String = (usePremium && vdata.premium == 1) ? "premium" : vdata.vtype;
                if (!vtype || !Config.config.colors.vtype.hasOwnProperty(vtype))
                    return null;
                var value:int = Utils.toInt(Config.config.colors.vtype[vtype], -1);
                if (value < 0)
                    return null;
                return prefix + StringUtils.leftPad(value.toString(16), 6, "0");
            }
            catch (ex:Error)
            {
                Logger.add(ex.getStackTrace());
            }
            return null;
        }

        public static function GetDmgSrcColorValue(damageSource:String, damageDest:String, isDead:Boolean, isBlowedUp:Boolean, prefix:String = '#'):String
        {
            try
            {
                if (damageSource == null || damageDest == null)
                    return null;
                var key:String = damageSource + "_" + damageDest + "_";
                key += !isDead ? "hit" : isBlowedUp ? "blowup" : "kill";
                if (Config.config.colors.damage[key] == null)
                    return null;
                var value:int = Utils.toInt(Config.config.colors.damage[key], -1);
                if (value < 0)
                    return null;
                return prefix + StringUtils.leftPad(value.toString(16), 6, "0");
            }
            catch (ex:Error)
            {
                Logger.add(ex.getStackTrace());
            }
            return null;
        }

        public static function GetDmgKindValue(dmg_kind:String, prefix:String = '#'):String
        {
            try
            {
                if (dmg_kind == null || !Config.config.colors.dmg_kind[dmg_kind])
                    return null;
                var value:int = Utils.toInt(Config.config.colors.dmg_kind[dmg_kind], -1);
                if (value < 0)
                    return null;
                return prefix + StringUtils.leftPad(value.toString(16), 6, "0");
            }
            catch (ex:Error)
            {
                Logger.add(ex.getStackTrace());
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

        //   src: ally, squadman, enemy, unknown, player (allytk, enemytk - how to detect?)
        public static function damageFlagToDamageSource(damageFlag:Number):String
        {
            switch (damageFlag)
            {
                case Defines.FROM_ALLY:
                    return "ally";
                case Defines.FROM_ENEMY:
                    return "enemy";
                case Defines.FROM_PLAYER:
                    return "player";
                case Defines.FROM_SQUAD:
                    return "squadman";
                case Defines.FROM_UNKNOWN:
                default:
                    return "unknown";
            }
        }
    }
}
