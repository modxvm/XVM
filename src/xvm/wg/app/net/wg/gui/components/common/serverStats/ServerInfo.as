package net.wg.gui.components.common.serverStats
{
    import scaleform.clik.core.UIComponent;
    import flash.display.MovieClip;
    import flash.text.TextField;
    import net.wg.gui.components.advanced.InviteIndicator;
    import flash.display.Sprite;
    import flash.display.DisplayObject;
    import flash.events.MouseEvent;
    import net.wg.data.constants.Values;
    import scaleform.clik.constants.InvalidationType;
    
    public class ServerInfo extends UIComponent
    {
        
        public function ServerInfo()
        {
            super();
            this.updateVisibility(false);
            this.hitMc.useHandCursor = false;
            this.hitMc.addEventListener(MouseEvent.ROLL_OVER,this.showPlayersTooltip);
            this.hitMc.addEventListener(MouseEvent.ROLL_OUT,this.hideTooltip);
        }
        
        private static var TYPE_UNAVAILABLE:String = "unavailable";
        
        private static var TYPE_CLUSTER:String = "clusterCCU";
        
        private static var TYPE_FULL:String = "regionCCU/clusterCCU";
        
        private static var ADD_HIT_AREA_WIDTH:Number = 15;
        
        public var hitMc:MovieClip;
        
        public var pCount:TextField;
        
        public var waiting:InviteIndicator;
        
        public var icon:Sprite;
        
        public var tooltipFullData:String = "";
        
        public var tooltipType:String = "unavailable";
        
        private var _relativelyOwner:DisplayObject = null;
        
        override protected function onDispose() : void
        {
            super.onDispose();
            this.waiting.dispose();
            this.waiting = null;
            this._relativelyOwner = null;
            this.hitMc.removeEventListener(MouseEvent.ROLL_OVER,this.showPlayersTooltip);
            this.hitMc.removeEventListener(MouseEvent.ROLL_OUT,this.hideTooltip);
        }
        
        public function setValues(param1:String, param2:String) : void
        {
            this.tooltipType = param2 != Values.EMPTY_STR?param2:TYPE_UNAVAILABLE;
            if((param1) && !(param1 == Values.EMPTY_STR))
            {
                this.pCount.htmlText = param1;
                this.hitMc.width = this.pCount.x + this.pCount.textWidth - this.hitMc.x + ADD_HIT_AREA_WIDTH;
            }
            this.updateVisibility(!(param1 == "") && (App.instance.globalVarsMgr.isShowServerStatsS()));
            invalidateSize();
        }
        
        override protected function draw() : void
        {
            super.draw();
            if((isInvalid(InvalidationType.SIZE)) && (this.relativelyOwner))
            {
                this.x = this.relativelyOwner.x + (this.relativelyOwner.width - this.hitMc.width >> 1) ^ 0;
            }
        }
        
        public function hideTooltip(param1:MouseEvent) : void
        {
            App.toolTipMgr.hide();
        }
        
        override protected function configUI() : void
        {
            super.configUI();
        }
        
        public function showPlayersTooltip(param1:MouseEvent) : void
        {
            switch(this.tooltipType)
            {
                case TYPE_UNAVAILABLE:
                    App.toolTipMgr.showComplex(TOOLTIPS.HEADER_INFO_PLAYERS_UNAVAILABLE);
                    break;
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
        
        private function updateVisibility(param1:Boolean) : void
        {
            this.icon.visible = param1;
            this.pCount.visible = param1;
            this.waiting.visible = !param1;
        }
        
        public function get relativelyOwner() : DisplayObject
        {
            return this._relativelyOwner;
        }
        
        public function set relativelyOwner(param1:DisplayObject) : void
        {
            this._relativelyOwner = param1;
            invalidateSize();
        }
    }
}
