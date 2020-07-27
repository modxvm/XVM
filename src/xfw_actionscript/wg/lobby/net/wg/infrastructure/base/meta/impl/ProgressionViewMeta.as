package net.wg.infrastructure.base.meta.impl
{
    import net.wg.infrastructure.base.AbstractView;
    import net.wg.data.constants.Errors;

    public class ProgressionViewMeta extends AbstractView
    {

        public var onEscapePress:Function;

        public function ProgressionViewMeta()
        {
            super();
        }

        public function onEscapePressS() : void
        {
            App.utils.asserter.assertNotNull(this.onEscapePress,"onEscapePress" + Errors.CANT_NULL);
            this.onEscapePress();
        }
    }
}
