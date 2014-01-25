package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;


   public interface IResearchMeta extends IEventDispatcher
   {
          
      function requestNationDataS() : Boolean;

      function getResearchItemsDataS(param1:Number, param2:Boolean) : Object;

      function onResearchItemsDrawnS() : void;

      function request4InstallS(param1:Number) : void;

      function requestModuleInfoS(param1:Number) : void;

      function goToTechTreeS(param1:String) : void;

      function exitFromResearchS() : void;

      function as_drawResearchItems(param1:String, param2:Number) : void;

      function as_setFreeXP(param1:Number) : void;

      function as_setInstalledItems(param1:Array) : void;

      function as_setWalletStatus(param1:Object) : void;
   }

}