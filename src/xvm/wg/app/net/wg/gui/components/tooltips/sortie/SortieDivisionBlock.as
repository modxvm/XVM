package net.wg.gui.components.tooltips.sortie
{
    import scaleform.clik.core.UIComponent;
    import flash.text.TextField;
    import scaleform.clik.constants.InvalidationType;
    
    public class SortieDivisionBlock extends UIComponent
    {
        
        public function SortieDivisionBlock()
        {
            super();
        }
        
        public var divisionHeaderTF:TextField;
        
        public var levelsTF:TextField;
        
        public var bonusTF:TextField;
        
        public var playersTF:TextField;
        
        public var levelsIT:TextField;
        
        public var bonusIT:TextField;
        
        public var playersIT:TextField;
        
        private var _division:String = "";
        
        private var _divisionLvls:String = "";
        
        private var _playersLimit:String = "";
        
        private var _divisionBonus:String = "";
        
        override protected function configUI() : void
        {
            super.configUI();
            this.levelsTF.text = TOOLTIPS.FORTIFICATION_SORTIEDIVISIONTOOLTIP_VEHLEVEL;
            this.bonusTF.text = TOOLTIPS.FORTIFICATION_SORTIEDIVISIONTOOLTIP_BONUS;
            this.playersTF.text = TOOLTIPS.FORTIFICATION_SORTIEDIVISIONTOOLTIP_PLAYERSLIMIT;
        }
        
        override protected function draw() : void
        {
            super.draw();
            if(isInvalid(InvalidationType.DATA))
            {
                this.divisionHeaderTF.text = this._division;
                this.levelsIT.htmlText = this._divisionLvls;
                this.bonusIT.htmlText = this._divisionBonus;
                this.playersIT.htmlText = this._playersLimit;
            }
        }
        
        override protected function onDispose() : void
        {
            this.playersIT = null;
            this.levelsIT = null;
            this.bonusIT = null;
            this.divisionHeaderTF = null;
            this.levelsIT = null;
            this.bonusIT = null;
        }
        
        public function get division() : String
        {
            return this._division;
        }
        
        public function set division(param1:String) : void
        {
            this._division = param1;
            invalidateData();
        }
        
        public function get divisionLvls() : String
        {
            return this._divisionLvls;
        }
        
        public function set divisionLvls(param1:String) : void
        {
            this._divisionLvls = param1;
            invalidateData();
        }
        
        public function get divisionBonus() : String
        {
            return this._divisionBonus;
        }
        
        public function set divisionBonus(param1:String) : void
        {
            this._divisionBonus = param1;
            invalidateData();
        }
        
        public function get playersLimit() : String
        {
            return this._playersLimit;
        }
        
        public function set playersLimit(param1:String) : void
        {
            this._playersLimit = param1;
            invalidateData();
        }
    }
}
