package net.wg.gui.battle.views.prebattleTimer.data
{
    import net.wg.data.daapi.base.DAAPIDataClass;

    public class PrebattleTimerMessageVO extends DAAPIDataClass
    {

        public var msgType:String = "";

        public var msg:String = "";

        public var isBigMsg:Boolean = false;

        public var winCondition:String = "";

        public var fadeInDuration:uint = 300;

        public var duration:uint = 3500;

        public var icon:String = "";

        public var hightLight:String = "dark";

        public function PrebattleTimerMessageVO(param1:Object = null)
        {
            super(param1);
        }
    }
}
