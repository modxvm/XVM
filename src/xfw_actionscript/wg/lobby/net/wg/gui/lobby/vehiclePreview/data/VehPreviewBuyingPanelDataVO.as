package net.wg.gui.lobby.vehiclePreview.data
{
    import net.wg.data.daapi.base.DAAPIDataClass;
    import net.wg.gui.components.controls.VO.ItemPriceVO;

    public class VehPreviewBuyingPanelDataVO extends DAAPIDataClass
    {

        private static const ITEM_PRICE_DATA_FIELD_NAME:String = "itemPrice";

        public var buyButtonEnabled:Boolean = false;

        public var buyButtonLabel:String = "";

        public var buyButtonTooltip:String = "";

        public var showGlow:Boolean = false;

        public var itemPrice:ItemPriceVO = null;

        public var isMoneyEnough:Boolean = false;

        public var showAction:Boolean = false;

        public function VehPreviewBuyingPanelDataVO(param1:Object)
        {
            super(param1);
        }

        override protected function onDataWrite(param1:String, param2:Object) : Boolean
        {
            if(param1 == ITEM_PRICE_DATA_FIELD_NAME && param2 is Array)
            {
                this.itemPrice = new ItemPriceVO(param2[0]);
                return false;
            }
            return super.onDataWrite(param1,param2);
        }

        override protected function onDispose() : void
        {
            if(this.itemPrice)
            {
                this.itemPrice.dispose();
                this.itemPrice = null;
            }
            super.onDispose();
        }
    }
}
