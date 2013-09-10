package net.wg.gui.components.controls 
{
    import flash.display.*;
    import flash.events.*;
    import flash.ui.*;
    import net.wg.gui.events.*;
    import net.wg.utils.*;
    import scaleform.clik.constants.*;
    import scaleform.clik.controls.*;
    import scaleform.clik.events.*;
    import scaleform.clik.ui.*;
    import scaleform.gfx.*;
    
    public class NumericStepper extends scaleform.clik.controls.NumericStepper
    {
        public function NumericStepper()
        {
            this._textFilter = [];
            super();
            tabChildren = true;
            return;
        }

        protected override function updateAfterStateChange():void
        {
            invalidateSize();
            if (!(constraints == null) && !constraintsDisabled) 
                constraints.updateElement("textField", textField);
            return;
        }

        protected override function onNext(arg1:scaleform.clik.events.ButtonEvent):void
        {
            if (!isNaN(this._manualValue)) 
                this.normalizeValue();
            super.onNext(arg1);
            var loc1:*;
            this.selectionPosEnd = loc1 = String(value).length;
            this.selectionPosBegin = loc1;
            textField.setSelection(this.selectionPosBegin, this.selectionPosEnd);
            return;
        }

        protected override function onPrev(arg1:scaleform.clik.events.ButtonEvent):void
        {
            if (!isNaN(this._manualValue)) 
                this.normalizeValue();
            super.onPrev(arg1);
            var loc1:*;
            this.selectionPosEnd = loc1 = String(value).length;
            this.selectionPosBegin = loc1;
            textField.setSelection(this.selectionPosBegin, this.selectionPosEnd);
            return;
        }

        protected function onChanged(arg1:flash.events.Event):void
        {
            var loc1:*=App.utils.scheduler;
            loc1.cancelTask(this.normalizeValue);
            var loc2:*=stripNulls(textField.text);
            if (this.integral) 
                loc2 = stripDecimal(loc2);
            var loc3:*=Number(loc2);
            if (textField.text == "" || isNaN(loc3)) 
                loc3 = _minimum;
            this._manualValue = loc3;
            loc1.scheduleTask(this.normalizeValue, 1000);
            return;
        }

        protected function normalizeValue():void
        {
            if (!isNaN(this._manualValue)) 
            {
                this.value = this._manualValue;
                this.isValueChanged = true;
                invalidate();
            }
            this._manualValue = Number.NaN;
            return;
        }

        public function set textFilter(arg1:Array):void
        {
            if (this._textFilter == arg1) 
                return;
            this._textFilter = arg1;
            this.isTextFilterChanged = true;
            invalidate();
            return;
        }

        protected override function changeFocus():void
        {
            super.changeFocus();
            return;
        }

        protected function onKillTextFieldFocus(arg1:flash.events.FocusEvent):void
        {
            this.normalizeValue();
            return;
        }

        protected function onSetTextFieldFocus(arg1:flash.events.FocusEvent):void
        {
            this.selectionPosBegin = 0;
            this.selectionPosEnd = String(value).length;
            textField.setSelection(this.selectionPosBegin, this.selectionPosEnd);
            invalidate();
            textField.scrollH = 0;
            this.setState("focused");
            return;
        }

        internal function mouseScrollWheelHandler(arg1:flash.events.MouseEvent):void
        {
            this.scrollWheel(arg1.delta);
            return;
        }

        protected function onNextBtnOut(arg1:scaleform.clik.events.ButtonEvent):void
        {
            net.wg.gui.components.controls.SoundButton(nextBtn).clearRepeatInterval();
            return;
        }

        protected function onPrevBtnOut(arg1:scaleform.clik.events.ButtonEvent):void
        {
            net.wg.gui.components.controls.SoundButton(prevBtn).clearRepeatInterval();
            return;
        }

        protected function onNextBtnOver(arg1:scaleform.clik.events.ButtonEvent):void
        {
            net.wg.gui.components.controls.SoundButton(nextBtn).beginButtonRepeat();
            return;
        }

        protected function onPrevBtnOver(arg1:scaleform.clik.events.ButtonEvent):void
        {
            net.wg.gui.components.controls.SoundButton(prevBtn).beginButtonRepeat();
            return;
        }

        protected static function stripNulls(arg1:String):String
        {
            while (arg1.length > 1 && !(arg1.substr(0, 2) == "0.") && arg1.length > 0 && arg1.substr(0, 1) == "0") 
                arg1 = arg1.substr(1, (arg1.length - 1));
            return arg1;
        }

        protected static function stripDecimal(arg1:String):String
        {
            var loc1:*=arg1.split(".");
            var loc2:*=loc1.join("").split(",");
            return loc2.join("");
        }

        protected override function initialize():void
        {
            nextBtn = this.nextBtn1 as net.wg.gui.components.controls.SoundButton;
            prevBtn = this.prevBtn1 as net.wg.gui.components.controls.SoundButton;
            super.initialize();
            return;
        }

        public override function set maximum(arg1:Number):void
        {
            if (_maximum == arg1) 
                return;
            _maximum = stepSize * Math.floor(arg1 / stepSize);
            this.value = _value;
            return;
        }

        public override function set minimum(arg1:Number):void
        {
            if (_minimum == arg1) 
                return;
            _minimum = stepSize * Math.floor(arg1 / stepSize);
            this.value = _value;
            return;
        }

        public function get integral():Boolean
        {
            return this._integral;
        }

        public function set integral(arg1:Boolean):void
        {
            if (this._integral == arg1) 
                return;
            this._integral = arg1;
            this._integralDirty = true;
            invalidate();
            return;
        }

        public override function set value(arg1:Number):void
        {
            arg1 = lockValue(arg1);
            if (arg1 == _value) 
                return;
            var loc1:*=_value;
            _value = arg1;
            if (initialized) 
                dispatchEventAndSound(new scaleform.clik.events.IndexEvent(scaleform.clik.events.IndexEvent.INDEX_CHANGE, true, false, value, loc1, null));
            this.isValueChanged = true;
            invalidate();
            return;
        }

        public function get textColor():Number
        {
            return this._textColor;
        }

        public function set textColor(arg1:Number):void
        {
            if (this._textColor == arg1) 
                return;
            this._textColor = arg1;
            this.isTextColorChanged = true;
            invalidate();
            return;
        }

        public function get textFilter():Array
        {
            return this._textFilter;
        }

        protected function scrollWheel(arg1:Number):void
        {
            if (!enabled) 
                return;
            if (arg1 > 0) 
                this.onNext(null);
            else 
                this.onPrev(null);
            return;
        }

        public function get selectionTextColor():uint
        {
            return this._selectionTextColor;
        }

        public function set selectionTextColor(arg1:uint):void
        {
            this._selectionTextColor = this.rgbToArgb(arg1);
            scaleform.gfx.TextFieldEx.setSelectionTextColor(textField, this._selectionTextColor);
            scaleform.gfx.TextFieldEx.setInactiveSelectionTextColor(textField, this.rgbToArgb(textField.textColor));
            return;
        }

        public function get selectionBgColor():uint
        {
            return this._selectionBgColor;
        }

        public function set selectionBgColor(arg1:uint):void
        {
            this._selectionBgColor = this.rgbToArgb(arg1);
            scaleform.gfx.TextFieldEx.setSelectionBkgColor(textField, this._selectionBgColor);
            scaleform.gfx.TextFieldEx.setInactiveSelectionBkgColor(textField, 0);
            return;
        }

        internal function rgbToArgb(arg1:uint):uint
        {
            return 4278190080 + arg1;
        }

        public override function handleInput(arg1:scaleform.clik.events.InputEvent):void
        {
            if (arg1.isDefaultPrevented()) 
                return;
            var loc1:*=arg1.details;
            var loc2:*=loc1.value == scaleform.clik.constants.InputValue.KEY_DOWN || loc1.value == scaleform.clik.constants.InputValue.KEY_HOLD;
            var loc3:*=loc1.navEquivalent;
            switch (loc3) 
            {
                case scaleform.clik.constants.NavigationCode.UP:
                    if (_value < _maximum) 
                        if (loc2) 
                            this.onNext(null);
                    else 
                    {
                        this.selectionPosEnd = loc3 = String(value).length;
                        this.selectionPosBegin = loc3;
                        textField.setSelection(this.selectionPosBegin, this.selectionPosEnd);
                        invalidate();
                    }
                    arg1.handled = true;
                    break;
                case scaleform.clik.constants.NavigationCode.LEFT:
                case scaleform.clik.constants.NavigationCode.RIGHT:
                    break;
                case scaleform.clik.constants.NavigationCode.DOWN:
                    if (loc2 && _value > _minimum) 
                        this.onPrev(null);
                    arg1.handled = true;
                    break;
                case scaleform.clik.constants.NavigationCode.HOME:
                    if (!loc2 && !loc1.shiftKey) 
                        this.value = _minimum;
                    arg1.handled = true;
                    break;
                case scaleform.clik.constants.NavigationCode.END:
                    if (!loc2 && !loc1.shiftKey) 
                        this.value = _maximum;
                    arg1.handled = true;
                    break;
                case scaleform.clik.constants.NavigationCode.ENTER:
                    if (!loc2) 
                        if (loc1.code == flash.ui.Keyboard.ENTER) 
                        {
                            this.normalizeValue();
                            if (initialized) 
                                dispatchEvent(new net.wg.gui.events.NumericStepperEvent(net.wg.gui.events.NumericStepperEvent.SUBMIT));
                        }
            }
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            this.selectionTextColor = this._selectionTextColor;
            this.selectionBgColor = this._selectionBgColor;
            textField.addEventListener(flash.events.Event.CHANGE, this.onChanged);
            tabEnabled = _focusable;
            tabChildren = true;
            if (textField != null) 
            {
                var loc1:*;
                textField.mouseEnabled = loc1 = true;
                textField.tabEnabled = loc1;
            }
            nextBtn.addEventListener(scaleform.clik.events.ButtonEvent.DRAG_OUT, this.onNextBtnOut);
            prevBtn.addEventListener(scaleform.clik.events.ButtonEvent.DRAG_OUT, this.onPrevBtnOut);
            nextBtn.addEventListener(scaleform.clik.events.ButtonEvent.DRAG_OVER, this.onNextBtnOver);
            prevBtn.addEventListener(scaleform.clik.events.ButtonEvent.DRAG_OVER, this.onPrevBtnOver);
            textField.selectable = this.enabled;
            prevBtn.repeatInterval = loc1 = 40;
            nextBtn.repeatInterval = loc1;
            prevBtn.repeatDelay = loc1 = 200;
            nextBtn.repeatDelay = loc1;
            textField.type = "input";
            textField.addEventListener(flash.events.FocusEvent.FOCUS_IN, this.onSetTextFieldFocus);
            textField.addEventListener(flash.events.FocusEvent.FOCUS_OUT, this.onKillTextFieldFocus);
            addEventListener(flash.events.MouseEvent.MOUSE_WHEEL, this.mouseScrollWheelHandler, false, 0, true);
            return;
        }

        protected override function draw():void
        {
            super.draw();
            if (this.isTextColorChanged) 
            {
                this.isTextColorChanged = false;
                textField.textColor = this._textColor;
            }
            if (this.isTextFilterChanged) 
            {
                this.isTextFilterChanged = false;
                textField.filters = null;
                textField.filters = this._textFilter;
            }
            if (this._integralDirty) 
            {
                textField.restrict = this._integral ? "0-9" : "0-9.";
                this._integralDirty = false;
            }
            if (this.isValueChanged) 
            {
                this.isValueChanged = false;
                textField.scrollH = 0;
            }
            if (this.selectionPosEnd > -1) 
            {
                textField.setSelection(this.selectionPosBegin, this.selectionPosEnd);
                this.selectionPosEnd = -1;
                this.selectionPosBegin = -1;
            }
            return;
        }

        protected override function updateLabel():void
        {
            super.updateLabel();
            return;
        }

        public var nextBtn1:net.wg.gui.components.controls.SoundButton;

        public var prevBtn1:net.wg.gui.components.controls.SoundButton;

        protected var bg:flash.display.MovieClip;

        protected var border:flash.display.MovieClip;

        internal var selectionPosBegin:Number=-1;

        internal var isValueChanged:Boolean=true;

        internal var _textColor:Number=9868935;

        internal var _textFilter:Array;

        internal var _manualValue:Number=NaN;

        internal var _selectionTextColor:uint=1973787;

        internal var _selectionBgColor:uint=9868935;

        internal var isTextColorChanged:Boolean;

        protected var _integral:Boolean=true;

        protected var _integralDirty:Boolean=true;

        internal var isTextFilterChanged:Boolean;

        internal var selectionPosEnd:Number=-1;
    }
}
