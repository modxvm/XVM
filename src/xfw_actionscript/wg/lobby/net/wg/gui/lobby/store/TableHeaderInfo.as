package net.wg.gui.lobby.store
{
    import net.wg.infrastructure.base.UIComponentEx;
    import flash.text.TextField;

    public class TableHeaderInfo extends UIComponentEx
    {

        public var saveField:TextField = null;

        public var countField:TextField = null;

        public var textField:TextField = null;

        public var compareField:TextField = null;

        public var vehNameField:TextField = null;

        public var saleField:TextField = null;

        public function TableHeaderInfo()
        {
            super();
        }

        override protected function configUI() : void
        {
            super.configUI();
            this.textField.text = MENU.SHOP_TABLE_HEADER_PRICE;
            this.compareField.text = MENU.SHOP_TABLE_HEADER_COMPARE;
            this.vehNameField.text = MENU.SHOP_MENU_VEHICLE_TRADEINVEHICLE_VEHFORTRADE;
            this.saleField.text = MENU.SHOP_TABLE_HEADER_SALE;
        }

        override protected function onDispose() : void
        {
            this.countField = null;
            this.textField = null;
            this.compareField = null;
            this.saveField = null;
            this.vehNameField = null;
            this.saleField = null;
            super.onDispose();
        }

        public function enableSale(param1:Boolean) : void
        {
            this.saleField.visible = param1;
        }

        public function enableTradeIn(param1:Boolean) : void
        {
            this.vehNameField.visible = param1;
            this.saveField.visible = param1;
            this.saveField.text = MENU.SHOP_MENU_VEHICLE_TRADEINVEHICLE_SAVING;
        }

        public function isCompareNeed(param1:Boolean) : void
        {
            this.compareField.visible = param1;
        }
    }
}
