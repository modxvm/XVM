/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.battle
{
    import com.xfw.*;
    import com.xvm.*;
    import com.xvm.infrastructure.*;
    import com.xvm.battle.shared.sixthSense.SixthSenseXvmView;
    CLIENT::WG {
        import net.wg.comp7.battle.Comp7BattlePage;
    }
    CLIENT::LESTA {
        import net.wg.gui.battle.comp7.Comp7BattlePage;
    }

    public class BattleXvmMod extends XvmModBase
    {
        public static const APP_TYPE:int = Defines.APP_TYPE_BATTLE_COMP7;

        public override function get logPrefix():String
        {
            return "[XVM:BATTLE]";
        }

        private static const VIEWS:Object =
        {
            "comp7BattlePage": [
                SixthSenseXvmView,
                BattleXvmView                   // BattleXvmView should be loaded last (implements invalidation methods)
            ]
        }

        public override function get views():Object
        {
            return VIEWS;
        }

        public static function get comp7BattlePage():Comp7BattlePage
        {
            return BattleXvmView.battlePage as Comp7BattlePage;
        }
    }
}
