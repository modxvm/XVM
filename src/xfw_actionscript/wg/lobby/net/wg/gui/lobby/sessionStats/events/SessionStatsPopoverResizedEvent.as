package net.wg.gui.lobby.sessionStats.events
{
    import flash.events.Event;

    public class SessionStatsPopoverResizedEvent extends Event
    {

        public static const RESIZED:String = "SessionStatsPopoverResizedEvent.RESIZED";

        private var _isExpanded:Boolean;

        public function SessionStatsPopoverResizedEvent(param1:Boolean)
        {
            super(RESIZED,true);
            this._isExpanded = param1;
        }

        public function get isExpanded() : Boolean
        {
            return this._isExpanded;
        }

        override public function clone() : Event
        {
            return new SessionStatsPopoverResizedEvent(this._isExpanded);
        }
    }
}
