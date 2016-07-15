/**
 * XVM Entry Point
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm
{
    import com.xfw.*;
    import com.xvm.battle.*;
    import com.xvm.battle.events.*;
    import com.xvm.battle.vo.*;
    import com.xvm.extraFields.*;
    import com.xvm.types.*;
    import com.xvm.types.cfg.*;
    import flash.display.*;
    import flash.events.*;
    import net.wg.infrastructure.managers.*;

    /**
     *  Link additional classes into xfw.swc
     */
    Chance;
    Config;
    Dossier;
    ExtraFields;
    Locale;
    Stat;
    VehicleInfo;
    XvmCommands;
    Utils;

    // Battle
    BattleCommands;
    BattleEvents;
    BattleGlobalData;
    BattleMacros;
    BattleState;
    PlayerStateEvent;
    VOArenaInfo;
    VOCaptureBarData;
    VODamageInfo;
    VOMinimapCirclesData;
    VOPlayersData;
    VOPlayerState;
    VOXmqpData;

    public class Xvm extends Sprite
    {
        public static function addEventListener(type:String, listener:Function):void
        {
            _instance.addEventListener(type, listener, false, 0, true);
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

        public function Xvm():void
        {
            _instance = this;
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
            networkServicesSettings:Object, IS_DEVELOPMENT:Boolean):Object
        {
            //Logger.add("onSetConfig");
            //Logger.addObject(config_data, 5);
            //Logger.addObject(lang_data, 3);
            //Logger.addObject(vehInfo_data, 3);
            Config.config = ObjectConverter.convertData(config_data, CConfig);
            Locale.setupLanguage(lang_data);
            VehicleInfo.setVehicleInfoData(vehInfo_data);
            Config.networkServicesSettings = new NetworkServicesSettings(networkServicesSettings);
            Config.IS_DEVELOPMENT = IS_DEVELOPMENT;
            Xvm.dispatchEvent(new Event(Defines.XVM_EVENT_CONFIG_LOADED));
            return null;
        }

        private function onUpdateReserve(vehInfo_data:Array):Object
        {
            Logger.add("onUpdateReserve");
            VehicleInfo.setVehicleInfoData(vehInfo_data);
            return null;
        }
    }
}
