package net.wg.gui.components.controls
{
    import net.wg.infrastructure.base.UIComponentEx;
    import net.wg.data.constants.Time;
    import net.wg.utils.IAssertable;
    import net.wg.utils.IUtils;
    import net.wg.utils.ICommons;
    import flash.display.MovieClip;
    import flash.text.TextField;
    import scaleform.clik.utils.Padding;
    import flash.events.Event;
    import scaleform.clik.events.ComponentEvent;
    import scaleform.clik.constants.InvalidationType;
    import flash.text.TextFieldAutoSize;
    import scaleform.clik.events.ButtonEvent;
    import flash.events.MouseEvent;
    import scaleform.clik.events.InputEvent;
    import net.wg.data.constants.Values;
    import net.wg.gui.components.controls.helpers.TimeNumericstepperHelper;
    import scaleform.clik.ui.InputDetails;
    import scaleform.clik.constants.InputValue;
    import scaleform.clik.constants.NavigationCode;
    
    public class TimeNumericStepper extends UIComponentEx
    {
        
        public function TimeNumericStepper()
        {
            this._skipValues = [];
            this._textPadding = new Padding(0);
            super();
            this._paddingsBetweenTF = new TextPaddings({"hoursTF":[0,0],
            "delimiterTF":[0,2],
            "minutesTF":[0,2]
        });
    }
    
    public static var DELIMITER:String = ":";
    
    public static var DEFAULT_MINUTES:String = "00";
    
    public static var DEFAULT_VALUE:int = -1;
    
    private static var STEP:int = 1;
    
    private static var TEXT_START_X:int = 5;
    
    private static var TEXT_DEFAULT_VALUE_START_X:int = 9;
    
    private static var TEXT_START_Y:int = 3;
    
    private static var PADDING_TOP_IDX:int = 0;
    
    private static var PADDING_LEFT_IDX:int = 1;
    
    private static function checkValidHour(param1:int) : Boolean
    {
        var _loc2_:Boolean = 0 <= param1 && param1 <= Time.HOURS_IN_DAY;
        _loc2_ = (_loc2_) || param1 == DEFAULT_VALUE;
        return _loc2_;
    }
    
    private static function get asserter() : IAssertable
    {
        return App.utils.asserter;
    }
    
    private static function get utils() : IUtils
    {
        return App.utils;
    }
    
    private static function get commons() : ICommons
    {
        return App.utils.commons;
    }
    
    public var nextBtn:SoundButton;
    
    public var prevBtn:SoundButton;
    
    public var bg:MovieClip;
    
    public var border:MovieClip;
    
    public var hoursTF:TextField;
    
    public var delimiterTF:TextField;
    
    public var minutesTF:TextField;
    
    private var _paddingsBetweenTF:TextPaddings = null;
    
    private var _value:Number = -1;
    
    private var _prevValue:int = -1;
    
    private var _canDefaultValueIsVisible:Boolean = true;
    
    private var _textColor:Number = 9868935;
    
    private var _isTwelveHoursFormat:Boolean = false;
    
    private var _skipValues:Array;
    
    private var _emptyFieldPattern:String = "-- --";
    
    private var _textPadding:Padding;
    
    override public function set focused(param1:Number) : void
    {
        super.focused = param1;
        invalidateState();
    }
    
    public function get value() : int
    {
        return this._value;
    }
    
    public function set value(param1:int) : void
    {
        if(param1 == this.value)
        {
            return;
        }
        var _loc2_:* = "Invalid value of hours";
        asserter.assert(checkValidHour(param1),_loc2_);
        if(!this.canDefaultValueIsVisible && param1 == DEFAULT_VALUE)
        {
            if(this._prevValue == DEFAULT_VALUE)
            {
                this._value = 0;
            }
        }
        else
        {
            this._prevValue = this._value;
            this._value = param1;
        }
        dispatchEvent(new Event(Event.CHANGE));
        invalidateData();
    }
    
    public function get canDefaultValueIsVisible() : Boolean
    {
        return this._canDefaultValueIsVisible;
    }
    
    public function set canDefaultValueIsVisible(param1:Boolean) : void
    {
        if(this.canDefaultValueIsVisible == param1)
        {
            return;
        }
        this._canDefaultValueIsVisible = param1;
        dispatchEvent(new ComponentEvent(ComponentEvent.STATE_CHANGE));
        invalidate(InvalidationType.SETTINGS);
    }
    
    public function get textColor() : Number
    {
        return this._textColor;
    }
    
    public function set textColor(param1:Number) : void
    {
        if(this._textColor == param1)
        {
            return;
        }
        this._textColor = param1;
        invalidate(InvalidationType.SETTINGS);
    }
    
    public function get isTwelveHoursFormat() : Boolean
    {
        return this._isTwelveHoursFormat;
    }
    
    public function set isTwelveHoursFormat(param1:Boolean) : void
    {
        this._isTwelveHoursFormat = param1;
        invalidate(InvalidationType.SETTINGS);
    }
    
    public function get skipValues() : Array
    {
        return this._skipValues;
    }
    
    public function set skipValues(param1:Array) : void
    {
        var _loc2_:* = "Not correct amount of arguments in restrictions. Two values on one restriction are necessary.";
        asserter.assert(param1.length % 2 == 0,_loc2_);
        this._skipValues = this.helper.sortSkipValues(param1);
        invalidate(InvalidationType.SETTINGS);
    }
    
    public function get emptyFieldPattern() : String
    {
        return this._emptyFieldPattern;
    }
    
    public function set emptyFieldPattern(param1:String) : void
    {
        this._emptyFieldPattern = param1;
        invalidate(InvalidationType.SETTINGS);
    }
    
    public function get textPadding() : Array
    {
        return [this._textPadding.top,this._textPadding.left];
    }
    
    public function set textPadding(param1:Array) : void
    {
        var _loc2_:* = "Two values were expected in Array of textPadding (top,left)";
        asserter.assert(param1.length == 2,_loc2_);
        this._textPadding = new Padding(param1[PADDING_TOP_IDX],param1[PADDING_LEFT_IDX]);
        invalidate(InvalidationType.SETTINGS);
    }
    
    public function get currentValueIsDefault() : Boolean
    {
        return this.value == DEFAULT_VALUE;
    }
    
    public function get prevValue() : int
    {
        return this._prevValue;
    }
    
    override protected function configUI() : void
    {
        super.configUI();
        this.customizeBtns();
        this.addListeners();
        this.hoursTF.autoSize = TextFieldAutoSize.LEFT;
        this.delimiterTF.autoSize = TextFieldAutoSize.LEFT;
        this.minutesTF.autoSize = TextFieldAutoSize.LEFT;
        this.isTwelveHoursFormat = App.utils.isTwelveHoursFormatS();
    }
    
    override protected function draw() : void
    {
        var _loc1_:String = null;
        super.draw();
        if(isInvalid(InvalidationType.STATE))
        {
            mouseEnabled = tabEnabled = enabled;
            gotoAndPlay(enabled?_focused > 0?"focused":"default":"disabled");
            if(_baseDisposed)
            {
                return;
            }
            this.prevBtn.enabled = this.nextBtn.enabled = enabled;
        }
        if(isInvalid(InvalidationType.SETTINGS))
        {
            this.checkCurrentHourWithSkipValues();
            this.changeTextColor();
        }
        if(isInvalid(InvalidationType.DATA))
        {
            if(this._value == Time.HOURS_IN_DAY)
            {
                this._value = 0;
            }
            _loc1_ = "Current value \"" + this._value + "\" is in skipValues";
            asserter.assert(!this.isInSkipValues(this._value),_loc1_);
        }
        this.setTexts();
        this.updateTextSize();
    }
    
    override protected function onDispose() : void
    {
        commons.cleanupDynamicObject(this._paddingsBetweenTF);
        this._skipValues.splice(0,this._skipValues.length);
        this._skipValues = null;
        this._paddingsBetweenTF.dispose();
        this._paddingsBetweenTF = null;
        this._textPadding = null;
        this.removeListeners();
        this.nextBtn.dispose();
        this.nextBtn = null;
        this.prevBtn.dispose();
        this.prevBtn = null;
        this.bg = null;
        this.border = null;
        this.hoursTF = null;
        this.delimiterTF = null;
        this.minutesTF = null;
        this.helper.dispose();
        super.onDispose();
    }
    
    private function checkCurrentHourWithSkipValues() : void
    {
        var _loc1_:* = 0;
        var _loc2_:* = 0;
        var _loc3_:* = 0;
        while(_loc3_ < this.skipValues.length)
        {
            _loc1_ = this.skipValues[_loc3_];
            _loc2_ = this.skipValues[_loc3_ + 1];
            if(_loc1_ <= this.value && this.value < _loc2_)
            {
                this.value = _loc2_;
            }
            _loc3_++;
        }
    }
    
    private function customizeBtns() : void
    {
        this.prevBtn.enabled = this.nextBtn.enabled = enabled;
        this.prevBtn.autoRepeat = this.nextBtn.autoRepeat = true;
        this.prevBtn.focusable = this.nextBtn.focusable = false;
        this.prevBtn.focusTarget = this.nextBtn.focusTarget = this;
        this.prevBtn.tabEnabled = this.nextBtn.tabEnabled = false;
        this.prevBtn.mouseEnabled = this.nextBtn.mouseEnabled = true;
    }
    
    private function addListeners() : void
    {
        this.nextBtn.addEventListener(ButtonEvent.CLICK,this.nextBtnClickHandler,false,0,true);
        this.prevBtn.addEventListener(ButtonEvent.CLICK,this.prevBtnClickHandler,false,0,true);
        this.nextBtn.addEventListener(ButtonEvent.DRAG_OUT,this.nextBtnOutHandler);
        this.prevBtn.addEventListener(ButtonEvent.DRAG_OUT,this.prevBtnOutHandler);
        this.nextBtn.addEventListener(ButtonEvent.DRAG_OVER,this.nextBtnOverHandler);
        this.prevBtn.addEventListener(ButtonEvent.DRAG_OVER,this.prevBtnOverHandler);
        addEventListener(MouseEvent.MOUSE_WHEEL,this.mouseScrollWheelHandler,false,0,true);
        addEventListener(InputEvent.INPUT,this.handleInput,false,0,true);
    }
    
    private function removeListeners() : void
    {
        this.nextBtn.removeEventListener(ButtonEvent.CLICK,this.nextBtnClickHandler);
        this.prevBtn.removeEventListener(ButtonEvent.CLICK,this.prevBtnClickHandler);
        this.nextBtn.removeEventListener(ButtonEvent.DRAG_OUT,this.nextBtnOutHandler);
        this.prevBtn.removeEventListener(ButtonEvent.DRAG_OUT,this.prevBtnOutHandler);
        this.nextBtn.removeEventListener(ButtonEvent.DRAG_OVER,this.nextBtnOverHandler);
        this.prevBtn.removeEventListener(ButtonEvent.DRAG_OVER,this.prevBtnOverHandler);
        removeEventListener(MouseEvent.MOUSE_WHEEL,this.mouseScrollWheelHandler);
        removeEventListener(InputEvent.INPUT,this.handleInput);
    }
    
    private function scrollWheel(param1:Number) : void
    {
        if(!enabled)
        {
            return;
        }
        if(param1 > 0)
        {
            this.nextBtnClickHandler(null);
        }
        else
        {
            this.prevBtnClickHandler(null);
        }
    }
    
    private function changeTextColor() : void
    {
        this.hoursTF.textColor = this.textColor;
        this.delimiterTF.textColor = this.textColor;
        this.minutesTF.textColor = this.textColor;
    }
    
    private function updateTextSize() : void
    {
        var _loc1_:Number = this.hoursTF.scaleX = this.delimiterTF.scaleX = this.minutesTF.scaleX = 1 / scaleX;
        var _loc2_:Number = this.hoursTF.scaleY = this.delimiterTF.scaleY = this.minutesTF.scaleY = 1 / scaleY;
        var _loc3_:Number = this.currentValueIsDefault?TEXT_DEFAULT_VALUE_START_X:TEXT_START_X;
        this.normalizeTextPositionAfterResize(_loc3_,_loc1_,_loc2_);
    }
    
    private function normalizeTextPositionAfterResize(param1:Number, param2:Number, param3:Number) : void
    {
        this.hoursTF.x = (param1 + this._textPadding.left) * param2;
        this.delimiterTF.x = this.hoursTF.x + (this.hoursTF.textWidth + this._paddingsBetweenTF["delimiterTF"].left) * param2;
        this.minutesTF.x = this.delimiterTF.x + (this.delimiterTF.textWidth + this._paddingsBetweenTF["minutesTF"].left) * param2;
        this.hoursTF.y = this.delimiterTF.y = this.minutesTF.y = TEXT_START_Y + this._textPadding.top * param3;
    }
    
    private function setTexts() : void
    {
        if(this.currentValueIsDefault)
        {
            this.hoursTF.text = this._emptyFieldPattern;
            this.delimiterTF.text = Values.EMPTY_STR;
            this.minutesTF.text = Values.EMPTY_STR;
        }
        else if(this.isTwelveHoursFormat)
        {
            this.hoursTF.text = utils.intToStringWithPrefixPaternS(App.utils.dateTime.convertToTwelveHourFormat(this.value),Time.COUNT_SYMBOLS_WITH_PREFIX,Time.PREFIX);
            this.delimiterTF.text = Values.EMPTY_STR;
            this.minutesTF.text = this.isAm?Time.AM:Time.PM;
        }
        else
        {
            this.hoursTF.text = utils.intToStringWithPrefixPaternS(this.value,Time.COUNT_SYMBOLS_WITH_PREFIX,Time.PREFIX);
            this.delimiterTF.text = DELIMITER;
            this.minutesTF.text = DEFAULT_MINUTES;
        }
        
    }
    
    private function isInSkipValues(param1:int) : Boolean
    {
        var _loc3_:* = 0;
        var _loc4_:* = 0;
        var _loc2_:* = 0;
        while(_loc2_ < this.skipValues.length)
        {
            _loc3_ = this.skipValues[_loc2_];
            _loc4_ = this.skipValues[_loc2_ + 1];
            if(param1 >= _loc3_ && param1 < _loc4_)
            {
                return true;
            }
            _loc2_ = _loc2_ + 2;
        }
        return false;
    }
    
    private function getHourWithoutSkipValues(param1:int, param2:Boolean) : int
    {
        var _loc5_:* = 0;
        var _loc6_:* = 0;
        var _loc3_:int = param1;
        var _loc4_:* = 0;
        while(_loc4_ < this.skipValues.length)
        {
            _loc5_ = this.skipValues[_loc4_];
            _loc6_ = this.skipValues[_loc4_ + 1];
            if(_loc3_ >= _loc5_ && _loc3_ < _loc6_ && (param2))
            {
                _loc3_ = _loc6_;
                if(_loc3_ == Time.HOURS_IN_DAY)
                {
                    _loc3_ = this.getHourWithoutSkipValues(0,true);
                }
            }
            else if(_loc5_ <= _loc3_ && _loc3_ < _loc6_ && !param2)
            {
                if(_loc5_ == 0)
                {
                    _loc3_ = Time.HOURS_IN_DAY - 1;
                }
                else
                {
                    _loc3_ = _loc5_ - 1;
                }
            }
            
            _loc4_ = _loc4_ + 2;
        }
        return _loc3_;
    }
    
    private function onNext() : void
    {
        var _loc1_:int = this.value + STEP;
        if(_loc1_ >= Time.HOURS_IN_DAY)
        {
            _loc1_ = 0;
        }
        this.value = this.getHourWithoutSkipValues(_loc1_,true);
    }
    
    private function onPrev() : void
    {
        var _loc1_:int = this.value - STEP;
        if(_loc1_ < 0)
        {
            _loc1_ = Time.HOURS_IN_DAY - 1;
        }
        this.value = this.getHourWithoutSkipValues(_loc1_,false);
    }
    
    private function get helper() : TimeNumericstepperHelper
    {
        return TimeNumericstepperHelper.instance;
    }
    
    private function get isAm() : Boolean
    {
        return this._value < Time.HOURS_IN_DAY >> 1;
    }
    
    private function mouseScrollWheelHandler(param1:MouseEvent) : void
    {
        this.scrollWheel(param1.delta);
    }
    
    private function nextBtnClickHandler(param1:ButtonEvent) : void
    {
        this.onNext();
    }
    
    private function prevBtnClickHandler(param1:ButtonEvent) : void
    {
        this.onPrev();
    }
    
    private function nextBtnOutHandler(param1:ButtonEvent) : void
    {
        this.nextBtn.clearRepeatInterval();
    }
    
    private function prevBtnOutHandler(param1:ButtonEvent) : void
    {
        this.prevBtn.clearRepeatInterval();
    }
    
    private function nextBtnOverHandler(param1:ButtonEvent) : void
    {
        this.nextBtn.beginButtonRepeat();
    }
    
    private function prevBtnOverHandler(param1:ButtonEvent) : void
    {
        this.prevBtn.beginButtonRepeat();
    }
    
    override public function handleInput(param1:InputEvent) : void
    {
        if(param1.isDefaultPrevented())
        {
            return;
        }
        var _loc2_:InputDetails = param1.details;
        var _loc3_:Boolean = _loc2_.value == InputValue.KEY_DOWN || _loc2_.value == InputValue.KEY_HOLD;
        switch(_loc2_.navEquivalent)
        {
            case NavigationCode.UP:
                param1.handled = true;
                if(_loc3_)
                {
                    this.onNext();
                }
                param1.handled = true;
                break;
            case NavigationCode.DOWN:
                param1.handled = true;
                if(_loc3_)
                {
                    this.onPrev();
                }
                param1.handled = true;
                break;
        }
    }
}
}
import net.wg.infrastructure.interfaces.entity.IDisposable;
import scaleform.clik.utils.Padding;

class TextPaddings extends Object implements IDisposable
{

function TextPaddings(param1:Object)
{
    var _loc2_:String = null;
    var _loc3_:Array = null;
    super();
    for(_loc2_ in param1)
    {
        if(_loc2_ in this)
        {
            _loc3_ = param1[_loc2_];
            this[_loc2_] = new Padding(_loc3_[TOP_PADDING_IDX],_loc3_[LEFT_PADDING_IDX]);
        }
    }
}

public static var TOP_PADDING_IDX:int = 0;

public static var LEFT_PADDING_IDX:int = 1;

public var hoursTF:Padding;

public var delimiterTF:Padding;

public var minutesTF:Padding;

public function dispose() : void
{
    this.hoursTF = null;
    this.delimiterTF = null;
    this.minutesTF = null;
}
}
