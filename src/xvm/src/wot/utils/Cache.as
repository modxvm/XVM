class wot.utils.Cache
{
    private static var s_cache = {};

    public static function Get(key:String, populateFunc:Function)
    {
        if (!key || !s_cache.hasOwnProperty(key))
        {
            if (!populateFunc)
                return null;
            if (!key)
                return populateFunc();
            s_cache[key] = populateFunc();
            //wot.utils.Logger.add("CACHE[" + key + "]=" + s_cache[key]);
        }
        return s_cache[key];
    }
/*
    public static function Set(key:String, value:Object)
    {
        s_cache[key] = value;
    }
*/
    public static function Remove(key:String)
    {
        delete s_cache[key];
    }

}