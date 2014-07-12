package net.wg.infrastructure.base.meta.impl
{
   import net.wg.gui.lobby.store.Store;
   import net.wg.data.VO.StoreTableData;
   import net.wg.data.constants.Errors;
   
   public class ShopMeta extends Store
   {
      
      public function ShopMeta() {
         super();
      }
      
      public var buyItem:Function = null;
      
      public function buyItemS(param1:StoreTableData) : void {
         App.utils.asserter.assertNotNull(this.buyItem,"buyItem" + Errors.CANT_NULL);
         this.buyItem(param1);
      }
   }
}
