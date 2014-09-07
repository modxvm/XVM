package net.wg.gui.components.tooltips
{
    import flash.display.MovieClip;
    import net.wg.gui.lobby.fortifications.cmp.build.impl.BuildingIndicatorsCmp;
    import flash.text.TextField;
    import flash.display.Sprite;
    import net.wg.gui.components.tooltips.VO.ToolTipFortBuildingInfoVO;
    import net.wg.gui.components.tooltips.VO.ToolTipStatusColorsVO;
    import net.wg.gui.components.tooltips.helpers.Utils;
    import scaleform.clik.utils.Padding;
    
    public class ToolTipFortBuildingInfo extends ToolTipSpecial
    {
        
        public function ToolTipFortBuildingInfo()
        {
            super();
            contentMargin = new Padding(0,6,21,4);
            background.x = -6;
            background.y = -4;
            this.buildingIcon = content.buildingIcon;
            this.buildingName = content.buildingName;
            this.currentMap = content.currentMap;
            this.buildingLevel = content.buildingLevel;
            this.infoTF = content.infoTF;
            this.extraInfo = content.extraInfo;
            this.separator = this.extraInfo.separator;
            this.buildingIndicators = this.extraInfo.buildingIndicators;
            this.descrAction = this.extraInfo.descrAction;
            this.status = this.extraInfo.status;
        }
        
        private static var INFO_MSG_BOTTOM_PADDING_BIG:int = 25;
        
        private static var INFO_MSG_BOTTOM_PADDING_SMALL:int = 5;
        
        public var buildingIcon:MovieClip;
        
        public var buildingIndicators:BuildingIndicatorsCmp;
        
        public var buildingName:TextField;
        
        public var currentMap:TextField;
        
        public var buildingLevel:TextField;
        
        public var descrAction:TextField;
        
        public var status:Status = null;
        
        public var infoTF:TextField;
        
        public var extraInfo:MovieClip;
        
        public var separator:Sprite;
        
        private var model:ToolTipFortBuildingInfoVO;
        
        override protected function redraw() : void
        {
            separators = new Vector.<Separator>();
            this.setData();
            updatePositions();
            super.redraw();
        }
        
        override protected function onDispose() : void
        {
            this.buildingIndicators.dispose();
            this.buildingIndicators = null;
            if(this.model)
            {
                this.model.dispose();
                this.model = null;
            }
            this.status.dispose();
            this.status = null;
            this.buildingIcon = null;
            this.extraInfo = null;
            super.onDispose();
        }
        
        private function setData() : void
        {
            var _loc1_:ToolTipStatusColorsVO = null;
            var _loc2_:* = 0;
            this.model = new ToolTipFortBuildingInfoVO(_data);
            this.buildingIcon.gotoAndStop(this.model.buildingUID);
            this.buildingName.htmlText = this.model.buildingName;
            this.buildingLevel.htmlText = this.model.buildingLevel;
            if(!this.model.isAvailable)
            {
                this.infoTF.htmlText = this.model.infoMessage;
                this.infoTF.height = this.infoTF.textHeight + INFO_MSG_BOTTOM_PADDING_SMALL;
            }
            if(this.model.indicatorModel)
            {
                this.currentMap.htmlText = this.model.currentMap;
                this.descrAction.htmlText = this.model.descrAction;
                this.buildingIndicators.setData(this.model.indicatorModel);
                _loc1_ = Utils.instance.getStatusColor(this.model.statusLevel);
                this.status.setData(this.model.statusMsg,"",_loc1_);
                if(!this.model.isAvailable)
                {
                    this.extraInfo.removeChild(this.separator);
                    this.extraInfo.removeChild(this.status);
                    this.extraInfo.removeChild(this.descrAction);
                    _loc2_ = Math.floor(this.extraInfo.y + this.buildingIndicators.y + this.buildingIndicators.height + INFO_MSG_BOTTOM_PADDING_BIG);
                    this.infoTF.y = _loc2_;
                }
            }
            else
            {
                this.infoTF.htmlText = this.model.infoMessage;
                this.infoTF.height = this.infoTF.textHeight + INFO_MSG_BOTTOM_PADDING_SMALL;
                content.removeChild(this.extraInfo);
            }
        }
    }
}
