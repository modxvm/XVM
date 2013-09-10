package scaleform.clik.controls 
{
    import flash.events.*;
    import flash.text.*;
    import scaleform.clik.constants.*;
    import scaleform.clik.core.*;
    import scaleform.clik.events.*;
    import scaleform.clik.managers.*;
    import scaleform.clik.ui.*;
    import scaleform.clik.utils.*;
    import scaleform.gfx.*;
    
    public class TextInput extends scaleform.clik.core.UIComponent
    {
        public function TextInput()
        {
            super();
            return;
        }

        public function appendHtml(arg1:String):void
        {
            this._text = this._text + arg1;
            this._isHtml = true;
            invalidateData();
            return;
        }

        public override function handleInput(arg1:scaleform.clik.events.InputEvent):void
        {
            if (arg1.handled) 
                return;
            var loc1:*=arg1.details;
            if (loc1.value == scaleform.clik.constants.InputValue.KEY_DOWN || loc1.value == scaleform.clik.constants.InputValue.KEY_HOLD) 
                return;
            return;
        }

        public override function toString():String
        {
            return "[CLIK TextInput " + name + "]";
        }

        protected override function configUI():void
        {
            super.configUI();
            if (!this.constraintsDisabled) 
                constraints.addElement("textField", this.textField, scaleform.clik.utils.Constraints.ALL);
            addEventListener(scaleform.clik.events.InputEvent.INPUT, this.handleInput, false, 0, true);
            this.textField.addEventListener(flash.events.FocusEvent.FOCUS_IN, this.handleTextFieldFocusIn, false, 0, true);
            if (this.focusable && this.editable) 
                addEventListener(flash.events.MouseEvent.MOUSE_DOWN, this.handleMouseDown, false, 0, true);
            this.setState(this.defaultState, "default");
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
                this.updateTextField();
                dispatchEvent(new scaleform.clik.events.ComponentEvent(scaleform.clik.events.ComponentEvent.STATE_CHANGE));
                invalidate(scaleform.clik.constants.InvalidationType.SIZE);
            }
            else if (isInvalid(scaleform.clik.constants.InvalidationType.DATA)) 
                this.updateText();
            if (isInvalid(scaleform.clik.constants.InvalidationType.SIZE)) 
            {
                setActualSize(_width, _height);
                if (!this.constraintsDisabled) 
                    constraints.update(_width, _height);
            }
            return;
        }

        protected override function changeFocus():void
        {
            this.setState(this.defaultState);
            return;
        }

        public function get maxChars():uint
        {
            return this._maxChars;
        }

        protected function updateTextField():void
        {
            if (this.textField == null) 
            {
                trace(">>> Error :: " + this + ", textField is NULL.");
                return;
            }
            this.updateText();
            this.textField.maxChars = this._maxChars;
            this.textField.alwaysShowSelection = this._alwaysShowSelection;
            this.textField.selectable = this.enabled ? this._editable : this.enabled;
            this.textField.type = this._editable && this.enabled ? flash.text.TextFieldType.INPUT : flash.text.TextFieldType.DYNAMIC;
            this.textField.tabEnabled = this._editable && this.enabled && _focusable;
            this.textField.addEventListener(flash.events.Event.CHANGE, this.handleTextChange, false, 0, true);
            if (this.textField.hasEventListener(flash.events.FocusEvent.FOCUS_IN)) 
                this.textField.removeEventListener(flash.events.FocusEvent.FOCUS_IN, this.handleTextFieldFocusIn, false);
            this.textField.addEventListener(flash.events.FocusEvent.FOCUS_IN, this.handleTextFieldFocusIn, false, 0, true);
            return;
        }

        protected function handleTextFieldFocusIn(arg1:flash.events.FocusEvent):void
        {
            scaleform.clik.managers.FocusHandler.getInstance().setFocus(this);
            return;
        }

        protected function setState(... rest):void
        {
            var loc3:*=null;
            var loc4:*=null;
            if (rest.length == 1) 
            {
                loc3 = rest[0].toString();
                if (!(this._state == loc3) && _labelHash[loc3]) 
                {
                    var loc5:*;
                    this._newFrame = loc5 = loc3;
                    this._state = loc5;
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
                    this._state = loc5;
                    invalidateState();
                    break;
                }
                ++loc2;
            }
            return;
        }

        protected function updateAfterStateChange():void
        {
            var loc1:*=0;
            var loc2:*=0;
            if (!initialized) 
                return;
            constraints.updateElement("textField", this.textField);
            if (_focused) 
                if (scaleform.gfx.Extensions.isScaleform) 
                {
                    loc1 = scaleform.gfx.Extensions.numControllers;
                    loc2 = 0;
                    while (loc2 < loc1) 
                    {
                        if (scaleform.gfx.FocusManager.getFocus(loc2) == this) 
                            scaleform.gfx.FocusManager.setFocus(this.textField, loc2);
                        ++loc2;
                    }
                }
                else 
                    stage.focus = this.textField;
            return;
        }

        protected function handleRollOver(arg1:flash.events.MouseEvent):void
        {
            if (focused || !this.enabled) 
                return;
            this.setState("over");
            return;
        }

        protected function handleRollOut(arg1:flash.events.MouseEvent):void
        {
            if (focused || !this.enabled) 
                return;
            this.setState("out", "default");
            return;
        }

        protected function handleMouseDown(arg1:flash.events.MouseEvent):void
        {
            if (focused || !this.enabled) 
                return;
            if (arg1 is scaleform.gfx.MouseEventEx) 
                scaleform.gfx.FocusManager.setFocus(this.textField, (arg1 as scaleform.gfx.MouseEventEx).mouseIdx);
            else 
                stage.focus = this.textField;
            return;
        }

        protected function handleTextChange(arg1:flash.events.Event):void
        {
            if (!_focused) 
                return;
            this._text = this._isHtml ? this.textField.htmlText : this.textField.text;
            dispatchEvent(new flash.events.Event(flash.events.Event.CHANGE));
            return;
        }

        public override function dispose():void
        {
            removeEventListener(flash.events.MouseEvent.MOUSE_DOWN, this.handleMouseDown, false);
            removeEventListener(flash.events.MouseEvent.ROLL_OVER, this.handleRollOver, false);
            removeEventListener(flash.events.MouseEvent.ROLL_OUT, this.handleRollOut, false);
            removeEventListener(scaleform.clik.events.InputEvent.INPUT, this.handleInput, false);
            this.textField.removeEventListener(flash.events.Event.CHANGE, this.handleTextChange, false);
            this.textField.removeEventListener(flash.events.FocusEvent.FOCUS_IN, this.handleTextFieldFocusIn, false);
            this.defaultTextFormat = null;
            this._textFormat = null;
            this.textField = null;
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
            super.tabEnabled = false;
            var loc1:*;
            mouseChildren = loc1 = this.enabled;
            mouseEnabled = loc1;
            super.initialize();
            this._textFormat = this.textField.getTextFormat();
            this.defaultTextFormat = new flash.text.TextFormat();
            this.defaultTextFormat.italic = true;
            this.defaultTextFormat.color = 11184810;
            return;
        }

        public override function get enabled():Boolean
        {
            return super.enabled;
        }

        public override function set enabled(arg1:Boolean):void
        {
            super.enabled = arg1;
            mouseChildren = arg1;
            super.tabEnabled = false;
            tabChildren = _focusable;
            this.setState(this.defaultState);
            return;
        }

        public override function get focusable():Boolean
        {
            return _focusable;
        }

        public override function set focusable(arg1:Boolean):void
        {
            _focusable = arg1;
            if (!_focusable && this.enabled) 
                tabChildren = false;
            this.changeFocus();
            if (_focusable && this.editable) 
                addEventListener(flash.events.MouseEvent.MOUSE_DOWN, this.handleMouseDown, false, 0, true);
            else 
                removeEventListener(flash.events.MouseEvent.MOUSE_DOWN, this.handleMouseDown, false);
            return;
        }

        public function get text():String
        {
            return this._text;
        }

        public function set text(arg1:String):void
        {
            this._isHtml = false;
            this._text = arg1;
            invalidateData();
            return;
        }

        public function get htmlText():String
        {
            return this._text;
        }

        public function set htmlText(arg1:String):void
        {
            this._isHtml = true;
            this._text = arg1;
            invalidateData();
            return;
        }

        public function get defaultText():String
        {
            return this._defaultText;
        }

        public function set defaultText(arg1:String):void
        {
            this._defaultText = arg1;
            invalidateData();
            return;
        }

        public function get displayAsPassword():Boolean
        {
            return this._displayAsPassword;
        }

        public function set displayAsPassword(arg1:Boolean):void
        {
            this._displayAsPassword = arg1;
            if (this.textField != null) 
                this.textField.displayAsPassword = arg1;
            return;
        }

        protected function updateText():void
        {
            if (_focused && this._usingDefaultTextFormat) 
            {
                this.textField.defaultTextFormat = this._textFormat;
                this._usingDefaultTextFormat = false;
                if (this._displayAsPassword && !this.textField.displayAsPassword) 
                    this.textField.displayAsPassword = true;
            }
            if (this._text == "") 
            {
                this.textField.text = "";
                if (!_focused && !(this._defaultText == "")) 
                {
                    if (this._displayAsPassword) 
                        this.textField.displayAsPassword = false;
                    this.textField.text = this._defaultText;
                    this._usingDefaultTextFormat = true;
                    if (this.defaultTextFormat != null) 
                        this.textField.setTextFormat(this.defaultTextFormat);
                }
            }
            else if (this._isHtml) 
                this.textField.htmlText = this._text;
            else 
                this.textField.text = this._text;
            return;
        }

        public function set maxChars(arg1:uint):void
        {
            this._maxChars = arg1;
            if (this.textField != null) 
                this.textField.maxChars = arg1;
            return;
        }

        public function get editable():Boolean
        {
            return this._editable;
        }

        public function set editable(arg1:Boolean):void
        {
            this._editable = arg1;
            if (this.textField != null) 
                this.textField.type = this._editable && this.enabled ? flash.text.TextFieldType.INPUT : flash.text.TextFieldType.DYNAMIC;
            this.focusable = arg1;
            return;
        }

        public override function get tabEnabled():Boolean
        {
            return this.textField.tabEnabled;
        }

        public override function set tabEnabled(arg1:Boolean):void
        {
            this.textField.tabEnabled = arg1;
            return;
        }

        public override function get tabIndex():int
        {
            return this.textField.tabIndex;
        }

        public override function set tabIndex(arg1:int):void
        {
            this.textField.tabIndex = arg1;
            return;
        }

        public function get actAsButton():Boolean
        {
            return this._actAsButton;
        }

        public function set actAsButton(arg1:Boolean):void
        {
            if (this._actAsButton == arg1) 
                return;
            this._actAsButton = arg1;
            if (arg1) 
            {
                addEventListener(flash.events.MouseEvent.ROLL_OVER, this.handleRollOver, false, 0, true);
                addEventListener(flash.events.MouseEvent.ROLL_OUT, this.handleRollOut, false, 0, true);
            }
            else 
            {
                removeEventListener(flash.events.MouseEvent.ROLL_OVER, this.handleRollOver, false);
                removeEventListener(flash.events.MouseEvent.ROLL_OUT, this.handleRollOut, false);
            }
            return;
        }

        public function get alwaysShowSelection():Boolean
        {
            return this._alwaysShowSelection;
        }

        public function set alwaysShowSelection(arg1:Boolean):void
        {
            this._alwaysShowSelection = arg1;
            if (this.textField != null) 
                this.textField.alwaysShowSelection = arg1;
            return;
        }

        public function get length():uint
        {
            return this.textField.length;
        }

        public function get defaultState():String
        {
            return this.enabled ? focused ? "focused" : "default" : "disabled";
        }

        public function appendText(arg1:String):void
        {
            this._text = this._text + arg1;
            this._isHtml = false;
            invalidateData();
            return;
        }

        public var defaultTextFormat:flash.text.TextFormat;

        public var constraintsDisabled:Boolean=false;

        protected var _text:String="";

        protected var _displayAsPassword:Boolean=false;

        protected var _maxChars:uint=0;

        protected var _editable:Boolean=true;

        protected var _alwaysShowSelection:Boolean=false;

        protected var _isHtml:Boolean=false;

        protected var _state:String="default";

        protected var _newFrame:String;

        protected var _textFormat:flash.text.TextFormat;

        protected var _usingDefaultTextFormat:Boolean=true;

        protected var _defaultText:String="";

        internal var hscroll:Number=0;

        public var textField:flash.text.TextField;

        protected var _actAsButton:Boolean=false;
    }
}
