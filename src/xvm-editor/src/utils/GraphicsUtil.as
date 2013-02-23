/**
 * ...
 * @author sirmax2
 */
package utils
{

import flash.display.MovieClip;
import flash.filters.DropShadowFilter;
import flash.geom.ColorTransform;

public class GraphicsUtil
{
    public static function createShadowFilter(distance:Number, angle:Number, color:Number,
        alpha:Number, size:Number, strength:Number):Object
    {
        if (!alpha || !strength || !size)
            return new DropShadowFilter(0, 0, 0, 0, 0, 0, 0, 0);
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
    public static function setColor(item:Object, col:Number, ratio:Number = NaN):void
    {
        if (!isNaN(ratio))
        {
            var tr: ColorTransform = new ColorTransform();
            tr.color = Number(col);
            tr.redMultiplier = 1 - ratio;
            tr.greenMultiplier = 1 - ratio;
            tr.blueMultiplier = 1 - ratio;
            tr.redOffset *= ratio;
            tr.greenOffset *= ratio;
            tr.blueOffset *= ratio;
            item.transform.colorTransform = tr;
        }
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

    public static function GetVTypeColorValue(vtype:String,
        prefix: String = "#", darker: Boolean = false): String
    {
        try
        {
            return prefix + Utils.toInt(Config.s_config.colors.vtype[vtype], 0xFFFFFE).toString(16);
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

    public static function GetDynamicColorValue(type: Number, value: Number, prefix: String = "#", darker: Boolean = false): String
    {
        if (isNaN(value))
            return prefix + "FFFBFB";

        var cfg_root: Object = Config.s_config.colors;
        var cfg: Array;
        switch (type)
        {
            case Defines.DYNAMIC_COLOR_X:
                cfg = cfg_root.x;
                break;
            case Defines.DYNAMIC_COLOR_EFF:
                cfg = cfg_root.eff;
                break;
            case Defines.DYNAMIC_COLOR_WN:
                cfg = cfg_root.wn;
                break;
            case Defines.DYNAMIC_COLOR_RATING:
                cfg = cfg_root.rating;
                break;
            case Defines.DYNAMIC_COLOR_TWR:
                cfg = cfg_root.twr;
                break;
            case Defines.DYNAMIC_COLOR_KB:
                cfg = cfg_root.kb;
                break;
            case Defines.DYNAMIC_COLOR_TBATTLES:
                cfg = cfg_root.t_battles;
                break;
            case Defines.DYNAMIC_COLOR_HP:
                cfg = cfg_root.hp;
                break;
            case Defines.DYNAMIC_COLOR_HP_RATIO:
                cfg = cfg_root.hp_ratio;
                break;
            default:
                return prefix + "FFFEFE";
        }

        var cfg_len:Number = cfg.length;
        if (value == 0 && (type == Defines.DYNAMIC_COLOR_EFF || type == Defines.DYNAMIC_COLOR_RATING))
        {
            if (cfg_len == 0)
                return "";
            var cvalue: Number = cfg[0].value;
            if (cvalue != 0)
                return "";
            var color: Number = Utils.toInt(cfg[0].color, 0xFFFFFF);
            if (darker)
                color = GraphicsUtil.darkenColor(color, 50);
            return prefix + color.toString(16);
        }

        for (var i:Number = 0; i < cfg_len; ++i)
        {
            var cvalue2: Number = cfg[i].value;
            var color2: Number = Utils.toInt(cfg[i].color, 0xFFFFFF);
            if (value < cvalue2)
            {
                if (darker)
                    color2 = GraphicsUtil.darkenColor(color2, 50);
                return prefix + color2.toString(16);
            }
        }

        return prefix + "FFFFFF";
    }

    public static function GetDynamicAlphaValue(type: Number, value: Number): Number
    {
        if (isNaN(value))
            return 101;

        var cfg_root:Object = Config.s_config.alpha;
        var cfg: Array;
        switch (type)
        {
          case Defines.DYNAMIC_ALPHA_HP:
              cfg = cfg_root.hp;
              break;
          case Defines.DYNAMIC_ALPHA_HP_RATIO:
              cfg = cfg_root.hp_ratio;
              break;
          default:
              return 102;
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

    public static function GetDmgKindValue(dmg_kind: String, prefix: String = '#'): String
    {
        try
        {
            if (!dmg_kind || !Config.s_config.colors.dmg_kind[dmg_kind])
                return "";
            return prefix + Utils.toInt(Config.s_config.colors.dmg_kind[dmg_kind], 0xFFFFFE).toString(16);
        }
        catch (ex:Error)
        {
            return prefix + "FFFEFE";
        }
        return prefix + "FFFEFE";
    }

}

}
