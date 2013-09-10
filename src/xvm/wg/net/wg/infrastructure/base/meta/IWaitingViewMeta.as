package net.wg.infrastructure.base.meta 
{
    import flash.events.*;
    
    public interface IWaitingViewMeta extends flash.events.IEventDispatcher
    {
        function show(arg1:Object):void;

        function hide(arg1:Object):void;
    }
}
