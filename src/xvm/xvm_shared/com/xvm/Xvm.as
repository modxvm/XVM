/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * http://www.modxvm.com/
 */
package com.xvm
{
    import com.xfw.*;
    import com.xvm.types.*;
    import com.xvm.types.cfg.*;
    import flash.display.*;
    import flash.events.*;

    /**
     *  Link additional classes into xvm_shared.swc
     */

    import com.xvm.battle.*;
    BattleGlobalData;
    BattleMacros;
    Xmqp;

    import com.xvm.extraFields.*;
    ExtraFields;
    ExtraFieldsGroup;

    public class Xvm extends Sprite
    {
        public static function addEventListener(type:String, listener:Function, useWeakReference:Boolean = true):void
        {
            _instance.addEventListener(type, listener, false, 0, useWeakReference);
        }

        public static function removeEventListener(type:String, listener:Function):void
        {
            _instance.removeEventListener(type, listener);
        }

        public static function dispatchEvent(e:Event):void
        {
            _instance.dispatchEvent(e);
        }

        // SWF Profiler

        public static function swfProfilerBegin(name:String):void
        {
            if (Config.IS_DEVELOPMENT)
                Xfw.cmd(XvmCommandsInternal.XVM_PROFILER_COMMAND_BEGIN, Logger.counterPrefix + ":" + name);
        }

        public static function swfProfilerEnd(name:String):void
        {
            if (Config.IS_DEVELOPMENT)
                Xfw.cmd(XvmCommandsInternal.XVM_PROFILER_COMMAND_END, Logger.counterPrefix + ":" + name);
        }

        // initialization

        private static var _instance:Xvm;
        private var _battleState:BattleState;

        public function Xvm():void
        {
            _instance = this;
            _battleState = BattleState.instance;
            this.addChild(_battleState);
            Macros.clear();
            Xfw.addCommandListener(XvmCommandsInternal.AS_L10N, onL10n);
            Xfw.addCommandListener(XvmCommandsInternal.AS_SET_CONFIG, onSetConfig);
            Xfw.addCommandListener(XvmCommandsInternal.AS_UPDATE_RESERVE, onUpdateReserve);
            Xfw.cmd(XvmCommandsInternal.REQUEST_CONFIG);
        }

        // DAAPI Python-Flash interface

        private function onL10n(value:String):String
        {
            return Utils.fixImgTag(Locale.get(value));
        }

        private function onSetConfig(config_data:Object, lang_data:Object, vehInfo_data:Array,
            networkServicesSettings:Object, IS_DEVELOPMENT:Boolean):void
        {
            //Logger.add("onSetConfig");
            //Logger.addObject(config_data, 5);
            //Logger.addObject(lang_data, 3);
            //Logger.addObject(vehInfo_data, 3);
            Config.IS_DEVELOPMENT = IS_DEVELOPMENT;
            Config.config = ObjectConverter.convertData(config_data, CConfig);
            Locale.setupLanguage(lang_data);
            VehicleInfo.setVehicleInfoData(vehInfo_data);
            Config.networkServicesSettings = new NetworkServicesSettings(networkServicesSettings);
            if (BattleGlobalData.initialized)
            {
                Config.applyGlobalBattleMacros();
            }
            Xvm.dispatchEvent(new Event(Defines.XVM_EVENT_CONFIG_LOADED));
        }

        private function onUpdateReserve(vehInfo_data:Array):void
        {
            //Logger.add("onUpdateReserve");
            VehicleInfo.setVehicleInfoData(vehInfo_data);
        }
    }
}
