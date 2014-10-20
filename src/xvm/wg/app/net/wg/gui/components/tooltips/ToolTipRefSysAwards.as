package net.wg.gui.components.tooltips
{
    import net.wg.gui.components.controls.UILoaderAlt;
    import flash.text.TextField;
    import flash.display.Sprite;
    import net.wg.gui.events.UILoaderEvent;
    import net.wg.gui.components.tooltips.helpers.Utils;
    import net.wg.gui.components.tooltips.VO.ToolTipRefSysAwardsVO;
    
    public class ToolTipRefSysAwards extends ToolTipSpecial
    {
        
        public function ToolTipRefSysAwards()
        {
            super();
            this.awardsType = content.awardsType;
            this.awardsType.autoSize = false;
            this.awardsType.addEventListener(UILoaderEvent.COMPLETE,this.onCompleteHandler);
            this.whiteBg = content.whiteBg;
            this.infoTitle = content.infoTitle;
            this.infoBody = content.infoBody;
            this.conditions = content.conditions;
            this.awardStatus = content.awardStatus;
        }
        
        private static var PADDING_TOP:uint = 240;
        
        private static var PADDING_LEFT:int = 24;
        
        private static var BG_WIDTH:int = 352;
        
        private static var BG_HEIGHT:int = 428;
        
        private static var WHITE_BG_HEIGHT:int = 38;
        
        private static var ICON_TOP:int = 79;
        
        public var awardsType:UILoaderAlt = null;
        
        public var infoTitle:TextField = null;
        
        public var infoBody:TextField = null;
        
        public var conditions:TextField = null;
        
        public var awardStatus:TextField = null;
        
        public var whiteBg:Sprite = null;
        
        override protected function onDispose() : void
        {
            var _loc1_:Sprite = null;
            this.awardsType.removeEventListener(UILoaderEvent.COMPLETE,this.onCompleteHandler);
            this.awardsType.dispose();
            this.awardsType = null;
            for each(_loc1_ in separators)
            {
                content.removeChild(_loc1_);
            }
            separators.splice(0,separators.length);
            separators = null;
            super.onDispose();
        }
        
        override protected function redraw() : void
        {
            separators = new Vector.<Separator>();
            this.setData();
            this.updatePositions();
            super.redraw();
        }
        
        override protected function updateSize() : void
        {
            background.width = BG_WIDTH;
            background.height = BG_HEIGHT;
        }
        
        override protected function updatePositions() : void
        {
            var _loc1_:Separator = null;
            _loc1_ = null;
            this.awardsType.x = PADDING_LEFT + 1;
            this.awardsType.y = 40;
            this.infoTitle.x = PADDING_LEFT;
            this.infoTitle.y = 19;
            _loc1_ = Utils.instance.createSeparate(content);
            _loc1_.y = PADDING_TOP;
            separators.push(_loc1_);
            this.infoBody.x = PADDING_LEFT;
            this.infoBody.y = _loc1_.y + _loc1_.height + 17 ^ 0;
            this.conditions.x = PADDING_LEFT;
            this.conditions.y = this.infoBody.y + this.infoBody.height + 7 ^ 0;
            _loc1_ = Utils.instance.createSeparate(content);
            _loc1_.y = this.conditions.y + this.conditions.height + 7 ^ 0;
            separators.push(_loc1_);
            this.whiteBg.x = 0;
            this.whiteBg.y = _loc1_.y + _loc1_.height ^ 0;
            this.whiteBg.width = background.width;
            this.whiteBg.height = WHITE_BG_HEIGHT;
            this.awardStatus.x = PADDING_LEFT;
            this.awardStatus.y = _loc1_.y + _loc1_.height + 9 ^ 0;
            super.updatePositions();
        }
        
        private function setData() : void
        {
            var _loc1_:ToolTipRefSysAwardsVO = new ToolTipRefSysAwardsVO(_data);
            this.awardsType.source = _loc1_.iconSource;
            this.infoTitle.htmlText = _loc1_.infoTitle;
            this.infoBody.htmlText = _loc1_.infoBody;
            this.conditions.htmlText = _loc1_.conditions;
            this.awardStatus.htmlText = _loc1_.awardStatus;
        }
        
        private function onCompleteHandler(param1:UILoaderEvent) : void
        {
            this.awardsType.x = background.width - this.awardsType.width >> 1;
            this.awardsType.y = ICON_TOP;
        }
    }
}
