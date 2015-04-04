/**
 * XVM - clock
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package xvm.clock
{
    import com.xfw.*;
    import com.xvm.infrastructure.*;

    public class ClockXvmMod extends XvmModBase
    {
        public override function get logPrefix():String
        {
            return "[XVM:CLOCK]";
        }

        private static const _views:Object =
        {
            "lobby": ClockXvmView
        }

        public override function get views():Object
        {
            return _views;
        }
    }
}
