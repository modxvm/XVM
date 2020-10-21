package net.wg.gui.lobby.eventPlayerPackTrade.data
{
    import net.wg.data.daapi.base.DAAPIDataClass;
    import net.wg.gui.lobby.eventItemPackTrade.data.ItemVO;

    public class EventPlayerPackTradeVO extends DAAPIDataClass
    {

        private static const ITEM1:String = "item1";

        private static const ITEM2:String = "item2";

        private static const ITEM3:String = "item3";

        private static const VEHICLE1:String = "vehicle1";

        private static const VEHICLE2:String = "vehicle2";

        public var backDescription:String = "";

        public var header:String = "";

        public var inStock:String = "";

        public var tokens:int = 0;

        public var oldPrice:int = 0;

        public var newPrice:int = 0;

        public var percent:int = 0;

        public var btnLabel:String = "";

        public var btnEnabled:Boolean = true;

        public var btnTooltip:String = "";

        public var item1:ItemVO = null;

        public var item2:ItemVO = null;

        public var item3:ItemVO = null;

        public var infoTitle:String = "";

        public var infoDescription:String = "";

        public var infoTooltip:String = "";

        public var vehicle1:ItemVO = null;

        public var vehicle2:ItemVO = null;

        public var description:String = "";

        public function EventPlayerPackTradeVO(param1:Object)
        {
            super(param1);
        }

        override protected function onDataWrite(param1:String, param2:Object) : Boolean
        {
            if(param1 == ITEM1)
            {
                this.item1 = new ItemVO(param2);
                return false;
            }
            if(param1 == ITEM2)
            {
                this.item2 = new ItemVO(param2);
                return false;
            }
            if(param1 == ITEM3)
            {
                this.item3 = new ItemVO(param2);
                return false;
            }
            if(param1 == VEHICLE1)
            {
                this.vehicle1 = new ItemVO(param2);
                return false;
            }
            if(param1 == VEHICLE2)
            {
                this.vehicle2 = new ItemVO(param2);
                return false;
            }
            return super.onDataWrite(param1,param2);
        }

        override protected function onDispose() : void
        {
            if(this.item1 != null)
            {
                this.item1.dispose();
                this.item1 = null;
            }
            if(this.item2 != null)
            {
                this.item2.dispose();
                this.item2 = null;
            }
            if(this.item3 != null)
            {
                this.item3.dispose();
                this.item3 = null;
            }
            if(this.vehicle1 != null)
            {
                this.vehicle1.dispose();
                this.vehicle1 = null;
            }
            if(this.vehicle2 != null)
            {
                this.vehicle2.dispose();
                this.vehicle2 = null;
            }
            super.onDispose();
        }
    }
}
