package net.wg.gui.lobby.eventStylesTrade.events
{
    import flash.events.Event;

    public class StylesTradeEvent extends Event
    {

        public static const BUY_CLICK:String = "buyClick";

        public static const BUNDLE_CONFIRM_CLICK:String = "bundleConfirmClick";

        public static const BUY_CONFIRM_CLICK:String = "buyConfirmClick";

        public static const BUY_CANCEL_CLICK:String = "cancelClick";

        public static const USE_CLICK:String = "useClick";

        public static const BUNDLE_CLICK:String = "bundleClick";

        public static const DATA_CHANGED:String = "dataChanged";

        private var _index:int = 0;

        public function StylesTradeEvent(param1:String, param2:int = 0)
        {
            super(param1,true,false);
            this._index = param2;
        }

        override public function clone() : Event
        {
            return new StylesTradeEvent(type,this._index);
        }

        public function get index() : int
        {
            return this._index;
        }
    }
}
