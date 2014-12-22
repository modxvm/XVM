package net.wg.gui.components.tooltips
{
    import flash.text.TextField;
    import net.wg.gui.components.common.serverStats.ServerInfo;
    import flash.display.Sprite;
    import net.wg.gui.components.tooltips.VO.ToolTipSettingsButtonVO;
    import net.wg.gui.components.tooltips.helpers.Utils;
    import flash.text.TextFormatAlign;
    import net.wg.data.constants.Values;
    
    public class ToolTipSettingsButton extends ToolTipSpecial
    {
        
        public function ToolTipSettingsButton()
        {
            super();
            this.headerTF = content.headerTF;
            this.descriptionTF = content.descriptionTF;
            this.serverNameHeader = content.serverNameHeader;
            this.serverName = content.serverName;
            this.serverStatsHeader = content.serverStatsHeader;
            this.serverInfo = content.serverInfo;
            this.whiteBg = content.whiteBg;
            contentMargin.bottom = Utils.instance.MARGIN_AFTER_LASTITEM;
            contentMargin.right = 0;
        }
        
        private static var MAX_WIDTH:Number = 283;
        
        private static var MARGIN_AFTER_SUBHEADER:Number = 2;
        
        public var headerTF:TextField;
        
        public var descriptionTF:TextField;
        
        public var serverNameHeader:TextField;
        
        public var serverName:TextField;
        
        public var serverStatsHeader:TextField;
        
        public var serverInfo:ServerInfo;
        
        public var whiteBg:Sprite;
        
        override protected function redraw() : void
        {
            var _loc4_:* = NaN;
            topPosition = bgShadowMargin.top + contentMargin.top;
            var _loc1_:Separator = null;
            separators = new Vector.<Separator>();
            var _loc2_:Number = 5;
            var _loc3_:ToolTipSettingsButtonVO = new ToolTipSettingsButtonVO(_data);
            this.headerTF.htmlText = Utils.instance.htmlWrapper(_loc3_.name,Utils.instance.COLOR_HEADER,18,"$TitleFont");
            this.headerTF.width = this.headerTF.textWidth + _loc2_;
            this.descriptionTF.multiline = true;
            this.descriptionTF.wordWrap = true;
            this.descriptionTF.autoSize = TextFormatAlign.LEFT;
            this.descriptionTF.htmlText = Utils.instance.htmlWrapper(_loc3_.description,Utils.instance.COLOR_NORMAL,12,"$TextFont");
            this.descriptionTF.width = this.descriptionTF.textWidth + _loc2_;
            this.serverNameHeader.htmlText = Utils.instance.htmlWrapper(_loc3_.serverHeader,Utils.instance.COLOR_BLOCK_HEADER,14,"$TitleFont",true);
            this.serverNameHeader.width = this.serverNameHeader.textWidth + _loc2_;
            this.serverName.text = _loc3_.serverName;
            this.serverName.width = this.serverName.textWidth + _loc2_;
            if(!App.globalVarsMgr.isShowServerStatsS())
            {
                this.serverStatsHeader.text = "";
            }
            else
            {
                this.serverStatsHeader.htmlText = Utils.instance.htmlWrapper(_loc3_.playersOnServer,Utils.instance.COLOR_BLOCK_HEADER,14,"$TitleFont",true);
                this.serverInfo.setValues(_loc3_.serversStats,Values.EMPTY_STR);
            }
            this.serverStatsHeader.width = this.serverStatsHeader.textWidth + _loc2_;
            _loc4_ = contentMargin.left + bgShadowMargin.left;
            this.headerTF.x = _loc4_;
            this.headerTF.y = topPosition;
            topPosition = topPosition + (this.headerTF.textHeight + Utils.instance.MARGIN_AFTER_BLOCK ^ 0);
            this.descriptionTF.x = _loc4_;
            this.descriptionTF.y = topPosition;
            topPosition = topPosition + (this.descriptionTF.textHeight + Utils.instance.MARGIN_AFTER_BLOCK ^ 0);
            _loc1_ = Utils.instance.createSeparate(content);
            _loc1_.y = topPosition;
            separators.push(_loc1_);
            this.whiteBg.y = topPosition;
            topPosition = topPosition + Utils.instance.MARGIN_AFTER_SEPARATE;
            this.serverNameHeader.x = _loc4_;
            this.serverNameHeader.y = topPosition;
            topPosition = topPosition + (this.serverNameHeader.textHeight + MARGIN_AFTER_SUBHEADER ^ 0);
            this.serverName.x = _loc4_;
            this.serverName.y = topPosition;
            topPosition = topPosition + (this.serverNameHeader.textHeight + Utils.instance.MARGIN_AFTER_BLOCK ^ 0);
            if(!App.globalVarsMgr.isShowServerStatsS())
            {
                this.serverStatsHeader.x = 0;
                this.serverStatsHeader.y = 0;
                this.serverStatsHeader.visible = false;
                this.serverInfo.x = 0;
                this.serverInfo.y = 0;
                this.serverInfo.visible = false;
            }
            else
            {
                this.serverStatsHeader.x = _loc4_;
                this.serverStatsHeader.y = topPosition;
                topPosition = topPosition + (this.serverStatsHeader.textHeight + MARGIN_AFTER_SUBHEADER ^ 0);
                this.serverInfo.x = _loc4_;
                this.serverInfo.y = topPosition;
                topPosition = topPosition + (this.serverInfo.height + Utils.instance.MARGIN_AFTER_BLOCK ^ 0);
            }
            this.whiteBg.height = topPosition - this.whiteBg.y;
            contentMargin.bottom = 0;
            _loc3_.dispose();
            _loc3_ = null;
            updatePositions();
            super.redraw();
        }
        
        override protected function updateSize() : void
        {
            var _loc1_:* = NaN;
            super.updateSize();
            if(this.whiteBg.visible)
            {
                _loc1_ = content.width + contentMargin.right - bgShadowMargin.left;
                this.whiteBg.x = bgShadowMargin.left;
                this.whiteBg.width = _loc1_;
            }
        }
        
        override protected function onDispose() : void
        {
            this.serverInfo.dispose();
            this.serverInfo = null;
            super.onDispose();
        }
        
        override public function toString() : String
        {
            return "[WG ToolTipSettingsButton " + name + "]";
        }
    }
}
