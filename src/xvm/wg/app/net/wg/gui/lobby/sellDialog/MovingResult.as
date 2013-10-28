package net.wg.gui.lobby.sellDialog
{
   import scaleform.clik.core.UIComponent;
   import net.wg.gui.components.controls.IconText;
   import flash.text.TextField;


   public class MovingResult extends UIComponent
   {
          
      public function MovingResult() {
         super();
      }

      public var creditsIT:IconText;

      public var text:TextField;

      override protected function configUI() : void {
         this.text.text = DIALOGS.CONFIRMMODULEDIALOG_TOTALLABEL;
         this.creditsIT.textFieldYOffset = VehicleSellDialog.ICONS_TEXT_OFFSET;
      }
   }

}