/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.battle
{
    import com.xfw.*;
    import com.xvm.*;
    import com.xvm.infrastructure.*;
    import com.xvm.battle.classic.battleloading.BattleLoadingXvmView;
    import com.xvm.battle.classic.fullStats.FullStatsXvmView;
    import com.xvm.battle.classic.playersPanel.PlayersPanelXvmView;
    import com.xvm.battle.shared.minimap.MinimapXvmView;
    import com.xvm.battle.shared.sixthSense.SixthSenseXvmView;
    import com.xvm.battle.shared.teamBasesPanel.TeamBasesPanelXvmView;
    import net.wg.gui.battle.random.views.*;

    public class BattleXvmMod extends XvmModBase
    {
        public function BattleXvmMod():void
        {
            Xvm.appType = Defines.APP_TYPE_BATTLE_CLASSIC;
            super();
        }

        public override function get logPrefix():String
        {
            return "[XVM:BATTLE]";
        }

        private static const _views:Object =
        {
            "classicBattlePage": [
                BattleLoadingXvmView,
                FullStatsXvmView,
                PlayersPanelXvmView,
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

        public static function get battlePageClassic():BattlePage
        {
            return BattleXvmView.battlePage as BattlePage;
        }
    }
}
