/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.vehiclemarkers.ui
{
    import com.xfw.*;
    import com.xvm.*;
    import com.xvm.battle.*;
    import flash.display.*;
    import flash.external.*;
    import flash.events.*;
    import flash.utils.Timer;

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
            addEventListener(Defines.XVM_EVENT_CONFIG_LOADED, onConfigLoaded);
            super();
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
                if (!_initialized)
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
            Macros.RegisterGlobalMacrosData();
            Macros.RegisterBattleGlobalMacrosData(BattleMacros.RegisterGlobalMacrosData);
            Stat.clearBattleStat();
            Stat.loadBattleStat();
        }
    }
}
