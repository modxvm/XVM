/**
 * XVM Entry Point
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm
{
    XvmLinks;

    import com.xfw.*;
    //import com.xfw.events.*;
    //import com.xfw.types.*;
    //import com.xfw.utils.*;
    import flash.display.*;
    import flash.events.*;
    //import net.wg.app.*;
    //import net.wg.data.constants.*;
    //import net.wg.infrastructure.base.*;
    //import net.wg.infrastructure.events.*;
    //import net.wg.infrastructure.managers.*;

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
            Config.load();

            Xfw.addCommandListener(Defines.XVM_AS_COMMAND_RELOAD_CONFIG, onReloadConfig);
        }

        // DAAPI Python-Flash interface

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
            //Xfw.cmd(_XFW_COMMAND_INITIALIZED);
        }

        /*
        public function as_xvm_cmd(cmd:*, ...rest):*
        {
            //Logger.add("as_xvm_cmd: " + cmd + " " + rest.join(", "));

            try
            {
                switch (cmd)
                {
                    case Defines.XFW_AS_COMMAND_L10N:
                        return Locale.get(rest[0]);

                    default:
                        var e:XfwCmdReceivedEvent = new XfwCmdReceivedEvent(cmd, rest);
                        dispatchEvent(e);
                        return e.retValue;
                }
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
        }

        private function handleXfwCommand(e:XfwCmdReceivedEvent):void
        {
            //Logger.add("handleXfwCommand: " + e.result.cmd);
            try
            {
                switch (e.cmd)
                {
                    case Defines.XVM_AS_COMMAND_SET_SVC_SETTINGS:
                        e.stopImmediatePropagation();
                        Config.networkServicesSettings = new NetworkServicesSettings(e.args[0]);
                        break;
                }
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
        }
        */
    }
}
