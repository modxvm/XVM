package net.wg.infrastructure.base.meta
{
    import flash.events.IEventDispatcher;
    
    public interface IFortBattleDirectionPopoverMeta extends IEventDispatcher
    {
        
        function requestToJoinS(param1:int) : void;
        
        function as_setData(param1:Object) : void;
    }
}
