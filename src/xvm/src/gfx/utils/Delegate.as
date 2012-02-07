class gfx.utils.Delegate extends Object
{
    function Delegate()
    {
        super();
    } // End of the function
    static function create(obj, func)
    {
        var _loc2 = function ()
        {
            var _loc2 = arguments.callee.target;
            var _loc3 = arguments.callee.func;
            return (_loc3.apply(_loc2, arguments));
        };
        _loc2.target = obj;
        _loc2.func = func;
        return (_loc2);
    } // End of the function
} // End of Class
