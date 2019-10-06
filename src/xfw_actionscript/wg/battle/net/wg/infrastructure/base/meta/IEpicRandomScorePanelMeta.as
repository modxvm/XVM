package net.wg.infrastructure.base.meta
{
    import flash.events.IEventDispatcher;

    public interface IEpicRandomScorePanelMeta extends IEventDispatcher
    {

        function as_setTeamHealthPercentages(param1:int, param2:int) : void;
    }
}
