package net.wg.gui.lobby.header
{
    import net.wg.gui.components.controls.FightListItemRenderer;
    import flash.display.MovieClip;
    import flash.text.TextField;
    import scaleform.clik.utils.Constraints;
    
    public class FightButtonFancyRenderer extends FightListItemRenderer
    {
        
        public function FightButtonFancyRenderer()
        {
            super();
            scaleX = scaleY = 1;
            this.newIndicator.visible = false;
            this.newIndicator.mouseChildren = false;
            this.hitArea = this.hitAreaA;
            this._originalTitleY = Math.floor(textField.y);
            this._originalDescrY = Math.floor(this.descr.y);
            this.descr.visible = false;
        }
        
        private static var DESCR_TEXT_COLOR:uint = 8092009;
        
        private static var DESCR_ACTIVE_TEXT_COLOR:uint = 16748339;
        
        private static var TITLE_VERTICAL_PADDING:int = 8;
        
        private static var INCREASE_TEXT_HEIGHT:int = 3;
        
        public var newIndicator:MovieClip;
        
        public var hitAreaA:MovieClip;
        
        public var icon:MovieClip;
        
        public var descr:TextField;
        
        private var _originalTitleY:int;
        
        private var _originalDescrY:int;
        
        override protected function configUI() : void
        {
            super.configUI();
            if(!constraintsDisabled)
            {
                constraints.addElement(this.icon.name,this.icon,Constraints.LEFT | Constraints.TOP);
            }
        }
        
        override protected function applyData(param1:BattleSelectDropDownVO) : void
        {
            var _loc2_:BattleSelectDropDownVO = null;
            super.applyData(param1);
            if(this.newIndicator)
            {
                if(this.newIndicator.visible != param1.isNew)
                {
                    this.newIndicator.visible = param1.isNew;
                    this.updateNewAnimation(param1.isNew);
                }
            }
            this.icon.gotoAndStop(param1.icon);
            if(param1.active)
            {
                this.descr.text = param1.description;
                if(this.descr.numLines == 1)
                {
                    textField.y = this._originalTitleY - TITLE_VERTICAL_PADDING;
                }
                else
                {
                    textField.y = this._originalTitleY - TITLE_VERTICAL_PADDING * 2;
                    this.descr.y = this._originalDescrY - TITLE_VERTICAL_PADDING;
                    this.descr.height = this.descr.height + INCREASE_TEXT_HEIGHT;
                }
                if(enabled)
                {
                    _loc2_ = BattleSelectDropDownVO(data);
                    this.descr.textColor = _loc2_.active?DESCR_ACTIVE_TEXT_COLOR:DESCR_TEXT_COLOR;
                }
            }
            this.descr.visible = param1.active;
        }
        
        override public function set enabled(param1:Boolean) : void
        {
            super.enabled = param1;
            this.icon.alpha = param1?1:0.5;
        }
        
        override protected function updateAfterStateChange() : void
        {
            super.updateAfterStateChange();
            if(!constraintsDisabled && (this.icon))
            {
                constraints.updateElement(this.icon.name,this.icon);
            }
        }
        
        private function updateNewAnimation(param1:Boolean) : void
        {
            preventAutosizing = true;
            if(param1)
            {
                this.newIndicator.gotoAndPlay("shine");
            }
            else
            {
                this.newIndicator.gotoAndStop(1);
            }
        }
    }
}
