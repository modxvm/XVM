package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;


   public interface IBattleLoadingMeta extends IEventDispatcher
   {
          
      function as_setMapBG(param1:String) : void;

      function as_setProgress(param1:Number) : void;

      function as_setMapName(param1:String) : void;

      function as_setBattleTypeName(param1:String) : void;

      function as_setBattleTypeFrameNum(param1:Number) : void;

      function as_setBattleTypeFrameName(param1:String) : void;

      function as_setWinText(param1:String) : void;

      function as_setTeams(param1:String, param2:String) : void;

      function as_setTip(param1:String) : void;

      function as_setTipTitle(param1:String) : void;

      function as_setPlayerData(param1:Number, param2:Number) : void;

      function as_setVehiclesData(param1:Boolean, param2:Array) : void;

      function as_addVehicleInfo(param1:Boolean, param2:Object, param3:Array) : void;

      function as_updateVehicleInfo(param1:Boolean, param2:Object, param3:Array) : void;

      function as_setVehicleStatus(param1:Boolean, param2:Number, param3:uint, param4:Array) : void;

      function as_setPlayerStatus(param1:Boolean, param2:Number, param3:uint) : void;
   }

}