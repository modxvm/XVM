package net.wg.infrastructure.base.meta.impl
{
   import net.wg.gui.lobby.store.Store;
   import net.wg.data.VO.StoreTableData;
   import net.wg.data.constants.Errors;
   
   public class InventoryMeta extends Store
   {
      
      public function InventoryMeta() {
         super();
      }
      
      public var sellItem:Function = null;
      
      public function sellItemS(param1:StoreTableData) : void {
         App.utils.asserter.assertNotNull(this.sellItem,"sellItem" + Errors.CANT_NULL);
         this.sellItem(param1);
      }
   }
}
