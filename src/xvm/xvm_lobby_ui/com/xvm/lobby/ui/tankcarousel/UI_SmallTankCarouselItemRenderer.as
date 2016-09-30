/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.lobby.ui.tankcarousel
{
    import com.xfw.*;
    import com.xvm.*;
    import flash.utils.*;

    public dynamic class UI_SmallTankCarouselItemRenderer extends SmallTankCarouselItemRendererUI
    {
        public static const DEFAULT_WIDTH:int = 162;
        public static const DEFAULT_HEIGHT:int = 37;

        public function UI_SmallTankCarouselItemRenderer()
        {
            Logger.add(getQualifiedClassName(this));
            super();
        }
    }
}
