package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IWaitingViewMeta extends IEventDispatcher
   {
      
      function show(param1:Object) : void;
      
      function hide(param1:Object) : void;
   }
}
