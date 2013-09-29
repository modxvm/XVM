package net.wg.gui.components.advanced 
{
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.text.*;
    import scaleform.clik.constants.*;
    import scaleform.clik.controls.*;
    import scaleform.clik.events.*;
    import scaleform.clik.ui.*;
    import scaleform.clik.utils.*;
    import scaleform.gfx.*;
    
    public class TextAreaSimple extends scaleform.clik.controls.TextArea
    {
        public function TextAreaSimple()
        {
            this._textPadding = new scaleform.clik.utils.Padding(0, 0, 0, 0);
            super();
            return;
        }

        protected override function draw():void
        {
            var loc1:*=NaN;
            super.draw();
            if (isInvalid(scaleform.clik.constants.InvalidationType.STATE)) 
            {
                if (textField != null) 
                {
                    this.selectionTextColor = this._selectionTextColor;
                    this.selectionBgColor = this._selectionBgColor;
                }
            }
            if (_autoScrollBar) 
            {
                if (this._showBgForm) 
                {
                    loc1 = 3;
                    _scrollBar.y = loc1;
                    _scrollBar.x = width - _scrollBar.width - 2;
                    _scrollBar.height = height - loc1 * 2;
                }
                else 
                {
                    _scrollBar.y = 1;
                    _scrollBar.x = (width - _scrollBar.width - 1);
                    _scrollBar.height = height - 2;
                }
            }
            this.updateText();
            return;
        }

        protected override function updateText():void
        {
            super.updateText();
            if (this.autoScroll) 
            {
                position = this._safePosition ? textField.scrollV : textField.maxScrollV;
            }
            if (_scrollBar) 
            {
                constraints.update(availableWidth, _height);
            }
            return;
        }

        protected override function handleScroll(arg1:flash.events.Event):void
        {
            super.handleScroll(arg1);
            this._safePosition = _scrollBar.position < textField.maxScrollV;
            return;
        }

        public function get safePosition():Boolean
        {
            return this._safePosition;
        }

        public function set safePosition(arg1:Boolean):void
        {
            this._safePosition = arg1;
            return;
        }

        public function appendHtmlResetPosition(arg1:String):void
        {
            this.safePosition = false;
            appendHtml(arg1);
            return;
        }

        internal function onMouseWheel(arg1:flash.events.MouseEvent):void
        {
            var loc1:*=null;
            var loc2:*=null;
            if (enabled) 
            {
                loc1 = new flash.geom.Point(stage.mouseX, stage.mouseY);
                if (visible && hitTestPoint(loc1.x, loc1.y, true)) 
                {
                    loc2 = getObjectsUnderPoint(loc1);
                }
            }
            return;
        }

        public override function handleInput(arg1:scaleform.clik.events.InputEvent):void
        {
            var loc2:*=null;
            var loc3:*=NaN;
            var loc4:*=NaN;
            if (arg1.handled) 
            {
                return;
            }
            var loc1:*=arg1.details;
            if (loc1.value == scaleform.clik.constants.InputValue.KEY_DOWN || loc1.value == scaleform.clik.constants.InputValue.KEY_HOLD) 
            {
                return;
            }
            if (arg1.handled) 
            {
                return;
            }
            loc2 = arg1.details.navEquivalent;
            var loc5:*=loc2;
            switch (loc5) 
            {
                case scaleform.clik.constants.NavigationCode.UP:
                {
                    if (position == 1) 
                    {
                        return;
                    }
                    position = Math.max(1, (position - 1));
                    arg1.handled = true;
                    break;
                }
                case scaleform.clik.constants.NavigationCode.DOWN:
                {
                    if (position == _maxScroll) 
                    {
                        return;
                    }
                    position = Math.min(_maxScroll, position + 1);
                    arg1.handled = true;
                    break;
                }
                case scaleform.clik.constants.NavigationCode.END:
                {
                    position = _maxScroll;
                    arg1.handled = true;
                    break;
                }
                case scaleform.clik.constants.NavigationCode.HOME:
                {
                    position = 1;
                    arg1.handled = true;
                    break;
                }
                case scaleform.clik.constants.NavigationCode.PAGE_UP:
                {
                    loc3 = textField.bottomScrollV - textField.scrollV;
                    position = Math.max(1, position - loc3);
                    arg1.handled = true;
                    break;
                }
                case scaleform.clik.constants.NavigationCode.PAGE_DOWN:
                {
                    loc4 = textField.bottomScrollV - textField.scrollV;
                    position = Math.min(_maxScroll, position + loc4);
                    arg1.handled = true;
                    break;
                }
            }
            return;
        }

        public function get showBgForm():Boolean
        {
            return this._showBgForm;
        }

        public function set showBgForm(arg1:Boolean):void
        {
            this._showBgForm = arg1;
            return;
        }

        public function get textPadding():Object
        {
            return this._textPadding;
        }

        public function set textPadding(arg1:Object):void
        {
            this._textPadding = new scaleform.clik.utils.Padding(arg1.top, arg1.right, arg1.bottom, arg1.left);
            return;
        }

        public function get autoScroll():Boolean
        {
            return this._autoScroll;
        }

        public function set autoScroll(arg1:Boolean):void
        {
            this._autoScroll = arg1;
            return;
        }

        public function get selectable():Boolean
        {
            return this._selectable;
        }

        public function set selectable(arg1:Boolean):void
        {
            this._selectable = arg1;
            this.focusable = _editable ? _editable : this._selectable;
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

        public override function dispose():void
        {
            this._textPadding = null;
            this.bgForm = null;
            textField.removeEventListener(flash.events.FocusEvent.FOCUS_IN, handleTextFieldFocusIn, false);
            textField.removeEventListener(flash.events.FocusEvent.FOCUS_IN, this.onSetFocusHdlr);
            textField.removeEventListener(flash.events.FocusEvent.FOCUS_OUT, this.onKillFocusHdlr);
            removeEventListener(flash.events.MouseEvent.MOUSE_DOWN, handleMouseDown, false);
            removeEventListener(scaleform.clik.events.InputEvent.INPUT, this.handleInput, false);
            removeEventListener(flash.events.MouseEvent.MOUSE_WHEEL, this.onMouseWheel);
            super.dispose();
            return;
        }

        public override function get focusable():Boolean
        {
            return _focusable;
        }

        public override function set focusable(arg1:Boolean):void
        {
            _focusable = arg1;
            if (!_focusable && enabled) 
            {
                tabChildren = false;
            }
            changeFocus();
            if (_focusable && this.selectable) 
            {
                addEventListener(flash.events.MouseEvent.MOUSE_DOWN, handleMouseDown, false, 0, true);
            }
            else 
            {
                removeEventListener(flash.events.MouseEvent.MOUSE_DOWN, handleMouseDown, false);
            }
            return;
        }

        public override function get editable():Boolean
        {
            return _editable;
        }

        public override function set editable(arg1:Boolean):void
        {
            _editable = arg1;
            if (textField != null) 
            {
                textField.type = _editable && enabled ? flash.text.TextFieldType.INPUT : flash.text.TextFieldType.DYNAMIC;
            }
            this.focusable = _editable ? _editable : this.selectable;
            return;
        }

        protected override function configUI():void
        {
            if (this._showBgForm) 
            {
                textField.x = PADDING_FOR_BG;
                textField.y = PADDING_FOR_BG;
                textField.width = textField.width - PADDING_FOR_BG * 2;
                textField.height = textField.height - PADDING_FOR_BG * 2;
            }
            else 
            {
                textField.x = this._textPadding.left;
                textField.y = this._textPadding.top;
                textField.width = textField.width - (this._textPadding.left + this._textPadding.right);
                textField.height = textField.height - (this._textPadding.top + this._textPadding.bottom);
            }
            if (!constraintsDisabled) 
            {
                constraints.addElement("textField", textField, scaleform.clik.utils.Constraints.ALL);
            }
            addEventListener(scaleform.clik.events.InputEvent.INPUT, this.handleInput, false, 0, true);
            textField.addEventListener(flash.events.FocusEvent.FOCUS_IN, handleTextFieldFocusIn, false, 0, true);
            if (this.focusable && this._selectable) 
            {
                addEventListener(flash.events.MouseEvent.MOUSE_DOWN, handleMouseDown, false, 0, true);
            }
            setState(defaultState, "default");
            addEventListener(flash.events.MouseEvent.MOUSE_WHEEL, this.onMouseWheel);
            textField.selectable = enabled ? this.editable || this._selectable : false;
            this.bgForm.visible = this.showBgForm;
            return;
        }

        protected override function updateTextField():void
        {
            _resetScrollPosition = true;
            if (textField == null) 
            {
                trace(">>> Error :: " + this + ", textField is NULL.");
                return;
            }
            this.updateText();
            textField.maxChars = _maxChars;
            textField.alwaysShowSelection = _alwaysShowSelection;
            textField.selectable = enabled ? this._selectable : enabled;
            textField.type = _editable && enabled ? flash.text.TextFieldType.INPUT : flash.text.TextFieldType.DYNAMIC;
            textField.tabEnabled = this._selectable && enabled && _focusable;
            textField.addEventListener(flash.events.Event.CHANGE, handleTextChange, false, 0, true);
            if (textField.hasEventListener(flash.events.FocusEvent.FOCUS_IN)) 
            {
                textField.removeEventListener(flash.events.FocusEvent.FOCUS_IN, handleTextFieldFocusIn, false);
            }
            textField.addEventListener(flash.events.FocusEvent.FOCUS_IN, handleTextFieldFocusIn, false, 0, true);
            if (!textField.hasEventListener(flash.events.FocusEvent.FOCUS_IN)) 
            {
                textField.addEventListener(flash.events.FocusEvent.FOCUS_IN, this.onSetFocusHdlr);
            }
            if (!textField.hasEventListener(flash.events.FocusEvent.FOCUS_OUT)) 
            {
                textField.addEventListener(flash.events.FocusEvent.FOCUS_OUT, this.onKillFocusHdlr);
            }
            textField.selectable = enabled ? this.editable || this._selectable : enabled;
            return;
        }

        internal function onSetFocusHdlr(arg1:flash.events.FocusEvent):void
        {
            App.utils.IME.setVisible(true);
            return;
        }

        internal function onKillFocusHdlr(arg1:flash.events.FocusEvent):void
        {
            App.utils.IME.setVisible(false);
            return;
        }

        internal static const PADDING_FOR_BG:Number=7;

        public var bgForm:flash.display.Sprite;

        internal var _safePosition:Boolean=false;

        internal var _autoScroll:Boolean=false;

        internal var _showBgForm:Boolean=false;

        internal var _selectable:Boolean=false;

        internal var _textPadding:scaleform.clik.utils.Padding;

        internal var _selectionTextColor:uint=1973787;

        internal var _selectionBgColor:uint=9868935;
    }
}
