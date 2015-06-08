/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package xvm.tcarousel_ui
{
    import com.xfw.*;
    import com.xvm.infrastructure.*;

    /**
     *  This class is used to link UI classes into *_ui.swf
     */
    public class TCarouselUIXvmMod extends XvmModBase
    {
        UI_TankCarousel;
        UI_TankCarouselItemRenderer;

        override public function get logPrefix():String
        {
            return "[XVM:TCAROUSEL_UI]";
        }

        private static const _views:Object =
        {
            "hangar": TCarouselUIXvmView
        }

        public static const XFW_CMD_INIT:String = "xvm_tcarousel.init";
        private static var _initialized:Boolean = false;

        override public function entryPoint():void
        {
            if (_initialized)
                return;
            _initialized = true;
            Xfw.cmd(XFW_CMD_INIT);
        }

        override public function get views():Object
        {
            return _views;
        }
    }
}
