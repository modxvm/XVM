class net.wargaming.utils.ObjectUtils
{
    function ObjectUtils()
    {
    } // End of the function
    static function cloneObj(obj)
    {
        if (typeof(obj) == "object")
        {
            var _loc2 = obj instanceof Array ? ([]) : ({});
            for (var _loc3 in obj)
            {
                _loc2[_loc3] = typeof(obj[_loc3]) == "object" ? (net.wargaming.utils.ObjectUtils.cloneObj(obj[_loc3])) : (obj[_loc3]);
            } // end of for...in
            return (_loc2);
        } // end if
        return;
    } // End of the function
} // End of Class
