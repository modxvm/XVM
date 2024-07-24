/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.battle
{
    import com.xfw.*;
    import com.xvm.*;
    import com.xvm.infrastructure.*;

    public class BattleXvmMod extends XvmModBase
    {
        public static const APP_TYPE:int = Defines.APP_TYPE_BATTLE_EVENT_SPECIAL;

        public override function get logPrefix():String
        {
            return "[XVM:BATTLE]";
        }

        private static const VIEWS:Object =
        {
            "cosmicBattlePage": [],
            "racesBattlePage": []
        }

        public override function get views():Object
        {
            return VIEWS;
        }
    }
}
