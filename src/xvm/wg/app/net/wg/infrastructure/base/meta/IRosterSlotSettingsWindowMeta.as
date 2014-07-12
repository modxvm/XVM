package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IRosterSlotSettingsWindowMeta extends IEventDispatcher
   {
      
      function onFiltersUpdateS(param1:int, param2:String, param3:Boolean, param4:int, param5:Boolean) : void;
      
      function getFilterDataS() : Object;
      
      function submitButtonHandlerS(param1:Object) : void;
      
      function cancelButtonHandlerS() : void;
      
      function as_setDefaultData(param1:Array) : void;
      
      function as_setListData(param1:Array) : void;
   }
}
