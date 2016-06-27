/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package xvm.tankcarousel_ui
{
    import com.xfw.*;
    import com.xvm.*;
    import flash.utils.*;
    import net.wg.gui.lobby.hangar.tcarousel.FalloutTankCarousel;

    public dynamic class UI_FalloutTankCarousel extends FalloutTankCarouselUI
    {
        public function UI_FalloutTankCarousel()
        {
            Logger.add(getQualifiedClassName(this));
            super();
        }
    }
}
