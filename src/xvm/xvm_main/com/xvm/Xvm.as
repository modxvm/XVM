/**
 * XVM Entry Point
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm
{
    XvmLinks;

    import com.xfw.*;
    import com.xvm.types.*;
    import com.xvm.types.cfg.CConfig;
    import flash.display.*;
    import flash.events.*;

    public class Xvm extends Sprite //AbstractView
    {
        public static function addEventListener(type:String, listener:Function):void
        {
            _instance.addEventListener(type, listener);
        }

        public static function removeEventListener(type:String, listener:Function):void
        {
            _instance.removeEventListener(type, listener);
        }

        public static function dispatchEvent(e:Event):void
        {
            _instance.dispatchEvent(e);
        }

        // initialization

        private static var _instance:Xvm;

        public function Xvm():void
        {
            _instance = this;
            Xfw.addCommandListener(XvmCommandsInternal.AS_L10N, onL10n);
            Xfw.addCommandListener(XvmCommandsInternal.AS_SET_CONFIG, onSetConfig);
            Xfw.addCommandListener(XvmCommandsInternal.AS_SET_SVC_SETTINGS, onSetSvcSettings);
            Xfw.cmd(XvmCommandsInternal.REQUEST_CONFIG);
        }

        // DAAPI Python-Flash interface

        private function onL10n(value:String):String
        {
            return Locale.get(value);
        }

        private function onSetConfig(config_str:String, lang_str:String, vehInfo_str:String):Object
        {
            //Logger.add("onSetConfig");
            Config.config = ObjectConverter.convertData(JSONx.parse(config_str), CConfig);
            Locale.setupLanguage(lang_str);
            VehicleInfo.setVehicleInfoData(vehInfo_str);
            Xvm.dispatchEvent(new Event(Defines.XVM_EVENT_CONFIG_LOADED));
            return null;
        }

        private function onSetSvcSettings(nss:Object):Object
        {
            Config.networkServicesSettings = new NetworkServicesSettings(nss);
            return null;
        }
    }
}
