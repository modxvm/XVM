package net.wg.gui.lobby.premiumWindow.data
{
    import net.wg.data.daapi.base.DAAPIDataClass;
    import net.wg.gui.components.controls.VO.ActionPriceVO;

    public class PremiumItemRendererVo extends DAAPIDataClass
    {

        private static const FIELD_NAME_ACTION_PRICE:String = "actionPrice";

        public var id:String = "";

        public var image:String = "";

        public var duration:String = "";

        public var actionPrice:ActionPriceVO = null;

        public var enabled:Boolean = false;

        public var haveMoney:Boolean = true;

        public function PremiumItemRendererVo(param1:Object)
        {
            super(param1);
        }

        override protected function onDataWrite(param1:String, param2:Object) : Boolean
        {
            if(param1 == FIELD_NAME_ACTION_PRICE && param2)
            {
                this.actionPrice = new ActionPriceVO(param2);
                return false;
            }
            return super.onDataWrite(param1,param2);
        }

        override protected function onDispose() : void
        {
            if(this.actionPrice)
            {
                this.actionPrice.dispose();
            }
            this.actionPrice = null;
            super.onDispose();
        }
    }
}
