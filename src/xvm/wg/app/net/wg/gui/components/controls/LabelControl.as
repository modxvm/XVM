package net.wg.gui.components.controls
{
   import scaleform.clik.controls.Label;
   import flash.text.TextFormat;


   public class LabelControl extends Label
   {
          
      public function LabelControl() {
         super();
      }

      protected var _textAlign:String = "none";

      public function set textAlign(param1:String) : void {
         if(this._textAlign == param1)
         {
            return;
         }
         this._textAlign = param1;
         invalidateData();
      }

      public function get textAlign() : String {
         return this._textAlign;
      }

      override protected function updateText() : void {
         var _loc1_:TextFormat = null;
         super.updateText();
         if(!(_text == null) && !(textField == null))
         {
            _loc1_ = textField.getTextFormat();
            _loc1_.align = this._textAlign;
            textField.setTextFormat(_loc1_);
         }
      }
   }

}