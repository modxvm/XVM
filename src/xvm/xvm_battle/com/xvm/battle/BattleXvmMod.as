/**
 * XVM - battle
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.battle
{
    import com.xfw.*;
    import com.xvm.*;
    import com.xvm.infrastructure.*;
    import com.xvm.battle.BattleXvmView;
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
            // BattleXvmView should be loaded last
            "classicBattlePage": [ PlayersPanelXvmView, TeamBasesPanelXvmView, BattleXvmView ]
        }

        override public function entryPoint():void
        {
            super.entryPoint();
            //Logger.addObject(stage);
            //Logger.addObject(root);

            Macros.RegisterGlobalMacrosData();
        }

        public override function get views():Object
        {
            return _views;
        }
    }
}
