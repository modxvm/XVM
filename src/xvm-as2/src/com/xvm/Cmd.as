/**
 * XVM
 * @author Maxim Schedriviy <m.schedriviy(at)gmail.com>
 */
import com.xvm.*;
import flash.external.*;

class com.xvm.Cmd
{
    private static var COMMAND_LOG:String = "log";
    private static var COMMAND_SET_CONFIG:String = "setConfig";
    private static var COMMAND_GETSCREENSIZE:String = "getScreenSize";
    private static var COMMAND_LOADBATTLESTAT:String = "loadBattleStat";
    private static var COMMAND_LOADUSERDATA:String = "loadUserData";
    private static var COMMAND_LOGSTAT:String = "logstat";

    public static var RESPOND_CONFIG = "xvm.config";
    public static var RESPOND_BATTLEDATA = "xvm.battledata";
    public static var RESPOND_BATTLESTATE = "xvm.battleState";

    public static function log(str:String)
    {
        _call(null, null, [COMMAND_LOG, str]);
    }

    public static function setConfig()
    {
        _call(null, null, [COMMAND_SET_CONFIG, JSONx.stringify(Config.config, '', true)]);
    }

    public static function getScreenSize(target:Object, callback:Function)
    {
        _call(target, callback, [COMMAND_GETSCREENSIZE]);
    }

    public static function loadBattleStat(players:Array)
    {
        _call(null, null, [COMMAND_LOADBATTLESTAT, Config.config.rating.showPlayersStatistics, players]);
    }

    public static function logStat()
    {
        _call(null, null, [COMMAND_LOGSTAT]);
    }

    /////////////////////////////////////////////////////////////////

    private static var _listeners:Object = {};
    private static var _counter:Number = 0;

    private static var _xvm_sandbox_cmd_initialized:Boolean = false;
    private static function _call(target:Object, callback:Function, args:Array)
    {
        if (!_xvm_sandbox_cmd_initialized)
        {
            ExternalInterface.addCallback("xvm.respond", null, _callback);
            setTimeout(function() {
                Cmd._xvm_sandbox_cmd_initialized = true;
                Cmd._call(target, callback, args);
            }, 1);
        }
        else
        {
            //Logger.add(">>> Cmd.send: " + com.xvm.JSONx.stringify(arguments, "", true));
            var id:String = Sandbox.GetCurrentSandboxPrefix() + String(++_counter);
            if (callback != null)
                _listeners[id] = {target:target, callback:callback};
            args.unshift('xvm.cmd', id);
            ExternalInterface.call.apply(null, args);
        }
    }

    private static function _callback(id:String, data)
    {
        if (!_listeners.hasOwnProperty(id))
            return;
        try
        {
            var callback:Function = _listeners[id].callback;
            if (callback != null)
                callback.call(_listeners[id].target, data);
        }
        finally
        {
            delete _listeners[id];
        }
    }
}
