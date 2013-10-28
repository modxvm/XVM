package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;


   public interface IBattleResultsMeta extends IEventDispatcher
   {
          
      function saveSortingS(param1:String, param2:String) : void;

      function showQuestsWindowS(param1:String) : void;

      function as_setData(param1:Object) : void;
   }

}