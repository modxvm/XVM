/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * http://www.modxvm.com/
 */
package com.xvm.battle
{
    import com.xfw.*;
    import com.xvm.infrastructure.*;
    import com.xvm.battle.battleloading.RankedBattleLoadingXvmView;
    import com.xvm.battle.fullStats.RankedFullStatsXvmView;
    import com.xvm.battle.minimap.MinimapXvmView;
    import com.xvm.battle.playersPanel.RankedPlayersPanelXvmView;
    import com.xvm.battle.sixthSense.SixthSenseXvmView;
    import com.xvm.battle.teamBasesPanel.TeamBasesPanelXvmView;
    import net.wg.gui.battle.ranked.*;

    public class BattleXvmMod extends XvmModBase
    {
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
