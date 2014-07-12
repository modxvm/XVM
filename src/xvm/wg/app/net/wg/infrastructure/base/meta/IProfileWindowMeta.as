package net.wg.infrastructure.base.meta
{
    import flash.events.IEventDispatcher;
    
    public interface IProfileWindowMeta extends IEventDispatcher
    {
        
        function userAddFriendS() : void;
        
        function userSetIgnoredS() : void;
        
        function userCreatePrivateChannelS() : void;
        
        function as_setInitData(param1:Object) : void;
        
        function as_update(param1:Object) : void;
        
        function as_addFriendAvailable(param1:Boolean) : void;
        
        function as_setIgnoredAvailable(param1:Boolean) : void;
        
        function as_setCreateChannelAvailable(param1:Boolean) : void;
    }
}
