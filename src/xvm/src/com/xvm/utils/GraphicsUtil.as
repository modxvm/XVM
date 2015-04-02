/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.utils
{
    import com.xvm.*;

    public class GraphicsUtil
    {
        public static function rgbToHex(r:int, g:int, b:int):int
        {
            return (r << 16 | g << 8 | b);
        }

        public static function hexToRgb(hex:int):Object
        {
            return { r: (hex & 0xff0000) >> 16, g: (hex & 0x00ff00) >> 8, b: hex & 0x0000ff };
        }

        public static function darkenColor(hexColor:int, percent:int):int
        {
            if (percent > 100)
                percent = 100;
            if (percent < 0)
                percent = 0;

            var factor:Number = 1 - (percent / 100.0);
            var rgb:Object = hexToRgb(hexColor);

            rgb.r *= factor;
            rgb.b *= factor;
            rgb.g *= factor;

            return rgbToHex(Math.round(rgb.r), Math.round(rgb.g), Math.round(rgb.b));
        }

/*        public static function createShadowFilter(distance:Number, angle:Number, color:Number,
            alpha:Number, size:Number, strength:Number):DropShadowFilter
        {
            if (strength == null || size == null)
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
*/
        public static function brightenColor(hexColor:Number, percent:Number):Number
        {
            if (isNaN(percent))
                percent = 0;
            if (percent > 100)
                percent = 100;
            if (percent < 0)
                percent = 0;

            var factor:Number = percent / 100;
            var rgb:Object = hexToRgb(hexColor);

            rgb.r += (255 - rgb.r) * factor;
            rgb.b += (255 - rgb.b) * factor;
            rgb.g += (255 - rgb.g) * factor;

            return rgbToHex(Math.round(rgb.r), Math.round(rgb.g), Math.round(rgb.b));
        }
/*
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
        }*/
    }
}
