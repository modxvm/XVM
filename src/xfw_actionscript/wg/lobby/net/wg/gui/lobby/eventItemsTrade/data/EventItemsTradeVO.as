package net.wg.gui.lobby.eventItemsTrade.data
{
    import net.wg.data.daapi.base.DAAPIDataClass;

    public class EventItemsTradeVO extends DAAPIDataClass
    {

        public var backDescription:String = "";

        public var header:String = "";

        public var title:String = "";

        public var description:String = "";

        public var inStock:String = "";

        public var tokens:int = 0;

        public var value:int = 0;

        public var btnLabel:String = "";

        public var btnTooltip:String = "";

        public var availableForPurchase:String = "";

        public var count:int = 0;

        public var multiplier:String = "";

        public var item:String = "";

        public var sign:String = "";

        public function EventItemsTradeVO(param1:Object)
        {
            super(param1);
        }
    }
}
