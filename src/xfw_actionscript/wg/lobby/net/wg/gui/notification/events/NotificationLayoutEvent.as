package net.wg.gui.notification.events
{
    import flash.events.Event;
    import flash.geom.Point;

    public class NotificationLayoutEvent extends Event
    {

        public static const UPDATE_LAYOUT:String = "notificationLayoutUpdate";

        public static const RESET_LAYOUT:String = "notificationLayoutReset";

        private var _padding:Point = null;

        public function NotificationLayoutEvent(param1:String, param2:Point = null)
        {
            super(param1);
            this._padding = param2;
        }

        override public function clone() : Event
        {
            return new NotificationLayoutEvent(type,this._padding);
        }

        override public function toString() : String
        {
            return formatToString("NotificationLayoutEvent","type","padding");
        }

        public function get padding() : Point
        {
            return this._padding;
        }
    }
}
