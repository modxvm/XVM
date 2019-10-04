package net.wg.gui.lobby.profile.pages.statistics.header
{
    import net.wg.infrastructure.base.UIComponentEx;
    import flash.display.MovieClip;

    public class HeaderBGImage extends UIComponentEx
    {

        public var separator:MovieClip;

        public function HeaderBGImage()
        {
            super();
        }

        override protected function onDispose() : void
        {
            this.separator = null;
            super.onDispose();
        }
    }
}
