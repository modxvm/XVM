package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface ITickerMeta extends IEventDispatcher
   {
      
      function showBrowserS(param1:String) : void;
      
      function as_setItems(param1:Array) : void;
   }
}
