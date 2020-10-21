package net.wg.infrastructure.base.meta
{
    import flash.events.IEventDispatcher;

    public interface IBattleQueueMeta extends IEventDispatcher
    {

        function startClickS() : void;

        function as_setTypeInfo(param1:Object) : void;

        function as_setPlayers(param1:String) : void;

        function as_setDP(param1:Array) : void;

        function as_showStart(param1:Boolean) : void;
    }
}
