class net.wargaming.utils.DebugUtils
{
    function DebugUtils()
    {
    } // End of the function
    static function LOG_DEBUG()
    {
        arguments.unshift("DEBUG");
        net.wargaming.utils.DebugUtils.__doLog.apply(null, arguments);
    } // End of the function
    static function LOG_ERROR()
    {
        arguments.unshift("ERROR");
        net.wargaming.utils.DebugUtils.__doLog.apply(null, arguments);
    } // End of the function
    static function LOG_WARNING()
    {
        arguments.unshift("WARNING");
        net.wargaming.utils.DebugUtils.__doLog.apply(null, arguments);
    } // End of the function
    static function LOG_DEBUG_FORMAT()
    {
        arguments.unshift("DEBUG");
        net.wargaming.utils.DebugUtils.__doLogFormat.apply(null, arguments);
    } // End of the function
    static function LOG_ERROR_FORMAT()
    {
        arguments.unshift("ERROR");
        net.wargaming.utils.DebugUtils.__doLogFormat.apply(null, arguments);
    } // End of the function
    static function LOG_WARNING_FORMAT()
    {
        arguments.unshift("WARNING");
        net.wargaming.utils.DebugUtils.__doLogFormat.apply(null, arguments);
    } // End of the function
    static function __doLog()
    {
        var _loc2 = ["debug.LOG_GUI"];
        while (arguments.length)
        {
            _loc2.push(String(arguments.shift()));
        } // end while
        flash.external.ExternalInterface.call.apply(null, _loc2);
    } // End of the function
    static function __doLogFormat()
    {
        var _loc2 = ["debug.LOG_GUI_FORMAT"];
        while (arguments.length)
        {
            _loc2.push(String(arguments.shift()));
        } // end while
        flash.external.ExternalInterface.call.apply(null, _loc2);
    } // End of the function
} // End of Class
