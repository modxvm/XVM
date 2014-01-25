package net.wg.gui.tutorial.controls
{
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;


   public class HintTextItemRenderer extends HintBaseItemRenderer
   {
          
      public function HintTextItemRenderer() {
         super();
      }

      public var textField:TextField;

      override protected function configUI() : void {
         super.configUI();
         this.textField.autoSize = TextFieldAutoSize.LEFT;
      }

      override protected function drawData() : void {
         super.drawData();
         this.textField.htmlText = _data.label;
         setActualSize(width,this.textField.height);
      }
   }

}