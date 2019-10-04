package net.wg.gui.components.controls
{
    import net.wg.infrastructure.base.UIComponentEx;
    import flash.text.TextField;

    public class Money extends UIComponentEx
    {

        public var price:TextField = null;

        public function Money()
        {
            super();
        }

        override protected function onDispose() : void
        {
            this.price = null;
            super.onDispose();
        }
    }
}
