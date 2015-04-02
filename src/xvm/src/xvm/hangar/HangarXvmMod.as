/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package xvm.hangar
{
    import com.xfw.*;
    import com.xfw.infrastructure.*;
    import xvm.hangar.views.*;

    public class HangarXvmMod extends XvmModBase
    {
        public override function get logPrefix():String
        {
            return "[XVM:HANGAR]";
        }

        private static const _views:Object =
        {
            "login": Login,
            "lobby": Lobby,
            "hangar": Hangar,
            "battleLoading": BattleLoading,
            "battleResults": BattleResults
        }

        public override function get views():Object
        {
            return _views;
        }
    }
}
