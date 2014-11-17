package net.wg.gui.components.advanced
{
    import scaleform.clik.controls.TextArea;
    import flash.display.Sprite;
    import scaleform.clik.utils.Padding;
    import scaleform.gfx.TextFieldEx;
    import flash.events.FocusEvent;
    import flash.events.MouseEvent;
    import scaleform.clik.events.InputEvent;
    import flash.text.TextFieldType;
    import scaleform.clik.utils.Constraints;
    import flash.events.Event;
    import scaleform.clik.constants.InvalidationType;
    import flash.geom.Point;
    import scaleform.clik.ui.InputDetails;
    import scaleform.clik.constants.InputValue;
    import scaleform.clik.constants.NavigationCode;
    
    public class TextAreaSimple extends scaleform.clik.controls.TextArea
    {
        
        public function TextAreaSimple()
        {
            this._textPadding = new Padding(0,0,0,0);
            super();
        }
        
        private static var PADDING_FOR_BG:Number = 7;
        
        public var bgForm:Sprite;
        
        private var _safePosition:Boolean = false;
        
        private var _autoScroll:Boolean = false;
        
        private var _showBgForm:Boolean = false;
        
        private var _selectable:Boolean = false;
        
        private var _textPadding:Padding;
        
        private var _selectionTextColor:uint = 1973787;
        
        private var _selectionBgColor:uint = 9868935;
        
        public function get showBgForm() : Boolean
        {
            return this._showBgForm;
        }
        
        public function set showBgForm(param1:Boolean) : void
        {
            this._showBgForm = param1;
        }
        
        public function get textPadding() : Object
        {
            return this._textPadding;
        }
        
        public function set textPadding(param1:Object) : void
        {
            this._textPadding = new Padding(param1.top,param1.right,param1.bottom,param1.left);
        }
        
        public function get autoScroll() : Boolean
        {
            return this._autoScroll;
        }
        
        public function set autoScroll(param1:Boolean) : void
        {
            this._autoScroll = param1;
        }
        
        public function get selectable() : Boolean
        {
            return this._selectable;
        }
        
        public function set selectable(param1:Boolean) : void
        {
            this._selectable = param1;
            this.focusable = _editable?_editable:this._selectable;
        }
        
        public function get selectionTextColor() : uint
        {
            return this._selectionTextColor;
        }
        
        public function set selectionTextColor(param1:uint) : void
        {
            this._selectionTextColor = this.rgbToArgb(param1);
            TextFieldEx.setSelectionTextColor(textField,this._selectionTextColor);
            TextFieldEx.setInactiveSelectionTextColor(textField,this.rgbToArgb(textField.textColor));
        }
        
        public function get selectionBgColor() : uint
        {
            return this._selectionBgColor;
        }
        
        public function set selectionBgColor(param1:uint) : void
        {
            this._selectionBgColor = this.rgbToArgb(param1);
            TextFieldEx.setSelectionBkgColor(textField,this._selectionBgColor);
            TextFieldEx.setInactiveSelectionBkgColor(textField,0);
        }
        
        private function rgbToArgb(param1:uint) : uint
        {
            return 4.27819008E9 + param1;
        }
        
        override protected function onDispose() : void
        {
            this._textPadding = null;
            this.bgForm = null;
            textField.removeEventListener(FocusEvent.FOCUS_IN,handleTextFieldFocusIn,false);
            textField.removeEventListener(FocusEvent.FOCUS_IN,this.onSetFocusHdlr);
            textField.removeEventListener(FocusEvent.FOCUS_OUT,this.onKillFocusHdlr);
            removeEventListener(MouseEvent.MOUSE_DOWN,handleMouseDown,false);
            removeEventListener(InputEvent.INPUT,this.handleInput,false);
            removeEventListener(MouseEvent.MOUSE_WHEEL,this.onMouseWheel);
            super.onDispose();
        }
        
        override public function get focusable() : Boolean
        {
            return _focusable;
        }
        
        override public function set focusable(param1:Boolean) : void
        {
            _focusable = param1;
            if(!_focusable && (enabled))
            {
                tabChildren = false;
            }
            changeFocus();
            if((_focusable) && (this.selectable))
            {
                addEventListener(MouseEvent.MOUSE_DOWN,handleMouseDown,false,0,true);
            }
            else
            {
                removeEventListener(MouseEvent.MOUSE_DOWN,handleMouseDown,false);
            }
        }
        
        override public function get editable() : Boolean
        {
            return _editable;
        }
        
        override public function set editable(param1:Boolean) : void
        {
            _editable = param1;
            if(textField != null)
            {
                textField.type = (_editable) && (enabled)?TextFieldType.INPUT:TextFieldType.DYNAMIC;
            }
            this.focusable = _editable?_editable:this.selectable;
        }
        
        override protected function configUI() : void
        {
            if(this._showBgForm)
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
            if(!constraintsDisabled)
            {
                constraints.addElement("textField",textField,Constraints.ALL);
            }
            addEventListener(InputEvent.INPUT,this.handleInput,false,0,true);
            textField.addEventListener(FocusEvent.FOCUS_IN,handleTextFieldFocusIn,false,0,true);
            if((this.focusable) && (this._selectable))
            {
                addEventListener(MouseEvent.MOUSE_DOWN,handleMouseDown,false,0,true);
            }
            setState(defaultState,"default");
            addEventListener(MouseEvent.MOUSE_WHEEL,this.onMouseWheel);
            textField.selectable = enabled?(this.editable) || (this._selectable):false;
            this.bgForm.visible = this.showBgForm;
        }
        
        override protected function updateTextField() : void
        {
            _resetScrollPosition = true;
            if(textField == null)
            {
                return;
            }
            this.updateText();
            textField.maxChars = _maxChars;
            textField.alwaysShowSelection = _alwaysShowSelection;
            textField.selectable = enabled?this._selectable:enabled;
            textField.type = (_editable) && (enabled)?TextFieldType.INPUT:TextFieldType.DYNAMIC;
            textField.tabEnabled = (this._selectable) && (enabled) && (_focusable);
            textField.addEventListener(Event.CHANGE,handleTextChange,false,0,true);
            if(textField.hasEventListener(FocusEvent.FOCUS_IN))
            {
                textField.removeEventListener(FocusEvent.FOCUS_IN,handleTextFieldFocusIn,false);
            }
            textField.addEventListener(FocusEvent.FOCUS_IN,handleTextFieldFocusIn,false,0,true);
            if(!textField.hasEventListener(FocusEvent.FOCUS_IN))
            {
                textField.addEventListener(FocusEvent.FOCUS_IN,this.onSetFocusHdlr);
            }
            if(!textField.hasEventListener(FocusEvent.FOCUS_OUT))
            {
                textField.addEventListener(FocusEvent.FOCUS_OUT,this.onKillFocusHdlr);
            }
            textField.selectable = enabled?(this.editable) || (this._selectable):enabled;
        }
        
        private function onSetFocusHdlr(param1:FocusEvent) : void
        {
            App.utils.IME.setVisible(true);
        }
        
        private function onKillFocusHdlr(param1:FocusEvent) : void
        {
            App.utils.IME.setVisible(false);
        }
        
        override protected function draw() : void
        {
            var _loc1_:* = NaN;
            super.draw();
            if(isInvalid(InvalidationType.STATE))
            {
                if(textField != null)
                {
                    this.selectionTextColor = this._selectionTextColor;
                    this.selectionBgColor = this._selectionBgColor;
                }
            }
            if(_autoScrollBar)
            {
                if(this._showBgForm)
                {
                    _loc1_ = 3;
                    _scrollBar.y = _loc1_;
                    _scrollBar.x = width - _scrollBar.width - 2;
                    _scrollBar.height = height - _loc1_ * 2;
                }
                else
                {
                    _scrollBar.y = 1;
                    _scrollBar.x = width - _scrollBar.width - 1;
                    _scrollBar.height = height - 2;
                }
            }
            this.updateText();
        }
        
        override protected function updateText() : void
        {
            super.updateText();
            if(this.autoScroll)
            {
                position = this._safePosition?textField.scrollV:textField.maxScrollV;
            }
            if(_scrollBar)
            {
                constraints.update(availableWidth,_height);
            }
        }
        
        override protected function handleScroll(param1:Event) : void
        {
            super.handleScroll(param1);
            this._safePosition = _scrollBar.position < textField.maxScrollV;
        }
        
        public function get safePosition() : Boolean
        {
            return this._safePosition;
        }
        
        public function set safePosition(param1:Boolean) : void
        {
            this._safePosition = param1;
        }
        
        public function appendHtmlResetPosition(param1:String) : void
        {
            this.safePosition = false;
            appendHtml(param1);
        }
        
        private function onMouseWheel(param1:MouseEvent) : void
        {
            var _loc2_:Point = null;
            var _loc3_:Object = null;
            if(enabled)
            {
                _loc2_ = new Point(stage.mouseX,stage.mouseY);
                if((visible) && (hitTestPoint(_loc2_.x,_loc2_.y,true)))
                {
                    _loc3_ = getObjectsUnderPoint(_loc2_);
                }
            }
        }
        
        override public function handleInput(param1:InputEvent) : void
        {
            var _loc3_:String = null;
            var _loc4_:* = NaN;
            var _loc5_:* = NaN;
            if(param1.handled)
            {
                return;
            }
            var _loc2_:InputDetails = param1.details;
            if(_loc2_.value == InputValue.KEY_DOWN || _loc2_.value == InputValue.KEY_HOLD)
            {
                return;
            }
            if(param1.handled)
            {
                return;
            }
            _loc3_ = param1.details.navEquivalent;
            switch(_loc3_)
            {
                case NavigationCode.UP:
                    if(position == 1)
                    {
                        return;
                    }
                    position = Math.max(1,position - 1);
                    param1.handled = true;
                    break;
                case NavigationCode.DOWN:
                    if(position == _maxScroll)
                    {
                        return;
                    }
                    position = Math.min(_maxScroll,position + 1);
                    param1.handled = true;
                    break;
                case NavigationCode.END:
                    position = _maxScroll;
                    param1.handled = true;
                    break;
                case NavigationCode.HOME:
                    position = 1;
                    param1.handled = true;
                    break;
                case NavigationCode.PAGE_UP:
                    _loc4_ = textField.bottomScrollV - textField.scrollV;
                    position = Math.max(1,position - _loc4_);
                    param1.handled = true;
                    break;
                case NavigationCode.PAGE_DOWN:
                    _loc5_ = textField.bottomScrollV - textField.scrollV;
                    position = Math.min(_maxScroll,position + _loc5_);
                    param1.handled = true;
                    break;
            }
        }
    }
}
