package net.wg.gui.lobby.referralSystem.data
{
    import net.wg.data.daapi.base.DAAPIDataClass;
    
    public class ComplexProgressIndicatorVO extends DAAPIDataClass
    {
        
        public function ComplexProgressIndicatorVO(param1:Object)
        {
            super(param1);
        }
        
        private static var FIELD_STEPS:String = "steps";
        
        public var isCompleted:Boolean = false;
        
        public var completedText:String = "";
        
        public var completedImage:String = "";
        
        public var progress:Number = 0;
        
        public var text:String = "";
        
        public var steps:Array = null;
        
        public var isProgressAvailable:Boolean = true;
        
        public var progressAlertText:String = "";
        
        override protected function onDataWrite(param1:String, param2:Object) : Boolean
        {
            var _loc3_:Array = null;
            var _loc4_:Object = null;
            var _loc5_:ProgressStepVO = null;
            if(param1 == FIELD_STEPS)
            {
                this.steps = [];
                _loc3_ = param2 as Array;
                for each(_loc4_ in _loc3_)
                {
                    _loc5_ = _loc4_?new ProgressStepVO(_loc4_):null;
                    this.steps.push(_loc5_);
                }
                return false;
            }
            return true;
        }
        
        override protected function onDispose() : void
        {
            this.disposeSteps();
            super.onDispose();
        }
        
        private function disposeSteps() : void
        {
            var _loc1_:ProgressStepVO = null;
            if(this.steps)
            {
                for each(_loc1_ in this.steps)
                {
                    if(_loc1_)
                    {
                        _loc1_.dispose();
                    }
                }
                this.steps.splice(0);
                this.steps = null;
            }
        }
    }
}
