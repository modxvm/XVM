package net.wg.gui.components.controls
{
    import scaleform.clik.controls.StatusIndicator;
    
    public class StatusIndicatorAnim extends StatusIndicator
    {
        
        public function StatusIndicatorAnim()
        {
            super();
        }
        
        private var _useAnim:Boolean = false;
        
        private var _callback:Function = null;
        
        private var ANIM_STEP_TIME:Number = 40;
        
        private var NUM_CYCLES:Number = 20;
        
        private var _curCycle:Number = 0;
        
        private var _step:Number = 0;
        
        override public function set value(param1:Number) : void
        {
            var _loc2_:Number = Math.max(_minimum,Math.min(_maximum,param1));
            if(_value == _loc2_)
            {
                return;
            }
            if(this._useAnim)
            {
                this.animUpdatePosition(_loc2_);
            }
            else
            {
                _value = _loc2_;
                this.updatePosition();
            }
        }
        
        private function animUpdatePosition(param1:Number) : void
        {
            this._step = Math.ceil((param1 - value) / this.NUM_CYCLES);
            this._curCycle = this.NUM_CYCLES;
            App.utils.scheduler.cancelTask(this.animIndicator);
            App.utils.scheduler.scheduleTask(this.animIndicator,this.ANIM_STEP_TIME,param1);
        }
        
        private function animIndicator(param1:Number) : void
        {
            this._curCycle--;
            if(this._curCycle == -1)
            {
                _value = param1;
                App.utils.scheduler.cancelTask(this.animIndicator);
            }
            else
            {
                _value = _value + this._step;
                App.utils.scheduler.scheduleTask(this.animIndicator,this.ANIM_STEP_TIME,param1);
            }
            this.updatePosition();
        }
        
        override protected function updatePosition() : void
        {
            super.updatePosition();
            if(this.callback != null)
            {
                this.callback.call(null);
            }
        }
        
        public function get callback() : Function
        {
            return this._callback;
        }
        
        public function set callback(param1:Function) : void
        {
            this._callback = param1;
        }
        
        override protected function onDispose() : void
        {
            App.utils.scheduler.cancelTask(this.animIndicator);
            super.onDispose();
        }
        
        public function get useAnim() : Boolean
        {
            return this._useAnim;
        }
        
        public function set useAnim(param1:Boolean) : void
        {
            this._useAnim = param1;
        }
    }
}
