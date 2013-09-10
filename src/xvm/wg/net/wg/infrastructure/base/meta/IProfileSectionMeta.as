package net.wg.infrastructure.base.meta 
{
    import flash.events.*;
    
    public interface IProfileSectionMeta extends flash.events.IEventDispatcher
    {
        function setActiveS(arg1:Boolean):void;

        function requestDataS(arg1:Object):void;

        function as_update(arg1:Object):void;

        function as_setInitData(arg1:Object):void;
    }
}
