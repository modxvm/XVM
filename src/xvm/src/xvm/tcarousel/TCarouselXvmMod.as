/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package xvm.tcarousel
{
    import com.xfw.*;
    import com.xfw.infrastructure.*;

    public class TCarouselXvmMod extends XvmModBase
    {
        override public function get logPrefix():String
        {
            return "[XVM:TCAROUSEL]";
        }

        private static const _views:Object =
        {
            "hangar": TCarouselXvmView
        }

        override public function entryPoint():void
        {
            //Logger.add((new Error()).getStackTrace());
            super.entryPoint();
        }

        override public function get views():Object
        {
            return _views;
        }
    }
}
