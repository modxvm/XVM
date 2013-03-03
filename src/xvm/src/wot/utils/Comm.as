import com.xvm.JSON;
import wot.utils.Defines;
import wot.utils.Logger;

class wot.utils.Comm
{
    // try to retrieve stats after: 100, 200, 300, 500, 750, 1000, 1500, 2000, 2500, 3500, 5000, 7500, 10000
    private static var timeouts = [ 100, 100, 100, 200, 250, 250,  500,  500,  500,  1000, 1500, 2500, 2500 ];

    private static var __dummy = Logger.dummy; // avoid import warning

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
        Logger.add(cmd);

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
                callback.call(target, { str:"", error:"no data" } );

            var response = JSON.parse(str);

            if (response.status == "ERROR")
            {
                if (callback)
                    callback.call(target, { error:response.error } );
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
        }
        catch (ex)
        {
            if (callback)
                callback.call(target, { str:str, error:ex } );
        }
    }
}
