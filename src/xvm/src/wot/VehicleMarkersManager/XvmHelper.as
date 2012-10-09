/**
 * Helper class with various xvm-related static functions
 */
import wot.utils.Utils;
import wot.VehicleMarkersManager.ErrorHandler;

class wot.VehicleMarkersManager.XvmHelper
{
    // Level in roman numerals
    public static var rlevel: Array = [ "I", "II", "III", "IV", "V", "VI", "VII", "VIII", "IX", "X" ];

    /**
     * Create CSS based on config
     */
    public static function createCSS(config_font:Object, color:Number, className:String):String
    {
        try
        {
            if (!config_font)
                return null;

            return "." + className + " {" +
                "color:#" + Utils.padLeft(color.toString(16), 6, '0') + ";" +
                "font-family:" + (config_font.name || "$FieldFont") + ";" +
                "font-size:" + (config_font.size || 13) + "px;" +
                "font-weight:" + (config_font.bold ? "bold" : "normal") + ";" +
                "font-style:" + (config_font.italic ? "italic" : "normal") + ";" +
                "text-align:" + (config_font.align || "center") + ";" +
                "}";
        }
        catch (e)
        {
            ErrorHandler.setText("ERROR: createCSS():" + String(e));
        }

        return null;
    }

    /**
     * Create TextFormat based on config
     */
    public static function createNewTextFormat(config_font: Object): TextFormat
    {
        try
        {
            if (!config_font)
                return null;

            return new TextFormat(
                config_font.name || "$FieldFont",
                config_font.size || 13,
                0x000000,
                config_font.bold,
                config_font.italic,
                false, null, null,
                config_font.align || "center",
                0, 0, 0, 0);
        }
        catch (e)
        {
            ErrorHandler.setText("ERROR: createNewTextFormat():" + String(e));
        }

        return null;
    }
}
