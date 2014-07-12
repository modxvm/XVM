package net.wg.infrastructure.base.meta
{
    import flash.events.IEventDispatcher;
    
    public interface IBaseRallyMainWindowMeta extends IEventDispatcher
    {
        
        function onBackClickS() : void;
        
        function canGoBackS() : Boolean;
        
        function onBrowseRalliesS() : void;
        
        function onCreateRallyS() : void;
        
        function onJoinRallyS(param1:Number, param2:int, param3:Number) : void;
        
        function onAutoMatchS(param1:String, param2:Array) : void;
        
        function autoSearchApplyS(param1:String) : void;
        
        function autoSearchCancelS(param1:String) : void;
        
        function as_loadView(param1:String, param2:String) : void;
        
        function as_enableWndCloseBtn(param1:Boolean) : void;
        
        function as_autoSearchEnableBtn(param1:Boolean) : void;
        
        function as_changeAutoSearchState(param1:Object) : void;
        
        function as_hideAutoSearch() : void;
    }
}
