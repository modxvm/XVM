/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package xvm.squad
{
    import com.xvm.*;
    import com.xvm.infrastructure.*;

    public class SquadXvmMod extends XvmModBase
    {
        public override function get logPrefix():String
        {
            return "[XVM:SQUAD]";
        }

        private static const _views:Object =
        {
            "prb_windows/squadWindow": SquadXvmView
        }

        public override function get views():Object
        {
            return _views;
        }
    }
}
