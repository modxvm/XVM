package net.wg.gui.components.popovers
{
    import net.wg.infrastructure.base.UIComponentEx;
    import flash.display.MovieClip;

    public class UnClickableShadowBG extends UIComponentEx
    {

        public var shadow:MovieClip;

        public var hit:MovieClip;

        public function UnClickableShadowBG()
        {
            super();
            this.shadow.buttonMode = true;
            this.shadow.hitArea = this.hit;
            this.shadow.tabEnabled = false;
        }
    }
}
