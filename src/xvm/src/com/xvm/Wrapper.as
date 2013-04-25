class com.xvm.Wrapper
{
    public static function override(owner:Object, worker:Object, functions:Array)
    {
        var len:Number = functions.length;
        for (var i = 0; i < len; ++i)
        {
            var func = functions[i];
            owner[func] = Wrapper.wrap(worker, func);
        }
    }

    public static function wrap(worker, func)
    {
        return function() {
            //com.xvm.Logger.add("wr:" + func);
            var f = worker[func];
            if (f == undefined)
            {
                com.xvm.Logger.add("WARNING: no worker func: " + typeof(worker) + "::" + func + "()");
                return undefined;
            }
            if (typeof(f) != "function")
            {
                com.xvm.Logger.add("WARNING: not a function: " + typeof(worker) + "::" + func + "()");
                return undefined;
            }
            return f.apply(worker, arguments); 
        }
    }
}