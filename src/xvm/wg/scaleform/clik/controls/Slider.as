package scaleform.clik.controls 
{
    import flash.events.*;
    import flash.geom.*;
    import scaleform.clik.constants.*;
    import scaleform.clik.core.*;
    import scaleform.clik.events.*;
    import scaleform.clik.ui.*;
    import scaleform.clik.utils.*;
    
    public class Slider extends scaleform.clik.core.UIComponent
    {
        public function Slider()
        {
            super();
            return;
        }

        public function get snapInterval():Number
        {
            return this._snapInterval;
        }

        public function set snapInterval(arg1:Number):void
        {
            this._snapInterval = arg1;
            this.invalidateSettings();
            return;
        }

        public function invalidateSettings():void
        {
            invalidate(scaleform.clik.constants.InvalidationType.SETTINGS);
            return;
        }

        public override function handleInput(arg1:scaleform.clik.events.InputEvent):void
        {
            if (arg1.isDefaultPrevented()) 
                return;
            var loc1:*=arg1.details;
            var loc2:*=loc1.controllerIndex;
            var loc3:*=loc1.value == scaleform.clik.constants.InputValue.KEY_DOWN || loc1.value == scaleform.clik.constants.InputValue.KEY_HOLD;
            var loc4:*=loc1.navEquivalent;
            switch (loc4) 
            {
                case scaleform.clik.constants.NavigationCode.RIGHT:
                    if (loc3) 
                    {
                        this.value = this.value + this._snapInterval;
                        arg1.handled = true;
                    }
                    break;
                case scaleform.clik.constants.NavigationCode.LEFT:
                    if (loc3) 
                    {
                        this.value = this.value - this._snapInterval;
                        arg1.handled = true;
                    }
                    break;
                case scaleform.clik.constants.NavigationCode.HOME:
                    if (!loc3) 
                    {
                        this.value = this.minimum;
                        arg1.handled = true;
                    }
                    break;
                case scaleform.clik.constants.NavigationCode.END:
                    if (!loc3) 
                    {
                        this.value = this.maximum;
                        arg1.handled = true;
                    }
                    break;
                default:
                    break;
            }
            return;
        }

        public function set value(arg1:Number):void
        {
            this._value = this.lockValue(arg1);
            dispatchEvent(new scaleform.clik.events.SliderEvent(scaleform.clik.events.SliderEvent.VALUE_CHANGE, false, true, this._value));
            this.draw();
            return;
        }

        public override function toString():String
        {
            return "[CLIK Slider " + name + "]";
        }

        protected override function configUI():void
        {
            addEventListener(scaleform.clik.events.InputEvent.INPUT, this.handleInput, false, 0, true);
            this.thumb.addEventListener(flash.events.MouseEvent.MOUSE_DOWN, this.beginDrag, false, 0, true);
            this.track.addEventListener(flash.events.MouseEvent.MOUSE_DOWN, this.trackPress, false, 0, true);
            tabEnabled = true;
            var loc1:*;
            this.track.focusTarget = loc1 = this;
            this.thumb.focusTarget = loc1;
            this.track.enabled = loc1 = this.enabled;
            this.thumb.enabled = loc1;
            this.thumb.lockDragStateChange = true;
            constraints.addElement("track", this.track, scaleform.clik.utils.Constraints.LEFT | scaleform.clik.utils.Constraints.RIGHT);
            return;
        }

        protected override function draw():void
        {
            if (isInvalid(scaleform.clik.constants.InvalidationType.STATE)) 
                gotoAndPlay(this.enabled ? _focused ? "focused" : "default" : "disabled");
            if (isInvalid(scaleform.clik.constants.InvalidationType.SIZE)) 
            {
                setActualSize(_width, _height);
                constraints.update(_width, _height);
            }
            this.updateThumb();
            return;
        }

        protected override function changeFocus():void
        {
            super.changeFocus();
            invalidateState();
            if (this.enabled) 
            {
                if (!this._thumbPressed) 
                    this.thumb.displayFocus = !(_focused == 0);
                if (!this._trackPressed) 
                    this.track.displayFocus = !(_focused == 0);
            }
            return;
        }

        protected function updateThumb():void
        {
            if (!this.enabled) 
                return;
            var loc1:*=_width - this.offsetLeft - this.offsetRight;
            this.thumb.x = (this._value - this._minimum) / (this._maximum - this._minimum) * loc1 - this.thumb.width / 2 + this.offsetLeft;
            return;
        }

        protected function doDrag(arg1:flash.events.MouseEvent):void
        {
            var loc1:*=globalToLocal(new flash.geom.Point(arg1.stageX, arg1.stageY));
            var loc2:*=loc1.x - this._dragOffset.x;
            var loc3:*=_width - this.offsetLeft - this.offsetRight;
            var loc4:*=this.lockValue((loc2 - this.offsetLeft) / loc3 * (this._maximum - this._minimum) + this._minimum);
            if (this.value == loc4) 
                return;
            this._value = loc4;
            this.updateThumb();
            if (this.liveDragging) 
                dispatchEvent(new scaleform.clik.events.SliderEvent(scaleform.clik.events.SliderEvent.VALUE_CHANGE, false, true, this._value));
            return;
        }

        protected function endDrag(arg1:flash.events.MouseEvent):void
        {
            stage.removeEventListener(flash.events.MouseEvent.MOUSE_MOVE, this.doDrag, false);
            stage.removeEventListener(flash.events.MouseEvent.MOUSE_UP, this.endDrag, false);
            if (!this.liveDragging) 
                dispatchEvent(new scaleform.clik.events.SliderEvent(scaleform.clik.events.SliderEvent.VALUE_CHANGE, false, true, this._value));
            this._trackDragMouseIndex = undefined;
            this._thumbPressed = false;
            this._trackPressed = false;
            return;
        }

        protected function trackPress(arg1:flash.events.MouseEvent):void
        {
            this._trackPressed = true;
            this.track.focused = _focused;
            var loc1:*=_width - this.offsetLeft - this.offsetRight;
            var loc2:*=this.lockValue((arg1.localX * scaleX - this.offsetLeft) / loc1 * (this._maximum - this._minimum) + this._minimum);
            if (this.value == loc2) 
                return;
            this.value = loc2;
            if (!this.liveDragging) 
                dispatchEvent(new scaleform.clik.events.SliderEvent(scaleform.clik.events.SliderEvent.VALUE_CHANGE, false, true, this._value));
            this._trackDragMouseIndex = 0;
            this._dragOffset = {"x":0};
            return;
        }

        protected function lockValue(arg1:Number):Number
        {
            arg1 = Math.max(this._minimum, Math.min(this._maximum, arg1));
            if (!this.snapping) 
                return arg1;
            var loc1:*=Math.round(arg1 / this.snapInterval) * this.snapInterval;
            return loc1;
        }

        protected function scrollWheel(arg1:Number):void
        {
            if (_focused) 
            {
                this.value = this.value - arg1 * this._snapInterval;
                dispatchEvent(new flash.events.Event(flash.events.Event.CHANGE));
            }
            return;
        }

        protected override function preInitialize():void
        {
            constraints = new scaleform.clik.utils.Constraints(this, scaleform.clik.constants.ConstrainMode.REFLOW);
            return;
        }

        protected override function initialize():void
        {
            super.initialize();
            tabChildren = false;
            var loc1:*;
            mouseChildren = loc1 = this.enabled;
            mouseEnabled = loc1;
            return;
        }

        public override function get enabled():Boolean
        {
            return super.enabled;
        }

        public override function set enabled(arg1:Boolean):void
        {
            if (arg1 == super.enabled) 
                return;
            super.enabled = arg1;
            var loc1:*;
            this.track.enabled = loc1 = arg1;
            this.thumb.enabled = loc1;
            return;
        }

        public override function get focusable():Boolean
        {
            return _focusable;
        }

        public override function set focusable(arg1:Boolean):void
        {
            super.focusable = arg1;
            tabChildren = false;
            return;
        }

        public function get value():Number
        {
            return this._value;
        }

        protected function beginDrag(arg1:flash.events.MouseEvent):void
        {
            this._thumbPressed = true;
            var loc1:*=globalToLocal(new flash.geom.Point(arg1.stageX, arg1.stageY));
            this._dragOffset = {"x":loc1.x - this.thumb.x - this.thumb.width / 2};
            stage.addEventListener(flash.events.MouseEvent.MOUSE_MOVE, this.doDrag, false, 0, true);
            stage.addEventListener(flash.events.MouseEvent.MOUSE_UP, this.endDrag, false, 0, true);
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
            this._minimum = arg1;
            return;
        }

        public function get position():Number
        {
            return this._value;
        }

        public function set position(arg1:Number):void
        {
            this._value = arg1;
            return;
        }

        public function get snapping():Boolean
        {
            return this._snapping;
        }

        public function set snapping(arg1:Boolean):void
        {
            this._snapping = arg1;
            this.invalidateSettings();
            return;
        }

        public var liveDragging:Boolean=true;

        public var state:String="default";

        public var offsetLeft:Number=0;

        public var offsetRight:Number=0;

        protected var _maximum:Number=10;

        protected var _value:Number=0;

        protected var _snapInterval:Number=1;

        protected var _snapping:Boolean=false;

        protected var _dragOffset:Object;

        protected var _trackDragMouseIndex:Number;

        protected var _trackPressed:Boolean=false;

        protected var _thumbPressed:Boolean=false;

        public var thumb:scaleform.clik.controls.Button;

        public var track:scaleform.clik.controls.Button;

        protected var _minimum:Number=0;
    }
}
