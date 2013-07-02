/**
 * ...
 * @author sirmax2
 */
import com.xvm.Config;
import com.xvm.Defines;
import com.xvm.Utils;
import flash.filters.DropShadowFilter;
import flash.geom.ColorTransform;

class com.xvm.GraphicsUtil
{
    public static function createShadowFilter(distance:Number, angle:Number, color:Number,
        alpha:Number, size:Number, strength:Number):DropShadowFilter
    {
        if (alpha == null || strength == null || size == null)
            return null;
        return new DropShadowFilter(distance, angle, color, alpha * 0.01, size, size, strength * 0.01, 3);
    }

    public static function colorByRatio($value:Number, $start:Number, $end:Number):Number
    {
        var r: Number = $start >> 16;
        var g: Number = ($start >> 8) & 0xff;
        var b: Number = $start & 0xff;
        var r2: Number = ($end >> 16) - r;
        var g2: Number = (($end >> 8) & 0xff) - g;
        var b2: Number = ($end & 0xff) - b;
        return ((r + ($value * r2)) << 16 | (g + ($value * g2)) << 8 | (b + ($value * b2)));
    }

    //method to set a specified movieClip(item:movidClip) to a specified color(col:hex value number)
    public static function setColor(item:Object, col:Number, ratio:Number)
    {
        var tr: ColorTransform = new ColorTransform();
        tr.rgb = Number(col);

        if (!isNaN(ratio))
        {
            tr.redMultiplier = 1 - ratio;
            tr.greenMultiplier = 1 - ratio;
            tr.blueMultiplier = 1 - ratio;
            tr.redOffset *= ratio;
            tr.greenOffset *= ratio;
            tr.blueOffset *= ratio;
        }

        item.transform.colorTransform = tr;
    }

    // require 2-colored black and white source image (mask).
    public static function colorize(item:Object, col:Number, multiplicator:Number)
    {
        if (multiplicator == null)
            multiplicator = 1;
        var tr:flash.geom.ColorTransform = new flash.geom.ColorTransform();
        tr.redMultiplier = ((col >> 16) & 0xFF) / 255 * multiplicator;
        tr.greenMultiplier = ((col >> 8) & 0xFF) / 255 * multiplicator;
        tr.blueMultiplier = (col & 0xFF) / 255 * multiplicator;
        tr.redOffset = 0;
        tr.greenOffset = 0;
        tr.blueOffset = 0;
        item.transform.colorTransform = tr;
    }

    public static function brightenColor(hexColor: Number, percent: Number): Number
    {
        if (isNaN(percent))
            percent = 0;
        if (percent > 100)
            percent = 100;
        if (percent < 0)
            percent = 0;

        var factor: Number = percent / 100;
        var rgb: Object = hexToRgb(hexColor);

        rgb.r += (255 - rgb.r) * factor;
        rgb.b += (255 - rgb.b) * factor;
        rgb.g += (255 - rgb.g) * factor;

        return rgbToHex(Math.round(rgb.r), Math.round(rgb.g), Math.round(rgb.b));
    }

    public static function darkenColor(hexColor:Number, percent:Number): Number
    {
        if (isNaN(percent))
            percent = 0;
        if (percent > 100)
            percent = 100;
        if (percent < 0)
            percent = 0;

        var factor: Number = 1 - (percent/100);
        var rgb: Object = hexToRgb(hexColor);

        rgb.r *= factor;
        rgb.b *= factor;
        rgb.g *= factor;

        return rgbToHex(Math.round(rgb.r), Math.round(rgb.g), Math.round(rgb.b));
    }

    public static function rgbToHex(r:Number, g:Number, b:Number): Number
    {
        return (r << 16 | g << 8 | b);
    }

    public static function hexToRgb(hex:Number): Object
    {
        return { r: (hex & 0xff0000) >> 16, g: (hex & 0x00ff00) >> 8, b: hex & 0x0000ff };
    }

    public static function brightness(hex:Number): Number
    {
        var max: Number = 0;
        var rgb: Object = hexToRgb(hex);
        if(rgb.r > max)
            max = rgb.r;
        if(rgb.g > max)
            max = rgb.g;
        if(rgb.b > max)
            max = rgb.b;
        max /= 255;
        return max;
    }

    public static function GetVTypeColorValue(iconSource:String, vtype:String, prefix: String, darker: Boolean): String
    {
        if (!prefix)
            prefix = "#";

        try
        {
            if (!vtype || Config.s_config.colors.vtype.usePremiumColor == true)
            {
                var vi2 = com.xvm.VehicleInfo.getInfo2(iconSource);
                if (vi2 != null)
                    vtype = (Config.s_config.colors.vtype.usePremiumColor == true && vi2.premium == 1) ? "premium" : vi2.type;
            }
            if (!vtype || !Config.s_config.colors.vtype[vtype])
                return "";
            return prefix + Utils.padLeft(Utils.toInt(Config.s_config.colors.vtype[vtype], 0xFFFFFE).toString(16), 6, "0");
        }
        catch (ex:Error)
        {
            return prefix + "FFFEFE";
        }
        return prefix + "FFFEFE";
    }

    public static function GetDmgSrcValue(damageSource:String, damageDest:String, isDead:Boolean, isBlowedUp:Boolean, prefix: String): String
    {
        if (!prefix)
            prefix = "#";

        try
        {
            if (!damageSource || !damageDest)
                return "";
            var key:String = damageSource + "_" + damageDest + "_";
            key += !isDead ? "hit" : isBlowedUp ? "blowup" : "kill";
            if (!Config.s_config.colors.damage[key])
                return "";
            return prefix + Utils.padLeft(Utils.toInt(Config.s_config.colors.damage[key], 0xFFFFFE).toString(16), 6, "0");
        }
        catch (ex:Error)
        {
            return prefix + "FFFEFE";
        }
        return prefix + "FFFEFE";
    }

