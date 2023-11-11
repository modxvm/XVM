/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.battle
{
    import com.xfw.*;
    import com.xvm.*;
    import com.xvm.infrastructure.*;
    import com.xvm.battle.winback.battleloading.WinbackBattleLoadingXvmView;
    import com.xvm.battle.winback.fullStats.WinbackFullStatsXvmView;
    import com.xvm.battle.winback.playersPanel.WinbackPlayersPanelXvmView;
    import com.xvm.battle.winback.teamBasesPanel.TeamBasesPanelXvmView;
    import com.xvm.battle.shared.minimap.MinimapXvmView;
    import com.xvm.battle.shared.sixthSense.SixthSenseXvmView;
    import net.wg.gui.battle.random.views.*;

    public class BattleXvmMod extends XvmModBase
    {
        public static const APP_TYPE:int = Defines.APP_TYPE_BATTLE_WINBACK;

        public override function get logPrefix():String
        {
            return "[XVM:BATTLE]";
        }

        private static const VIEWS:Object =
        {
            "winbackBattlePage": [
                // TODO: Fix this after prestige levels fixup for WG
                // WinbackBattleLoadingXvmView,
                // WinbackFullStatsXvmView,
                // WinbackPlayersPanelXvmView,
                TeamBasesPanelXvmView,
                MinimapXvmView,
                SixthSenseXvmView,
                BattleXvmView                   // BattleXvmView should be loaded last (implements invalidation methods)
            ]
        }

        public override function get views():Object
        {
            return VIEWS;
        }

        public static function get winbackBattlePage():BattlePage
        {
            return BattleXvmView.battlePage as BattlePage;
        }
    }
}
