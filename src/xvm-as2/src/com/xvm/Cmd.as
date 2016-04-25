/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
import com.xvm.*;
import flash.external.*;

class com.xvm.Cmd
{
    private static var COMMAND_PROF_METHOD_START:String = "prof_method_start";
    private static var COMMAND_PROF_METHOD_END:String = "prof_method_end";

    public static function profMethodStart(name:String)
    {
        if (Config.IS_DEVELOPMENT)
            _call([COMMAND_PROF_METHOD_START, name]);
    }

    public static function profMethodEnd(name:String)
    {
        if (Config.IS_DEVELOPMENT)
            _call([COMMAND_PROF_METHOD_END, name]);
    }

    /////////////////////////////////////////////////////////////////

    private static var _counter:Number = 0;

    private static function _call(args:Array)
    {
        //Logger.add(">>> Cmd.send: " + com.xvm.JSONx.stringify(arguments, "", true));
        var id:String = Sandbox.GetCurrentSandboxPrefix() + String(++_counter);
        args.unshift('xvm.cmd', id);
        ExternalInterface.call.apply(null, args);
    }
}
