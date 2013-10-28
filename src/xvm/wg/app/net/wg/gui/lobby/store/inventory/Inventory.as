package net.wg.gui.lobby.store.inventory
{
   import net.wg.infrastructure.base.meta.impl.InventoryMeta;
   import net.wg.infrastructure.base.meta.IInventoryMeta;
   import net.wg.data.constants.Linkages;
   import net.wg.gui.lobby.store.StoreEvent;
   import net.wg.infrastructure.interfaces.IStoreMenuView;


   public class Inventory extends InventoryMeta implements IInventoryMeta
   {
          
      public function Inventory() {
         super();
      }

      override protected function onPopulate() : void {
         super.onPopulate();
         storeTable.setModuleRendererLinkage(Linkages.INVENTORY_MODULE_ITEM_RENDERER);
         storeTable.setVehicleRendererLinkage(Linkages.INVENTORY_VEHICLE_ITEM_RENDERER);
         storeTable.addEventListener(StoreEvent.SELL,this.onSellItemHandler);
      }

      override protected function onDispose() : void {
         super.onDispose();
         storeTable.removeEventListener(StoreEvent.SELL,this.onSellItemHandler);
      }

      override protected function onMenuChangeType() : void {
         var _loc1_:IStoreMenuView = null;
         if(!initializing)
         {
            _loc1_ = getCurrentView();
            assertNotNull(_loc1_,"currentView");
            _loc1_.setSubFilterData(nationFilter.nation.selectedIndex-1,subFilterData);
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

      override protected function getLocalizator() : Function {
         return MENU.inventory_menu;
      }

      override protected function onViewNeedUpdate(param1:IStoreMenuView, param2:String) : void {
         super.onViewNeedUpdate(param1,param2);
         if(!initializing)
         {
            param1.setSubFilterData(nation,subFilterData);
         }
         param1.update(getViewData(param2));
         storeTable.updateHeaderCountTitle(MENU.shop_table_header_count(param1.fittingType));
      }

      private function onSellItemHandler(param1:StoreEvent) : void {
         sellItemS(param1.data);
         param1.stopImmediatePropagation();
      }
   }

}