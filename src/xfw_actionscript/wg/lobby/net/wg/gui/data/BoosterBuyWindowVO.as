package net.wg.gui.data
{
    import net.wg.data.daapi.base.DAAPIDataClass;
    import net.wg.gui.components.advanced.vo.StaticItemSlotVO;

    public class BoosterBuyWindowVO extends DAAPIDataClass
    {

        private static const FIELD_BOOSTER_SLOT:String = "boosterSlot";

        public var windowTitle:String = "";

        public var nameText:String = "";

        public var descText:String = "";

        public var countLabelText:String = "";

        public var buyLabelText:String = "";

        public var totalPriceLabelText:String = "";

        public var inHangarLabelText:String = "";

        public var boosterSlot:StaticItemSlotVO = null;

        public var rearmCheckboxLabel:String = "";

        public var rearmCheckboxTooltip:String = "";

        public var submitBtnLabel:String = "";

        public var cancelBtnLabel:String = "";

        public function BoosterBuyWindowVO(param1:Object = null)
        {
            super(param1);
        }

        override protected function onDispose() : void
        {
            if(this.boosterSlot)
            {
                this.boosterSlot.dispose();
                this.boosterSlot = null;
            }
            super.onDispose();
        }

        override protected function onDataWrite(param1:String, param2:Object) : Boolean
        {
            if(param1 == FIELD_BOOSTER_SLOT)
            {
                this.boosterSlot = new StaticItemSlotVO(param2);
                return false;
            }
            return super.onDataWrite(param1,param2);
        }
    }
}
