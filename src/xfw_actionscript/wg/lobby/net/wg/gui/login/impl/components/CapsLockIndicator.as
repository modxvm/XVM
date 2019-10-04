package net.wg.gui.login.impl.components
{
    import net.wg.infrastructure.base.UIComponentEx;
    import flash.text.TextField;

    public class CapsLockIndicator extends UIComponentEx
    {

        public var label:TextField;

        public function CapsLockIndicator()
        {
            super();
        }

        override protected function onDispose() : void
        {
            this.label = null;
            super.onDispose();
        }

        override protected function configUI() : void
        {
            super.configUI();
            this.label.text = MENU.LOGIN_CAPS;
        }
    }
}
