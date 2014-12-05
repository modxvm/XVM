package net.wg.infrastructure.base.meta
{
    import flash.events.IEventDispatcher;
    
    public interface IChannelCarouselMeta extends IEventDispatcher
    {
        
        function channelOpenClickS(param1:Number) : void;
        
        function closeAllS() : void;
        
        function channelCloseClickS(param1:Number) : void;
        
        function as_getDataProvider() : Object;
        
        function as_getBattlesDataProvider() : Object;
    }
}
