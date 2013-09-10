/**
 * XVM Utils
 * @author Maxim Schedriviy <m.schedriviy@gmail.com>
 */
package com.xvm.utils
{
    public class WGUtils
    {
        import org.idmedia.as3commons.util.StringUtils;

        public static function vehicleClassToVehicleType(vclass:String):String
        {
            switch (vclass)
            {
                case "lightTank": return "LT";
                case "mediumTank": return "MT";
                case "heavyTank": return "HT";
                case "SPG": return "SPG";
                case "AT-SPG": return "TD";
                default: return vclass;
            }
        }

        public static function GetPlayerName(fullplayername:String):String
        {
            var pos:int = fullplayername.indexOf("[");
            return (pos < 0) ? fullplayername : StringUtils.trim(fullplayername.slice(0, pos));
        }

        public static function GetClanName(fullplayername:String):String
        {
            var pos:Number = fullplayername.indexOf("[");
            if (pos < 0)
                return "";
            var n:String = fullplayername.slice(pos + 1);
            return n.slice(0, n.indexOf("]"));
        }

        public static function GetClanNameWithBrackets(fullplayername:String):String
        {
            var clan:String = GetClanName(fullplayername);
            return clan ? "[" + clan + "]" : "";
        }
    }
}
