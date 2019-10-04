package net.wg.infrastructure.base.meta
{
    import flash.events.IEventDispatcher;

    public interface IBCBattleResultTransitionMeta extends IEventDispatcher
    {

        function as_msgTypeHandler(param1:String) : void;

        function as_updateStage(param1:int, param2:int) : void;
    }
}
