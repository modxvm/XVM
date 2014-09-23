package net.wg.gui.components.common.serverStats
{
    import scaleform.clik.core.UIComponent;
    import flash.display.MovieClip;
    import flash.text.TextField;
    import net.wg.gui.components.advanced.InviteIndicator;
    import flash.display.Sprite;
    import flash.display.DisplayObject;
    import flash.events.MouseEvent;
    import net.wg.utils.ILocale;
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
        
        private static var CURRENT_SERVER_TEXT_COLOR:String = "#E9E2BF";
        
        public var hitMc:MovieClip;
        
        public var pCount:TextField;
        
        public var waiting:InviteIndicator;
        
        public var icon:Sprite;
        
        public var tooltipType:String = "regionCCU/clusterCCU";
        
        public var tooltipFullData:String = "";
        
        private var _relativelyOwner:DisplayObject = null;
        
        override protected function onDispose() : void
        {
            super.onDispose();
            this.hitMc.removeEventListener(MouseEvent.ROLL_OVER,this.showPlayersTooltip);
            this.hitMc.removeEventListener(MouseEvent.ROLL_OUT,this.hideTooltip);
        }
        
        public function setValues(param1:Object) : void
        {
            var _loc3_:* = NaN;
            var _loc4_:* = NaN;
            var _loc5_:ILocale = null;
            var _loc6_:String = null;
            var _loc2_:* = "- / -";
            this.tooltipType = TYPE_UNAVAILABLE;
            if(param1)
            {
                _loc3_ = param1.regionCCU != undefined?param1.regionCCU:0;
                _loc4_ = param1.clusterCCU != undefined?param1.clusterCCU:0;
                _loc5_ = App.utils.locale;
                _loc6_ = _loc4_ != 0?"<font color=\"" + CURRENT_SERVER_TEXT_COLOR + "\">" + _loc5_.integer(_loc4_) + "</font>":"";
                if(_loc4_ == 0 && _loc3_ == 0)
                {
                    this.tooltipType = TYPE_UNAVAILABLE;
                    _loc2_ = "- / -";
                }
                else if(_loc4_ == _loc3_)
                {
                    this.tooltipType = TYPE_CLUSTER;
                    _loc2_ = _loc6_;
                }
                else
                {
                    this.tooltipType = TYPE_FULL;
                    _loc2_ = _loc6_ + " / " + _loc5_.integer(_loc3_);
                }
                
                this.pCount.htmlText = _loc2_;
                this.hitMc.width = this.pCount.x + this.pCount.textWidth - this.hitMc.x + 15;
            }
            this.updateVisibility(!(_loc2_ == "") && (App.instance.globalVarsMgr.isShowServerStatsS()));
            invalidateSize();
        }
        
        override protected function draw() : void
        {
            super.draw();
            if((isInvalid(InvalidationType.SIZE)) && (this._relativelyOwner))
            {
                this.x = this._relativelyOwner.x + (this._relativelyOwner.width - this.hitMc.width >> 1) ^ 0;
            }
        }
        
        public function hideTooltip(param1:Object) : void
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
