package net.wg.gui.cyberSport.controls
{
   import scaleform.clik.core.UIComponent;
   import flash.text.TextField;
   
   public class RosterSettingsNumerationBlock extends UIComponent
   {
      
      public function RosterSettingsNumerationBlock() {
         super();
      }
      
      public var tf2:TextField;
      
      public var tf3:TextField;
      
      public var tf4:TextField;
      
      public var tf5:TextField;
      
      public var tf6:TextField;
      
      public var tf7:TextField;
      
      override protected function configUI() : void {
         super.configUI();
         this.tf2.text = this.tf3.text = this.tf4.text = this.tf5.text = this.tf6.text = this.tf7.text = CYBERSPORT.WINDOW_UNIT_ROSTERSETTINGSVIEW_OR;
      }
   }
}
