package net.wg.infrastructure.base.meta
{
    import flash.events.IEventDispatcher;
    
    public interface ILobbyHeaderMeta extends IEventDispatcher
    {
        
        function menuItemClickS(param1:String) : void;
        
        function showLobbyMenuS() : void;
        
        function showExchangeWindowS() : void;
        
        function showExchangeXPWindowS() : void;
        
        function showPremiumDialogS() : void;
        
        function onPaymentS() : void;
        
        function showSquadS() : void;
        
        function fightClickS(param1:Number, param2:String) : void;
        
        function as_setScreen(param1:String) : void;
        
        function as_creditsResponse(param1:String) : void;
        
        function as_goldResponse(param1:String) : void;
        
        function as_doDisableNavigation() : void;
        
        function as_doDisableHeaderButton(param1:String, param2:Boolean) : void;
        
        function as_updateSquad(param1:Boolean) : void;
        
        function as_nameResponse(param1:String, param2:String, param3:String, param4:Boolean, param5:Boolean) : void;
        
        function as_setClanEmblem(param1:String) : void;
        
        function as_setPremiumParams(param1:Boolean, param2:String, param3:String, param4:Boolean) : void;
        
        function as_updateBattleType(param1:String, param2:String, param3:Boolean) : void;
        
        function as_setWalletStatus(param1:Object) : void;
        
        function as_setFreeXP(param1:String, param2:Boolean) : void;
        
        function as_highlightTutorialControls(param1:String) : void;
        
        function as_resetHighlightTutorialControls() : void;
        
        function as_disableFightButton(param1:Boolean, param2:String) : void;
        
        function as_setFightButton(param1:String) : void;
        
        function as_setCoolDownForReady(param1:uint) : void;
    }
}
