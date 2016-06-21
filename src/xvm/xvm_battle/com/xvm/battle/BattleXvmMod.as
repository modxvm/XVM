/**
 * XVM - battle
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.battle
{
    import com.xfw.*;
    import com.xvm.*;
    import com.xfw.events.*;
    import com.xvm.infrastructure.*;
    import com.xvm.battle.*;
    import com.xvm.battle.fragCorrelationBar.FragCorrelationBarXvmView;
    import com.xvm.battle.fullStats.FullStatsXvmView;
    import com.xvm.battle.playersPanel.PlayersPanelXvmView;
    import com.xvm.battle.teamBasesPanel.TeamBasesPanelXvmView;

    public class BattleXvmMod extends XvmModBase
    {
        public override function get logPrefix():String
        {
            return "[XVM:BATTLE]";
        }

        private static const _views:Object =
        {
            "classicBattlePage": [
                FragCorrelationBarXvmView,      // FragCorrelationBarXvmView should be loaded first (implements battle state update methods)
                FullStatsXvmView,
                PlayersPanelXvmView,
                TeamBasesPanelXvmView,
                BattleXvmView                   // BattleXvmView should be loaded last (implements invalidation methods)
            ]
        }

        override public function entryPoint():void
        {
            super.entryPoint();
            Macros.RegisterGlobalMacrosData();
            Macros.RegisterBattleGlobalMacrosData(BattleMacros.RegisterGlobalMacrosData);
            Stat.clearBattleStat();
            Stat.loadBattleStat();
        }

        public override function get views():Object
        {
            return _views;
        }
    }
}
