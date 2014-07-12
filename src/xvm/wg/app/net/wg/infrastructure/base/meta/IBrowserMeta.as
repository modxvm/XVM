package net.wg.infrastructure.base.meta
{
    import flash.events.IEventDispatcher;
    
    public interface IBrowserMeta extends IEventDispatcher
    {
        
        function browserActionS(param1:String) : void;
        
        function browserMoveS(param1:int, param2:int, param3:int) : void;
        
        function browserDownS(param1:int, param2:int, param3:int) : void;
        
        function browserUpS(param1:int, param2:int, param3:int) : void;
        
        function browserFocusOutS() : void;
        
        function onBrowserShowS(param1:Boolean) : void;
        
        function onBrowserHideS() : void;
        
        function as_loadingStart() : void;
        
        function as_loadingStop() : void;
        
        function as_configure(param1:String, param2:Boolean) : void;
    }
}
