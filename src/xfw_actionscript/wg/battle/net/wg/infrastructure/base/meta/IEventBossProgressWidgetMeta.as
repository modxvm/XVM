package net.wg.infrastructure.base.meta
{
    import flash.events.IEventDispatcher;

    public interface IEventBossProgressWidgetMeta extends IEventDispatcher
    {

        function as_setWidgetData(param1:Object) : void;

        function as_updateHp(param1:Number) : void;

        function as_updateKills(param1:Number) : void;

        function as_setHpRatio(param1:Number) : void;
    }
}
