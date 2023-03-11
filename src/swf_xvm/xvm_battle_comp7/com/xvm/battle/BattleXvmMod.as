/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.battle
{
    import net.wg.gui.battle.comp7.Comp7BattlePage;
	
	import com.xvm.Defines;
	import com.xvm.battle.BattleXvmView;
	import com.xvm.infrastructure.XvmModBase;
	

    public class BattleXvmMod extends XvmModBase
    {
        public static const APP_TYPE:int = Defines.APP_TYPE_BATTLE_COMP7;

        public override function get logPrefix():String
        {
            return "[XVM:BATTLE]";
        }

        private static const VIEWS:Object =
        {
            "comp7BattlePage": [
                BattleXvmView                   // BattleXvmView should be loaded last (implements invalidation methods)
            ]
        }

        public override function get views():Object
        {
            return VIEWS;
        }

        public static function get eventBattlePage():Comp7BattlePage
        {
            return BattleXvmView.battlePage as Comp7BattlePage;
        }
    }
}
