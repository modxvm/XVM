/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package xvm.battleloading
{
    import net.wg.infrastructure.interfaces.IView;
    import com.xfw.*;
    import com.xfw.infrastructure.IXfwView;
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
