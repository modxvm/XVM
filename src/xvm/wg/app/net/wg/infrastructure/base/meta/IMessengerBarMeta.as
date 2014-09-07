package net.wg.infrastructure.base.meta
{
    import flash.events.IEventDispatcher;
    
    public interface IMessengerBarMeta extends IEventDispatcher
    {
        
        function channelButtonClickS() : void;
        
        function contactsButtonClickS() : void;
        
        function as_setInitData(param1:Object) : void;
    }
}
