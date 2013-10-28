package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   import net.wg.data.VO.StoreTableData;


   public interface IInventoryMeta extends IEventDispatcher
   {
          
      function sellItemS(param1:StoreTableData) : void;
   }

}