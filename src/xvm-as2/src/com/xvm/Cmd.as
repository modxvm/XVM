import flash.external.ExternalInterface;
import com.xvm.Sandbox;
import com.xvm.Config;

class com.xvm.Cmd
{
    private static var COMMAND_LOG:String = "log";
    private static var COMMAND_LOAD_FILE:String = "loadFile";
    private static var COMMAND_GET_CONFIG:String = "getConfig";
    private static var COMMAND_GETSCREENSIZE:String = "getScreenSize";
    private static var COMMAND_GETGAMEREGION:String = "getGameRegion";
    private static var COMMAND_GETLANGUAGE:String = "getLanguage";
    private static var COMMAND_LOADBATTLESTAT:String = "loadBattleStat";
    private static var COMMAND_LOADUSERDATA:String = "loadUserData";
    private static var COMMAND_LOGSTAT:String = "logstat";
    private static var COMMAND_SAVE_SETTINGS:String = "save_settings";
    private static var COMMAND_LOAD_SETTINGS:String = "load_settings";
    private static var COMMAND_GETVEHICLEINFODATA:String = "getVehicleInfoData";

    public static var RESPOND_BATTLEDATA = "xvm.battledata";

    public static function log(str:String)
    {
        _call(null, null, [COMMAND_LOG, str]);
    }

    public static function loadFile(filename:String, target:Object, callback:Function)
    {
        _call(target, callback, [COMMAND_LOAD_FILE, filename]);
    }

    public static function getConfig(target:Object, callback:Function)
    {
        _call(target, callback, [COMMAND_GET_CONFIG]);
    }

    public static function getScreenSize(target:Object, callback:Function)
    {
        _call(target, callback, [COMMAND_GETSCREENSIZE]);
    }

    public static function getGameRegion(target:Object, callback:Function)
    {
        _call(target, callback, [COMMAND_GETGAMEREGION]);
    }

    public static function getLanguage(target:Object, callback:Function)
    {
        _call(target, callback, [COMMAND_GETLANGUAGE]);
    }

    public static function loadBattleStat(players:Array)
    {
        _call(null, null, [COMMAND_LOADBATTLESTAT, Config.s_config.rating.showPlayersStatistics, players]);
    }

    public static function logStat()
    {
        _call(null, null, [COMMAND_LOGSTAT]);
    }

    public static function loadSettings(target:Object, callback:Function)
    {
        _call(target, callback, [COMMAND_LOAD_SETTINGS]);
    }

    public static function saveSettings(settingsStr)
    {
        _call(null, null, [COMMAND_SAVE_SETTINGS, settingsStr]);
    }

    public static function getVehicleInfoData(target:Object, callback:Function)
    {
        _call(target, callback, [COMMAND_GETVEHICLEINFODATA]);
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
