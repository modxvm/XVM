package net.wg.infrastructure.base.meta 
{
    import flash.events.*;
    
    public interface ILobbyHeaderMeta extends flash.events.IEventDispatcher
    {
        function menuItemClickS(arg1:String):void;

        function showLobbyMenuS():void;

        function showExchangeWindowS(arg1:Object):void;

        function showExchangeXPWindowS(arg1:Object):void;

        function showPremiumDialogS(arg1:flash.events.Event):void;

        function onPaymentS():void;

        function as_setScreen(arg1:String):void;

        function as_creditsResponse(arg1:String):void;

        function as_goldResponse(arg1:String):void;

        function as_setFreeXP(arg1:String):void;

        function as_nameResponse(arg1:String, arg2:Boolean, arg3:Boolean):void;

        function as_setClanEmblem(arg1:String):void;

        function as_setProfileType(arg1:String):void;

        function as_setPremiumParams(arg1:String, arg2:String, arg3:Boolean):void;

        function as_setServerStats(arg1:Object):void;

        function as_setServerInfo(arg1:String, arg2:String):void;

        function as_premiumResponse(arg1:Boolean):void;

        function as_setTankName(arg1:String):void;

        function as_setTankType(arg1:String):void;

        function as_setTankElite(arg1:Boolean):void;

        function as_doDisableNavigation():void;
    }
}
