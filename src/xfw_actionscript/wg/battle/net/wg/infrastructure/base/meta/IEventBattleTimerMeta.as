package net.wg.infrastructure.base.meta
{
    import flash.events.IEventDispatcher;

    public interface IEventBattleTimerMeta extends IEventDispatcher
    {

        function as_showAddExtraTime(param1:String, param2:Boolean) : void;

        function as_setIsEnlarged(param1:Boolean) : void;
    }
}
