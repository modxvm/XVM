package net.wg.gui.lobby.store
{
   import scaleform.clik.core.UIComponent;
   import flash.text.TextField;


   public class TableHeaderInfo extends UIComponent
   {
          
      public function TableHeaderInfo() {
         super();
      }

      public var countField:TextField = null;

      public var textField:TextField = null;

      override protected function configUI() : void {
         super.configUI();
         this.textField.text = MENU.SHOP_TABLE_HEADER_PRICE;
      }
   }

}