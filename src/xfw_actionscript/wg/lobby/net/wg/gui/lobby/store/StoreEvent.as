package net.wg.gui.lobby.store
{
    import flash.events.Event;

    public class StoreEvent extends Event
    {

        public static const BUY:String = "storeBuy";

        public static const SELL:String = "storeSell";

        public static const INFO:String = "storeInfo";

        public static const ADD_TO_COMPARE:String = "addToCompare";

        public static const BUY_WITH_TRADE_IN:String = "tradeIn";

        private var _itemCD:String = null;

        public function StoreEvent(param1:String, param2:String)
        {
            super(param1,true,true);
            this._itemCD = param2;
        }

        override public function clone() : Event
        {
            return new StoreEvent(type,this.itemCD);
        }

        public function get itemCD() : String
        {
            return this._itemCD;
        }
    }
}
