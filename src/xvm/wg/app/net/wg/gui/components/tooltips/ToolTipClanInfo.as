package net.wg.gui.components.tooltips
{
    import flash.text.TextField;
    import net.wg.gui.components.controls.UILoaderAlt;
    import net.wg.gui.components.tooltips.helpers.Utils;
    import flash.text.TextFieldAutoSize;
    import scaleform.gfx.TextFieldEx;
    import net.wg.gui.components.tooltips.VO.ClanInfoVO;
    
    public class ToolTipClanInfo extends ToolTipSpecial
    {
        
        public function ToolTipClanInfo() {
            super();
            this.headerTF = content.headerTF;
            this.infoTF = content.infoTF;
            this.icon = content.icon;
            this.fortCreationDateFT = content.fortCreationDateFT;
            this.fullClanNameTF = content.fullClanNameTF;
            this.texts = Vector.<TextField>([this.headerTF,this.fullClanNameTF,this.infoTF,this.fortCreationDateFT]);
        }
        
        private static var SEPARATOR_PADDING:int = 13;
        
        private static var ADDITIONAL_PADDING:int = 3;
        
        public var headerTF:TextField;
        
        public var infoTF:TextField;
        
        public var fortCreationDateFT:TextField;
        
        public var fullClanNameTF:TextField;
        
        public var icon:UILoaderAlt;
        
        private var texts:Vector.<TextField>;
        
        override protected function redraw() : void {
            separators = new Vector.<Separator>();
            this.setData();
            this.updatePositions();
            super.redraw();
        }
        
        override protected function updatePositions() : void {
            var _loc5_:TextField = null;
            var _loc1_:int = this.texts.length;
            var _loc2_:Separator = null;
            var _loc3_:int = contentMargin.top + bgShadowMargin.top + ADDITIONAL_PADDING;
            var _loc4_:* = 0;
            while(_loc4_ < _loc1_)
            {
                _loc5_ = this.texts[_loc4_];
                _loc5_.autoSize = TextFieldAutoSize.LEFT;
                TextFieldEx.setVerticalAlign(_loc5_,TextFieldEx.VALIGN_TOP);
                _loc5_.x = contentMargin.left + bgShadowMargin.left + 1;
                _loc5_.y = _loc3_;
                _loc3_ = _loc3_ + (_loc5_.height + this.calculatePaddings(_loc4_));
                _loc4_++;
            }
            super.updatePositions();
        }
        
        override protected function updateSize() : void {
            super.updateSize();
            background.height = background.height + 3;
        }
        
        private function calculatePaddings(param1:int) : int {
            var _loc2_:* = 0;
            switch(param1)
            {
                case 0:
                    _loc2_ = -2;
                    break;
                case 1:
                    _loc2_ = 7;
                    break;
                case 2:
                    _loc2_ = 15;
                    break;
                case 3:
                    _loc2_ = 12;
                    break;
                default:
                    _loc2_ = 14;
            }
            return _loc2_;
        }
        
        private function setData() : void {
            var _loc1_:ClanInfoVO = new ClanInfoVO(_data);
            this.headerTF.htmlText = _loc1_.headerText;
            this.fullClanNameTF.htmlText = _loc1_.fullClanName;
            this.fortCreationDateFT.htmlText = _loc1_.fortCreationDate;
            this.infoTF.htmlText = _loc1_.infoText;
        }
    }
}
