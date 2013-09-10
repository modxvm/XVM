package scaleform.clik.controls 
{
    import scaleform.clik.constants.*;
    import scaleform.clik.core.*;
    
    public class StatusIndicator extends scaleform.clik.core.UIComponent
    {
        public function StatusIndicator()
        {
            super();
            return;
        }

        protected override function initialize():void
        {
            super.initialize();
            return;
        }

        public function get maximum():Number
        {
            return this._maximum;
        }

        public function set maximum(arg1:Number):void
        {
            this._maximum = arg1;
            return;
        }

        public function get minimum():Number
        {
            return this._minimum;
        }

        public function set minimum(arg1:Number):void
        {
            if (this._minimum == arg1) 
            {
                return;
            }
            this._minimum = arg1;
            this.updatePosition();
            return;
        }

        public function get value():Number
        {
            return this._value;
        }

        public function set value(arg1:Number):void
        {
            var loc1:*=Math.max(this._minimum, Math.min(this._maximum, arg1));
            if (this._value == loc1) 
            {
                return;
            }
            this._value = loc1;
            this.updatePosition();
            return;
        }

        public function get position():Number
        {
            return this._value;
        }

        public function set position(arg1:Number):void
        {
            this.value = arg1;
            return;
        }

        public override function toString():String
        {
            return "[CLIK StatusIndicator " + name + "]";
        }

        protected override function configUI():void
        {
            super.configUI();
            var loc1:*;
            focusable = loc1 = false;
            tabEnabled = loc1;
            return;
        }

        protected override function draw():void
        {
            if (isInvalid(scaleform.clik.constants.InvalidationType.SIZE)) 
            {
                setActualSize(_width, _height);
            }
            if (isInvalid(scaleform.clik.constants.InvalidationType.DATA)) 
            {
                this.updatePosition();
            }
            return;
        }

        protected function updatePosition():void
        {
            if (!enabled) 
            {
                return;
            }
            var loc1:*=(this._value - this._minimum) / (this._maximum - this._minimum);
            gotoAndStop(Math.max(1, Math.round(loc1 * totalFrames)));
            return;
        }

        protected var _maximum:Number=10;

        protected var _minimum:Number=0;

        protected var _value:Number=0;
    }
}
