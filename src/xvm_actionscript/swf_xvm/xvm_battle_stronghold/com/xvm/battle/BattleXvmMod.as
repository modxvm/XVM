/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.battle
{
    import com.xvm.Defines;
    import com.xvm.battle.BattleXvmView;
    import com.xvm.battle.stronghold.battleloading.StrongholdBattleLoadingXvmView;
    import com.xvm.battle.stronghold.fullStats.StrongholdFullStatsXvmView;
    import com.xvm.battle.stronghold.playersPanel.StrongholdPlayersPanelXvmView;
    import com.xvm.battle.stronghold.teamBasesPanel.TeamBasesPanelXvmView;
    import com.xvm.battle.shared.minimap.MinimapXvmView;
    import com.xvm.battle.shared.sixthSense.SixthSenseXvmView;
    import com.xvm.infrastructure.XvmModBase;
    import net.wg.gui.battle.random.views.BattlePage;

    public class BattleXvmMod extends XvmModBase
    {
        public static const APP_TYPE:int = Defines.APP_TYPE_BATTLE_CLASSIC;

        public override function get logPrefix():String
        {
            return "[XVM:BATTLE]";
        }

        CLIENT::WG {
            private static const VIEWS:Object =
            {
                "strongholdBattlePage": [
                    StrongholdBattleLoadingXvmView,
                    StrongholdPlayersPanelXvmView,
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
                "strongholdBattlePage": [
                    StrongholdBattleLoadingXvmView,
                    StrongholdFullStatsXvmView,
                    StrongholdPlayersPanelXvmView,
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

        public static function get battlePageClassic():BattlePage
        {
            return BattleXvmView.battlePage as BattlePage;
        }
    }
}
