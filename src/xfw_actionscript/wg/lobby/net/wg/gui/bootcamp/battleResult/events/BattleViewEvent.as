package net.wg.gui.bootcamp.battleResult.events
{
    import flash.events.Event;

    public final class BattleViewEvent extends Event
    {

        public static const ANIMATION_COMPLETE:String = "animationsComplete";

        public static const ANIMATIONS_QUEUE_START:String = "animationsQueueStart";

        public static const ANIMATIONS_QUEUE_COMPLETE:String = "animationsQueueComplete";

        private var _elementId:String = "";

        public function BattleViewEvent(param1:String, param2:String = "", param3:Boolean = false, param4:Boolean = false)
        {
            super(param1,param3,param4);
            this._elementId = param2;
        }

        override public function clone() : Event
        {
            return new BattleViewEvent(type,this._elementId,bubbles,cancelable);
        }

        override public function toString() : String
        {
            return formatToString("BattleViewEvent","type","elementId","bubbles","cancelable");
        }

        public function get elementId() : String
        {
            return this._elementId;
        }
    }
}
