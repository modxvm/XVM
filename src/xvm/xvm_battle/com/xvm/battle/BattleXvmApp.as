package com.xvm.battle
{
    import com.xfw.*;
    import com.xvm.*;

    public class BattleXvmApp extends XvmAppBase
    {
        private var battleXvmMod:BattleXvmMod;

        public function BattleXvmApp():void
        {
            battleXvmMod = new BattleXvmMod();
            addChild(battleXvmMod);

            Logger.counterPrefix = "B";

            BattleGlobalData.init();
            Stat.clearBattleStat();
            Stat.loadBattleStat();
        }
    }
}
