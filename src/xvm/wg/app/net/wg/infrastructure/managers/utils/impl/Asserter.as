package net.wg.infrastructure.managers.utils.impl
{
    import net.wg.utils.IAssertable;
    import net.wg.infrastructure.exceptions.AssertionException;
    import scaleform.gfx.Extensions;
    
    public final class Asserter extends Object implements IAssertable
    {
        
        public function Asserter() {
            super();
            this.assertProcessing = this.startingAssertProcessing;
        }
        
        private var assertProcessing:Function = null;
        
        private var _errorLoggingEnabled:Boolean = true;
        
        public final function assert(param1:Boolean, param2:String, param3:Class = null) : void {
            this.assertProcessing(param1,param2,param3);
        }
        
        public final function assertNotNull(param1:Object, param2:String, param3:Class = null) : void {
            this.assert(!(param1 == null),param2);
        }
        
        public final function assertNull(param1:Object, param2:String, param3:Class = null) : void {
            this.assert(param1 == null,param2);
        }
        
        public final function enableErrorLogging(param1:Boolean) : void {
            this._errorLoggingEnabled = param1;
        }
        
        private function throwException(param1:String, param2:Class = null) : void {
            var _loc3_:Error = null;
            if(param2 == null)
            {
                _loc3_ = new AssertionException(param1);
            }
            else
            {
                _loc3_ = new param2() as Error;
                this.assertNotNull(_loc3_,"ex argument must be Error object class");
            }
            _loc3_.message = param1;
            if(!Extensions.isGFxPlayer && (Extensions.isScaleform) && (this._errorLoggingEnabled))
            {
                DebugUtils.LOG_ERROR(param1);
                DebugUtils.LOG_ERROR(_loc3_.getStackTrace());
            }
            throw _loc3_;
        }
        
        private function startingAssertProcessing(param1:Boolean, param2:String, param3:Class) : void {
            var _loc4_:Function = Object(App.globalVarsMgr).isDevelopment;
            if(_loc4_ != null)
            {
                if(_loc4_())
                {
                    this.assertProcessing = this.debugAssertProcessing;
                }
                else
                {
                    this.assertProcessing = this.releaseAssertProcessing;
                }
                this.assertProcessing(param1,param2,param3);
            }
            else if(!param1)
            {
                this.throwException(param2,param3);
            }
            
        }
        
        private function debugAssertProcessing(param1:Boolean, param2:String, param3:Class) : void {
            if(!param1)
            {
                this.throwException(param2,param3);
            }
        }
        
        private function releaseAssertProcessing(param1:Boolean, param2:String, param3:Class) : void {
        }
    }
}
