package net.wg.gui.lobby.profile.headerBar
{
    import scaleform.clik.core.UIComponent;
    import flash.display.Sprite;
    import flash.display.MovieClip;
    import scaleform.clik.constants.InvalidationType;
    
    public class ProfileTabButtonBg extends UIComponent
    {
        
        public function ProfileTabButtonBg()
        {
            super();
            stop();
        }
        
        public var lastLine:Sprite;
        
        public var firstLine:Sprite;
        
        private var _selected:Boolean;
        
        private var lastLineItemVisible:Boolean;
        
        public var selectedBg:MovieClip;
        
        public var bg:MovieClip;
        
        override protected function draw() : void
        {
            super.draw();
            if(isInvalid(InvalidationType.SIZE))
            {
                this.selectedBg.width = _width;
                this.bg.width = _width;
                this.lastLine.x = _width - this.lastLine.width;
            }
            if(isInvalid(InvalidationType.DATA))
            {
                this.firstLine.visible = !this._selected;
                this.lastLine.visible = (this.lastLineItemVisible) && !this._selected;
                this.selectedBg.visible = this._selected;
            }
        }
        
        public function get selected() : Boolean
        {
            return this._selected;
        }
        
        public function set selected(param1:Boolean) : void
        {
            this._selected = param1;
            invalidateData();
        }
        
        public function showLastLineItem(param1:Boolean) : void
        {
            this.lastLineItemVisible = param1;
            invalidateData();
        }
    }
}
