package net.wg.gui.lobby.header.headerButtonBar
{
    import flash.display.Sprite;
    
    public class HBC_Settings extends HeaderButtonContentItem
    {
        
        public function HBC_Settings()
        {
            super();
            _minScreenPadding.left = 1;
            _minScreenPadding.right = 1;
            _additionalScreenPadding.left = 14;
            _additionalScreenPadding.right = 14;
        }
        
        public var icon:Sprite;
        
        override protected function updateSize() : void
        {
            bounds.width = this.icon.width;
            super.updateSize();
        }
        
        override protected function updateData() : void
        {
            readyToShow = true;
        }
    }
}
