package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;


   public interface IBattleResultsMeta extends IEventDispatcher
   {
          
      function saveSortingS(param1:String, param2:String, param3:int) : void;

      function showEventsWindowS(param1:String) : void;

      function getClanEmblemS(param1:String, param2:Number) : void;

      function as_setData(param1:Object) : void;

      function as_setClanEmblem(param1:String, param2:String) : void;
   }

}