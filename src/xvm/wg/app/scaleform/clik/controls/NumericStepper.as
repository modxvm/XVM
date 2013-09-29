package scaleform.clik.controls 
{
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;
    import scaleform.clik.constants.*;
    import scaleform.clik.core.*;
    import scaleform.clik.events.*;
    import scaleform.clik.ui.*;
    import scaleform.clik.utils.*;
    
    public class NumericStepper extends scaleform.clik.core.UIComponent
    {
        public function NumericStepper()
        {
            super();
            return;
        }

        public function decrement():void
        {
            this.onPrev(null);
            return;
        }

        public override function handleInput(arg1:scaleform.clik.events.InputEvent):void
        {
            if (arg1.isDefaultPrevented()) 
            {
                return;
            }
            var loc1:*=arg1.details;
            var loc2:*=loc1.controllerIndex;
            var loc3:*=loc1.value == scaleform.clik.constants.InputValue.KEY_DOWN || loc1.value == scaleform.clik.constants.InputValue.KEY_HOLD;
            var loc4:*=loc1.navEquivalent;
            switch (loc4) 
            {
                case scaleform.clik.constants.NavigationCode.RIGHT:
                {
                    if (this._value < this._maximum) 
                    {
                        if (loc3) 
                        {
                            this.onNext(null);
                        }
                        arg1.handled = true;
                    }
                    break;
                }
                case scaleform.clik.constants.NavigationCode.LEFT:
                {
                    if (this._value > this._minimum) 
                    {
                        if (loc3) 
                        {
                            this.onPrev(null);
                        }
                        arg1.handled = true;
                    }
                    break;
                }
                case scaleform.clik.constants.NavigationCode.HOME:
                {
                    if (!loc3) 
                    {
                        this.value = this._minimum;
                    }
                    arg1.handled = true;
                    break;
                }
                case scaleform.clik.constants.NavigationCode.END:
                {
                    if (!loc3) 
                    {
                        this.value = this._maximum;
                    }
                    arg1.handled = true;
                    break;
                }
            }
            return;
        }

        public override function toString():String
        {
            return "[CLIK NumericStepper " + name + "]";
        }

        protected override function configUI():void
        {
            if (!this.constraintsDisabled) 
            {
                constraints.addElement("textField", this.textField, scaleform.clik.utils.Constraints.LEFT | scaleform.clik.utils.Constraints.RIGHT);
            }
            addEventListener(scaleform.clik.events.InputEvent.INPUT, this.handleInput, false, 0, true);
            this.nextBtn.addEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.onNext, false, 0, true);
            this.prevBtn.addEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.onPrev, false, 0, true);
            tabEnabled = _focusable;
            tabChildren = false;
            if (this.textField != null) 
            {
                var loc1:*;
                this.textField.mouseEnabled = loc1 = false;
                this.textField.tabEnabled = loc1;
            }
            if (this.container != null) 
            {
                this.container.mouseEnabled = loc1 = false;
                this.container.tabEnabled = loc1;
            }
            this.nextBtn.enabled = loc1 = this.enabled;
            this.prevBtn.enabled = loc1;
            this.nextBtn.autoRepeat = loc1 = true;
            this.prevBtn.autoRepeat = loc1;
            this.nextBtn.focusable = loc1 = false;
            this.prevBtn.focusable = loc1;
            this.nextBtn.focusTarget = loc1 = this;
            this.prevBtn.focusTarget = loc1;
            this.nextBtn.tabEnabled = loc1 = false;
            this.prevBtn.tabEnabled = loc1;
            this.nextBtn.mouseEnabled = loc1 = true;
            this.prevBtn.mouseEnabled = loc1;
            return;
        }

        public function set maximum(arg1:Number):void
        {
            this._maximum = arg1;
            arg1 = this._value;
            return;
        }

        protected override function draw():void
        {
            if (isInvalid(scaleform.clik.constants.InvalidationType.STATE)) 
            {
                if (this._newFrame) 
                {
                    gotoAndPlay(this._newFrame);
                    this._newFrame = null;
                }
                this.updateAfterStateChange();
                dispatchEvent(new scaleform.clik.events.ComponentEvent(scaleform.clik.events.ComponentEvent.STATE_CHANGE));
            }
            if (isInvalid(scaleform.clik.constants.InvalidationType.DATA)) 
            {
                this.updateLabel();
            }
            if (isInvalid(scaleform.clik.constants.InvalidationType.SIZE)) 
            {
                setActualSize(_width, _height);
                if (!this.constraintsDisabled) 
                {
                    constraints.update(_width, _height);
                }
            }
            return;
        }

        protected override function changeFocus():void
        {
            if (_focused || _displayFocus) 
            {
                this.setState("focused", "default");
            }
            else 
            {
                this.setState("default");
            }
            this.updateAfterStateChange();
            var loc1:*;
            this.nextBtn.displayFocus = loc1 = _focused > 0;
            this.prevBtn.displayFocus = loc1;
            return;
        }

        protected function handleDataChange(arg1:flash.events.Event):void
        {
            invalidate(scaleform.clik.constants.InvalidationType.DATA);
            return;
        }

        protected function updateLabel():void
        {
            var loc1:*=this._value.toString();
            if (this._labelFunction != null) 
            {
                loc1 = this._labelFunction(this._value);
            }
            this.textField.text = loc1;
            return;
        }

        protected function onNext(arg1:scaleform.clik.events.ButtonEvent):void
        {
            this.value = this._value + this.stepSize;
            return;
        }

        protected function onPrev(arg1:scaleform.clik.events.ButtonEvent):void
        {
            this.value = this._value - this.stepSize;
            return;
        }

        protected function setState(... rest):void
        {
            var loc3:*=null;
            var loc4:*=null;
            if (rest.length == 1) 
            {
                loc3 = rest[0].toString();
                if (!(this.state == loc3) && _labelHash[loc3]) 
                {
                    var loc5:*;
                    this._newFrame = loc5 = loc3;
                    this.state = loc5;
                    invalidateState();
                }
                return;
            }
            var loc1:*=rest.length;
            var loc2:*=0;
            while (loc2 < loc1) 
            {
                loc4 = rest[loc2].toString();
                if (_labelHash[loc4]) 
                {
                    this._newFrame = loc5 = loc4;
                    this.state = loc5;
                    invalidateState();
                    break;
                }
                ++loc2;
            }
            return;
        }

        protected function lockValue(arg1:Number):Number
        {
            var loc1:*=Math.max(this._minimum, Math.min(this._maximum, this.stepSize * Math.round(arg1 / this.stepSize)));
            return loc1;
        }

        protected override function preInitialize():void
        {
            if (!this.constraintsDisabled) 
            {
                constraints = new scaleform.clik.utils.Constraints(this, scaleform.clik.constants.ConstrainMode.COUNTER_SCALE);
            }
            return;
        }

        protected override function initialize():void
        {
            super.initialize();
            return;
        }

        public override function get enabled():Boolean
        {
            return super.enabled;
        }

        public override function set enabled(arg1:Boolean):void
        {
            if (arg1 == super.enabled) 
            {
                return;
            }
            super.enabled = arg1;
            var loc1:*;
            tabEnabled = loc1 = arg1;
            mouseEnabled = loc1;
            gotoAndPlay(arg1 ? _focused > 0 ? "focused" : "default" : "disabled");
            if (!initialized) 
            {
                return;
            }
            this.updateAfterStateChange();
            this.nextBtn.enabled = loc1 = arg1;
            this.prevBtn.enabled = loc1;
            return;
        }

        public override function get focusable():Boolean
        {
            return _focusable;
        }

        public override function set focusable(arg1:Boolean):void
        {
            super.focusable = arg1;
            return;
        }

        public function get maximum():Number
        {
            return this._maximum;
        }

        protected function updateAfterStateChange():void
        {
            invalidateSize();
            this.updateLabel();
            if (this.textField != null) 
            {
                var loc1:*;
                this.textField.mouseEnabled = loc1 = false;
                this.textField.tabEnabled = loc1;
            }
            if (this.container != null) 
            {
                this.container.mouseEnabled = loc1 = false;
                this.container.tabEnabled = loc1;
            }
            if (!(constraints == null) && !this.constraintsDisabled) 
            {
                constraints.updateElement("textField", this.textField);
            }
            return;
        }

        public function get minimum():Number
        {
            return this._minimum;
        }

        public function set minimum(arg1:Number):void
        {
            this._minimum = arg1;
            arg1 = this._value;
            return;
        }

        public function get value():Number
        {
            return this._value;
        }

        public function set value(arg1:Number):void
        {
            arg1 = this.lockValue(arg1);
            if (arg1 == this._value) 
            {
                return;
            }
            var loc1:*=this._value;
            this._value = arg1;
            if (initialized) 
            {
                dispatchEventAndSound(new scaleform.clik.events.IndexEvent(scaleform.clik.events.IndexEvent.INDEX_CHANGE, true, false, this.value, loc1, null));
            }
            invalidate();
            return;
        }

        public function get labelFunction():Function
        {
            return this._labelFunction;
        }

        public function set labelFunction(arg1:Function):void
        {
            this._labelFunction = arg1;
            this.updateLabel();
            return;
        }

        public function increment():void
        {
            this.onNext(null);
            return;
        }

        public var stepSize:Number=1;

        public var constraintsDisabled:Boolean=false;

        protected var _maximum:Number=10;

        protected var _minimum:Number=0;

        protected var _value:Number=0;

        protected var _labelFunction:Function;

        protected var state:String="default";

        protected var _newFrame:String;

        public var textField:flash.text.TextField;

        public var nextBtn:scaleform.clik.controls.Button;

        public var prevBtn:scaleform.clik.controls.Button;

        public var container:flash.display.MovieClip;

        protected var _stepSize:Number;
    }
}
