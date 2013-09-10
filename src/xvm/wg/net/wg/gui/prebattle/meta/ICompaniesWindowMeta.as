package net.wg.gui.prebattle.meta 
{
    import flash.events.*;
    
    public interface ICompaniesWindowMeta extends flash.events.IEventDispatcher
    {
        function createCompanyS():void;

        function joinCompanyS(arg1:uint):void;

        function getDivisionsListS():Array;

        function refreshCompaniesListS(arg1:String, arg2:Boolean, arg3:uint):void;

        function requestPlayersListS(arg1:uint):void;

        function showFAQWindowS():void;

        function getClientIDS():Number;

        function as_getCompaniesListDP():Object;

        function as_showPlayersList(arg1:uint):void;

        function as_setDefaultFilter(arg1:String, arg2:Boolean, arg3:uint):void;

        function as_setRefreshCoolDown(arg1:Number):void;

        function as_disableCreateButton(arg1:Boolean):void;
    }
}
