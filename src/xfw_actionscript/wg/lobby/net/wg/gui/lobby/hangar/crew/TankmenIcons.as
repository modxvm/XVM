package net.wg.gui.lobby.hangar.crew
{
    import net.wg.infrastructure.base.UIComponentEx;
    import net.wg.gui.components.controls.UILoaderAlt;

    public class TankmenIcons extends UIComponentEx
    {

        public var imageLoader:UILoaderAlt;

        public function TankmenIcons()
        {
            super();
        }

        override protected function onDispose() : void
        {
            this.imageLoader.dispose();
            this.imageLoader = null;
            super.onDispose();
        }
    }
}
