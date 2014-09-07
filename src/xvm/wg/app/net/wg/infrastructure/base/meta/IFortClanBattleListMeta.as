package net.wg.infrastructure.base.meta
{
    import flash.events.IEventDispatcher;
    
    public interface IFortClanBattleListMeta extends IEventDispatcher
    {
        
        function as_setClanBattleData(param1:Object) : void;
        
        function as_upateClanBattlesCount(param1:String) : void;
    }
}
