package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   import net.wg.data.VO.StoreTableData;
   
   public interface IStoreMeta extends IEventDispatcher
   {
      
      function requestTableDataS(param1:Number, param2:String, param3:Array) : void;
      
      function requestFilterDataS(param1:String) : void;
      
      function onCloseButtonClickS() : void;
      
      function onShowInfoS(param1:StoreTableData) : void;
      
      function getNameS() : String;
      
      function as_setNations(param1:Array) : void;
      
      function as_completeInit() : void;
      
      function as_update() : void;
      
      function as_setFilterType(param1:Object) : void;
      
      function as_setSubFilter(param1:Object) : void;
      
      function as_setFilterOptions(param1:Array) : void;
   }
}
