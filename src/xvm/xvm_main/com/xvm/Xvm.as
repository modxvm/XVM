/**
 * XVM Entry Point
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm
{
    XvmLinks;

    import com.xfw.*;
    import com.xvm.utils.*;
    import com.xvm.types.*;
    import com.xvm.types.cfg.*;
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
            Xfw.addCommandListener(XvmCommandsInternal.AS_UPDATE_RESERVE, onUpdateReserve);
            Xfw.addCommandListener(XvmCommandsInternal.AS_SET_SVC_SETTINGS, onSetSvcSettings);
            Xfw.cmd(XvmCommandsInternal.REQUEST_CONFIG);
        }

        // DAAPI Python-Flash interface

        private function onL10n(value:String):String
        {
            return Utils.fixImgTag(Locale.get(value));
        }

        private function onSetConfig(config_data:Object, lang_data:Object, vehInfo_data:Array):Object
        {
            //Logger.add("onSetConfig");
            //Logger.addObject(config_data, 5);
            //Logger.addObject(lang_data, 3);
            //Logger.addObject(vehInfo_data, 3);
            Config.config = ObjectConverter.convertData(config_data, CConfig);
            Locale.setupLanguage(lang_data);
            VehicleInfo.setVehicleInfoData(vehInfo_data);
            Xvm.dispatchEvent(new Event(Defines.XVM_EVENT_CONFIG_LOADED));
            return null;
        }

        private function onUpdateReserve(vehInfo_data:Array):Object
        {
            Logger.add("onUpdateReserve");
            VehicleInfo.setVehicleInfoData(vehInfo_data);
            return null;
        }

        private function onSetSvcSettings(nss:Object):Object
        {
            Config.networkServicesSettings = new NetworkServicesSettings(nss);
            return null;
        }
    }
}
