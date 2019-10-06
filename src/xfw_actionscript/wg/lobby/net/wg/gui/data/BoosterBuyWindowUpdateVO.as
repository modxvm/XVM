package net.wg.gui.data
{
    import net.wg.data.daapi.base.DAAPIDataClass;
    import net.wg.gui.components.controls.VO.ActionPriceVO;

    public class BoosterBuyWindowUpdateVO extends DAAPIDataClass
    {

        private static const FIELD_ACTION_PRICE_DATA:String = "actionPriceData";

        public var actionPriceData:ActionPriceVO = null;

        public var itemPrice:int = -1;

        public var itemCount:int = -1;

        public var currency:String = "";

        public var currencyCount:int = -1;

        public var rearmCheckboxValue:Boolean = false;

        public function BoosterBuyWindowUpdateVO(param1:Object = null)
        {
            super(param1);
        }

        override protected function onDispose() : void
        {
            if(this.actionPriceData)
            {
                this.actionPriceData.dispose();
                this.actionPriceData = null;
            }
            super.onDispose();
        }

        override protected function onDataWrite(param1:String, param2:Object) : Boolean
        {
            if(param1 == FIELD_ACTION_PRICE_DATA)
            {
                this.actionPriceData = new ActionPriceVO(param2);
                return false;
            }
            return super.onDataWrite(param1,param2);
        }
    }
}
