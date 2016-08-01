/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.vehiclemarkers.ui
{
    import com.xfw.*;
    import com.xvm.*;
    import com.xvm.battle.*;
    import com.xvm.types.cfg.*;
    import flash.display.*;
    import flash.external.*;
    import flash.events.*;

    XvmVehicleMarker;

    /**
     * This class is used as wrapper for Flash->Python communication.
     */
    public class XvmVehicleMarkersMod extends Xvm
    {
        public function XvmVehicleMarkersMod():void
        {
            Xfw.registerCommandProvider(xvm_cmd);
            Logger.counterPrefix = "V";
            Xfw.cmd(XvmCommands.INITIALIZED);

            this.addEventListener(Defines.XVM_EVENT_CONFIG_LOADED, onConfigLoaded, false, 0, true);

            super();

            Xfw.addCommandListener("BC_setVehiclesData", BattleState.instance.setVehiclesData);
            Xfw.addCommandListener("BC_addVehiclesInfo", BattleState.instance.addVehiclesInfo);
            Xfw.addCommandListener("BC_updateVehiclesInfo", BattleState.instance.updateVehiclesInfo);
            Xfw.addCommandListener("BC_updateVehicleStatus", BattleState.instance.updateVehicleStatus);
            Xfw.addCommandListener("BC_updatePlayerStatus", BattleState.instance.updatePlayerStatus);
            Xfw.addCommandListener("BC_setVehiclesStats", BattleState.instance.setVehicleStats);
            Xfw.addCommandListener("BC_updateVehiclesStats", BattleState.instance.updateVehiclesStats);
            Xfw.addCommandListener("BC_updatePersonalStatus", BattleState.instance.updatePersonalStatus);
            Xfw.addCommandListener("BC_setArenaInfo", BattleState.instance.setArenaInfo);
            Xfw.addCommandListener("BC_setUserTags", BattleState.instance.setUserTags);
            Xfw.addCommandListener("BC_updateUserTags", BattleState.instance.updateUserTags);
            Xfw.addCommandListener("BC_setPersonalStatus", BattleState.instance.setPersonalStatus);
            Xfw.addCommandListener("BC_updateInvitationsStatuses", BattleState.instance.updateInvitationsStatuses);
        }

        private function xvm_cmd(... rest):*
        {
            rest.unshift("xvm.cmd");
            return ExternalInterface.call.apply(null, rest);
        }

        private var _initialized:Boolean = false;

        private function onConfigLoaded(e:Event):void
        {
            try
            {
                //Logger.add("onConfigLoaded: enabled=" + Config.config.markers.enabled);
                if (!_initialized && Config.config.markers.enabled)
                {
                    _initialized = true;
                    initialize();
                }
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
        }

        private function initialize():void
        {
            Macros.clear();
            BattleGlobalData.init();
            Stat.clearBattleStat();
            Stat.loadBattleStat();
        }
    }
}
