package net.wg.infrastructure.base.meta 
{
    import flash.events.*;
    
    public interface IIntroPageMeta extends flash.events.IEventDispatcher
    {
        function stopVideoS():void;

        function handleErrorS(arg1:Object):void;

        function as_playVideo(arg1:Object):void;
    }
}
