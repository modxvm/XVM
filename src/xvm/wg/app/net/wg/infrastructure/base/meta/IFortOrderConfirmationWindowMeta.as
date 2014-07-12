package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IFortOrderConfirmationWindowMeta extends IEventDispatcher
   {
      
      function submitS(param1:Number) : void;
      
      function getTimeStrS(param1:Number) : String;
      
      function as_setData(param1:Object) : void;
      
      function as_setSettings(param1:Object) : void;
   }
}
