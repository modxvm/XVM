/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.vehiclemarkers.ui
{
    import com.xfw.*;
    import com.xvm.*;
    import com.xvm.battle.*;
    import flash.external.*;
    import flash.events.*;
    import net.wg.data.constants.generated.*;
    import net.wg.infrastructure.events.*;
    import net.wg.gui.utils.*;

    XvmVehicleMarker;

    /**
     * This class is used as wrapper for Flash->Python communication.
     *
     * Use this code to log calls count:
     *     var __stack:String = XfwUtils.stack(); Xvm.swfProfilerBegin(__stack); Xvm.swfProfilerEnd(__stack);
     */
    public class XvmVehicleMarkersMod extends Xvm
    {
        static private var _allyAtlas:String = ATLAS_CONSTANTS.VEHICLE_MARKER_ATLAS;
        static private var _enemyAtlas:String = ATLAS_CONSTANTS.VEHICLE_MARKER_ATLAS;

        [Inline]
        static public function get allyAtlas():String
        {
            return _allyAtlas;
        }

        [Inline]
        static public function get enemyAtlas():String
        {
            return _enemyAtlas;
        }

        public function XvmVehicleMarkersMod():void
        {
            Xfw.registerCommandProvider(xvm_cmd);
            Logger.setCounterPrefix("V");

            this.addEventListener(Defines.XVM_EVENT_CONFIG_LOADED, onConfigLoaded, false, 0, true);

            Xfw.addCommandListener("xvm_vm.as.cmd_response", as_cmd_response);

            createBattleControllerListeners();

            Xfw.cmd(XvmCommands.INITIALIZED);

            super(Defines.APP_TYPE_VEHICLE_MARKERS);
        }

        private var _lastCmdResponse:*;
        private function xvm_cmd(... rest):*
        {
            rest.unshift("xvm.cmd");
            _lastCmdResponse = undefined;
            ExternalInterface.call.apply(null, rest);
            return _lastCmdResponse;
        }

        private function as_cmd_response(value:*):void
        {
            _lastCmdResponse = value;
        }

        private var _initialized:Boolean = false;

        private function onConfigLoaded(e:Event):void
        {
            Xvm.swfProfilerBegin(XfwUtils.stack());
            removeBattleControllerListeners();
            if (Config.config.markers.enabled)
            {
                registerVehicleIconAtlases();
                createBattleControllerListeners();
                if (!_initialized)
                {
                    _initialized = true;
                    initialize();
                }
            }
            Xvm.swfProfilerEnd(XfwUtils.stack());
        }

        private function registerVehicleIconAtlases():void
        {
            _allyAtlas = registerVehicleIconAtlas(_allyAtlas, Config.config.iconset.vehicleMarkerAllyAtlas, onAtlasInitializedAlly);
            _enemyAtlas = registerVehicleIconAtlas(_enemyAtlas, Config.config.iconset.vehicleMarkerEnemyAtlas, onAtlasInitializedEnemy);
        }

        private function registerVehicleIconAtlas(currentAtlas:String, cfgAtlas:String, callback:Function):String
        {
            var newAtlas:String = Macros.FormatStringGlobal(cfgAtlas);
            if (currentAtlas != newAtlas)
            {
                var atlasManager:RootSWFAtlasManager = RootSWFAtlasManager.instance;
                if (!atlasManager.isAtlasInitialized(newAtlas))
                {
                    atlasManager.addEventListener(AtlasEvent.ATLAS_INITIALIZED, callback);
                    atlasManager.initAtlas(newAtlas);
                }
            }
            return newAtlas;
        }

        private function onAtlasInitializedAlly(e:AtlasEvent):void
        {
            RootSWFAtlasManager.instance.removeEventListener(AtlasEvent.ATLAS_INITIALIZED, onAtlasInitializedAlly);
            Xvm.dispatchEvent(new Event(Defines.XVM_EVENT_ATLAS_LOADED));
        }

        private function onAtlasInitializedEnemy(e:AtlasEvent):void
        {
            RootSWFAtlasManager.instance.removeEventListener(AtlasEvent.ATLAS_INITIALIZED, onAtlasInitializedEnemy);
            Xvm.dispatchEvent(new Event(Defines.XVM_EVENT_ATLAS_LOADED));
        }

        private function createBattleControllerListeners():void
        {
            Xfw.addCommandListener("BC_setVehiclesData", BattleState.instance.setVehiclesData);
            Xfw.addCommandListener("BC_addVehiclesInfo", BattleState.instance.addVehiclesInfo);
            Xfw.addCommandListener("BC_updateVehiclesData", BattleState.instance.updateVehiclesData);
            Xfw.addCommandListener("BC_updateVehicleStatus", BattleState.instance.updateVehicleStatus);
            Xfw.addCommandListener("BC_updatePlayerStatus", BattleState.instance.updatePlayerStatus);
            Xfw.addCommandListener("BC_setFrags", BattleState.instance.setFrags);
            Xfw.addCommandListener("BC_updateVehiclesStat", BattleState.instance.updateVehiclesStat);
            Xfw.addCommandListener("BC_updatePersonalStatus", BattleState.instance.updatePersonalStatus);
            Xfw.addCommandListener("BC_setUserTags", BattleState.instance.setUserTags);
            Xfw.addCommandListener("BC_updateUserTags", BattleState.instance.updateUserTags);
            Xfw.addCommandListener("BC_setPersonalStatus", BattleState.instance.setPersonalStatus);
            Xfw.addCommandListener("BC_updateInvitationsStatuses", BattleState.instance.updateInvitationsStatuses);
        }

        private function removeBattleControllerListeners():void
        {
            Xfw.removeCommandListener("BC_setVehiclesData", BattleState.instance.setVehiclesData);
            Xfw.removeCommandListener("BC_addVehiclesInfo", BattleState.instance.addVehiclesInfo);
            Xfw.removeCommandListener("BC_updateVehiclesData", BattleState.instance.updateVehiclesData);
            Xfw.removeCommandListener("BC_updateVehicleStatus", BattleState.instance.updateVehicleStatus);
            Xfw.removeCommandListener("BC_updatePlayerStatus", BattleState.instance.updatePlayerStatus);
            Xfw.removeCommandListener("BC_setFrags", BattleState.instance.setFrags);
            Xfw.removeCommandListener("BC_updateVehiclesStat", BattleState.instance.updateVehiclesStat);
            Xfw.removeCommandListener("BC_updatePersonalStatus", BattleState.instance.updatePersonalStatus);
            Xfw.removeCommandListener("BC_setUserTags", BattleState.instance.setUserTags);
            Xfw.removeCommandListener("BC_updateUserTags", BattleState.instance.updateUserTags);
            Xfw.removeCommandListener("BC_setPersonalStatus", BattleState.instance.setPersonalStatus);
            Xfw.removeCommandListener("BC_updateInvitationsStatuses", BattleState.instance.updateInvitationsStatuses);
        }

        private function initialize():void
        {
            Xmqp.init();
            BattleGlobalData.init();
            Stat.clearBattleStat();
            Stat.loadBattleStat();
        }
    }
}
