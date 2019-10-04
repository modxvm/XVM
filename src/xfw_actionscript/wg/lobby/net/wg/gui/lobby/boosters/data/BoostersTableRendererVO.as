package net.wg.gui.lobby.boosters.data
{
    import net.wg.data.daapi.base.DAAPIDataClass;
    import net.wg.gui.lobby.components.data.BoosterSlotVO;
    import net.wg.gui.components.controls.VO.ActionPriceVO;

    public class BoostersTableRendererVO extends DAAPIDataClass
    {

        private static const BOOSTER_SLOT_VO:String = "boosterSlotVO";

        private static const PRICE:String = "price";

        private static const ACTION_PRICE_DATA:String = "actionPriceData";

        public var headerText:String = "";

        public var descriptionText:String = "";

        public var addDescriptionText:String = "";

        public var actionBtnLabel:String = "";

        public var actionBtnEnabled:Boolean = false;

        public var actionBtnTooltip:String = "";

        public var id:Number = -1;

        public var questID:String = "";

        public var tooltip:String = "";

        public var boosterSlotVO:BoosterSlotVO = null;

        public var rendererState:String = "";

        public var priceText:String = "";

        public var price:ActionPriceVO = null;

        public var creditsPriceState:String = "";

        public var goldPriceState:String = "";

        public var actionStyle:String = "";

        public var actionPriceData:ActionPriceVO = null;

        public function BoostersTableRendererVO(param1:Object)
        {
            super(param1);
        }

        override protected function onDataWrite(param1:String, param2:Object) : Boolean
        {
            if(param1 == BOOSTER_SLOT_VO && param2 != null)
            {
                this.boosterSlotVO = new BoosterSlotVO(param2);
                return false;
            }
            if(param1 == PRICE && param2 != null)
            {
                this.price = new ActionPriceVO(param2);
                return false;
            }
            if(param1 == ACTION_PRICE_DATA && param2 != null)
            {
                this.actionPriceData = new ActionPriceVO(param2);
                return false;
            }
            return super.onDataWrite(param1,param2);
        }

        override protected function onDispose() : void
        {
            if(this.boosterSlotVO != null)
            {
                this.boosterSlotVO.dispose();
                this.boosterSlotVO = null;
            }
            if(this.actionPriceData != null)
            {
                this.actionPriceData.dispose();
                this.actionPriceData = null;
            }
            if(this.price != null)
            {
                this.price.dispose();
                this.price = null;
            }
            super.onDispose();
        }
    }
}
