package net.wg.infrastructure.base.meta 
{
    import flash.events.*;
    
    public interface ITutorialControlMeta extends flash.events.IEventDispatcher
    {
        function restartS():void;

        function refuseS():void;

        function as_setup(arg1:Object):void;

        function as_setPlayerXPLevel(arg1:int):void;

        function as_setChapterInfo(arg1:String, arg2:String):void;

        function as_clearChapterInfo():void;

        function as_setRunMode():void;

        function as_setRestartMode():void;

        function as_setDisabled(arg1:Boolean):void;
    }
}
