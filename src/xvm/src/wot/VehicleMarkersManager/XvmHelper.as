/**
 * Helper class with various xvm-related static functions
 */
import wot.VehicleMarkersManager.ErrorHandler;
import wot.utils.Defines;

class wot.VehicleMarkersManager.XvmHelper
{
    // Level in roman numerals
    public static var rlevel: Array = [ "I", "II", "III", "IV", "V", "VI", "VII", "VIII", "IX", "X" ];

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
            ErrorHandler.setText("ERROR: XVMCreateNewTextFormat():" + String(e));
        }

        return null;
    }
    
    public static function translateDmgToConst(str: String): Number
    {
        if (str == "attack")     return Defines.ATTACK;
        if (str == "fire")       return Defines.FIRE;
        if (str == "ramming")    return Defines.RAMMING;
        if (str == "world_collision") return Defines.WORLD_COLLISION;
        if (str == "death_zone") return Defines.DEATH_ZONE;
        if (str == "drowning")   return Defines.DROWNING;
        if (str == "explosion")  return Defines.EXPLOSION;
    }
}
