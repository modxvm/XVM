package com.xvm.lobby.ui.tankcarousel
{
    import com.xvm.types.cfg.*;
    import flash.utils.*;
    import net.wg.gui.lobby.hangar.tcarousel.helper.*;

    public class SmallTankCarouselHelper extends TankCarouselHelperBase implements ITankCarouselHelper
    {
        public function SmallTankCarouselHelper(cfg:CCarouselCell)
        {
            super(cfg);
        }

        override public function get linkRenderer():String
        {
            return getQualifiedClassName(UI_SmallTankCarouselItemRenderer);
        }

        CLIENT::WG {
            override public function get isSmall():Boolean
            {
                return true;
            }
        }

        // PROTECTED

        override protected function get DEFAULT_RENDERER_WIDTH():int
        {
            return UI_SmallTankCarouselItemRenderer.DEFAULT_RENDERER_WIDTH;
        }

        override protected function get DEFAULT_RENDERER_HEIGHT():int
        {
            return UI_SmallTankCarouselItemRenderer.DEFAULT_RENDERER_HEIGHT;
        }

        override protected function get DEFAULT_RENDERER_VISIBLE_HEIGHT():int
        {
            return UI_SmallTankCarouselItemRenderer.DEFAULT_RENDERER_VISIBLE_HEIGHT;
        }
    }
}