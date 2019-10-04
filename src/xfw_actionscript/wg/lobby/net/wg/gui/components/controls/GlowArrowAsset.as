package net.wg.gui.components.controls
{
    import net.wg.infrastructure.base.UIComponentEx;
    import flash.display.MovieClip;

    public class GlowArrowAsset extends UIComponentEx
    {

        public var hit:MovieClip;

        public function GlowArrowAsset()
        {
            super();
            hitArea = this.hit;
        }

        override public function get width() : Number
        {
            return this.hit.width;
        }

        override public function get height() : Number
        {
            return this.hit.height;
        }
    }
}
