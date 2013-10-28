package net.wg.gui.lobby.battleResults
{
   import scaleform.clik.core.UIComponent;
   import flash.text.TextField;
   import net.wg.gui.components.controls.UILoaderAlt;


   public class TankStatsView extends UIComponent
   {
          
      public function TankStatsView() {
         super();
      }

      public var playerNameLbl:TextField;

      public var arenaCreateDateLbl:TextField;

      public var vehicleStateLbl:TextField;

      public var tankNameLbl:TextField;

      public var tankIcon:UILoaderAlt;

      public var bgOverlay:UILoaderAlt;

      public var areaIcon:UILoaderAlt;

      override public function dispose() : void {
         this.tankIcon.dispose();
         this.bgOverlay.dispose();
         this.areaIcon.dispose();
      }
   }

}