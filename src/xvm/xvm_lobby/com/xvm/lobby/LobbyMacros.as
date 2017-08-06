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
                switch (o.getSubname())
                {
                    case "player_id":
                        return Xfw.cmd(XvmCommands.GET_PLAYER_ID);
                    case "name":
                        return Xfw.cmd(XvmCommands.GET_PLAYER_NAME);
                    case "clan":
                        return Xfw.cmd(XvmCommands.GET_PLAYER_CLAN_NAME);
                    case "clan_id":
                        return Xfw.cmd(XvmCommands.GET_PLAYER_CLAN_ID);
                    case "battles":
                        return Xfw.cmd(XvmCommands.GET_PLAYER_DOSSIER_VALUE, 'battles');
                    case "wins":
                        return Xfw.cmd(XvmCommands.GET_PLAYER_DOSSIER_VALUE, 'wins');
                    case "winrate":
                        return Xfw.cmd(XvmCommands.GET_PLAYER_DOSSIER_VALUE, 'winrate');
                    case "def":
                        return Xfw.cmd(XvmCommands.GET_PLAYER_DOSSIER_VALUE, 'defence');
                    case "frg":
                        return Xfw.cmd(XvmCommands.GET_PLAYER_DOSSIER_VALUE, 'frags');
                    case "dmg":
                        return Xfw.cmd(XvmCommands.GET_PLAYER_DOSSIER_VALUE, 'damageDealt');
                    case "cap":
                        return Xfw.cmd(XvmCommands.GET_PLAYER_DOSSIER_VALUE, 'capture');
                    case "hip":
                        return Xfw.cmd(XvmCommands.GET_PLAYER_DOSSIER_VALUE, 'hitPercent');
                    case "spo":
                        return Xfw.cmd(XvmCommands.GET_PLAYER_DOSSIER_VALUE, 'spotted');
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
