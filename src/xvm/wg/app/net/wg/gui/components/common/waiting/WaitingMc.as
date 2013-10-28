package net.wg.gui.components.common.waiting
{
   import scaleform.clik.core.UIComponent;
   import flash.text.TextField;


   public class WaitingMc extends UIComponent
   {
          
      public function WaitingMc() {
         super();
      }

      public static const TEXT_INVALID:String = "textInv";

      private var _text:String = "";

      public var textField:TextField;

      public function setMessage(param1:String) : void {
         this._text = param1;
         invalidate(TEXT_INVALID);
      }

      override protected function draw() : void {
         super.draw();
         if(isInvalid(TEXT_INVALID))
         {
            this.textField.text = this._text;
         }
      }
   }

}