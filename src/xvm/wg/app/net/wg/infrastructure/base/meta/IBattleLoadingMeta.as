package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;


   public interface IBattleLoadingMeta extends IEventDispatcher
   {
          
      function getDataS() : void;

      function as_setMapBG(param1:String) : void;

      function as_setProgress(param1:Number) : void;

      function as_setMapName(param1:String) : void;

      function as_setBattleTypeName(param1:String) : void;

      function as_setBattleTypeFrameNum(param1:Number) : void;

      function as_setBattleTypeFrameName(param1:String) : void;

      function as_setWinText(param1:String) : void;

      function as_setTeams(param1:String, param2:String) : void;

      function as_setTip(param1:String) : void;

      function as_setTeamValues(param1:Object) : void;
   }

}