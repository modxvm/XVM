package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;


   public interface IHistoricalBattlesListWindowMeta extends IEventDispatcher
   {
          
      function onBattleSelectedS(param1:Number) : void;

      function onVehicleSelectedS(param1:Number) : void;

      function onPriceSelectedS(param1:Number) : void;

      function showFullDescriptionS() : void;

      function as_setCarouselData(param1:Array) : void;

      function as_setBattleData(param1:Object) : void;

      function as_setTeamsData(param1:Array, param2:Array) : void;

      function as_setStatusMessage(param1:String) : void;

      function as_selectBattle(param1:Number) : void;

      function as_selectVehicle(param1:Number) : void;

      function as_setPrices(param1:Array, param2:Number) : void;

      function as_setPriceInfo(param1:String) : void;

      function as_updateFightButton(param1:Boolean, param2:String, param3:String, param4:Boolean) : void;

      function as_setCarouselEnabled(param1:Boolean) : void;

      function as_setListEnabled(param1:Boolean) : void;

      function as_setPriceDDEnabled(param1:Boolean) : void;

      function as_setCloseBtnEnabled(param1:Boolean) : void;

      function as_setDate(param1:String, param2:String, param3:String) : void;

      function as_updateTimer(param1:String, param2:String) : void;
   }

}