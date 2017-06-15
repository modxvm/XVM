/**
 * XVM Macro substitutions
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.lobby
{
    import com.xfw.*;
    import com.xvm.*;
    import com.xvm.vo.*;

    internal class LobbyMacros
    {
        internal static function RegisterBattleTypeMacros(battleType:String):void
        {
            // {{battletype-key}}
            Macros.Globals["battletype-key"] = function():String { return battleType; }
        }

        internal static function RegisterVehiclesMacros():void
        {
            Macros.Globals["v"] = function(o:IVOMacrosOptions):* {
                if (o == null || o.getSubname() == null || o.vehicleData == null)
                    return null;
                return o.vehicleData.__vehicleDossierCut[o.getSubname()]; // TODO: refactor, remove VehicleDossierCut class
            }
        }

        internal static function RegisterClockMacros():void
        {
            Macros.Globals["_clock"] = function(o:IVOMacrosOptions):* {
                if (o == null || o.getSubname() == null)
                    return null;
                var date:Date = App.utils.dateTime.now();
                var H:Number = date.hours % 12;
                if (H == 0)
                    H = 12;
                switch (o.getSubname())
                {
                    case "Y": return date.fullYear;
                    case "M": return date.month + 1;
                    case "MM": return App.utils.dateTime.getMonthName(date.month + 1, true, false);
                    case "MMM": return App.utils.dateTime.getMonthName(date.month + 1, true, true);
                    case "D": return date.date;
                    case "W": return App.utils.dateTime.getDayName(date.day == 0 ? 7 : date.day, true, false);
                    case "WW": return App.utils.dateTime.getDayName(date.day == 0 ? 7 : date.day, true, true);
                    case "h": return date.hours;
                    case "m": return date.minutes;
                    case "s": return date.seconds;
                    case "H": return H;
                    case "AM": return date.hours < 12 ? "AM" : null;
                    default: return "";
                }
            }
        }
    }
}
