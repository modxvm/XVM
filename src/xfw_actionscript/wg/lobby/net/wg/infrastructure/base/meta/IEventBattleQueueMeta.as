package net.wg.infrastructure.base.meta
{
    import flash.events.IEventDispatcher;

    public interface IEventBattleQueueMeta extends IEventDispatcher
    {

        function moveSpaceS(param1:Number, param2:Number, param3:Number) : void;

        function notifyCursorOver3dSceneS(param1:Boolean) : void;

        function notifyCursorDraggingS(param1:Boolean) : void;

        function as_setSubdivisionName(param1:String) : void;
    }
}
