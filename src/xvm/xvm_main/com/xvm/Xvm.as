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
        }

        // DAAPI Python-Flash interface

        private function onL10n(value:String):String
        {
            return Locale.get(value);
        }

        private function onSetConfig(config_str:String):void
        {
            Config.setConfig(JSONx.parse(config_str) as CConfig);
            Xvm.dispatchEvent(new Event(Defines.XVM_EVENT_CONFIG_LOADED));
        }

        private function onSetSvcSettings(nss:Object):void
        {
            Config.networkServicesSettings = new NetworkServicesSettings(nss);
        }
/*
        private function onReloadConfig():void
        {
            Logger.add("reload config");
            Config.load();
            var message:String = Locale.get("XVM config reloaded");
            var type:String = "Information";
            if (Config.stateInfo.warning != null)
            {
                message = Locale.get("Config file xvm.xc was not found, using the built-in config");
                type = "Warning";
            }
            else if (Config.stateInfo.error != null)
            {
                message = Locale.get("Error loading XVM config") + ":\n" + XfwUtils.encodeHtmlEntities(Config.stateInfo.error);
                type = "Error";
            }
            Xfw.cmd(XfwConst.XFW_COMMAND_SYSMESSAGE, message, type);
        }
*/
    }
}
