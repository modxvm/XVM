package net.wg.gui.components.common.ticker.events
{
    import flash.events.Event;

    public class BattleTickerEvent extends Event
    {

        public static const SHOW:String = "tickerShow";

        public static const HIDE:String = "tickerHide";

        public function BattleTickerEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
        {
            super(param1,param2,param3);
        }

        override public function clone() : Event
        {
            return new BattleTickerEvent(type,bubbles,cancelable);
        }
    }
}
