package net.wg.infrastructure.base.meta.impl
{
    import net.wg.infrastructure.base.AbstractView;
    import net.wg.data.constants.Errors;

    public class BCOverlayFinalWindowMeta extends AbstractView
    {

        public var animFinish:Function;

        public function BCOverlayFinalWindowMeta()
        {
            super();
        }

        public function animFinishS() : void
        {
            App.utils.asserter.assertNotNull(this.animFinish,"animFinish" + Errors.CANT_NULL);
            this.animFinish();
        }
    }
}
