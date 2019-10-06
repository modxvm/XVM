package net.wg.gui.lobby.store.shop
{
    import net.wg.infrastructure.base.meta.impl.ShopMeta;
    import net.wg.infrastructure.base.meta.IShopMeta;
    import net.wg.gui.lobby.store.StoreEvent;
    import net.wg.data.constants.generated.STORE_CONSTANTS;
    import net.wg.data.constants.Linkages;
    import flash.display.InteractiveObject;

    public class Shop extends ShopMeta implements IShopMeta
    {

        public function Shop()
        {
            super();
        }

        override protected function getLocalizator() : Function
        {
            return MENU.shop_menu;
        }

        override protected function onPopulate() : void
        {
            super.onPopulate();
            storeTable.addEventListener(StoreEvent.BUY,this.onStoreTableBuyHandler);
            storeTable.addEventListener(StoreEvent.BUY_WITH_TRADE_IN,this.onStoreTableBuyWithTradeInHandler);
        }

        override protected function onDispose() : void
        {
            storeTable.removeEventListener(StoreEvent.BUY,this.onStoreTableBuyHandler);
            storeTable.removeEventListener(StoreEvent.BUY_WITH_TRADE_IN,this.onStoreTableBuyWithTradeInHandler);
            super.onDispose();
        }

        override protected function getLinkageFromFittingType(param1:String) : String
        {
            if(param1 == STORE_CONSTANTS.VEHICLE || param1 == STORE_CONSTANTS.RESTORE_VEHICLE || param1 == STORE_CONSTANTS.TRADE_IN_VEHICLE)
            {
                return Linkages.SHOP_ACCORDION_VEHICLE_BUYING_VIEW;
            }
            return super.getLinkageFromFittingType(param1);
        }

        override public function getComponentForFocus() : InteractiveObject
        {
            return form;
        }

        override protected function get moduleItemRendererLinkage() : String
        {
            return Linkages.SHOP_MODULE_ITEM_RENDERER;
        }

        override protected function get vehicleItemRendererLinkage() : String
        {
            return Linkages.SHOP_VEHICLE_ITEM_RENDERER;
        }

        private function onStoreTableBuyWithTradeInHandler(param1:StoreEvent) : void
        {
            buyItemS(param1.itemCD,true);
            param1.stopImmediatePropagation();
        }

        private function onStoreTableBuyHandler(param1:StoreEvent) : void
        {
            buyItemS(param1.itemCD,false);
            param1.stopImmediatePropagation();
        }
    }
}
