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
            return Utils.createCSS(className,
                Utils.padLeft(color.toString(16), 6, '0'),
                config_font && config_font.name ? config_font.name : "$FieldFont",
                config_font && config_font.size ? config_font.size : 13,
                config_font && config_font.align ? config_font.align : "center",
                config_font && config_font.bold ? true : false,
                config_font && config_font.italic ? true : false);
        }
        catch (e)
        {
            ErrorHandler.setText("ERROR: createCSS():" + String(e));
        }

        return null;
    }
}
