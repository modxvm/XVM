package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   import flash.events.Event;


   public interface ILobbyHeaderMeta extends IEventDispatcher
   {
          
      function menuItemClickS(param1:String) : void;

      function showLobbyMenuS() : void;

      function showExchangeWindowS(param1:Object) : void;

      function showExchangeXPWindowS(param1:Object) : void;

      function showPremiumDialogS(param1:Event) : void;

      function onPaymentS() : void;

      function getServersS() : Array;

      function reloginS(param1:int) : void;

      function as_setScreen(param1:String) : void;

      function as_setPeripheryChanging(param1:Boolean) : void;

      function as_creditsResponse(param1:String) : void;

      function as_goldResponse(param1:String) : void;

      function as_setWalletStatus(param1:Object) : void;

      function as_disableRoamingDD(param1:Boolean) : void;

      function as_setFreeXP(param1:String, param2:Boolean) : void;

      function as_nameResponse(param1:String, param2:String, param3:String, param4:Boolean, param5:Boolean) : void;

      function as_setClanEmblem(param1:String) : void;

      function as_setProfileType(param1:String) : void;

      function as_setPremiumParams(param1:String, param2:String, param3:Boolean) : void;

      function as_setServerStats(param1:Object) : void;

      function as_setServerInfo(param1:String, param2:String) : void;

      function as_premiumResponse(param1:Boolean) : void;

      function as_setTankName(param1:String) : void;

      function as_setTankType(param1:String) : void;

      function as_setTankElite(param1:Boolean) : void;

      function as_doDisableNavigation() : void;
   }

}