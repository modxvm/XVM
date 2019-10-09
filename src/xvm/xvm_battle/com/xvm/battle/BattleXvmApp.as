/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.battle
{
    import com.xfw.*;
    import com.xvm.*;

    public class BattleXvmApp extends XvmAppBase
    {
        private var battleXvmMod:BattleXvmMod;

        public function BattleXvmApp():void
        {
            Logger.setCounterPrefix("B");
            super(BattleXvmMod.APP_TYPE);

            battleXvmMod = new BattleXvmMod();
            addChild(battleXvmMod);

            Xmqp.init();
            BattleGlobalData.init();
            Stat.clearBattleStat();
            Stat.loadBattleStat();

            //App.utils.scheduler.scheduleTask(function():void {
            //    App.voiceChatMgr.as_onPlayerSpeak(24246126, true, true);
            //}, 5000);
        }
    }
}
