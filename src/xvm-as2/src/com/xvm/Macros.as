/**
 * XVM Macro substitutions
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
import com.xvm.*;
import com.xvm.DataTypes.*;

class com.xvm.Macros
{
    // PUBLIC STATIC

    public static function Format(pname:String, format:String, options:Object):String
    {
        // moved to as3
        return null;
    }

    public static function FormatByPlayerId(playerId:Number, format:String, options:Object):String
    {
        // moved to as3
        return null;
    }

    public static function FormatNumber(pname:String, cfg:Object, fieldName:String, obj:Object, nullValue:Number, emptyValue:Number, isColorValue:Boolean):Number
    {
        // moved to as3
        return null;
    }

    public static function FormatGlobalNumberValue(value, defaultValue:Number):Number
    {
        // moved to as3
        return null;
    }

    public static function FormatGlobalBooleanValue(value, defaultValue:Boolean):Boolean
    {
        // moved to as3
        return null;
    }

    public static function FormatGlobalStringValue(value, defaultValue:String):String
    {
        // moved to as3
        return null;
    }

    public static function getGlobalValue(key:String)
    {
        // moved to as3
        return null;
    }

    public static function RegisterGlobalMacrosData()
    {
        // moved to as3
        return null;
    }

    public static function RegisterGlobalMacrosDataDelayed(onEventName: String)
    {
        // moved to as3
        return null;
    }

    public static function RegisterZoomIndicatorData(zoom:Number)
    {
        // moved to as3
        return null;
    }

    public static function RegisterPlayerData(pname:String, data:Object, team:Number)
    {
        // moved to as3
        return null;
    }

    public static function RegisterStatisticsMacros(pname:String, stat:StatData)
    {
        // moved to as3
        return null;
    }

    public static function RegisterMarkerData(pname:String, data:Object)
    {
        // moved to as3
        return null;
    }

    public static var s_my_frags:Number = 0;

    public static function UpdateMyFrags(frags:Number):Boolean
    {
        // moved to as3
        return true;
    }
}
