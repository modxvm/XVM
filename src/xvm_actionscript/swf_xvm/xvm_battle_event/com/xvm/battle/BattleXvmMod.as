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

    public class BattleXvmMod extends XvmModBase
    {
        public static const APP_TYPE:int = Defines.APP_TYPE_BATTLE_EVENT;

        public override function get logPrefix():String
        {
            return "[XVM:BATTLE]";
        }

        private static const VIEWS:Object =
        {
            "eventBattlePage": [
                SixthSenseXvmView,
                BattleXvmView                   // BattleXvmView should be loaded last (implements invalidation methods)
            ],
            "historicalBattles": [
                SixthSenseXvmView,
                BattleXvmView                   // BattleXvmView should be loaded last (implements invalidation methods)
            ]
        }

        public override function get views():Object
        {
            return VIEWS;
        }
    }
}
