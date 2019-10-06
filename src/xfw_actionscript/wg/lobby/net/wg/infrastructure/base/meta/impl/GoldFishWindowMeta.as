package net.wg.infrastructure.base.meta.impl
{
    import net.wg.gui.components.windows.SimpleWindow;
    import net.wg.data.constants.Errors;

    public class GoldFishWindowMeta extends SimpleWindow
    {

        public var eventHyperLinkClicked:Function;

        public function GoldFishWindowMeta()
        {
            super();
        }

        public function eventHyperLinkClickedS() : void
        {
            App.utils.asserter.assertNotNull(this.eventHyperLinkClicked,"eventHyperLinkClicked" + Errors.CANT_NULL);
            this.eventHyperLinkClicked();
        }
    }
}
