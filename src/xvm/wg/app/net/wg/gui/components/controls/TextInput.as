package net.wg.gui.components.controls 
{
    import flash.events.*;
    import flash.ui.*;
    import scaleform.clik.controls.*;
    import scaleform.clik.core.*;
    import scaleform.clik.events.*;
    import scaleform.gfx.*;
    
    public class TextInput extends scaleform.clik.controls.TextInput
    {
        public function TextInput()
        {
            super();
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            return;
        }

        protected override function updateTextField():void
        {
            super.updateTextField();
            if (textField != null) 
            {
                this.selectionTextColor = this._selectionTextColor;
                this.selectionBgColor = this._selectionBgColor;
                if (textField.hasEventListener(flash.events.FocusEvent.FOCUS_OUT)) 
                {
                    textField.removeEventListener(flash.events.FocusEvent.FOCUS_OUT, this.handleTextFieldFocusOut, false);
                }
                textField.addEventListener(flash.events.FocusEvent.FOCUS_OUT, this.handleTextFieldFocusOut, false, 0, true);
                if (textField.hasEventListener(flash.events.FocusEvent.FOCUS_IN)) 
                {
                    textField.removeEventListener(flash.events.FocusEvent.FOCUS_IN, this.handleTextFieldFocusIn, false);
                }
                textField.addEventListener(flash.events.FocusEvent.FOCUS_IN, this.handleTextFieldFocusIn, false, 0, true);
            }
            return;
        }

        protected override function handleTextFieldFocusIn(arg1:flash.events.FocusEvent):void
        {
            super.handleTextFieldFocusIn(arg1);
            this.autoSelectionText();
            this.highlight = false;
            App.utils.IME.setVisible(true);
            return;
        }

        protected function autoSelectionText():void
        {
            textField.setSelection(0, textField.text.length);
            return;
        }

        protected function handleTextFieldFocusOut(arg1:flash.events.FocusEvent):void
        {
            App.utils.IME.setVisible(false);
            return;
        }

        public override function handleInput(arg1:scaleform.clik.events.InputEvent):void
        {
            var loc1:*=arg1.details.code;
            switch (loc1) 
            {
                case flash.ui.Keyboard.LEFT:
                case flash.ui.Keyboard.RIGHT:
                case flash.ui.Keyboard.UP:
                case flash.ui.Keyboard.DOWN:
                {
                    arg1.handled = true;
                    return;
                }
            }
            super.handleInput(arg1);
            return;
        }

        protected override function handleTextChange(arg1:flash.events.Event):void
        {
            var loc1:*=null;
            var loc2:*=null;
            var loc3:*=NaN;
            super.handleTextChange(arg1);
            this.highlight = false;
            if (this._extractEscapes) 
            {
                loc1 = textField.text;
                loc2 = "";
                loc3 = 0;
                while (loc3 < loc1.length) 
                {
                    var loc4:*=loc1.charAt(loc3);
                    switch (loc4) 
                    {
                        case "\n":
                        case "\r":
                        {
                            break;
                        }
                        default:
                        {
                            loc2 = loc2 + loc1.charAt(loc3);
                        }
                    }
                    ++loc3;
                }
                textField.text = loc2;
            }
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

        public function get extractEscapes():Boolean
        {
            return this._extractEscapes;
        }

        public function set extractEscapes(arg1:Boolean):void
        {
            if (this._extractEscapes == arg1) 
            {
                return;
            }
            this._extractEscapes = arg1;
            return;
        }

        public function set highlight(arg1:Boolean):void
        {
            this.highlightMc.visible = arg1;
            return;
        }

        protected var _extractEscapes:Boolean=true;

        public var highlightMc:scaleform.clik.core.UIComponent=null;

        internal var _selectionTextColor:uint=1973787;

        internal var _selectionBgColor:uint=9868935;
    }
}
