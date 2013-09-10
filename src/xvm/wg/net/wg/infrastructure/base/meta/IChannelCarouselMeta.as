package net.wg.infrastructure.base.meta 
{
    import flash.events.*;
    
    public interface IChannelCarouselMeta extends flash.events.IEventDispatcher
    {
        function channelOpenClickS(arg1:Number):void;

        function channelCloseClickS(arg1:Number):void;

        function as_getDataProvider():Object;
    }
}
