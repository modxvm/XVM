package net.wg.gui.components.tooltips
{
    import flash.text.TextField;
    import net.wg.gui.components.controls.UILoaderAlt;
    import flash.display.Sprite;
    import net.wg.gui.components.tooltips.VO.FortClanInfoVO;
    import net.wg.gui.components.tooltips.helpers.Utils;
    import flash.text.TextFieldAutoSize;
    import net.wg.data.constants.Values;
    
    public class ToolTipClanInfo extends ToolTipSpecial
    {
        
        public function ToolTipClanInfo()
        {
            super();
            separators = new Vector.<Separator>();
            this._headerTF = content.headerTF;
            this._infoTF = content.infoTF;
            this._icon = content.icon;
            this._fortCreationDateFT = content.fortCreationDateFT;
            this._fullClanNameTF = content.fullClanNameTF;
            this._whiteBg = content.whiteBg;
            this.initTextFields();
        }
        
        private static var MARGIN_BETWEEN_INFO_AND_DESCRIPTION:int = 12;
        
        private static var SEPARATOR_PADDING:int = 20;
        
        private static var SEPARATORS_COUNT:int = 3;
        
        private static var TEXT_SIZE_CORRECTION:int = 3;
        
        private static var STATS_BLOCK_PADDING:int = 20;
        
        private static var FORT_CREATION_DATE_PADDING:int = 35;
        
        private static var PROTECTION_BLOCK_PADDING:int = 24;
        
        private static var INFO_BLOCK_TOP_SEPARATOR:int = 0;
        
        private static var INFO_BLOCK_BOTTOM_SEPARATOR:int = 1;
        
        private static var DEFENSE_INFO_SEPARATOR:int = 2;
        
        private var _headerTF:TextField;
        
        private var _infoTF:TextField;
        
        private var _fortCreationDateFT:TextField;
        
        private var _fullClanNameTF:TextField;
        
        private var _icon:UILoaderAlt;
        
        private var _sloganTF:TextField;
        
        private var _infoDescriptionBottomTF:TextField;
        
        private var _infoDescriptionTopTF:TextField;
        
        private var _infoBottomTF:TextField;
        
        private var _infoTopTF:TextField;
        
        private var _protectionHeaderTF:TextField;
        
        private var _whiteBg:Sprite;
        
        private function initTextFields() : void
        {
            this._sloganTF = content.sloganTF;
            this._infoDescriptionBottomTF = content.infoDescriptionBottomTF;
            this._infoDescriptionTopTF = content.infoDescriptionTopTF;
            this._infoTopTF = content.infoTopTF;
            this._infoBottomTF = content.infoBottomTF;
            this._protectionHeaderTF = content.protectionHeaderTF;
        }
        
        override protected function redraw() : void
        {
            this.applyData();
            this.updatePositions();
            super.redraw();
        }
        
        protected function applyData() : void
        {
            var _loc1_:FortClanInfoVO = FortClanInfoVO(this.dataVO);
            this._headerTF.htmlText = this.dataVO.headerText;
            this._fullClanNameTF.htmlText = this.dataVO.fullClanName;
            this._fortCreationDateFT.htmlText = this.dataVO.fortCreationDate;
            this._infoTF.htmlText = this.dataVO.infoText;
            this._sloganTF.htmlText = _loc1_.sloganText;
            this._infoDescriptionTopTF.htmlText = _loc1_.infoDescriptionTopText;
            this._infoTopTF.htmlText = _loc1_.infoTopText;
            this._protectionHeaderTF.htmlText = _loc1_.protectionHeaderText;
        }
        
        override protected function configUI() : void
        {
            this.configTextFields();
            this.createSeparators();
            super.configUI();
        }
        
        private function updateWhiteBg() : void
        {
            this._whiteBg.width = background.width;
            this._whiteBg.y = this._infoTopTF.y - Utils.instance.MARGIN_AFTER_SEPARATE;
            this._whiteBg.height = separators[INFO_BLOCK_BOTTOM_SEPARATOR].y - this._whiteBg.y;
        }
        
        private function createSeparators() : void
        {
            var _loc1_:* = 0;
            while(_loc1_ < SEPARATORS_COUNT)
            {
                separators.push(Utils.instance.createSeparate(content));
                _loc1_++;
            }
            this.hideSeparators();
        }
        
        private function configTextFields() : void
        {
            this._headerTF.autoSize = TextFieldAutoSize.LEFT;
            this._fullClanNameTF.autoSize = TextFieldAutoSize.LEFT;
            this._sloganTF.autoSize = TextFieldAutoSize.LEFT;
            this._fortCreationDateFT.autoSize = TextFieldAutoSize.LEFT;
            this._infoDescriptionBottomTF.autoSize = TextFieldAutoSize.LEFT;
            this._infoDescriptionBottomTF.visible = this._infoBottomTF.visible = false;
            this._infoDescriptionBottomTF.y = this._infoBottomTF.y = 0;
            this._infoDescriptionTopTF.autoSize = TextFieldAutoSize.LEFT;
            this._infoTF.autoSize = TextFieldAutoSize.LEFT;
            this._infoBottomTF.autoSize = TextFieldAutoSize.RIGHT;
            this._infoTopTF.autoSize = TextFieldAutoSize.RIGHT;
        }
        
        override protected function updatePositions() : void
        {
            this.alignInfoBlock();
            this.updateSeparators();
            this.updateWhiteBg();
            super.updatePositions();
        }
        
        private function updateSeparators() : void
        {
            var _loc2_:Separator = null;
            var _loc1_:* = 0;
            while(_loc1_ < separators.length)
            {
                _loc2_ = separators[_loc1_];
                if(_loc2_.alpha != 0)
                {
                    switch(_loc1_)
                    {
                        case INFO_BLOCK_TOP_SEPARATOR:
                            _loc2_.y = this._infoTopTF.y - Utils.instance.MARGIN_AFTER_SEPARATE;
                            break;
                        case INFO_BLOCK_BOTTOM_SEPARATOR:
                            _loc2_.y = this._infoTopTF.y + this._infoTopTF.height + Utils.instance.MARGIN_AFTER_SEPARATE;
                            break;
                        case DEFENSE_INFO_SEPARATOR:
                            _loc2_.y = this._infoTF.y + this._infoTF.height + SEPARATOR_PADDING;
                            break;
                    }
                }
                else
                {
                    _loc2_.y = 0;
                }
                _loc1_++;
            }
            this.showSeparators();
        }
        
        private function hideSeparators() : void
        {
            var _loc1_:Separator = null;
            for each(_loc1_ in separators)
            {
                _loc1_.visible = false;
            }
        }
        
        private function showSeparators() : void
        {
            var _loc1_:Separator = null;
            for each(_loc1_ in separators)
            {
                if(_loc1_.alpha != 0)
                {
                    _loc1_.visible = true;
                }
            }
        }
        
        private function alignInfoBlock() : void
        {
            var _loc1_:* = NaN;
            if(this._infoTopTF.x < this._headerTF.x)
            {
                _loc1_ = this._infoTopTF.width;
                this._infoTopTF.x = this._headerTF.x + _loc1_ - this._infoTopTF.width;
                this._infoDescriptionTopTF.x = this._infoTopTF.x + this._infoTopTF.width + MARGIN_BETWEEN_INFO_AND_DESCRIPTION;
            }
            if(this._sloganTF.htmlText == Values.EMPTY_STR)
            {
                this._infoTopTF.y = this._infoDescriptionTopTF.y = this._fullClanNameTF.y + this._fullClanNameTF.height + STATS_BLOCK_PADDING;
            }
            this._infoTopTF.height = this._infoDescriptionTopTF.height = this._infoDescriptionTopTF.textHeight + TEXT_SIZE_CORRECTION;
            this.defensePeriodBlockSwitch();
        }
        
        private function defensePeriodBlockSwitch() : void
        {
            if(this._infoTF.htmlText == Values.EMPTY_STR && this._protectionHeaderTF.htmlText == Values.EMPTY_STR)
            {
                this._infoTF.visible = false;
                this._protectionHeaderTF.visible = false;
                this._protectionHeaderTF.y = this._protectionHeaderTF.height = 0;
                this._infoTF.y = this._infoTF.height = 0;
                if(this._fortCreationDateFT.htmlText != Values.EMPTY_STR)
                {
                    this._fortCreationDateFT.y = this._infoDescriptionTopTF.y + this._infoDescriptionTopTF.height + FORT_CREATION_DATE_PADDING;
                }
                else
                {
                    this._fortCreationDateFT.y = this._fortCreationDateFT.height = 0;
                }
                separators[DEFENSE_INFO_SEPARATOR].alpha = 0;
            }
            else
            {
                this._infoTF.height = this._infoTF.textHeight + TEXT_SIZE_CORRECTION;
                this._protectionHeaderTF.y = this._infoDescriptionTopTF.y + this._infoDescriptionTopTF.height + PROTECTION_BLOCK_PADDING;
                this._infoTF.y = this._protectionHeaderTF.y + this._protectionHeaderTF.height;
                if(this._fortCreationDateFT.htmlText != Values.EMPTY_STR)
                {
                    this._fortCreationDateFT.y = this._infoTF.y + this._infoTF.height + FORT_CREATION_DATE_PADDING;
                }
                else
                {
                    separators[DEFENSE_INFO_SEPARATOR].alpha = 0;
                    this._fortCreationDateFT.y = this._fortCreationDateFT.height = 0;
                }
                this._infoTF.visible = true;
                this._protectionHeaderTF.visible = true;
            }
        }
        
        override protected function onDispose() : void
        {
            this._headerTF = null;
            this._infoTF = null;
            this._fortCreationDateFT = null;
            this._fullClanNameTF = null;
            this._icon.dispose();
            this._icon = null;
            this._sloganTF = null;
            this._infoDescriptionBottomTF = null;
            this._infoDescriptionTopTF = null;
            this._infoTopTF = null;
            this._infoBottomTF = null;
            this._protectionHeaderTF = null;
            this._whiteBg = null;
            super.onDispose();
        }
        
        public function get dataVO() : FortClanInfoVO
        {
            return new FortClanInfoVO(_data);
        }
    }
}
