package net.wg.gui.lobby.vehicleCustomization.data.purchase
{
    import net.wg.data.daapi.base.DAAPIDataClass;
    import net.wg.gui.lobby.vehicleCustomization.data.customizationPanel.CustomizationCarouselRendererVO;
    import net.wg.gui.components.controls.VO.ItemPriceVO;

    public class PurchaseVO extends DAAPIDataClass
    {

        private static const COMPOUND_PRICE:String = "compoundPrice";

        private static const ITEM_IMG:String = "itemImg";

        public var id:uint = 0;

        public var slotIdx:uint = 0;

        public var price:uint = 0;

        public var selected:Boolean = false;

        public var titleText:String = "";

        public var isFromStorage:Boolean = false;

        public var isLock:Boolean = false;

        public var quantity:int = -1;

        public var tooltip:String = "";

        private var _itemImg:CustomizationCarouselRendererVO = null;

        private var _compoundPriceData:ItemPriceVO = null;

        public function PurchaseVO(param1:Object)
        {
            super(param1);
        }

        override protected function onDataWrite(param1:String, param2:Object) : Boolean
        {
            if(param1 == COMPOUND_PRICE)
            {
                this._compoundPriceData = new ItemPriceVO(param2);
                return false;
            }
            if(param1 == ITEM_IMG)
            {
                this._itemImg = new CustomizationCarouselRendererVO(param2);
                return false;
            }
            return super.onDataWrite(param1,param2);
        }

        override protected function onDispose() : void
        {
            if(this._compoundPriceData != null)
            {
                this._compoundPriceData.dispose();
                this._compoundPriceData = null;
            }
            if(this._itemImg != null)
            {
                this._itemImg.dispose();
                this._itemImg = null;
            }
            super.onDispose();
        }

        public function get compoundPrice() : ItemPriceVO
        {
            return this._compoundPriceData;
        }

        public function get itemImg() : CustomizationCarouselRendererVO
        {
            return this._itemImg;
        }
    }
}
