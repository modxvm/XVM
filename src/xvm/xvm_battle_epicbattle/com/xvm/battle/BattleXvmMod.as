/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.battle
{
    import com.xfw.*;
    import com.xvm.*;
    import com.xvm.infrastructure.*;
    import com.xvm.battle.epicbattle.battleloading.EpicBattleLoadingXvmView;
    import com.xvm.battle.epicbattle.fullStats.EpicFullStatsXvmView;
    import com.xvm.battle.shared.minimap.MinimapXvmView;
    import com.xvm.battle.shared.sixthSense.SixthSenseXvmView;
    import com.xvm.battle.shared.teamBasesPanel.TeamBasesPanelXvmView;

    public class BattleXvmMod extends XvmModBase
    {
        public function BattleXvmMod():void
        {
            Xvm.appType = Defines.APP_TYPE_BATTLE_EPIC;
            super();
        }

        public override function get logPrefix():String
        {
            return "[XVM:BATTLE]";
        }

        private static const VIEWS:Object =
        {
            "epicBattlePage": [
                //EpicBattleLoadingXvmView, // TODO:EPIC
                //EpicFullStatsXvmView, // TODO:EPIC
                //TeamBasesPanelXvmView,
                //SixthSenseXvmView,
                //BattleXvmView                   // BattleXvmView should be loaded last (implements invalidation methods)
            ]
        }

        public override function get views():Object
        {
            return VIEWS;
        }
    }
}