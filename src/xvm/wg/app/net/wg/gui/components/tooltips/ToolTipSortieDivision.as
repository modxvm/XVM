package net.wg.gui.components.tooltips
{
    import flash.text.TextField;
    import net.wg.gui.components.tooltips.sortie.SortieDivisionBlock;
    import net.wg.gui.components.tooltips.helpers.Utils;
    import net.wg.gui.components.tooltips.VO.SortieDivisionVO;
    import net.wg.utils.ILocale;
    import scaleform.clik.utils.Padding;
    
    public class ToolTipSortieDivision extends ToolTipBase
    {
        
        public function ToolTipSortieDivision()
        {
            super();
            this.headerTF = content.headerTF;
            this.descrTF = content.descrTF;
            this.infoTF = content.infoTF;
            this.middleDiv = content.middleDiv;
            this.championDiv = content.championDiv;
            this.absoluteDiv = content.absoluteDiv;
            this._divisions = Vector.<SortieDivisionBlock>([this.middleDiv,this.championDiv,this.absoluteDiv]);
            contentMargin = new Padding(9,13,1,13);
        }
        
        private static var TEXT_PADDING:int = 5;
        
        private static var LEFT_SEP_PADDING:int = 14;
        
        private static var INFO_PADDING:int = 3;
        
        public var headerTF:TextField = null;
        
        public var descrTF:TextField = null;
        
        public var infoTF:TextField = null;
        
        public var middleDiv:SortieDivisionBlock = null;
        
        public var championDiv:SortieDivisionBlock = null;
        
        public var absoluteDiv:SortieDivisionBlock = null;
        
        private var _divisions:Vector.<SortieDivisionBlock> = null;
        
        private function addSeparatorWithMargin() : Separator
        {
            var _loc1_:Separator = Utils.instance.createSeparate(content);
            _loc1_.y = topPosition ^ 0;
            _loc1_.x = LEFT_SEP_PADDING;
            separators.push(_loc1_);
            topPosition = topPosition + Utils.instance.MARGIN_AFTER_SEPARATE;
            return _loc1_;
        }
        
        override protected function redraw() : void
        {
            var _loc1_:SortieDivisionVO = null;
            var _loc2_:* = 0;
            var _loc3_:ILocale = null;
            var _loc6_:SortieDivisionBlock = null;
            _loc1_ = new SortieDivisionVO(_data);
            _loc2_ = bgShadowMargin.left + contentMargin.left;
            _loc3_ = App.utils.locale;
            separators = new Vector.<Separator>();
            this.headerTF.text = _loc3_.makeString(TOOLTIPS.FORTIFICATION_SORTIEDIVISIONTOOLTIP_TITLE);
            this.headerTF.width = this.headerTF.textWidth + TEXT_PADDING;
            this.headerTF.x = _loc2_;
            this.headerTF.y = topPosition ^ 0;
            topPosition = topPosition + (this.headerTF.textHeight + Utils.instance.MARGIN_AFTER_BLOCK);
            this.descrTF.y = topPosition;
            this.descrTF.x = _loc2_;
            this.descrTF.text = _loc3_.makeString(TOOLTIPS.FORTIFICATION_SORTIEDIVISIONTOOLTIP_DESCRIPTION);
            this.descrTF.height = this.descrTF.textHeight + TEXT_PADDING;
            topPosition = this.descrTF.y + this.descrTF.height + Utils.instance.MARGIN_AFTER_BLOCK;
            var _loc4_:* = 0;
            while(_loc4_ < this._divisions.length)
            {
                _loc6_ = this._divisions[_loc4_];
                _loc6_.y = topPosition;
                _loc6_.x = _loc2_;
                _loc6_.division = _loc3_.makeString(_loc1_.divisions[_loc4_].divisName);
                _loc6_.divisionLvls = _loc1_.divisions[_loc4_].divisLevels;
                _loc6_.divisionBonus = _loc1_.divisions[_loc4_].divisBonus;
                _loc6_.playersLimit = _loc1_.divisions[_loc4_].divisPlayers;
                topPosition = topPosition + _loc6_.height;
                _loc4_++;
            }
            var _loc5_:Separator = this.addSeparatorWithMargin();
            this.infoTF.x = _loc2_;
            this.infoTF.y = topPosition - INFO_PADDING;
            this.infoTF.text = _loc3_.makeString(TOOLTIPS.FORTIFICATION_SORTIEDIVISIONTOOLTIP_INFO);
            this.infoTF.height = this.infoTF.textHeight + TEXT_PADDING;
            super.redraw();
        }
        
        override protected function onDispose() : void
        {
            this.headerTF = null;
            this.descrTF = null;
            this.infoTF = null;
            if(this._divisions)
            {
                this._divisions.splice(0,this._divisions.length);
                this._divisions = null;
            }
            if(this.middleDiv)
            {
                this.middleDiv.dispose();
                this.middleDiv = null;
            }
            if(this.championDiv)
            {
                this.championDiv.dispose();
                this.championDiv = null;
            }
            if(this.absoluteDiv)
            {
                this.absoluteDiv.dispose();
                this.absoluteDiv = null;
            }
            super.onDispose();
        }
    }
}
