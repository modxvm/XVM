/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package xvm.battleresults
{
    import com.xfw.*;
    import com.xvm.infrastructure.*;

    public class BattleResultsXvmMod extends XvmModBase
    {
        public override function get logPrefix():String
        {
            return "[XVM:BR]";
        }

        private static const _views:Object =
        {
            "battleResults": BattleResultsXvmView
        }

        public override function get views():Object
        {
            return _views;
        }
    }
}
