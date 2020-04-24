package net.wg.infrastructure.base.meta
{
    import flash.events.IEventDispatcher;

    public interface ITenYearsCountdownEntryPointMeta extends IEventDispatcher
    {

        function as_updateActivity(param1:Boolean) : void;

        function as_setAnimationEnabled(param1:Boolean) : void;
    }
}
