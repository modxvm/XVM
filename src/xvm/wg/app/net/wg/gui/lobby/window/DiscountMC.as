package net.wg.gui.lobby.window
{
   import scaleform.clik.core.UIComponent;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;


   public class DiscountMC extends UIComponent
   {
          
      public function DiscountMC() {
         super();
      }

      public var textField:TextField;

      private var _text:String;

      private var isTextChanged:Boolean;

      override protected function configUI() : void {
         super.configUI();
         this.textField.autoSize = TextFieldAutoSize.LEFT;
      }

      public function get text() : String {
         return this._text;
      }

      public function set text(param1:String) : void {
         this._text = param1;
         this.isTextChanged = true;
         invalidate();
      }

      override protected function draw() : void {
         super.draw();
         if(this.isTextChanged)
         {
            this.isTextChanged = false;
            this.textField.text = this._text;
         }
      }
   }

}