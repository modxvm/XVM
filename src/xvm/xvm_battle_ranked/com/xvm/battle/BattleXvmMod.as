/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.battle
{
    import com.xfw.*;
    import com.xvm.*;
    import com.xvm.infrastructure.*;
    import com.xvm.battle.ranked.battleloading.RankedBattleLoadingXvmView;
    import com.xvm.battle.ranked.fullStats.RankedFullStatsXvmView;
    import com.xvm.battle.ranked.playersPanel.RankedPlayersPanelXvmView;
    import com.xvm.battle.shared.minimap.MinimapXvmView;
    import com.xvm.battle.shared.sixthSense.SixthSenseXvmView;
    import com.xvm.battle.shared.teamBasesPanel.TeamBasesPanelXvmView;
    import net.wg.gui.battle.ranked.RankedBattlePage;

    public class BattleXvmMod extends XvmModBase
    {
        public function BattleXvmMod():void
        {
            Xvm.appType = Defines.APP_TYPE_BATTLE_RANKED;
            super();
        }

        public override function get logPrefix():String
        {
            return "[XVM:BATTLE]";
        }

        private static const _views:Object =
        {
            "rankedBattlePage": [
                RankedBattleLoadingXvmView,
                RankedFullStatsXvmView,
                RankedPlayersPanelXvmView,
                TeamBasesPanelXvmView,
                MinimapXvmView,
                SixthSenseXvmView,
                BattleXvmView                   // BattleXvmView should be loaded last (implements invalidation methods)
            ]
        }

        public override function get views():Object
        {
            return _views;
        }

        public static function get battlePageRanked():RankedBattlePage
        {
            return BattleXvmView.battlePage as RankedBattlePage;
        }
    }
}
