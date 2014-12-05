package net.wg.infrastructure.base.meta
{
    import flash.events.IEventDispatcher;
    
    public interface IQuestsWindowMeta extends IEventDispatcher
    {
        
        function onTabSelectedS(param1:String) : void;
        
        function as_loadView(param1:String, param2:String) : void;
        
        function as_selectTab(param1:String) : void;
    }
}
