/**
 * XVM - clock
 * @author Maxim Schedriviy "m.schedriviy(at)gmail.com"
 */
package xvm.clock
{
    import com.xvm.*;
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
