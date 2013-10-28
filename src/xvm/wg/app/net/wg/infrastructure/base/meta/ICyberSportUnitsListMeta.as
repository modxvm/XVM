package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;


   public interface ICyberSportUnitsListMeta extends IEventDispatcher
   {
          
      function getTeamDataS(param1:Number) : void;

      function refreshTeamsS() : void;

      function filterVehiclesS() : void;

      function loadPreviousS() : void;

      function loadNextS() : void;

      function as_appendTeamsData(param1:Array) : void;

      function as_setTeamsData(param1:Array, param2:Number) : void;

      function as_setSelectedUnit(param1:Object) : void;

      function as_clearSelectedUnit() : void;

      function as_setSearchResultText(param1:String) : void;

      function as_setSelectedVehiclesInfo(param1:String, param2:int) : void;

      function as_setRefreshCoolDown(param1:Number) : void;

      function as_selectUnitInList(param1:Number) : void;
   }

}