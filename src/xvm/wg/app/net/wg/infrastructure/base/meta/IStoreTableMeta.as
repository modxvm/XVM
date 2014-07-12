package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IStoreTableMeta extends IEventDispatcher
   {
      
      function refreshStoreTableDataProviderS() : void;
      
      function as_getTableDataProvider() : Object;
      
      function as_setTableType(param1:String) : void;
      
      function as_scrollToFirst(param1:Number, param2:String, param3:String) : void;
      
      function as_setGold(param1:Number) : void;
      
      function as_setCredits(param1:Number) : void;
   }
}
