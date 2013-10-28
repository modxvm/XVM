package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   import net.wg.data.VO.StoreTableData;


   public interface IShopMeta extends IEventDispatcher
   {
          
      function buyItemS(param1:StoreTableData) : void;
   }

}