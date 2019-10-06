package net.wg.gui.lobby.vehicleCustomization.data.purchase
{
    import net.wg.data.daapi.base.DAAPIDataClass;
    import net.wg.gui.components.controls.VO.ItemPriceVO;

    public class PurchasesTotalVO extends DAAPIDataClass
    {

        private static const TOTAL_PRICE_FIELD:String = "totalPrice";

        public var totalLabel:String = "";

        public var inFormationAlert:String = "";

        public var prolongationCondition:String = "";

        private var _totalPrice:ItemPriceVO = null;

        public var enoughMoney:Boolean = false;

        public function PurchasesTotalVO(param1:Object)
        {
            super(param1);
        }

        override protected function onDataWrite(param1:String, param2:Object) : Boolean
        {
            if(param2 != null && param1 == TOTAL_PRICE_FIELD)
            {
                this._totalPrice = new ItemPriceVO(param2);
                return false;
            }
            return super.onDataWrite(param1,param2);
        }

        override protected function onDispose() : void
        {
            if(this._totalPrice != null)
            {
                this._totalPrice.dispose();
                this._totalPrice = null;
            }
            super.onDispose();
        }

        public function get totalPrice() : ItemPriceVO
        {
            return this._totalPrice;
        }
    }
}
