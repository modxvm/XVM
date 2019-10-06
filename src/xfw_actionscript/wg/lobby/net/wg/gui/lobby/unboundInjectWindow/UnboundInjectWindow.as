package net.wg.gui.lobby.unboundInjectWindow
{
    import net.wg.infrastructure.base.meta.impl.UnboundInjectWindowMeta;
    import net.wg.infrastructure.base.meta.IUnboundInjectWindowMeta;
    import net.wg.gui.components.controls.UILoaderAlt;
    import net.wg.gui.components.controls.SoundButtonEx;
    import net.wg.data.Aliases;

    public class UnboundInjectWindow extends UnboundInjectWindowMeta implements IUnboundInjectWindowMeta
    {

        public var image:UILoaderAlt = null;

        public var btn:SoundButtonEx = null;

        public var ubComponent:UnboundTestComponent = null;

        public var gfComponent:GamefaceTestComponent = null;

        public function UnboundInjectWindow()
        {
            super();
        }

        override protected function configUI() : void
        {
            super.configUI();
            window.title = DEVELOPMENT.WULF_UNBOUNDINJECTIONWINDOW_TITLE;
        }

        override protected function onPopulate() : void
        {
            super.onPopulate();
            registerFlashComponentS(this.ubComponent,Aliases.UNBOUND_TEST_COMPONENT);
            registerFlashComponentS(this.gfComponent,Aliases.GAMEFACE_TEST_COMPONENT);
        }

        override protected function onDispose() : void
        {
            this.image.dispose();
            this.image = null;
            this.btn.dispose();
            this.btn = null;
            this.ubComponent = null;
            this.gfComponent = null;
            super.onDispose();
        }

        public function as_setData(param1:String, param2:String) : void
        {
            this.btn.label = param2;
            this.image.source = param1;
        }
    }
}
