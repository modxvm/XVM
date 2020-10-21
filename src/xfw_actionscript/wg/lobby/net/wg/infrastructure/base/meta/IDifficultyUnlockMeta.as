package net.wg.infrastructure.base.meta
{
    import flash.events.IEventDispatcher;

    public interface IDifficultyUnlockMeta extends IEventDispatcher
    {

        function onCloseClickS() : void;

        function onDifficultyChangeClickS() : void;

        function as_setDifficulty(param1:int, param2:Boolean) : void;

        function as_blurOtherWindows(param1:int) : void;
    }
}
