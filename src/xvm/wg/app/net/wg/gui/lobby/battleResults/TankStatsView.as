package net.wg.gui.lobby.battleResults
{
   import scaleform.clik.core.UIComponent;
   import net.wg.gui.components.controls.UserNameField;
   import flash.text.TextField;
   import net.wg.gui.components.controls.UILoaderAlt;
   import flash.events.MouseEvent;


   public class TankStatsView extends UIComponent
   {
          
      public function TankStatsView() {
         super();
      }

      public var playerNameLbl:UserNameField;

      public var arenaCreateDateLbl:TextField;

      public var vehicleStateLbl:TextField;

      public var tankNameLbl:TextField;

      public var tankIcon:UILoaderAlt;

      public var bgOverlay:UILoaderAlt;

      public var areaIcon:UILoaderAlt;

      private var _toolTip:String = null;

      override protected function onDispose() : void {
         this.vehicleStateLbl.removeEventListener(MouseEvent.ROLL_OVER,this.handleMouseRollOver);
         this.vehicleStateLbl.removeEventListener(MouseEvent.ROLL_OUT,this.handleMouseRollOut);
         this.tankIcon.dispose();
         this.bgOverlay.dispose();
         this.areaIcon.dispose();
      }

      public function get toolTip() : String {
         return this._toolTip;
      }

      public function set toolTip(param1:String) : void {
         this._toolTip = param1;
         this.vehicleStateLbl.addEventListener(MouseEvent.ROLL_OVER,this.handleMouseRollOver);
         this.vehicleStateLbl.addEventListener(MouseEvent.ROLL_OUT,this.handleMouseRollOut);
      }

      protected function handleMouseRollOver(param1:MouseEvent) : void {
         App.toolTipMgr.show(this.toolTip);
      }

      protected function handleMouseRollOut(param1:MouseEvent) : void {
         App.toolTipMgr.hide();
      }
   }

}