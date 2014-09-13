package
{
    import flash.display.DisplayObject;
    import flash.display.DisplayObjectContainer;
    
    public class DebugUtils extends Object
    {
        
        public function DebugUtils()
        {
            super();
        }
        
        public static var LOG_FMT:String = "debug.LOG_GUI_FORMAT";
        
        public static var LOG:String = "debug.LOG_GUI";
        
        public static function LOG_DEBUG(... rest) : void
        {
            rest.unshift("DEBUG");
            __doLog.apply(null,rest);
        }
        
        public static function traceDisplayList(param1:Object, param2:String = "") : void
        {
            var _loc4_:DisplayObject = null;
            if(param1 == null)
            {
                param1 = App.stage;
            }
            var _loc3_:Number = 0;
            while(_loc3_ < param1.numChildren)
            {
                _loc4_ = param1.getChildAt(_loc3_);
                if(_loc4_ is DisplayObjectContainer)
                {
                    traceDisplayList(DisplayObjectContainer(_loc4_));
                }
                _loc3_++;
            }
        }
        
        public static function LOG_ERROR(... rest) : void
        {
            rest.unshift("ERROR");
            __doLog.apply(null,rest);
        }
        
        public static function LOG_WARNING(... rest) : void
        {
            rest.unshift("WARNING");
            __doLog.apply(null,rest);
        }
        
        public static function LOG_DEBUG_FORMAT(... rest) : void
        {
            rest.unshift("DEBUG");
            __doLogFormat.apply(null,rest);
        }
        
        public static function LOG_ERROR_FORMAT(... rest) : void
        {
            rest.unshift("ERROR");
            __doLogFormat.apply(null,rest);
        }
        
        public static function LOG_WARNING_FORMAT(... rest) : void
        {
            rest.unshift("WARNING");
            __doLogFormat.apply(null,rest);
        }
        
        private static function __doLog() : void
        {
            var _loc2_:Array = [LOG];
            while(arguments.length)
            {
                _loc2_.push(String(arguments.shift()));
            }
            App.environment.call.apply(null,_loc2_);
        }
        
        private static function __doLogFormat() : void
        {
            var _loc2_:Array = [LOG_FMT];
            while(arguments.length)
            {
                _loc2_.push(String(arguments.shift()));
            }
            App.environment.call.apply(null,_loc2_);
        }
    }
}
