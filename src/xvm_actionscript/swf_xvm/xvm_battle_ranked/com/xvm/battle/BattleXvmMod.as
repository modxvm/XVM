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
    import com.xvm.battle.ranked.teamBasesPanel.TeamBasesPanelXvmView;
    import com.xvm.battle.shared.minimap.MinimapXvmView;
    import com.xvm.battle.shared.sixthSense.SixthSenseXvmView;
    import net.wg.gui.battle.ranked.RankedBattlePage;

    public class BattleXvmMod extends XvmModBase
    {
        public static const APP_TYPE:int = Defines.APP_TYPE_BATTLE_RANKED;

        public override function get logPrefix():String
        {
            return "[XVM:BATTLE]";
        }

        CLIENT::WG {
            private static const VIEWS:Object =
            {
                "rankedBattlePage": [
                    RankedBattleLoadingXvmView,
                    RankedPlayersPanelXvmView,
                    TeamBasesPanelXvmView,
                    MinimapXvmView,
                    SixthSenseXvmView,
                    BattleXvmView                   // BattleXvmView should be loaded last (implements invalidation methods)
                ]
            }
        }

        CLIENT::LESTA {
            private static const VIEWS:Object =
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
        }

        public override function get views():Object
        {
            return VIEWS;
        }

        public static function get battlePageRanked():RankedBattlePage
        {
            return BattleXvmView.battlePage as RankedBattlePage;
        }
    }
}
