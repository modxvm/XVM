/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
import com.xvm.*;
import flash.external.*;

class com.xvm.Cmd
{
    private static var COMMAND_LOG:String = "log";
    private static var COMMAND_GET_SCREEN_SIZE:String = "get_screen_size";
    private static var COMMAND_LOAD_BATTLE_STAT:String = "load_battle_stat";
    private static var COMMAND_CAPTURE_BAR_GET_BASE_NUM:String = "capture_bar_get_base_num";
    private static var COMMAND_PROF_METHOD_START:String = "prof_method_start";
    private static var COMMAND_PROF_METHOD_END:String = "prof_method_end";

    public static function log(str:String)
    {
        _call(null, null, [COMMAND_LOG, str]);
    }

    public static function getScreenSize(target:Object, callback:Function)
    {
        _call(target, callback, [COMMAND_GET_SCREEN_SIZE]);
    }

    public static function loadBattleStat(players:Array)
    {
        _call(null, null, [COMMAND_LOAD_BATTLE_STAT, players]);
    }

    public static function captureBarGetBaseNum(target:Object, callback:Function, id:Number)
    {
        _call(target, callback, [COMMAND_CAPTURE_BAR_GET_BASE_NUM, id]);
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
