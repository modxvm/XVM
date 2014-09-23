package net.wg.gui.components.tooltips
{
    import flash.text.TextField;
    import flash.display.Sprite;
    import net.wg.gui.components.controls.UnitCommanderStats;
    import flash.text.TextFieldAutoSize;
    import net.wg.gui.components.tooltips.helpers.Utils;
    import net.wg.utils.ILocale;
    import net.wg.gui.components.tooltips.VO.UnitCommandVO;
    import flash.display.MovieClip;
    import net.wg.gui.rally.vo.VehicleVO;
    import net.wg.infrastructure.interfaces.IImageUrlProperties;
    
    public class TooltipUnitCommand extends ToolTipSpecial
    {
        
        public function TooltipUnitCommand()
        {
            super();
            this.headerTF = content.headerTF;
            this.notEnoughTF = content.notEnoughTF;
            this.whiteBg = content.whiteBg;
            this.alertSuitable = content.alertSuitable;
            this.commanderStats = content.commanderStats;
            this.descriptionTF = content.descriptionTF;
            this.actionTF = content.actionTF;
        }
        
        public var headerTF:TextField = null;
        
        public var notEnoughTF:TextField = null;
        
        public var whiteBg:Sprite = null;
        
        public var alertSuitable:TextField = null;
        
        public var descriptionTF:TextField = null;
        
        public var actionTF:TextField = null;
        
        public var commanderStats:UnitCommanderStats = null;
        
        private var MARGIN_BEETWEEN_BLOCKS:Number = 3;
        
        private var MARGIN_AFTER_SUBHEADER:Number = 20;
        
        private var TANK_ICON:String = App.utils.getHtmlIconTextS(App.utils.getImageUrlProperties(RES_ICONS.MAPS_ICONS_LIBRARY_CYBERSPORT_TANKICON,29,12,0) as IImageUrlProperties);
        
        override public function toString() : String
        {
            return "[WG ToolTipUnitCommand " + name + "]";
        }
        
        private function setHeader(param1:String) : Number
        {
            this.headerTF.autoSize = TextFieldAutoSize.LEFT;
            this.headerTF.htmlText = Utils.instance.htmlWrapper(App.utils.locale.makeString(TOOLTIPS.CYBERSPORT_UNIT_COMMAND) + " " + param1,Utils.instance.COLOR_HEADER,18,"$TitleFont");
            this.headerTF.width = this.headerTF.textWidth + 5;
            this.headerTF.x = bgShadowMargin.left + contentMargin.left;
            this.headerTF.y = topPosition ^ 0;
            return this.headerTF.textHeight + Utils.instance.MARGIN_AFTER_BLOCK;
        }
        
        override protected function redraw() : void
        {
            var _loc1_:ILocale = null;
            var _loc2_:UnitCommandVO = null;
            _loc1_ = App.utils.locale;
            _loc2_ = new UnitCommandVO(_data);
            var _loc3_:Number = 300;
            separators = new Vector.<Separator>();
            topPosition = topPosition + this.setHeader(_loc2_.commanderName);
            this.addSeparatorWithMargin();
            this.commanderStats.y = topPosition ^ 0;
            this.commanderStats.x = bgShadowMargin.left;
            this.commanderStats.stats.text = _loc2_.commanderRating;
            topPosition = topPosition + (this.commanderStats.height + Utils.instance.MARGIN_AFTER_BLOCK);
            var _loc4_:Separator = this.addSeparatorWithMargin();
            if(_loc2_.unitComment)
            {
                this.whiteBg.y = _loc4_.y;
                this.whiteBg.visible = true;
                this.descriptionTF.y = topPosition ^ 0;
                this.descriptionTF.x = contentMargin.left + bgShadowMargin.left;
                this.descriptionTF.text = _loc2_.unitComment;
                this.descriptionTF.height = this.descriptionTF.textHeight + 10;
                topPosition = topPosition + (this.descriptionTF.textHeight + Utils.instance.MARGIN_AFTER_BLOCK);
                this.addSeparatorWithMargin();
            }
            this.whiteBg.height = topPosition - this.whiteBg.y - Utils.instance.MARGIN_AFTER_SEPARATE;
            if((_loc2_.conditions) && (_loc2_.vehiclesList) && _loc2_.vehiclesList.length > 0)
            {
                this.notEnoughTF.htmlText = Utils.instance.htmlWrapper(_loc1_.makeString(TOOLTIPS.SUITABLEVEHICLE_MATCHES),Utils.instance.COLOR_NORMAL,13,"$FieldFont") + " " + Utils.instance.htmlWrapper((_loc2_.vehiclesList.length + _loc2_.leftCount).toString(),Utils.instance.COLOR_NUMBER,13,"$TitleFont") + " " + this.TANK_ICON;
                this.notEnoughTF.height = this.notEnoughTF.textHeight + 5;
                this.notEnoughTF.y = topPosition ^ 0;
                this.notEnoughTF.x = bgShadowMargin.left + contentMargin.left;
                this.notEnoughTF.visible = true;
                topPosition = topPosition + (this.notEnoughTF.textHeight + Utils.instance.MARGIN_AFTER_BLOCK);
                this.addSeparatorWithMargin();
            }
            if(_loc2_.isPeripheryAnother)
            {
                this.alertSuitable.multiline = true;
                this.alertSuitable.wordWrap = true;
                this.alertSuitable.autoSize = TextFieldAutoSize.CENTER;
                this.alertSuitable.text = TOOLTIPS.CYBERSPORT_ALERT_ONANOTHERSERVER;
                this.alertSuitable.visible = true;
                this.alertSuitable.x = contentMargin.left + bgShadowMargin.left;
                this.alertSuitable.y = topPosition ^ 0;
                topPosition = topPosition + (this.alertSuitable.textHeight + Utils.instance.MARGIN_AFTER_BLOCK);
                this.addSeparatorWithMargin();
            }
            this.actionTF.y = topPosition ^ 0;
            this.actionTF.x = contentMargin.left + bgShadowMargin.left;
            this.actionTF.text = TOOLTIPS.CYBERSPORT_UNITCOMMAND_ACTION;
            _loc2_.dispose();
            _loc2_ = null;
            updatePositions();
            super.redraw();
        }
        
        private function addSeparatorWithMargin() : Separator
        {
            var _loc1_:Separator = null;
            _loc1_ = Utils.instance.createSeparate(content);
            _loc1_.y = topPosition ^ 0;
            separators.push(_loc1_);
            topPosition = topPosition + Utils.instance.MARGIN_AFTER_SEPARATE;
            return _loc1_;
        }
        
        private function addSuitableVehicleBlockItem(param1:MovieClip, param2:VehicleVO, param3:Number) : Number
        {
            var _loc4_:SuitableVehicleBlockItem = App.utils.classFactory.getComponent("SuitableVehicleBlockItemUI",SuitableVehicleBlockItem);
            _loc4_.setData(App.utils.nations.getNationIcon(param2.nationID),param2.level,param2.smallIconPath,"../maps/icons/filters/tanks/" + param2.type + ".png",param2.shortUserName);
            _loc4_.x = contentMargin.left + bgShadowMargin.left;
            _loc4_.y = param3 ^ 0;
            param1.addChild(_loc4_);
            var param3:Number = param3 + (_loc4_.height + this.MARGIN_BEETWEEN_BLOCKS);
            return param3;
        }
        
        override protected function updateSize() : void
        {
            super.updateSize();
            if(this.whiteBg.visible)
            {
                this.whiteBg.width = contentWidth + bgShadowMargin.horizontal;
            }
        }
    }
}
