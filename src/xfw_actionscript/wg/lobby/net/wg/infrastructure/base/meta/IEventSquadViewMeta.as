package net.wg.infrastructure.base.meta
{
    import flash.events.IEventDispatcher;

    public interface IEventSquadViewMeta extends IEventDispatcher
    {

        function selectDifficultyS(param1:int) : void;

        function as_updateDifficulty(param1:Object) : void;

        function as_enableDifficultyDropdown(param1:Boolean) : void;
    }
}
