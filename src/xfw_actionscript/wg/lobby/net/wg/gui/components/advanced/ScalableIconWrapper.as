package net.wg.gui.components.advanced
{
    import scaleform.clik.core.UIComponent;
    import net.wg.gui.components.controls.UILoaderAlt;

    public class ScalableIconWrapper extends UIComponent
    {

        public var loader:UILoaderAlt;

        public function ScalableIconWrapper()
        {
            super();
        }

        override protected function onDispose() : void
        {
            this.loader.dispose();
            this.loader = null;
            super.onDispose();
        }
    }
}
