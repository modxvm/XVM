package net.wg.infrastructure.base.meta
{
    import flash.events.IEventDispatcher;

    public interface IHangarHeaderMeta extends IEventDispatcher
    {

        function onQuestBtnClickS(param1:String, param2:String) : void;

        function as_setData(param1:Object) : void;

        function as_createBattlePass() : void;

        function as_removeBattlePass() : void;
    }
}
