package net.wg.gui.lobby.messengerBar.carousel
{
    import net.wg.gui.components.controls.ScrollBar;
    
    public class ChannelCarouselScrollBar extends ScrollBar
    {
        
        public function ChannelCarouselScrollBar()
        {
            super();
        }
        
        override protected function configUI() : void
        {
            super.configUI();
        }
        
        override protected function drawLayout() : void
        {
            constraints.update(_height,_width);
            downArrow.y = _width;
        }
    }
}
