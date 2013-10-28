package net.wg.gui.lobby.dialogs
{


   public class DemountDeviceDialog extends IconPriceDialog
   {
          
      public function DemountDeviceDialog() {
         super();
      }

      override protected function applyLayout() : void {
         super.applyLayout();
         textField.y = (priceMc.y - textField.height) / 2;
      }

      override protected function getTextAreaCurrentHeight() : Number {
         return textField.textHeight + ADDITIONAL_MULTI_LINE_PADDING;
      }
   }

}