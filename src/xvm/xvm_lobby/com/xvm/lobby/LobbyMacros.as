/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * http://www.modxvm.com/
 */
package com.xvm.lobby
{
    import com.xfw.*;
    import com.xvm.*;
    import com.xvm.vo.*;
    import com.xvm.types.stat.*;

    internal class LobbyMacros
    {
        internal static function RegisterBattleTypeMacros(battleType:String):void
        {
            // {{battletype-key}}
            Macros.Globals["battletype-key"] = function():String { return battleType; }
        }

        private static var _requestSent:Boolean = false;
        internal static function RegisterMyStatMacros():void
        {
            Macros.Globals["mystat"] = function(o:IVOMacrosOptions):* {
                if (o == null || o.getSubname() == null)
                {
                    return null;
                }
                var playerName:String = Xfw.cmd(XvmCommands.GET_PLAYER_NAME);
                var stat:StatData = Stat.getUserDataByName(playerName);
                //Logger.addObject(stat, 3);
                if (stat)
                {
                    return stat[o.getSubname()];
                }
                else
                {
                    Stat.loadUserData(playerName);
                    return null;
                }
            }
        }

        internal static function RegisterVehiclesMacros():void
        {
            Macros.Globals["v"] = function(o:IVOMacrosOptions):* {
                if (o == null || o.getSubname() == null || o.vehicleData == null)
                {
                    return null;
                }
                return o.vehicleData.__vehicleDossierCut[o.getSubname()]; // TODO: refactor, remove VehicleDossierCut class
            }
        }
    }
}
