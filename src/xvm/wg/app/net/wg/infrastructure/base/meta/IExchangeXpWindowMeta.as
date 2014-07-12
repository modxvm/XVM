package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IExchangeXpWindowMeta extends IEventDispatcher
   {
      
      function as_vehiclesDataChanged(param1:Boolean, param2:Array) : void;
      
      function as_totalExperienceChanged(param1:Number) : void;
      
      function as_setWalletStatus(param1:Object) : void;
   }
}
