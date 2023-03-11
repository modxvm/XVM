package com.xvm.lobby.ui.tankcarousel
{
    import com.xvm.types.cfg.*;
    import flash.utils.*;
    import net.wg.gui.lobby.hangar.tcarousel.helper.*;

    public class TankCarouselHelper extends TankCarouselHelperBase implements ITankCarouselHelper
    {
        public function TankCarouselHelper(cfg:CCarouselCell)
        {
            super(cfg);
        }

        override public function get linkRenderer():String
        {
            return getQualifiedClassName(UI_TankCarouselItemRenderer);
        }

        // PROTECTED

        override protected function get DEFAULT_RENDERER_WIDTH():int
        {
            return UI_TankCarouselItemRenderer.DEFAULT_RENDERER_WIDTH;
        }

        override protected function get DEFAULT_RENDERER_HEIGHT():int
        {
            return UI_TankCarouselItemRenderer.DEFAULT_RENDERER_HEIGHT;
        }

        override protected function get DEFAULT_RENDERER_VISIBLE_HEIGHT():int
        {
            return UI_TankCarouselItemRenderer.DEFAULT_RENDERER_VISIBLE_HEIGHT;
        }
    }
}
