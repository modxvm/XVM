package net.wg.gui.lobby.messengerBar.carousel 
{
    import net.wg.gui.components.controls.*;
    
    public class ChannelCarouselScrollBar extends net.wg.gui.components.controls.ScrollBar
    {
        public function ChannelCarouselScrollBar()
        {
            super();
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            return;
        }

        protected override function drawLayout():void
        {
            constraints.update(_height, _width);
            downArrow.y = _width;
            return;
        }
    }
}
