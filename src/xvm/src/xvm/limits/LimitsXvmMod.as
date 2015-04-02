/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package xvm.limits
{
    import com.xfw.*;
    import com.xfw.infrastructure.*;

    public class LimitsXvmMod extends XvmModBase
    {
        public override function get logPrefix():String
        {
            return "[XVM:LIMITS]";
        }

        private static const _views:Object =
        {
            "lobby": LimitsXvmView
        }

        public override function get views():Object
        {
            return _views;
        }
    }
}
