package net.wg.infrastructure.base.meta.impl
{
    import net.wg.gui.components.windows.SimpleWindow;
    import net.wg.data.constants.Errors;

    public class SquadPromoWindowMeta extends SimpleWindow
    {

        public var onHyperlinkClick:Function;

        public function SquadPromoWindowMeta()
        {
            super();
        }

        public function onHyperlinkClickS() : void
        {
            App.utils.asserter.assertNotNull(this.onHyperlinkClick,"onHyperlinkClick" + Errors.CANT_NULL);
            this.onHyperlinkClick();
        }
    }
}
