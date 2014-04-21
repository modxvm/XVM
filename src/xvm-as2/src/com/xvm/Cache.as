class com.xvm.Cache
{
    private static var s_cache = {};

    public static function Exist(key:String)
    {
        return key && s_cache[key] != undefined;
    }

    public static function Get(key:String, populateFunc:Function)
    {
        if (!Exist(key))
        {
            if (!populateFunc)
                return null;
            if (!key)
                return populateFunc();
            s_cache[key] = populateFunc();
            //com.xvm.Logger.add("CACHE[" + key + "]=" + s_cache[key]);
        }
        return s_cache[key];
    }

    public static function Remove(key:String)
    {
        delete s_cache[key];
    }
}
