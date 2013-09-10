package net.wg.gui.lobby.header 
{
    import flash.display.*;
    import flash.events.*;
    import net.wg.utils.*;
    import scaleform.clik.core.*;
    
    public class ServerStats extends scaleform.clik.core.UIComponent
    {
        public function ServerStats()
        {
            super();
            visible = false;
            this.players_online.useHandCursor = false;
            this.players_online.addEventListener(flash.events.MouseEvent.ROLL_OVER, this.showPlayersTooltip);
            this.players_online.addEventListener(flash.events.MouseEvent.ROLL_OUT, this.hideTooltip);
            return;
        }

        public override function dispose():void
        {
            super.dispose();
            this.players_online.removeEventListener(flash.events.MouseEvent.ROLL_OVER, this.showPlayersTooltip);
            this.players_online.removeEventListener(flash.events.MouseEvent.ROLL_OUT, this.hideTooltip);
            return;
        }

        public function setValues(arg1:Object):void
        {
            var loc1:*=arg1.regionCCU == undefined ? 0 : arg1.regionCCU;
            var loc2:*=arg1.clusterCCU == undefined ? 0 : arg1.clusterCCU;
            var loc3:*="";
            var loc4:*=App.utils.locale;
            if (loc2 != loc1) 
            {
                this.tooltipType = TYPE_FULL;
                loc3 = !(loc2 == 0) && !(loc1 == 0) ? loc4.integer(loc2) + " / " + loc4.integer(loc1) : "";
            }
            else 
            {
                this.tooltipType = TYPE_CLUSTER;
                loc3 = loc2 == 0 ? "" : loc4.integer(loc2);
            }
            this.players_online.pCount.text = loc3;
            this.visible = !(loc3 == "");
            return;
        }

        public function hideTooltip(arg1:Object):void
        {
            App.toolTipMgr.hide();
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            visible = App.instance.globalVarsMgr.isShowServerStatsS();
            return;
        }

        public function showPlayersTooltip(arg1:flash.events.MouseEvent):void
        {
            var loc1:*=this.tooltipType;
            switch (loc1) 
            {
                case TYPE_CLUSTER:
                {
                    App.toolTipMgr.showComplex(TOOLTIPS.HEADER_INFO_PLAYERS_ONLINE_REGION);
                    break;
                }
                case TYPE_FULL:
                {
                    App.toolTipMgr.showComplex(this.tooltipFullData);
                    break;
                }
                default:
                {
                    App.toolTipMgr.showComplex(TOOLTIPS.HEADER_INFO_PLAYERS_ONLINE_REGION);
                    break;
                }
            }
            return;
        }

        internal static const TYPE_CLUSTER:String="clusterCCU";

        internal static const TYPE_FULL:String="regionCCU/clusterCCU";

        public var players_online:flash.display.MovieClip;

        public var tooltipType:String="regionCCU/clusterCCU";

        public var tooltipFullData:String="";

        internal var locale:net.wg.utils.ILocale;
    }
}
