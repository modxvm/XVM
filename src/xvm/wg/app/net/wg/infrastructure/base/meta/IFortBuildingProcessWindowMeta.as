package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;


   public interface IFortBuildingProcessWindowMeta extends IEventDispatcher
   {
          
      function requestBuildingInfoS(param1:String) : void;

      function applyBuildingProcessS(param1:String) : void;

      function as_setData(param1:Object) : void;

      function as_responseBuildingInfo(param1:Object) : void;
   }

}