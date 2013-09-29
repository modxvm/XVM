package net.wg.infrastructure.base.meta 
{
    import flash.events.*;
    
    public interface IEULAMeta extends flash.events.IEventDispatcher
    {
        function requestEULATextS():void;

        function onLinkClickS(arg1:String):void;

        function onApplyS():void;

        function as_setEULAText(arg1:String):void;
    }
}
