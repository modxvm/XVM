package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;


   public interface ICrewMeta extends IEventDispatcher
   {
          
      function onShowRecruitWindowClickS(param1:Object, param2:Boolean) : void;

      function unloadTankmanS(param1:String) : void;

      function unloadAllTankmanS() : void;

      function equipTankmanS(param1:String, param2:Number) : void;

      function openPersonalCaseS(param1:String, param2:uint) : void;

      function updateTankmenS() : void;

      function as_tankmenResponse(param1:Array, param2:Array) : void;
   }

}