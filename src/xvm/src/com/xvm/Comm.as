import com.xvm.Defines;
import com.xvm.JSONx;
import com.xvm.Sandbox;

class com.xvm.Comm
{
    // try to retrieve stats after: 100, 200, 300, 500, 750, 1000, 1500, 2000, 2500, 3500, 5000, 7500, 10000
    private static var timeouts = [ 100, 100, 100, 200, 250, 250,  500,  500,  500,  1000, 1500, 2500, 2500 ];

    public static function SetVar(name:String, value:String):Void
    {
        (new LoadVars()).load(Defines.COMMAND_VAR + " " + name + "=" + value);
    }
 
    public static function Sync(command:String, arg:String, target:Object, callback:Function):Void
    {
        var lv:LoadVars = new LoadVars();
        lv.onData = function(str: String)
        {
            if (callback)
                callback.call(target, { str:str } );
        }
        lv.load(command + (arg && arg != "" ? " " + arg : ""));
    }

    public static var commandId = 0;
    public static function SyncEncoded(command:String, arg:String, target:Object, callback:Function):Void
    {
        var a:Array = arg.split("");
        var s:String = "";
        var a_length:Number = a.length;
        for (var i = 0; i < a_length; ++i)
        {
            var b:Number = a[i].charCodeAt(0);
            var c:String = (b < 128) ? b.toString(16) : escape(a[i].charAt(0)).split("%").join("");
           s += (c.length % 2 == 0 ? "" : "0") + c;
        }

        command += " " + Sandbox.GetCurrentSandboxPrefix() + (commandId++).toString(16) + ",";
        var partId = 0;
        s = s.length.toString(16) + "," + s;

        var sa:Array = [];
        while (s.length > 0)
        {
            var c = command + (partId++).toString(16) + ",";
            var m = Math.min(s.length, Defines.MAX_PATH - c.length);
            sa.push(c + s.slice(0, m))
            s = s.slice(m);
        }

        var lv:LoadVars = new LoadVars();
        var n = sa.length;
        lv.onData = function(str: String)
        {
            n--;
            if (n == 0 && callback)
                callback.call(target, { str:str } );
        }
        for (var i = 0; i < sa.length; ++i)
            lv.load(sa[i]);
    }

    /**
     * Run async command. Callback will be called after result received or timeout.
     * @param command command
     * @param resultId id of result, or -1 for auto
     * @param arg arguments string or null
     * @param target target object or null
     * @param callback callback function (required)
     * @param _recursiveData internal argument, must ne null or omitted
     */
    public static function Async(command:String, resultId:Number, arg:String, target:Object, callback:Function, _recursiveData:Object):Void
    {
        //if (!_recursiveData)
        //    Logger.add(command + " " + arg);
        var rData = _recursiveData || { resultId: resultId, timeoutId: -1 }

        var cmd = command + " " + rData.resultId + " " + (rData.timeoutId + 1) + (rData.resultId != -1 ? "" : " " + arg);
        //Logger.add(cmd);

        var lv:LoadVars = new LoadVars();
        lv.onData = function(str) { Comm.onAsyncData(str, command, resultId, arg, target, callback, rData); };
        lv.load(cmd);
    }

    private static function onAsyncData(str:String, command, resultId, arg, target, callback, rData)
    {
        //Logger.add(">> " + str)
        try
        {
            if (str == "" && callback)
            {
                callback.call(target, { str:"", error:"no data" } );
                return;
            }

            var response = JSONx.parse(str);

            if (response.status == "ERROR")
            {
                if (callback)
                    callback.call(target, { str:str, error:response.error } );
                return;
            }

            if (response.status == "NOT_READY")
            {
                rData.resultId = response.resultId;
                rData.timeoutId++;
                if (rData.timeoutId >= Comm.timeouts.length) {
                    if (callback)
                        callback.call(target, { resultId:rData.resultId, str:str, error: "timeout" } );
                    return;
                }
                var timer:Function = _global.setTimeout(function()
                    { Comm.Async(command, rData.resultId, arg, target, callback, rData); },
                    Comm.timeouts[rData.timeoutId]);
                return;
            }

            if (callback)
                callback.call(target, { str:str } );
            return;
        }
        catch (ex)
        {
            if (callback)
                callback.call(target, { str:str, error:ex } );
            return;
        }
    }

    public static function SaveSettings(key:String, value:Object):Void
    {
        SyncEncoded(Defines.COMMAND_SAVE_SETTINGS, key + ";" + JSONx.stringify(value, "", true));
    }

    public static function LoadSettings(key:String, target:Object, callback:Function):Void
    {
        SyncEncoded(Defines.COMMAND_LOAD_SETTINGS, key, target, callback);
    }
}
