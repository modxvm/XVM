package net.wg.infrastructure.base.meta
{
    import flash.events.IEventDispatcher;
    
    public interface IFortBattleRoomWindowMeta extends IEventDispatcher
    {
        
        function onBrowseClanBattlesS() : void;
        
        function onJoinClanBattleS(param1:Number, param2:int, param3:Number) : void;
        
        function onCreatedBattleRoomS(param1:Number, param2:Number) : void;
    }
}
