package net.wg.gui.components.controls
{
   import scaleform.clik.core.UIComponent;
   import flash.text.TextField;
   
   public class UnitCommanderStats extends UIComponent
   {
      
      public function UnitCommanderStats() {
         super();
      }
      
      public var stats:TextField;
      
      public var descr:TextField;
      
      override protected function configUI() : void {
         super.configUI();
         this.descr.text = TOOLTIPS.CYBERSPORT_COMMANDER_STATS;
      }
   }
}
