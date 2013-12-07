/**
 * XVM
 * @author Maxim Schedriviy <m.schedriviy@gmail.com>
 */
package xvm.tcarousel
{
    import com.xvm.*;
    import com.xvm.infrastructure.*;

    public class TCarouselXvmMod extends XvmModBase
    {
        public override function get logPrefix():String
        {
            return "[XVM:TCAROUSEL]";
        }

        private static const _views:Object =
        {
            // TODO: 0.8.10 "hangar": TCarouselXvmView
        }

        public override function get views():Object
        {
            return _views;
        }
    }
}
