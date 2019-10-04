package net.wg.infrastructure.base.meta.impl
{
    import net.wg.infrastructure.base.BaseDAAPIComponent;
    import net.wg.data.constants.Errors;

    public class MiniClientComponentMeta extends BaseDAAPIComponent
    {

        public var onHyperlinkClick:Function;

        public function MiniClientComponentMeta()
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
