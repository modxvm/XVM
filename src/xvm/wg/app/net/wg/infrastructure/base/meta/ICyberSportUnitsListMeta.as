package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;


   public interface ICyberSportUnitsListMeta extends IEventDispatcher
   {
          
      function getTeamDataS(param1:int) : Object;

      function refreshTeamsS() : void;

      function filterVehiclesS() : void;

      function loadPreviousS() : void;

      function loadNextS() : void;

      function as_setSelectedUnitIdx(param1:int) : void;

      function as_setSearchResultText(param1:String) : void;

      function as_setSelectedVehiclesInfo(param1:String, param2:int) : void;

      function as_setRefreshCoolDown(param1:Number) : void;

      function as_selectUnitInList(param1:Number) : void;

      function as_updateNavigationBlock(param1:Object) : void;

      function as_getSearchDP() : Object;
   }

}