/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * http://www.modxvm.com/
 */
package com.xvm
{
    import com.xfw.*;
    import com.xvm.types.cfg.*;
    import com.xvm.vo.*;

    public class MacrosUtils
    {
        public static function getDynamicColorValueInt(type:Number, value:Number, darker:Boolean = false):int
        {
            return parseInt(getDynamicColorValue(type, value, "0x", darker));
        }

        public static function getDynamicColorValue(type:Number, value:Number, prefix:String = '#', darker:Boolean = false):String
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
                case Defines.DYNAMIC_COLOR_WN6:             cfg = cfg_root.wn6; break;
                case Defines.DYNAMIC_COLOR_WN8:             cfg = cfg_root.wn8; break;
                case Defines.DYNAMIC_COLOR_WGR:             cfg = cfg_root.wgr; break;
                case Defines.DYNAMIC_COLOR_X:               cfg = cfg_root.x; break;
                case Defines.DYNAMIC_COLOR_WINRATE:         cfg = cfg_root.winrate; break;
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
                color = XfwUtils.toInt(cfg[i].color, 0xFFFFFF);
                if (value < cvalue)
                    break;
            }

            if (darker)
                color = GraphicsUtil.darkenColor(color, 50);
            return XfwUtils.toHtmlColor(color, prefix);
        }

        public static function getDynamicAlphaValue(type:Number, value:Number):Number
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
                case Defines.DYNAMIC_ALPHA_WN6:             cfg = cfg_root.wn6; break;
                case Defines.DYNAMIC_ALPHA_WN8:             cfg = cfg_root.wn8; break;
                case Defines.DYNAMIC_ALPHA_WGR:             cfg = cfg_root.wgr; break;
                case Defines.DYNAMIC_ALPHA_X:               cfg = cfg_root.x; break;
                case Defines.DYNAMIC_ALPHA_WINRATE:         cfg = cfg_root.winrate; break;
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

        public static function getVClassColorValue(vdata:VOVehicleData, prefix:String = '#', darker:Boolean = false):String
        {
            if (vdata == null)
                return null;
            var usePremium:Boolean = Config.config.colors.vtype.usePremiumColor == true;
            var vtype:String = (usePremium && vdata.premium == 1) ? "premium" : vdata.vtype;
            if (!vtype || !Config.config.colors.vtype.hasOwnProperty(vtype))
                return null;
            var value:int = XfwUtils.toInt(Config.config.colors.vtype[vtype], -1);
            if (value < 0)
                return null;
            return XfwUtils.toHtmlColor(value, prefix);
        }

        public static function getVTypeColorValue(vehCD:Number):String
        {
            var vdata:VOVehicleData = VehicleInfo.get(vehCD);
            var vtype:String = (Config.config.colors.vtype.usePremiumColor == true && vdata.premium) ? "premium" : vdata.vtype;
            if (!vtype || !Config.config.colors.vtype[vtype])
                return "";
            return XfwUtils.toHtmlColor(XfwUtils.toInt(Config.config.colors.vtype[vtype], 0xFFFFFE));
        }
    }
}
