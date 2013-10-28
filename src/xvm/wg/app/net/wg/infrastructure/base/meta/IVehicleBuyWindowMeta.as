package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;


   public interface IVehicleBuyWindowMeta extends IEventDispatcher
   {
          
      function submitS(param1:Object) : void;

      function storeSettingsS(param1:Boolean) : void;

      function as_setGold(param1:Number) : void;

      function as_setCredits(param1:Number) : void;

      function as_setInitData(param1:Object) : void;
   }

}