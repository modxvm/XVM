package net.wg.infrastructure.base.meta 
{
    import flash.events.*;
    
    public interface IQuestsControlMeta extends flash.events.IEventDispatcher
    {
        function showQuestsWindowS():void;

        function as_highlightControl():void;

        function as_resetControl():void;
    }
}
