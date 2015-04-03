/**
 * XVM Communication interface
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.io
{
    import com.xvm.*;
    import com.xvm.utils.*;
    import flash.external.*;
    import flash.utils.*;

    public class Cmd
    {
        private static const COMMAND_LOG:String = "log";
        private static const COMMAND_GETSCREENSIZE:String = "getScreenSize";
        private static const COMMAND_GETVEHICLEINFODATA:String = "getVehicleInfoData";
        private static const COMMAND_LOADBATTLESTAT:String = "loadBattleStat";
        private static const COMMAND_LOADBATTLERESULTSSTAT:String = "loadBattleResultsStat";
        private static const COMMAND_LOADUSERDATA:String = "loadUserData";
        private static const COMMAND_GETDOSSIER:String = "getDossier";
        private static const COMMAND_OPEN_URL:String = "openUrl";
        private static const COMMAND_LOGSTAT:String = "logstat";
        private static const COMMAND_SAVE_SETTINGS:String = "save_settings";
        private static const COMMAND_LOAD_SETTINGS:String = "load_settings";
        private static const COMMAND_TEST:String = "test";

        public static const RESPOND_BATTLESTATDATA:String = "xvm.battlestatdata";
        public static const RESPOND_BATTLERESULTSDATA:String = "xvm.battleresultsdata";
        public static const RESPOND_USERDATA:String = "xvm.userdata";
        public static const RESPOND_DOSSIER:String = "xvm.dossier";
        public static const RESPOND_BATTLESTATE:String = "xvm.battleState";
        public static const RESPOND_UPDATECURRENTVEHICLE:String = "xvm.updatecurrentvehicle";

        public static function log(str:String):void
        {
            _call(null, null, [COMMAND_LOG, str]);
        }

        public static function getScreenSize(target:Object, callback:Function):void
        {
            _call(target, callback, [COMMAND_GETSCREENSIZE]);
        }

        public static function getVehicleInfoData(target:Object, callback:Function):void
        {
            _call(target, callback, [COMMAND_GETVEHICLEINFODATA]);
        }

        public static function loadBattleStat(players:Array = null):void
        {
            _call(null, null, [COMMAND_LOADBATTLESTAT, players]);
        }

        public static function loadBattleResultsStat(arenaUniqueId:String):void
        {
            _call(null, null, [COMMAND_LOADBATTLERESULTSSTAT, arenaUniqueId]);
        }

        public static function loadUserData(value:String, isId:Boolean):void
        {
            _call(null, null, [COMMAND_LOADUSERDATA, value, isId]);
        }

        public static function getDossier(battleType:String, playerId:String, vehId:String):void
        {
            _call(null, null, [COMMAND_GETDOSSIER, battleType, playerId, vehId]);
        }

        public static function openUrl(url:String):void
        {
            _call(null, null, [COMMAND_OPEN_URL, url]);
        }

        public static function logStat():void
        {
            _call(null, null, [COMMAND_LOGSTAT]);
        }

        public static function loadSettings(target:Object, callback:Function, key:String):void
        {
            _call(target, callback, [COMMAND_LOAD_SETTINGS, key]);
        }

        public static function saveSettings(key:String, value:String):void
        {
            _call(null, null, [COMMAND_SAVE_SETTINGS, key, value]);
        }

        public static function runTest(... args):void
        {
            if (args[0] == "battleResults")
                args[1] = args[1].replace(".dat", "");
            args.unshift(COMMAND_TEST);
            _call(null, null, args);
        }

        /////////////////////////////////////////////////////////////////

        private static var _listeners:Object = {};
        private static var _counter:int = 0;

        private static function _call(target:Object, callback:Function, args:Array):void
        {
            _call_internal(target, callback, args, "xvm.cmd");
        }

        private static var _xvm_sandbox_cmd_initialized:Boolean = false;
        private static function _call_internal(target:Object, callback:Function, args:Array, cmd:String):void
        {
            if (!_xvm_sandbox_cmd_initialized)
            {
                ExternalInterface.addCallback("xfw.respond", _callback);
                ExternalInterface.addCallback("xvm.respond", _callback);
                setTimeout(function():void {
                    Cmd._xvm_sandbox_cmd_initialized = true;
                    Cmd._call_internal(target, callback, args, cmd);
                }, 1);
            }
            else
            {
                //Logger.add(">>> Cmd.send: " + com.xvm.JSONx.stringify(arguments, "", true));
                var id:String = Sandbox.GetCurrentSandboxPrefix() + String(++_counter);
                if (callback != null)
                    _listeners[id] = {target:target, callback:callback};
                args.unshift(cmd, id);
                ExternalInterface.call.apply(null, args);
            }
        }

        private static function _callback(id:String, data:*):void
        {
            if (!_listeners.hasOwnProperty(id))
                return;
            try
            {
                var callback:Function = _listeners[id].callback;
                if (callback != null)
                    callback.call(_listeners[id].target, data);
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
            finally
            {
                delete _listeners[id];
            }
        }
    }
}
