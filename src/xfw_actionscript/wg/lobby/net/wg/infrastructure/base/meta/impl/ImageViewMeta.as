package net.wg.infrastructure.base.meta.impl
{
    import net.wg.infrastructure.base.AbstractScreen;
    import net.wg.data.constants.Errors;

    public class ImageViewMeta extends AbstractScreen
    {

        public var onClose:Function;

        public function ImageViewMeta()
        {
            super();
        }

        public function onCloseS() : void
        {
            App.utils.asserter.assertNotNull(this.onClose,"onClose" + Errors.CANT_NULL);
            this.onClose();
        }
    }
}