    public static function GetDmgKindValue(dmg_kind: String, prefix: String): String
    {
        if (!prefix)
            prefix = "#";

        try
        {
            if (!dmg_kind || !Config.s_config.colors.dmg_kind[dmg_kind])
                return "";
            return prefix + Utils.padLeft(Utils.toInt(Config.s_config.colors.dmg_kind[dmg_kind], 0xFFFFFE).toString(16), 6, "0");
        }
        catch (ex:Error)
        {
            return prefix + "FFFEFE";
        }
        return prefix + "FFFEFE";
    }

    public static function GetDynamicColorValueInt(type: Number, value: Number, darker: Boolean): Number
    {
        return Number(GetDynamicColorValue(type, value, "0x", darker));
    }

    public static function GetDynamicColorValue(type: Number, value: Number, prefix: String, darker: Boolean): String
    {
        if (value == null)
            return "";

        if (!prefix)
            prefix = "#";

        if (isNaN(value))
            return prefix + "FFFBFB";

        var cfg_root: Object = Config.s_config.colors;
        var cfg: Array;
        switch (type)
        {
            case Defines.DYNAMIC_COLOR_HP:              cfg = cfg_root.hp; break;
            case Defines.DYNAMIC_COLOR_HP_RATIO:        cfg = cfg_root.hp_ratio; break;
            case Defines.DYNAMIC_COLOR_EFF:             cfg = cfg_root.eff; break;
            case Defines.DYNAMIC_COLOR_E:               cfg = cfg_root.e; break;
            case Defines.DYNAMIC_COLOR_WN:              cfg = cfg_root.wn; break;
            case Defines.DYNAMIC_COLOR_X:               cfg = cfg_root.x; break;
            case Defines.DYNAMIC_COLOR_TWR:             cfg = cfg_root.twr; break;
            case Defines.DYNAMIC_COLOR_RATING:          cfg = cfg_root.rating; break;
            case Defines.DYNAMIC_COLOR_KB:              cfg = cfg_root.kb; break;
            case Defines.DYNAMIC_COLOR_TBATTLES:        cfg = cfg_root.t_battles; break;
            case Defines.DYNAMIC_COLOR_TDB:             cfg = cfg_root.tdb; break;
            case Defines.DYNAMIC_COLOR_TDV:             cfg = cfg_root.tdv; break;
            case Defines.DYNAMIC_COLOR_TFB:             cfg = cfg_root.tfb; break;
            case Defines.DYNAMIC_COLOR_TSB:             cfg = cfg_root.tsb; break;
            default: return prefix + "FFFEFE";
        }

        var cfg_len:Number = cfg.length;
        for (var i:Number = 0; i < cfg_len; ++i)
        {
            var cvalue: Number = cfg[i].value;
            var color: Number = Utils.toInt(cfg[i].color, 0xFFFFFF);
            if (value < cvalue)
            {
                if (darker)
                    color = GraphicsUtil.darkenColor(color, 50);
                return prefix + Utils.padLeft(color.toString(16), 6, "0");
            }
        }

        return prefix + "FFFFFF";
    }

    public static function GetDynamicAlphaValue(type: Number, value: Number): Number
    {
        if (isNaN(value))
            return 0;

        var cfg_root:Object = Config.s_config.alpha;
        var cfg: Array;
        switch (type)
        {
            case Defines.DYNAMIC_ALPHA_HP:              cfg = cfg_root.hp; break;
            case Defines.DYNAMIC_ALPHA_HP_RATIO:        cfg = cfg_root.hp_ratio; break;
            case Defines.DYNAMIC_ALPHA_EFF:             cfg = cfg_root.eff; break;
            case Defines.DYNAMIC_ALPHA_E:               cfg = cfg_root.e; break;
            case Defines.DYNAMIC_ALPHA_WN:              cfg = cfg_root.wn; break;
            case Defines.DYNAMIC_ALPHA_X:               cfg = cfg_root.x; break;
            case Defines.DYNAMIC_ALPHA_TWR:             cfg = cfg_root.twr; break;
            case Defines.DYNAMIC_ALPHA_RATING:          cfg = cfg_root.rating; break;
            case Defines.DYNAMIC_ALPHA_KB:              cfg = cfg_root.kb; break;
            case Defines.DYNAMIC_ALPHA_TBATTLES:        cfg = cfg_root.t_battles; break;
            case Defines.DYNAMIC_ALPHA_TDB:             cfg = cfg_root.tdb; break;
            case Defines.DYNAMIC_ALPHA_TDV:             cfg = cfg_root.tdv; break;
            case Defines.DYNAMIC_ALPHA_TFB:             cfg = cfg_root.tfb; break;
            case Defines.DYNAMIC_ALPHA_TSB:             cfg = cfg_root.tsb; break;
          default:
              return 100;
        }

        var cfg_len:Number = cfg.length;
        for (var i:Number = 0; i < cfg_len; ++i)
        {
            var avalue: Number = cfg[i].value;
            var alpha: Number = cfg[i].alpha;
            if (value < avalue)
                return alpha;
        }

        return 100;
    }

    public static function fillRect(target:MovieClip, x:Number, y:Number,
        width: Number, height: Number, color: Number, alpha: Number)
    {
        target.moveTo(x, y);
        target.beginFill(color, alpha);
        target.lineTo(x + width, y);
        target.lineTo(x + width, y + height);
        target.lineTo(x, y + height);
        target.lineTo(x, y);
        target.endFill();
    }
}
