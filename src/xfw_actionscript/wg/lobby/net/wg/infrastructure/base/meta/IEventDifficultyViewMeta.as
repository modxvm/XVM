package net.wg.infrastructure.base.meta
{
    import flash.events.IEventDispatcher;

    public interface IEventDifficultyViewMeta extends IEventDispatcher
    {

        function closeViewS() : void;

        function selectDifficultyS(param1:int) : void;

        function as_setData(param1:Object) : void;

        function as_setProgress(param1:int, param2:String, param3:int) : void;
    }
}
