package net.wg.gui.lobby.eventMessageWindow.events
{
    import flash.events.Event;

    public class EventMessageWindowEvent extends Event
    {

        public static const RESULT:String = "EventMessageEventResult";

        public static const ON_OUTRO_ANIMATION_STARTED:String = "EventMessageEventOnOutroAnimationStarted";

        private var _result:int;

        public function EventMessageWindowEvent(param1:String, param2:int = 0, param3:Boolean = false, param4:Boolean = false)
        {
            super(param1,param3,param4);
            this._result = param2;
        }

        override public function clone() : Event
        {
            return new EventMessageWindowEvent(type,this.result,bubbles,cancelable);
        }

        override public function toString() : String
        {
            return formatToString("EventMessageWindowEvent","type","result","bubbles","cancelable","eventPhase");
        }

        public function get result() : int
        {
            return this._result;
        }
    }
}
