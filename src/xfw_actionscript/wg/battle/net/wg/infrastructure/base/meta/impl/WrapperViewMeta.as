package net.wg.infrastructure.base.meta.impl
{
    import net.wg.infrastructure.base.AbstractView;
    import net.wg.data.constants.Errors;

    public class WrapperViewMeta extends AbstractView
    {

        public var onWindowClose:Function;

        public function WrapperViewMeta()
        {
            super();
        }

        public function onWindowCloseS() : void
        {
            App.utils.asserter.assertNotNull(this.onWindowClose,"onWindowClose" + Errors.CANT_NULL);
            this.onWindowClose();
        }
    }
}
