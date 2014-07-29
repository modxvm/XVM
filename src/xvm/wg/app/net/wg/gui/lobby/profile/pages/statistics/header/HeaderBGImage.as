package net.wg.gui.lobby.profile.pages.statistics.header
{
    import scaleform.clik.core.UIComponent;
    import flash.display.MovieClip;
    
    public class HeaderBGImage extends UIComponent
    {
        
        public function HeaderBGImage()
        {
            super();
        }
        
        public var separator:MovieClip;
        
        override protected function onDispose() : void
        {
            this.separator = null;
            super.onDispose();
        }
    }
}
