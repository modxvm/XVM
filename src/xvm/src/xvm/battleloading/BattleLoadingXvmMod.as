/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package xvm.battleloading
{
    import com.xfw.*;
    import com.xvm.infrastructure.*;

    public class BattleLoadingXvmMod extends XvmModBase
    {
        public override function get logPrefix():String
        {
            return "[XVM:BL]";
        }

        private static const _views:Object =
        {
            "battleLoading": BattleLoadingXvmView
        }

        public override function get views():Object
        {
            return _views;
        }
    }
}
