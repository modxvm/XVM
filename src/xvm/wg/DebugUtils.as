package 
{
    import flash.display.*;
    
    public class DebugUtils extends Object
    {
        public function DebugUtils()
        {
            super();
            return;
        }

        public static function LOG_DEBUG(... rest):void
        {
            rest.unshift("DEBUG");
            __doLog.apply(null, rest);
            return;
        }

        public static function traceDisplayList(arg1:Object, arg2:String=""):void
        {
            var loc2:*=null;
            if (arg1 == null) 
            {
                arg1 = App.stage;
            }
            var loc1:*=0;
            while (loc1 < arg1.numChildren) 
            {
                if ((loc2 = arg1.getChildAt(loc1)) is flash.display.DisplayObjectContainer) 
                {
                    traceDisplayList(flash.display.DisplayObjectContainer(loc2));
                }
                ++loc1;
            }
            return;
        }

        public static function LOG_ERROR(... rest):void
        {
            rest.unshift("ERROR");
            __doLog.apply(null, rest);
            return;
        }

        public static function LOG_WARNING(... rest):void
        {
            rest.unshift("WARNING");
            __doLog.apply(null, rest);
            return;
        }

        public static function LOG_DEBUG_FORMAT(... rest):void
        {
            rest.unshift("DEBUG");
            __doLogFormat.apply(null, rest);
            return;
        }

        public static function LOG_ERROR_FORMAT(... rest):void
        {
            rest.unshift("ERROR");
            __doLogFormat.apply(null, rest);
            return;
        }

        public static function LOG_WARNING_FORMAT(... rest):void
        {
            rest.unshift("WARNING");
            __doLogFormat.apply(null, rest);
            return;
        }

        internal static function __doLog():void
        {
            trace("[" + arguments[0] + "] " + String(arguments.slice(1)));
            var loc1:*=[LOG];
            while (arguments.length) 
            {
                loc1.push(String(arguments.shift()));
            }
            App.environment.call.apply(null, loc1);
            return;
        }

        internal static function __doLogFormat():void
        {
            var loc1:*=[LOG_FMT];
            while (arguments.length) 
            {
                loc1.push(String(arguments.shift()));
            }
            App.environment.call.apply(null, loc1);
            return;
        }

        public static const LOG_FMT:String="debug.LOG_GUI_FORMAT";

        public static const LOG:String="debug.LOG_GUI";
    }
}
