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

    public static function wrap(obj, func)
    {
        return function() {
            //com.xvm.Logger.add("wr:" + func);
            return obj[func].apply(obj, arguments); 
        }
    }
}