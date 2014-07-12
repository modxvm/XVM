package net.wg.gui.prebattle.meta
{
    import flash.events.IEventDispatcher;
    
    public interface ICompaniesWindowMeta extends IEventDispatcher
    {
        
        function createCompanyS() : void;
        
        function joinCompanyS(param1:uint) : void;
        
        function getDivisionsListS() : Array;
        
        function refreshCompaniesListS(param1:String, param2:Boolean, param3:uint) : void;
        
        function requestPlayersListS(param1:uint) : void;
        
        function showFAQWindowS() : void;
        
        function getClientIDS() : Number;
        
        function as_getCompaniesListDP() : Object;
        
        function as_showPlayersList(param1:uint) : void;
        
        function as_setDefaultFilter(param1:String, param2:Boolean, param3:uint) : void;
        
        function as_setRefreshCoolDown(param1:Number) : void;
        
        function as_disableCreateButton(param1:Boolean) : void;
    }
}
