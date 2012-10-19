package preview
{

import utils.*;
import preview.*;

public class XvmHelper
{
    // Level in roman numerals
    public static var rlevel: Array = [ "I", "II", "III", "IV", "V", "VI", "VII", "VIII", "IX", "X" ];

    /**
     * Create CSS based on config
     */
    public static function createCSS(config_font:Object, color:Number, className:String):String
    {
        return "." + className + " {" +
            "color:#" + Utils.padLeft(color.toString(16), 6, '0') + ";" +
            "font-family:" + (config_font && config_font.name ? '"' + config_font.name + '"' : "$FieldFont") + ";" +
            "font-size:" + (config_font && config_font.size ? config_font.size : 13) + ";" +
            "font-weight:" + (config_font && config_font.bold ? "bold" : "normal") + ";" +
            "font-style:" + (config_font && config_font.italic ? "italic" : "normal") + ";" +
            "text-align:" + (config_font && config_font.align ? config_font.align : "center") + ";" +
            "}";

        return null;
    }
}

}
