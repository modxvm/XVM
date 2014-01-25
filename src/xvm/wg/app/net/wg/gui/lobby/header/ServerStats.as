package net.wg.gui.lobby.header
{
   import scaleform.clik.core.UIComponent;
   import flash.display.MovieClip;
   import net.wg.utils.ILocale;
   import flash.events.MouseEvent;


   public class ServerStats extends UIComponent
   {
          
      public function ServerStats() {
         super();
         visible = false;
         this.players_online.useHandCursor = false;
         this.players_online.addEventListener(MouseEvent.ROLL_OVER,this.showPlayersTooltip);
         this.players_online.addEventListener(MouseEvent.ROLL_OUT,this.hideTooltip);
      }

      private static const TYPE_CLUSTER:String = "clusterCCU";

      private static const TYPE_FULL:String = "regionCCU/clusterCCU";

      public var players_online:MovieClip;

      public var tooltipType:String = "regionCCU/clusterCCU";

      public var tooltipFullData:String = "";

      private var locale:ILocale;

      override protected function onDispose() : void {
         super.onDispose();
         this.players_online.removeEventListener(MouseEvent.ROLL_OVER,this.showPlayersTooltip);
         this.players_online.removeEventListener(MouseEvent.ROLL_OUT,this.hideTooltip);
      }

      public function setValues(param1:Object) : void {
         var _loc2_:Number = param1.regionCCU != undefined?param1.regionCCU:0;
         var _loc3_:Number = param1.clusterCCU != undefined?param1.clusterCCU:0;
         var _loc4_:* = "";
         var _loc5_:ILocale = App.utils.locale;
         if(_loc3_ == _loc2_)
         {
            this.tooltipType = TYPE_CLUSTER;
            _loc4_ = _loc3_ != 0?_loc5_.integer(_loc3_):"";
         }
         else
         {
            this.tooltipType = TYPE_FULL;
            _loc4_ = !(_loc3_ == 0) && !(_loc2_ == 0)?_loc5_.integer(_loc3_) + " / " + _loc5_.integer(_loc2_):"";
         }
         this.players_online.pCount.text = _loc4_;
         this.visible = !(_loc4_ == "");
      }

      public function hideTooltip(param1:Object) : void {
         App.toolTipMgr.hide();
      }

      override protected function configUI() : void {
         super.configUI();
         visible = App.instance.globalVarsMgr.isShowServerStatsS();
      }

      public function showPlayersTooltip(param1:MouseEvent) : void {
         switch(this.tooltipType)
         {
            case TYPE_CLUSTER:
               App.toolTipMgr.showComplex(TOOLTIPS.HEADER_INFO_PLAYERS_ONLINE_REGION);
               break;
            case TYPE_FULL:
               App.toolTipMgr.showComplex(this.tooltipFullData);
               break;
            default:
               App.toolTipMgr.showComplex(TOOLTIPS.HEADER_INFO_PLAYERS_ONLINE_REGION);
         }
      }
   }

}