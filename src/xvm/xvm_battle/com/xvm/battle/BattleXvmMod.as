/**
 * XVM - battle
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.battle
{
    import com.xfw.*;
    import com.xvm.infrastructure.*;
    import com.xvm.battle.BattleXvmView;

    public class BattleXvmMod extends XvmModBase
    {
        public override function get logPrefix():String
        {
            return "[XVM:BATTLE]";
        }

        private static const _views:Object =
        {
            "classicBattlePage": [ BattleXvmView ]
        }

        override public function entryPoint():void
        {
            super.entryPoint();
            //Logger.addObject(stage);
            //Logger.addObject(root);
        }

        public override function get views():Object
        {
            return _views;
        }
    }
}
