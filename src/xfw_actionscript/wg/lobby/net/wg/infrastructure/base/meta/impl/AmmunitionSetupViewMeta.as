package net.wg.infrastructure.base.meta.impl
{
    import net.wg.gui.tutorial.GFTutorialView;
    import net.wg.data.constants.Errors;

    public class AmmunitionSetupViewMeta extends GFTutorialView
    {

        public var onClose:Function;

        public var onEscapePress:Function;

        public function AmmunitionSetupViewMeta()
        {
            super();
        }

        public function onCloseS() : void
        {
            App.utils.asserter.assertNotNull(this.onClose,"onClose" + Errors.CANT_NULL);
            this.onClose();
        }

        public function onEscapePressS() : void
        {
            App.utils.asserter.assertNotNull(this.onEscapePress,"onEscapePress" + Errors.CANT_NULL);
            this.onEscapePress();
        }
    }
}
