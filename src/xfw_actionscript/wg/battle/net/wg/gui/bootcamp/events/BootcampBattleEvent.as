package net.wg.gui.bootcamp.events
{
    import flash.events.Event;

    public class BootcampBattleEvent extends Event
    {

        public static const PREBATTLE_CREATED:String = "bootcampPrebattleCreated";

        public function BootcampBattleEvent(param1:String, param2:Boolean = true, param3:Boolean = true)
        {
            super(param1,param2,param3);
        }

        override public function clone() : Event
        {
            return new BootcampBattleEvent(type,bubbles,cancelable);
        }

        override public function toString() : String
        {
            return formatToString("BootcampBattleEvent","type","bubbles","cancelable");
        }
    }
}
