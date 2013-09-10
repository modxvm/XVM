package net.wg.infrastructure.base.meta 
{
    import flash.events.*;
    
    public interface IProfileMeta extends flash.events.IEventDispatcher
    {
        function onCloseProfileS():void;

        function as_update(arg1:Object):void;
    }
}
