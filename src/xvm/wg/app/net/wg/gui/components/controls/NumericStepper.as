package net.wg.gui.components.controls
{
    import scaleform.clik.controls.NumericStepper;
    import flash.display.MovieClip;
    import scaleform.clik.events.ButtonEvent;
    import flash.events.FocusEvent;
    import scaleform.clik.events.IndexEvent;
    import scaleform.gfx.TextFieldEx;
    import scaleform.clik.events.InputEvent;
    import scaleform.clik.ui.InputDetails;
    import scaleform.clik.constants.InputValue;
    import flash.ui.Keyboard;
    import net.wg.gui.events.NumericStepperEvent;
    import scaleform.clik.constants.NavigationCode;
    import flash.events.Event;
    import flash.events.MouseEvent;
    import net.wg.utils.IScheduler;
    
    public class NumericStepper extends scaleform.clik.controls.NumericStepper
    {
        
        public function NumericStepper() {
            this._textFilter = [];
            super();
            tabChildren = true;
        }
        
        protected static function stripNulls(param1:String) : String {
            while(param1.length > 1 && !(param1.substr(0,2) == "0.") && param1.length > 0 && param1.substr(0,1) == "0")
            {
                param1 = param1.substr(1,param1.length - 1);
            }
            return param1;
        }
        
        protected static function stripDecimal(param1:String) : String {
            var _loc2_:Array = param1.split(".");
            var _loc3_:Array = _loc2_.join("").split(",");
            return _loc3_.join("");
        }
        
        public var nextBtn1:SoundButton;
        
        public var prevBtn1:SoundButton;
        
        protected var bg:MovieClip;
        
        protected var border:MovieClip;
        
        private var selectionPosBegin:Number = -1;
        
        private var selectionPosEnd:Number = -1;
        
        private var isValueChanged:Boolean = true;
        
        private var _textColor:Number = 9868935;
        
        private var _textFilter:Array;
        
        private var _manualValue:Number = NaN;
        
        private var _selectionTextColor:uint = 1973787;
        
        private var _selectionBgColor:uint = 9868935;
        
        private var isTextColorChanged:Boolean;
        
        protected var _integral:Boolean = true;
        
        protected var _integralDirty:Boolean = true;
        
        private var isTextFilterChanged:Boolean;
        
        override protected function onDispose() : void {
            nextBtn.removeEventListener(ButtonEvent.DRAG_OUT,this.onNextBtnOut);
            prevBtn.removeEventListener(ButtonEvent.DRAG_OUT,this.onPrevBtnOut);
            nextBtn.removeEventListener(ButtonEvent.DRAG_OVER,this.onNextBtnOver);
            prevBtn.removeEventListener(ButtonEvent.DRAG_OVER,this.onPrevBtnOver);
            textField.removeEventListener(FocusEvent.FOCUS_IN,this.onSetTextFieldFocus);
            textField.removeEventListener(FocusEvent.FOCUS_OUT,this.onKillTextFieldFocus);
            this.nextBtn1.dispose();
            this.nextBtn1 = null;
            this.prevBtn1.dispose();
            this.prevBtn1 = null;
            this.bg = null;
            this.border = null;
            this._textFilter.splice(0,this._textFilter.length);
            this._textFilter = null;
            super.onDispose();
        }
        
        override protected function initialize() : void {
            nextBtn = this.nextBtn1 as SoundButton;
            prevBtn = this.prevBtn1 as SoundButton;
            super.initialize();
        }
        
        override public function set maximum(param1:Number) : void {
            if(_maximum == param1)
            {
                return;
            }
            _maximum = stepSize * Math.floor(param1 / stepSize);
            this.value = _value;
        }
        
        override public function set minimum(param1:Number) : void {
            if(_minimum == param1)
            {
                return;
            }
            _minimum = stepSize * Math.floor(param1 / stepSize);
            this.value = _value;
        }
        
        public function get integral() : Boolean {
            return this._integral;
        }
        
        public function set integral(param1:Boolean) : void {
            if(this._integral == param1)
            {
                return;
            }
            this._integral = param1;
            this._integralDirty = true;
            invalidate();
        }
        
        override public function set value(param1:Number) : void {
            var param1:Number = lockValue(param1);
            if(param1 == _value)
            {
                return;
            }
            var _loc2_:Number = _value;
            _value = param1;
            if(initialized)
            {
                dispatchEventAndSound(new IndexEvent(IndexEvent.INDEX_CHANGE,true,false,value,_loc2_,null));
            }
            this.isValueChanged = true;
            invalidate();
        }
        
        public function get textColor() : Number {
            return this._textColor;
        }
        
        public function set textColor(param1:Number) : void {
            if(this._textColor == param1)
            {
                return;
            }
            this._textColor = param1;
            this.isTextColorChanged = true;
            invalidate();
        }
        
        public function get textFilter() : Array {
            return this._textFilter;
        }
        
        public function set textFilter(param1:Array) : void {
            if(this._textFilter == param1)
            {
                return;
            }
            this._textFilter = param1;
            this.isTextFilterChanged = true;
            invalidate();
        }
        
        public function get selectionTextColor() : uint {
            return this._selectionTextColor;
        }
        
        public function set selectionTextColor(param1:uint) : void {
            this._selectionTextColor = this.rgbToArgb(param1);
            TextFieldEx.setSelectionTextColor(textField,this._selectionTextColor);
            TextFieldEx.setInactiveSelectionTextColor(textField,this.rgbToArgb(textField.textColor));
        }
        
        public function get selectionBgColor() : uint {
            return this._selectionBgColor;
        }
        
        public function set selectionBgColor(param1:uint) : void {
            this._selectionBgColor = this.rgbToArgb(param1);
            TextFieldEx.setSelectionBkgColor(textField,this._selectionBgColor);
            TextFieldEx.setInactiveSelectionBkgColor(textField,0);
        }
        
        private function rgbToArgb(param1:uint) : uint {
            return 4.27819008E9 + param1;
        }
        
        override public function handleInput(param1:InputEvent) : void {
            if(param1.isDefaultPrevented())
            {
                return;
            }
            var _loc2_:InputDetails = param1.details;
            var _loc3_:Boolean = _loc2_.value == InputValue.KEY_DOWN || _loc2_.value == InputValue.KEY_HOLD;
            switch(_loc2_.navEquivalent)
            {
                case NavigationCode.UP:
                    if(_value < _maximum)
                    {
                        if(_loc3_)
                        {
                            this.onNext(null);
                        }
                    }
                    else
                    {
                        this.selectionPosBegin = this.selectionPosEnd = String(value).length;
                        textField.setSelection(this.selectionPosBegin,this.selectionPosEnd);
                        invalidate();
                    }
                    param1.handled = true;
                    break;
                case NavigationCode.LEFT:
                case NavigationCode.RIGHT:
                    break;
                case NavigationCode.DOWN:
                    if((_loc3_) && _value > _minimum)
                    {
                        this.onPrev(null);
                    }
                    param1.handled = true;
                    break;
                case NavigationCode.HOME:
                    if(!_loc3_ && !_loc2_.shiftKey)
                    {
                        this.value = _minimum;
                    }
                    param1.handled = true;
                    break;
                case NavigationCode.END:
                    if(!_loc3_ && !_loc2_.shiftKey)
                    {
                        this.value = _maximum;
                    }
                    param1.handled = true;
                    break;
                case NavigationCode.ENTER:
                    if(!_loc3_)
                    {
                        if(_loc2_.code == Keyboard.ENTER)
                        {
                            this.normalizeValue();
                            if(initialized)
                            {
                                dispatchEvent(new NumericStepperEvent(NumericStepperEvent.SUBMIT));
                            }
                        }
                    }
            }
        }
        
        override protected function configUI() : void {
            super.configUI();
            this.selectionTextColor = this._selectionTextColor;
            this.selectionBgColor = this._selectionBgColor;
            textField.addEventListener(Event.CHANGE,this.onChanged);
            tabEnabled = _focusable;
            tabChildren = true;
            if(textField != null)
            {
                textField.tabEnabled = textField.mouseEnabled = true;
            }
            nextBtn.addEventListener(ButtonEvent.DRAG_OUT,this.onNextBtnOut);
            prevBtn.addEventListener(ButtonEvent.DRAG_OUT,this.onPrevBtnOut);
            nextBtn.addEventListener(ButtonEvent.DRAG_OVER,this.onNextBtnOver);
            prevBtn.addEventListener(ButtonEvent.DRAG_OVER,this.onPrevBtnOver);
            prevBtn.mouseEnabled = nextBtn.mouseEnabled = this.enabled;
            textField.selectable = this.enabled;
            nextBtn.repeatInterval = prevBtn.repeatInterval = 40;
            nextBtn.repeatDelay = prevBtn.repeatDelay = 200;
            textField.type = "input";
            textField.addEventListener(FocusEvent.FOCUS_IN,this.onSetTextFieldFocus);
            textField.addEventListener(FocusEvent.FOCUS_OUT,this.onKillTextFieldFocus);
            addEventListener(MouseEvent.MOUSE_WHEEL,this.mouseScrollWheelHandler,false,0,true);
        }
        
        override protected function draw() : void {
            super.draw();
            if(this.isTextColorChanged)
            {
                this.isTextColorChanged = false;
                textField.textColor = this._textColor;
            }
            if(this.isTextFilterChanged)
            {
                this.isTextFilterChanged = false;
                textField.filters = null;
                textField.filters = this._textFilter;
            }
            if(this._integralDirty)
            {
                textField.restrict = this._integral?"0-9":"0-9.";
                this._integralDirty = false;
            }
            if(this.isValueChanged)
            {
                this.isValueChanged = false;
                textField.scrollH = 0;
            }
            if(this.selectionPosEnd > -1)
            {
                textField.setSelection(this.selectionPosBegin,this.selectionPosEnd);
                this.selectionPosEnd = -1;
                this.selectionPosBegin = -1;
            }
        }
        
        override protected function updateLabel() : void {
            super.updateLabel();
        }
        
        override protected function updateAfterStateChange() : void {
            invalidateSize();
            this.updateLabel();
            if(!(constraints == null) && !constraintsDisabled)
            {
                constraints.updateElement("textField",textField);
            }
        }
        
        override protected function onNext(param1:ButtonEvent) : void {
            if(!isNaN(this._manualValue))
            {
                this.normalizeValue();
            }
            super.onNext(param1);
            this.selectionPosBegin = this.selectionPosEnd = String(value).length;
            textField.setSelection(this.selectionPosBegin,this.selectionPosEnd);
        }
        
        override protected function onPrev(param1:ButtonEvent) : void {
            if(!isNaN(this._manualValue))
            {
                this.normalizeValue();
            }
            super.onPrev(param1);
            this.selectionPosBegin = this.selectionPosEnd = String(value).length;
            textField.setSelection(this.selectionPosBegin,this.selectionPosEnd);
        }
        
        protected function onChanged(param1:Event) : void {
            var _loc2_:IScheduler = App.utils.scheduler;
            _loc2_.cancelTask(this.normalizeValue);
            var _loc3_:String = stripNulls(textField.text);
            if(this.integral)
            {
                _loc3_ = stripDecimal(_loc3_);
            }
            var _loc4_:Number = Number(_loc3_);
            if(textField.text == "" || (isNaN(_loc4_)))
            {
                _loc4_ = _minimum;
            }
            this._manualValue = _loc4_;
            _loc2_.scheduleTask(this.normalizeValue,1000);
        }
        
        protected function normalizeValue() : void {
            if(!isNaN(this._manualValue))
            {
                this.value = this._manualValue;
                this.isValueChanged = true;
                invalidate();
            }
            this._manualValue = Number.NaN;
        }
        
        override protected function changeFocus() : void {
            super.changeFocus();
        }
        
        protected function onKillTextFieldFocus(param1:FocusEvent) : void {
            this.normalizeValue();
        }
        
        protected function onSetTextFieldFocus(param1:FocusEvent) : void {
            this.selectionPosBegin = 0;
            this.selectionPosEnd = String(value).length;
            textField.setSelection(this.selectionPosBegin,this.selectionPosEnd);
            invalidate();
            textField.scrollH = 0;
            this.setState("focused");
        }
        
        private function mouseScrollWheelHandler(param1:MouseEvent) : void {
            this.scrollWheel(param1.delta);
        }
        
        protected function scrollWheel(param1:Number) : void {
            if(!enabled)
            {
                return;
            }
            if(param1 > 0)
            {
                this.onNext(null);
            }
            else
            {
                this.onPrev(null);
            }
        }
        
        protected function onNextBtnOut(param1:ButtonEvent) : void {
            SoundButton(nextBtn).clearRepeatInterval();
        }
        
        protected function onPrevBtnOut(param1:ButtonEvent) : void {
            SoundButton(prevBtn).clearRepeatInterval();
        }
        
        protected function onNextBtnOver(param1:ButtonEvent) : void {
            SoundButton(nextBtn).beginButtonRepeat();
        }
        
        protected function onPrevBtnOver(param1:ButtonEvent) : void {
            SoundButton(prevBtn).beginButtonRepeat();
        }
    }
}
