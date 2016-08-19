package com.xvm.battle
{
    import com.xfw.*;
    import com.xvm.*;

    public class BattleXvmApp extends XvmAppBase
    {
        private var battleXvmMod:BattleXvmMod;

        public function BattleXvmApp():void
        {
            Logger.counterPrefix = "B";

            battleXvmMod = new BattleXvmMod();
            addChild(battleXvmMod);

            BattleGlobalData.init();
            Stat.clearBattleStat();
            Stat.loadBattleStat();
        }
    }
}
