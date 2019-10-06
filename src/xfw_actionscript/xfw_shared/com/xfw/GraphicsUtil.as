/**
 * XFW
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xfw
{
    import com.xfw.*;
    import flash.display.*;
    import flash.geom.*;

    public class GraphicsUtil
    {
        // Color math

        public static function darkenColor(hexColor:int, percent:int):int
        {
            if (percent > 100)
                percent = 100;
            if (percent < 0)
                percent = 0;

            var factor:Number = 1 - (percent / 100.0);
            var rgb:RGB = new RGB(hexColor);

            rgb.r *= factor;
            rgb.b *= factor;
            rgb.g *= factor;

            return rgb.toHex();
        }

        public static function brightenColor(hexColor:Number, percent:Number):Number
        {
            if (isNaN(percent))
                percent = 0;
            if (percent > 100)
                percent = 100;
            if (percent < 0)
                percent = 0;

            var factor:Number = percent / 100.0;
            var rgb:RGB = new RGB(hexColor);

            rgb.r += (255 - rgb.r) * factor;
            rgb.b += (255 - rgb.b) * factor;
            rgb.g += (255 - rgb.g) * factor;

            return rgb.toHex();
        }

        public static function colorByRatio(value:Number, start:Number, end:Number):Number
        {
            var r:Number = start >> 16;
            var g:Number = (start >> 8) & 0xff;
            var b:Number = start & 0xff;
            var r2:Number = (end >> 16) - r;
            var g2:Number = ((end >> 8) & 0xff) - g;
            var b2:Number = (end & 0xff) - b;
            return ((r + (value * r2)) << 16 | (g + (value * g2)) << 8 | (b + (value * b2)));
        }

        // Sprite color transform

        public static function tint(item:Sprite, color:Number, ratio:Number = NaN):void
        {
            var tr:ColorTransform = new ColorTransform();
            tr.color = color;
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

        public static function colorize(item:Sprite, color:Number, ratio:Number = 1):void
        {
            var tr:ColorTransform = new ColorTransform();
            tr.redMultiplier = ((color >> 16) & 0xFF) / 255 * ratio;
            tr.greenMultiplier = ((color >> 8) & 0xFF) / 255 * ratio;
            tr.blueMultiplier = (color & 0xFF) / 255 * ratio;
            tr.redOffset = 0;
            tr.greenOffset = 0;
            tr.blueOffset = 0;
            item.transform.colorTransform = tr;
        }
    }
}


class RGB
{
    public var r:int;
    public var g:int;
    public var b:int;

    public function RGB(hex:int)
    {
        r = (hex & 0xff0000) >> 16;
        g = (hex & 0x00ff00) >> 8;
        b = hex & 0x0000ff;
    }

    public function toHex():int
    {
        return r << 16 | g << 8 | b;
    }
}