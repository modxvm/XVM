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
    import net.wg.gui.battle.battleRoyale.BattleRoyalePage;

    public class BattleXvmMod extends XvmModBase
    {
        public static const APP_TYPE:int = Defines.APP_TYPE_BATTLE_ROYALE;

        public override function get logPrefix():String
        {
            return "[XVM:BATTLE]";
        }

        private static const VIEWS:Object =
        {
            "battleRoyalePage": [
                SixthSenseXvmView,
                BattleXvmView                   // BattleXvmView should be loaded last (implements invalidation methods)
            ]
        }

        public override function get views():Object
        {
            return VIEWS;
        }

        public static function get battleRoyalePage():BattleRoyalePage
        {
            return BattleXvmView.battlePage as BattleRoyalePage;
        }
    }
}
