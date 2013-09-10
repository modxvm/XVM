package scaleform.clik.controls 
{
    import __AS3__.vec.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;
    import flash.utils.*;
    import scaleform.clik.constants.*;
    import scaleform.clik.core.*;
    import scaleform.clik.events.*;
    import scaleform.clik.ui.*;
    import scaleform.clik.utils.*;
    import scaleform.gfx.*;
    
    public class Button extends scaleform.clik.core.UIComponent
    {
        public function Button()
        {
            this._stateMap = {"up":["up"], "over":["over"], "down":["down"], "release":["release", "over"], "out":["out", "up"], "disabled":["disabled"], "selecting":["selecting", "over"], "toggle":["toggle", "up"], "kb_selecting":["kb_selecting", "up"], "kb_release":["kb_release", "out", "up"], "kb_down":["kb_down", "down"]};
            this.statesDefault = Vector.<String>([""]);
            this.statesSelected = Vector.<String>(["selected_", ""]);
            super();
            buttonMode = true;
            return;
        }

        public function set autoSize(arg1:String):void
        {
            if (arg1 == this._autoSize) 
                return;
            this._autoSize = arg1;
            invalidateData();
            return;
        }

        public function get focusIndicator():flash.display.MovieClip
        {
            return this._focusIndicator;
        }

        public function set focusIndicator(arg1:flash.display.MovieClip):void
        {
            this._focusIndicatorLabelHash = null;
            this._focusIndicator = arg1;
            this._focusIndicatorLabelHash = scaleform.clik.core.UIComponent.generateLabelHash(this._focusIndicator);
            return;
        }

        public override function handleInput(arg1:scaleform.clik.events.InputEvent):void
        {
            if (arg1.isDefaultPrevented()) 
                return;
            var loc1:*=arg1.details;
            var loc2:*=loc1.controllerIndex;
            var loc3:*=loc1.navEquivalent;
            switch (loc3) 
            {
                case scaleform.clik.constants.NavigationCode.ENTER:
                    if (loc1.value != scaleform.clik.constants.InputValue.KEY_DOWN) 
                        if (loc1.value == scaleform.clik.constants.InputValue.KEY_UP) 
                            if (this._pressedByKeyboard) 
                            {
                                this.handleRelease(loc2);
                                arg1.handled = true;
                            }
                    else 
                    {
                        this.handlePress(loc2);
                        arg1.handled = true;
                    }
                    break;
            }
            return;
        }

        public function clearRepeatInterval():void
        {
            if (this._repeatTimer) 
            {
                this._repeatTimer.stop();
                this._repeatTimer.reset();
                this._repeatTimer.removeEventListener(flash.events.TimerEvent.TIMER_COMPLETE, this.beginRepeat);
                this._repeatTimer.removeEventListener(flash.events.TimerEvent.TIMER, this.handleRepeat);
                this._repeatTimer = null;
            }
            return;
        }

        public override function toString():String
        {
            return "[CLIK Button " + name + "]";
        }

        protected override function configUI():void
        {
            if (!this.constraintsDisabled) 
                constraints.addElement("textField", this.textField, scaleform.clik.utils.Constraints.ALL);
            super.configUI();
            tabEnabled = _focusable && this.enabled && tabEnabled;
            var loc1:*;
            tabChildren = loc1 = false;
            mouseChildren = loc1;
            addEventListener(flash.events.MouseEvent.ROLL_OVER, this.handleMouseRollOver, false, 0, true);
            addEventListener(flash.events.MouseEvent.ROLL_OUT, this.handleMouseRollOut, false, 0, true);
            addEventListener(flash.events.MouseEvent.MOUSE_DOWN, this.handleMousePress, false, 0, true);
            addEventListener(flash.events.MouseEvent.CLICK, this.handleMouseRelease, false, 0, true);
            addEventListener(flash.events.MouseEvent.DOUBLE_CLICK, this.handleMouseRelease, false, 0, true);
            addEventListener(scaleform.clik.events.InputEvent.INPUT, this.handleInput, false, 0, true);
            if (!(this._focusIndicator == null) && !_focused && this._focusIndicator.totalFrames == 1) 
                this.focusIndicator.visible = false;
            return;
        }

        protected override function draw():void
        {
            if (isInvalid(scaleform.clik.constants.InvalidationType.STATE)) 
            {
                if (this._newFrame) 
                {
                    gotoAndPlay(this._newFrame);
                    if (_baseDisposed) 
                        return;
                    this._newFrame = null;
                }
                if (this.focusIndicator && this._newFocusIndicatorFrame) 
                {
                    this.focusIndicator.gotoAndPlay(this._newFocusIndicatorFrame);
                    this._newFocusIndicatorFrame = null;
                }
                this.updateAfterStateChange();
                dispatchEvent(new scaleform.clik.events.ComponentEvent(scaleform.clik.events.ComponentEvent.STATE_CHANGE));
                invalidate(scaleform.clik.constants.InvalidationType.DATA, scaleform.clik.constants.InvalidationType.SIZE);
            }
            if (isInvalid(scaleform.clik.constants.InvalidationType.DATA)) 
            {
                this.updateText();
                if (this.autoSize != flash.text.TextFieldAutoSize.NONE) 
                    invalidateSize();
            }
            if (isInvalid(scaleform.clik.constants.InvalidationType.SIZE)) 
            {
                if (!this.preventAutosizing) 
                {
                    this.alignForAutoSize();
                    setActualSize(_width, _height);
                }
                if (!this.constraintsDisabled) 
                    if (constraints) 
                        constraints.update(_width, _height);
            }
            return;
        }

        protected function addToAutoGroup(arg1:flash.events.Event):void
        {
            if (parent == null) 
            {
                this.group = null;
                return;
            }
            var loc1:*=scaleform.clik.controls.ButtonGroup.getGroup(this._groupName, parent);
            if (loc1 == this.group) 
                return;
            this.group = loc1;
            return;
        }

        public function get owner():scaleform.clik.core.UIComponent
        {
            return this._owner;
        }

        protected function checkOwnerFocused():Boolean
        {
            var loc2:*=null;
            var loc1:*=false;
            if (this.owner != null) 
            {
                loc1 = !(this._owner.focused == 0);
                if (loc1 == 0) 
                {
                    loc2 = this._owner.focusTarget;
                    if (loc2 != null) 
                        loc1 = !(loc2 == 0);
                }
            }
            return loc1;
        }

        protected function calculateWidth():Number
        {
            var loc2:*=null;
            var loc1:*=actualWidth;
            if (!this.constraintsDisabled) 
            {
                loc2 = constraints.getElement("textField");
                loc1 = Math.ceil(this.textField.textWidth + loc2.left + loc2.right + 5);
            }
            return loc1;
        }

        protected function alignForAutoSize():void
        {
            var loc1:*=NaN;
            var loc3:*=NaN;
            var loc4:*=NaN;
            if (!initialized || this._autoSize == flash.text.TextFieldAutoSize.NONE || this.textField == null) 
                return;
            loc1 = _width;
            var loc5:*;
            _width = loc5 = this.calculateWidth();
            var loc2:*=loc5;
            loc5 = this._autoSize;
            switch (loc5) 
            {
                case flash.text.TextFieldAutoSize.RIGHT:
                    loc3 = x + loc1;
                    x = loc3 - loc2;
                    break;
                case flash.text.TextFieldAutoSize.CENTER:
                    loc4 = x + loc1 * 0.5;
                    x = loc4 - loc2 * 0.5;
                    break;
            }
            return;
        }

        protected function updateText():void
        {
            if (!(this._label == null) && !(this.textField == null)) 
                this.textField.text = this._label;
            return;
        }

        protected override function changeFocus():void
        {
            var loc1:*=null;
            if (!this.enabled) 
                return;
            if (this._focusIndicator != null) 
            {
                if (this._focusIndicator.totalframes != 1) 
                {
                    loc1 = "state" + _focused;
                    if (this._focusIndicatorLabelHash[loc1]) 
                        this._newFocusIndicatorFrame = "state" + _focused;
                    else 
                        this._newFocusIndicatorFrame = _focused || _displayFocus ? "show" : "hide";
                    invalidateState();
                }
                else 
                    this._focusIndicator.visible = _focused > 0;
                if (this._pressedByKeyboard && !_focused) 
                {
                    this.setState("kb_release");
                    this._pressedByKeyboard = false;
                }
            }
            else 
            {
                this.setState(_focused || _displayFocus ? "over" : "out");
                if (this._pressedByKeyboard && !_focused) 
                    this._pressedByKeyboard = false;
            }
            return;
        }

        protected function handleMouseRollOver(arg1:flash.events.MouseEvent):void
        {
            var loc1:*=arg1 as scaleform.gfx.MouseEventEx;
            var loc2:*=loc1 != null ? loc1.mouseIdx : 0;
            if (arg1.buttonDown) 
            {
                dispatchEvent(new scaleform.clik.events.ButtonEvent(scaleform.clik.events.ButtonEvent.DRAG_OVER));
                if (!this.enabled) 
                    return;
                if (this.lockDragStateChange && Boolean(this._mouseDown << loc2 & 1)) 
                    return;
                if (_focused || _displayFocus) 
                    this.setState(this.focusIndicator != null ? "kb_down" : "down");
                else 
                    this.setState("over");
            }
            else 
            {
                if (!this.enabled) 
                    return;
                if (_focused || _displayFocus) 
                    if (this._focusIndicator != null) 
                        this.setState("over");
                else 
                    this.setState("over");
            }
            return;
        }

        protected function handleMouseRollOut(arg1:flash.events.MouseEvent):void
        {
            var loc1:*=arg1 as scaleform.gfx.MouseEventEx;
            var loc2:*=loc1 != null ? loc1.mouseIdx : 0;
            if (arg1.buttonDown) 
            {
                dispatchEvent(new scaleform.clik.events.ButtonEvent(scaleform.clik.events.ButtonEvent.DRAG_OUT));
                if (Boolean(this._mouseDown & 1 << loc2)) 
                    if (stage != null) 
                        stage.addEventListener(flash.events.MouseEvent.MOUSE_UP, this.handleReleaseOutside, false, 0, true);
                if (this.lockDragStateChange || !this.enabled) 
                    return;
                if (_focused || _displayFocus) 
                    this.setState(this._focusIndicator != null ? "kb_release" : "release");
                else 
                    this.setState("out");
            }
            else 
            {
                if (!this.enabled) 
                    return;
                if (_focused || _displayFocus) 
                    if (this._focusIndicator != null) 
                        this.setState("out");
                else 
                    this.setState("out");
            }
            return;
        }

        protected function handleMousePress(arg1:flash.events.MouseEvent):void
        {
            var loc4:*=null;
            var loc1:*=arg1 as scaleform.gfx.MouseEventEx;
            var loc2:*=loc1 != null ? loc1.mouseIdx : 0;
            var loc3:*;
            if ((loc3 = loc1 != null ? loc1.buttonIdx : 0) != 0) 
                return;
            this._mouseDown = this._mouseDown | 1 << loc2;
            if (this.enabled) 
            {
                this.setState("down");
                if (this.autoRepeat && this._repeatTimer == null) 
                {
                    this._autoRepeatEvent = new scaleform.clik.events.ButtonEvent(scaleform.clik.events.ButtonEvent.CLICK, true, false, loc2, loc3, false, true);
                    this._repeatTimer = new flash.utils.Timer(this.repeatDelay, 1);
                    this._repeatTimer.addEventListener(flash.events.TimerEvent.TIMER_COMPLETE, this.beginRepeat, false, 0, true);
                    this._repeatTimer.start();
                }
                loc4 = new scaleform.clik.events.ButtonEvent(scaleform.clik.events.ButtonEvent.PRESS, true, false, loc2, loc3, false, false);
                dispatchEvent(loc4);
            }
            return;
        }

        protected function handleMouseRelease(arg1:flash.events.MouseEvent):void
        {
            var loc4:*=null;
            this._autoRepeatEvent = null;
            if (!this.enabled) 
                return;
            var loc1:*=arg1 as scaleform.gfx.MouseEventEx;
            var loc2:*=loc1 != null ? loc1.mouseIdx : 0;
            var loc3:*;
            if ((loc3 = loc1 != null ? loc1.buttonIdx : 0) != 0) 
                return;
            this._mouseDown = this._mouseDown ^ 1 << loc2;
            if (this._mouseDown == 0 && this._repeatTimer) 
            {
                this._repeatTimer.stop();
                this._repeatTimer.reset();
                this._repeatTimer.removeEventListener(flash.events.TimerEvent.TIMER_COMPLETE, this.beginRepeat);
                this._repeatTimer.removeEventListener(flash.events.TimerEvent.TIMER, this.handleRepeat);
                this._repeatTimer = null;
            }
            this.setState("release");
            this.handleClick(loc2);
            if (!this._isRepeating) 
            {
                loc4 = new scaleform.clik.events.ButtonEvent(scaleform.clik.events.ButtonEvent.CLICK, true, false, loc2, loc3, false, false);
                dispatchEvent(loc4);
            }
            this._isRepeating = false;
            return;
        }

        protected function handleReleaseOutside(arg1:flash.events.MouseEvent):void
        {
            this._autoRepeatEvent = null;
            if (contains(arg1.target as flash.display.DisplayObject)) 
                return;
            var loc1:*=arg1 as scaleform.gfx.MouseEventEx;
            var loc2:*=loc1 != null ? loc1.mouseIdx : 0;
            var loc3:*;
            if ((loc3 = loc1 != null ? loc1.buttonIdx : 0) != 0) 
                return;
            if (stage) 
                stage.removeEventListener(flash.events.MouseEvent.MOUSE_UP, this.handleReleaseOutside, false);
            this._mouseDown = this._mouseDown ^ 1 << loc2;
            dispatchEvent(new scaleform.clik.events.ButtonEvent(scaleform.clik.events.ButtonEvent.RELEASE_OUTSIDE));
            if (!this.enabled) 
                return;
            if (this.lockDragStateChange) 
                if (_focused || _displayFocus) 
                    this.setState(this.focusIndicator != null ? "kb_release" : "release");
                else 
                    this.setState("kb_release");
            return;
        }

        protected function handleRelease(arg1:uint=0):void
        {
            var loc1:*=null;
            if (!this.enabled) 
                return;
            this.setState(this.focusIndicator != null ? "kb_release" : "release");
            if (this._repeatTimer) 
            {
                this._repeatTimer.stop();
                this._repeatTimer.reset();
                this._repeatTimer.removeEventListener(flash.events.TimerEvent.TIMER_COMPLETE, this.beginRepeat);
                this._repeatTimer.removeEventListener(flash.events.TimerEvent.TIMER, this.handleRepeat);
                this._repeatTimer = null;
            }
            this.handleClick(arg1);
            this._pressedByKeyboard = false;
            if (!this._isRepeating) 
            {
                loc1 = new scaleform.clik.events.ButtonEvent(scaleform.clik.events.ButtonEvent.CLICK, true, false, arg1, 0, true, false);
                dispatchEvent(loc1);
            }
            this._isRepeating = false;
            return;
        }

        protected function handleClick(arg1:uint=0):void
        {
            if (this.toggle && (!this.selected || this.allowDeselect)) 
                this.selected = !this.selected;
            return;
        }

        protected function beginRepeat(arg1:flash.events.TimerEvent):void
        {
            this._repeatTimer.delay = this.repeatInterval;
            this._repeatTimer.repeatCount = 0;
            this._repeatTimer.removeEventListener(flash.events.TimerEvent.TIMER_COMPLETE, this.beginRepeat);
            this._repeatTimer.addEventListener(flash.events.TimerEvent.TIMER, this.handleRepeat, false, 0, true);
            this._repeatTimer.reset();
            this._repeatTimer.start();
            return;
        }

        protected function handleRepeat(arg1:flash.events.TimerEvent):void
        {
            if (this._mouseDown == 0 && !this._pressedByKeyboard) 
            {
                this._repeatTimer.stop();
                this._repeatTimer.reset();
                this._repeatTimer.removeEventListener(flash.events.TimerEvent.TIMER_COMPLETE, this.beginRepeat);
                this._repeatTimer.removeEventListener(flash.events.TimerEvent.TIMER, this.handleRepeat);
                this._repeatTimer = null;
            }
            if (this._autoRepeatEvent) 
            {
                this._isRepeating = true;
                dispatchEvent(this._autoRepeatEvent);
            }
            return;
        }

        protected function setState(arg1:String):void
        {
            var loc5:*=null;
            var loc6:*=0;
            var loc7:*=0;
            var loc8:*=null;
            this._state = arg1;
            var loc1:*=this.getStatePrefixes();
            var loc2:*=this._stateMap[arg1];
            if (loc2 == null || loc2.length == 0) 
                return;
            var loc3:*=loc1.length;
            var loc4:*=0;
            while (loc4 < loc3) 
            {
                loc5 = loc1[loc4];
                loc6 = loc2.length;
                loc7 = 0;
                while (loc7 < loc6) 
                {
                    loc8 = loc5 + loc2[loc7];
                    if (_labelHash[loc8]) 
                    {
                        this._newFrame = loc8;
                        invalidateState();
                        return;
                    }
                    ++loc7;
                }
                ++loc4;
            }
            return;
        }

        protected function getStatePrefixes():__AS3__.vec.Vector.<String>
        {
            return this._selected ? this.statesSelected : this.statesDefault;
        }

        protected function updateAfterStateChange():void
        {
            if (!initialized) 
                return;
            if (!(constraints == null) && !this.constraintsDisabled && !(this.textField == null)) 
                constraints.updateElement("textField", this.textField);
            return;
        }

        public override function dispose():void
        {
            this.clearRepeatInterval();
            removeEventListener(flash.events.Event.ADDED, this.addToAutoGroup, false);
            removeEventListener(flash.events.Event.REMOVED, this.addToAutoGroup, false);
            removeEventListener(flash.events.MouseEvent.ROLL_OVER, this.handleMouseRollOver, false);
            removeEventListener(flash.events.MouseEvent.ROLL_OUT, this.handleMouseRollOut, false);
            removeEventListener(flash.events.MouseEvent.MOUSE_DOWN, this.handleMousePress, false);
            removeEventListener(flash.events.MouseEvent.CLICK, this.handleMouseRelease, false);
            removeEventListener(flash.events.MouseEvent.DOUBLE_CLICK, this.handleMouseRelease, false);
            removeEventListener(scaleform.clik.events.InputEvent.INPUT, this.handleInput, false);
            this._owner = null;
            this.textField = null;
            this.defaultTextFormat = null;
            this._focusIndicator = null;
            if (this._group) 
            {
                this._group.dispose();
                this._group = null;
            }
            this.data = null;
            this.statesDefault = null;
            this.statesSelected = null;
            this._stateMap = null;
            super.dispose();
            return;
        }

        protected override function preInitialize():void
        {
            if (!this.constraintsDisabled) 
                constraints = new scaleform.clik.utils.Constraints(this, scaleform.clik.constants.ConstrainMode.COUNTER_SCALE);
            return;
        }

        protected override function initialize():void
        {
            super.initialize();
            tabEnabled = true;
            return;
        }

        public function get data():Object
        {
            return this._data;
        }

        public function set data(arg1:Object):void
        {
            this._data = arg1;
            return;
        }

        public function get autoRepeat():Boolean
        {
            return this._autoRepeat;
        }

        public function set autoRepeat(arg1:Boolean):void
        {
            this._autoRepeat = arg1;
            return;
        }

        public override function get enabled():Boolean
        {
            return super.enabled;
        }

        public override function set enabled(arg1:Boolean):void
        {
            var loc1:*=null;
            super.enabled = arg1;
            mouseChildren = false;
            if (super.enabled) 
                loc1 = this._focusIndicator == null && (_displayFocus || _focused) ? "over" : "up";
            else 
                loc1 = "disabled";
            this.setState(loc1);
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

        public function get toggle():Boolean
        {
            return this._toggle;
        }

        public function set toggle(arg1:Boolean):void
        {
            this._toggle = arg1;
            return;
        }

        protected function handlePress(arg1:uint=0):void
        {
            if (!this.enabled) 
                return;
            this._pressedByKeyboard = true;
            this.setState(this._focusIndicator != null ? "kb_down" : "down");
            if (this.autoRepeat && this._repeatTimer == null) 
            {
                this._autoRepeatEvent = new scaleform.clik.events.ButtonEvent(scaleform.clik.events.ButtonEvent.CLICK, true, false, arg1, 0, true, true);
                this._repeatTimer = new flash.utils.Timer(this.repeatDelay, 1);
                this._repeatTimer.addEventListener(flash.events.TimerEvent.TIMER_COMPLETE, this.beginRepeat, false, 0, true);
                this._repeatTimer.start();
            }
            var loc1:*=new scaleform.clik.events.ButtonEvent(scaleform.clik.events.ButtonEvent.PRESS, true, false, arg1, 0, true, false);
            dispatchEvent(loc1);
            return;
        }

        public function set owner(arg1:scaleform.clik.core.UIComponent):void
        {
            this._owner = arg1;
            return;
        }

        public function get state():String
        {
            return this._state;
        }

        public function get selected():Boolean
        {
            return this._selected;
        }

        public function set selected(arg1:Boolean):void
        {
            var loc1:*=false;
            if (this._selected == arg1) 
                return;
            this._selected = arg1;
            if (this.enabled) 
            {
                if (_focused) 
                    if (this._pressedByKeyboard && !(this._focusIndicator == null)) 
                        this.setState("kb_selecting");
                    else 
                        this.setState("selecting");
                else 
                    this.setState("toggle");
                if (this.owner) 
                {
                    loc1 = this._selected && !(this.owner == null) && this.checkOwnerFocused();
                    this.setState(loc1 && this._focusIndicator == null ? "selecting" : "toggle");
                    displayFocus = loc1;
                }
            }
            else 
                this.setState("disabled");
            validateNow();
            dispatchEvent(new flash.events.Event(flash.events.Event.SELECT));
            return;
        }

        public function get group():scaleform.clik.controls.ButtonGroup
        {
            return this._group;
        }

        public function set group(arg1:scaleform.clik.controls.ButtonGroup):void
        {
            if (this._group != null) 
                this._group.removeButton(this);
            this._group = arg1;
            if (this._group != null) 
                this._group.addButton(this);
            return;
        }

        public function get groupName():String
        {
            return this._groupName;
        }

        public function set groupName(arg1:String):void
        {
            if (_inspector && arg1 == "") 
                return;
            if (this._groupName == arg1) 
                return;
            if (arg1 == null) 
            {
                removeEventListener(flash.events.Event.ADDED, this.addToAutoGroup, false);
                removeEventListener(flash.events.Event.REMOVED, this.addToAutoGroup, false);
            }
            else 
            {
                addEventListener(flash.events.Event.ADDED, this.addToAutoGroup, false, 0, true);
                addEventListener(flash.events.Event.REMOVED, this.addToAutoGroup, false, 0, true);
            }
            this._groupName = arg1;
            this.addToAutoGroup(null);
            return;
        }

        public function get label():String
        {
            return this._label;
        }

        public function set label(arg1:String):void
        {
            if (this._label == arg1) 
                return;
            this._label = arg1;
            invalidateData();
            return;
        }

        public function get autoSize():String
        {
            return this._autoSize;
        }

        public var lockDragStateChange:Boolean=false;

        public var repeatDelay:Number=500;

        public var repeatInterval:Number=200;

        public var constraintsDisabled:Boolean=false;

        public var allowDeselect:Boolean=true;

        public var preventAutosizing:Boolean=false;

        protected var _toggle:Boolean=false;

        protected var _label:String;

        protected var _state:String;

        protected var _groupName:String;

        protected var _selected:Boolean=false;

        protected var _data:Object;

        protected var _autoRepeat:Boolean=false;

        protected var _autoSize:String="none";

        protected var _pressedByKeyboard:Boolean=false;

        protected var _isRepeating:Boolean=false;

        protected var _owner:scaleform.clik.core.UIComponent=null;

        protected var _stateMap:Object;

        protected var _newFrame:String;

        protected var _newFocusIndicatorFrame:String;

        protected var _repeatTimer:flash.utils.Timer;

        protected var _mouseDown:int=0;

        protected var _focusIndicatorLabelHash:Object;

        protected var _autoRepeatEvent:scaleform.clik.events.ButtonEvent;

        public var textField:flash.text.TextField;

        public var defaultTextFormat:flash.text.TextFormat;

        protected var _focusIndicator:flash.display.MovieClip;

        protected var _group:scaleform.clik.controls.ButtonGroup;

        protected var statesDefault:__AS3__.vec.Vector.<String>;

        protected var statesSelected:__AS3__.vec.Vector.<String>;
    }
}
