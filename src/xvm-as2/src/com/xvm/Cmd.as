/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
import com.xvm.*;
import flash.external.*;

class com.xvm.Cmd
{
    private static var COMMAND_LOG:String = "log";
    private static var COMMAND_GETSCREENSIZE:String = "getScreenSize";
    private static var COMMAND_LOADBATTLESTAT:String = "loadBattleStat";
    private static var COMMAND_LOADUSERDATA:String = "loadUserData";
    private static var COMMAND_CAPTUREBARGETBASENUM:String = "captureBarGetBaseNum";
    private static var COMMAND_PROF_METHOD_START:String = "profMethodStart";
    private static var COMMAND_PROF_METHOD_END:String = "profMethodEnd";

    public static var RESPOND_CONFIG:String = "xvm.config";
    public static var RESPOND_KEY_EVENT:String = "xvm.keyevent";

    public static var RESPOND_BATTLESTATDATA:String = "xvm.battlestatdata";
    public static var RESPOND_BATTLESTATE:String = "xvm.battleState";

    public static function log(str:String)
    {
        _call(null, null, [COMMAND_LOG, str]);
    }

    public static function getScreenSize(target:Object, callback:Function)
    {
        _call(target, callback, [COMMAND_GETSCREENSIZE]);
    }

    public static function loadBattleStat(players:Array)
    {
        _call(null, null, [COMMAND_LOADBATTLESTAT, players]);
    }

    public static function captureBarGetBaseNum(target:Object, callback:Function, id:Number)
    {
        _call(target, callback, [COMMAND_CAPTUREBARGETBASENUM, id]);
    }

    public static function profMethodStart(name:String)
    {
        if (Config.IS_DEVELOPMENT)
            _call(null, null, [COMMAND_PROF_METHOD_START, name]);
    }

    public static function profMethodEnd(name:String)
    {
        if (Config.IS_DEVELOPMENT)
            _call(null, null, [COMMAND_PROF_METHOD_END, name]);
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
