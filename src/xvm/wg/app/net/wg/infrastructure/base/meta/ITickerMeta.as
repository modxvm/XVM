package net.wg.infrastructure.base.meta 
{
    import flash.events.*;
    
    public interface ITickerMeta extends flash.events.IEventDispatcher
    {
        function showBrowserS(arg1:String):void;

        function as_setItems(arg1:Array):void;
    }
}
