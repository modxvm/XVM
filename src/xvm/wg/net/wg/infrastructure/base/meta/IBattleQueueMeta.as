package net.wg.infrastructure.base.meta 
{
    import flash.events.*;
    
    public interface IBattleQueueMeta extends flash.events.IEventDispatcher
    {
        function startClickS():void;

        function exitClickS():void;

        function onEscapeS():void;

        function as_setTimer(arg1:String, arg2:String):void;

        function as_setType(arg1:Number):void;

        function as_setPlayers(arg1:String, arg2:Number):void;

        function as_setListByLevel(arg1:Object):void;

        function as_setListByType(arg1:Object):void;

        function as_showStart(arg1:Boolean):void;

        function as_showExit(arg1:Boolean):void;
    }
}
