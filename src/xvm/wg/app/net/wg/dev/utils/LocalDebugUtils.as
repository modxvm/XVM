package net.wg.dev.utils
{
    public class LocalDebugUtils extends Object
    {
        
        public function LocalDebugUtils() {
            super();
        }
        
        public static function traceObjectStructure(param1:Object, param2:String = "") : void {
            var _loc3_:String = null;
            var _loc4_:* = undefined;
            var _loc5_:String = null;
            for(_loc3_ in param1)
            {
                if(_loc3_ == "")
                {
                }
                _loc4_ = param1[_loc3_];
                _loc5_ = typeof _loc4_;
                if(_loc5_ == "object" && _loc4_ is Array)
                {
                    _loc5_ = "array";
                }
                if(_loc5_ == "object")
                {
                    traceObjectStructure(_loc4_,param2 + "\t");
                }
                else if(_loc5_ == "array")
                {
                    traceArrayStructure(_loc4_ as Array,param2 + "\t");
                }
                
            }
        }
        
        public static function traceArrayStructure(param1:Array, param2:String = "") : void {
            var _loc5_:* = undefined;
            var _loc6_:String = null;
            var _loc3_:int = param1.length;
            var _loc4_:* = 0;
            while(_loc4_ < _loc3_)
            {
                _loc5_ = param1[_loc4_];
                _loc6_ = typeof _loc5_;
                if(_loc6_ == "object" && _loc5_ is Array)
                {
                    _loc6_ = "array";
                }
                if(_loc6_ == "object")
                {
                    traceObjectStructure(_loc5_,param2 + "\t");
                }
                else if(_loc6_ == "array")
                {
                    traceArrayStructure(_loc5_ as Array,param2 + "\t");
                }
                
                _loc4_++;
            }
        }
        
        public static function traceDisplayListProps(param1:Object, param2:Function = null, ... rest) : void {
            /*
             * Decompilation error
             * Code may be obfuscated
             * Error type: TranslateException
             */
            throw new Error("Not decompiled due to error");
        }
    }
}
