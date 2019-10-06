package net.wg.infrastructure.base.meta
{
    import flash.events.IEventDispatcher;

    public interface IStoreActionsViewMeta extends IEventDispatcher
    {

        function actionSelectS(param1:String) : void;

        function onBattleTaskSelectS(param1:String) : void;

        function onActionSeenS(param1:String) : void;

        function as_setData(param1:Object) : void;

        function as_actionTimeUpdate(param1:Array) : void;
    }
}
