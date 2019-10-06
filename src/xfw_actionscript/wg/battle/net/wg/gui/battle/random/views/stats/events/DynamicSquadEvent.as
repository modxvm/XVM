package net.wg.gui.battle.random.views.stats.events
{
    import flash.events.Event;

    public class DynamicSquadEvent extends Event
    {

        public static const ACCEPT:String = "accept";

        public static const ADD:String = "add";

        public var uid:Number = -1;

        public function DynamicSquadEvent(param1:String, param2:Number, param3:Boolean = false, param4:Boolean = false)
        {
            super(param1,param3,param4);
            this.uid = param2;
        }

        override public function clone() : Event
        {
            return new DynamicSquadEvent(type,this.uid,bubbles,cancelable);
        }
    }
}
