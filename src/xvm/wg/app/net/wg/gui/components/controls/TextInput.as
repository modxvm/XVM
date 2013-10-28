package net.wg.gui.components.controls
{
   import scaleform.clik.controls.TextInput;
   import scaleform.clik.core.UIComponent;
   import flash.events.FocusEvent;
   import scaleform.clik.events.InputEvent;
   import flash.ui.Keyboard;
   import flash.events.Event;
   import scaleform.gfx.TextFieldEx;


   public class TextInput extends scaleform.clik.controls.TextInput
   {
          
      public function TextInput() {
         super();
      }

      protected var _extractEscapes:Boolean = true;

      public var highlightMc:UIComponent = null;

      private var _selectionTextColor:uint = 1973787;

      private var _selectionBgColor:uint = 9868935;

      override protected function configUI() : void {
         super.configUI();
      }

      override protected function updateTextField() : void {
         super.updateTextField();
         if(textField != null)
         {
            this.selectionTextColor = this._selectionTextColor;
            this.selectionBgColor = this._selectionBgColor;
            if(textField.hasEventListener(FocusEvent.FOCUS_OUT))
            {
               textField.removeEventListener(FocusEvent.FOCUS_OUT,this.handleTextFieldFocusOut,false);
            }
            textField.addEventListener(FocusEvent.FOCUS_OUT,this.handleTextFieldFocusOut,false,0,true);
            if(textField.hasEventListener(FocusEvent.FOCUS_IN))
            {
               textField.removeEventListener(FocusEvent.FOCUS_IN,this.handleTextFieldFocusIn,false);
            }
            textField.addEventListener(FocusEvent.FOCUS_IN,this.handleTextFieldFocusIn,false,0,true);
         }
      }

      override protected function handleTextFieldFocusIn(param1:FocusEvent) : void {
         super.handleTextFieldFocusIn(param1);
         this.autoSelectionText();
         App.utils.IME.setVisible(true);
      }

      protected function autoSelectionText() : void {
         textField.setSelection(0,textField.text.length);
      }

      protected function handleTextFieldFocusOut(param1:FocusEvent) : void {
         App.utils.IME.setVisible(false);
      }

      override public function handleInput(param1:InputEvent) : void {
         switch(param1.details.code)
         {
            case Keyboard.LEFT:
            case Keyboard.RIGHT:
            case Keyboard.UP:
            case Keyboard.DOWN:
               param1.handled = true;
               return;
            default:
               super.handleInput(param1);
               return;
         }
      }

      override protected function handleTextChange(param1:Event) : void {
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc4_:* = NaN;
         super.handleTextChange(param1);
         this.highlight = false;
         if(this._extractEscapes)
         {
            _loc2_ = textField.text;
            _loc3_ = "";
            _loc4_ = 0;
            while(_loc4_ < _loc2_.length)
            {
               switch(_loc2_.charAt(_loc4_))
               {
                  case "\n":
                  case "\r":
                     break;
                  default:
                     _loc3_ = _loc3_ + _loc2_.charAt(_loc4_);
               }
               _loc4_++;
            }
            textField.text = _loc3_;
         }
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

      public function get extractEscapes() : Boolean {
         return this._extractEscapes;
      }

      public function set extractEscapes(param1:Boolean) : void {
         if(this._extractEscapes == param1)
         {
            return;
         }
         this._extractEscapes = param1;
      }

      public function set highlight(param1:Boolean) : void {
         this.highlightMc.visible = param1;
      }

      public function get highlight() : Boolean {
         return this.highlightMc.visible;
      }
   }

}