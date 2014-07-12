package net.wg.gui.lobby.store.shop
{
   import net.wg.infrastructure.base.meta.impl.ShopMeta;
   import net.wg.infrastructure.base.meta.IShopMeta;
   import net.wg.infrastructure.interfaces.IStoreMenuView;
   import net.wg.data.constants.Linkages;
   import net.wg.gui.lobby.store.StoreEvent;
   
   public class Shop extends ShopMeta implements IShopMeta
   {
      
      public function Shop() {
         super();
      }
      
      override protected function onViewNeedUpdate(param1:IStoreMenuView, param2:String) : void {
         super.onViewNeedUpdate(param1,param2);
         if(!initializing)
         {
            param1.setSubFilterData(nation,subFilterData);
         }
         param1.update(getViewData(param2));
         form.storeTable.updateHeaderCountTitle(MENU.shop_table_header_count(param1.fittingType));
      }
      
      override protected function getLocalizator() : Function {
         return MENU.shop_menu;
      }
      
      override protected function onPopulate() : void {
         super.onPopulate();
         form.storeTable.setModuleRendererLinkage(Linkages.SHOP_MODULE_ITEM_RENDERER);
         form.storeTable.setVehicleRendererLinkage(Linkages.SHOP_VEHICLE_ITEM_RENDERER);
         form.storeTable.addEventListener(StoreEvent.BUY,this.onBuyItemHandler);
      }
      
      override protected function onDispose() : void {
         super.onDispose();
         form.storeTable.removeEventListener(StoreEvent.SELL,this.onBuyItemHandler);
      }
      
      override protected function onMenuChangeType() : void {
         var _loc1_:IStoreMenuView = null;
         if(!initializing)
         {
            _loc1_ = getCurrentView();
            assertNotNull(_loc1_,"currentView");
            _loc1_.setSubFilterData(form.nationFilter.nation.selectedIndex - 1,subFilterData);
         }
         super.onMenuChangeType();
      }
      
      override protected function onMenuChange() : void {
         if(!initializing)
         {
            updateTable();
         }
         super.onMenuChange();
      }
      
      private function onBuyItemHandler(param1:StoreEvent) : void {
         buyItemS(param1.data);
         param1.stopImmediatePropagation();
      }
   }
}
