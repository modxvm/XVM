import gfx.io.GameDelegate;
import com.xvm.Logger;

class com.xvm.Cmd
{
    private static var COMMAND_LOG:String = "log";
    private static var COMMAND_GETSTAT:String = "getstat";
    private static var COMMAND_VAR:String = "var";
    private static var COMMAND_LOGSTAT:String = "logstat";
    private static var COMMAND_PING:String = "ping";
    private static var COMMAND_SAVE_SETTINGS:String = "save_settings";
    private static var COMMAND_LOAD_SETTINGS:String = "load_settings";

    public static function ping(target:Object, callback:String)
    {
        _call(target, callback, [COMMAND_PING]);
    }

    /////////////////////////////////////////////////////////////////
    
    private static function _call(target:Object, callback:String, args:Array):Void
    {
        //Logger.add(">>> Cmd.send: " + com.xvm.JSONx.stringify(arguments, "", true));
        GameDelegate.call("xvm.cmd", args, target, callback);
    }
}
