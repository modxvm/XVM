package net.wg.infrastructure.base.meta 
{
    import flash.events.*;
    
    public interface IWindowViewMeta extends flash.events.IEventDispatcher
    {
        function onWindowCloseS():void;

        function onWindowMinimizeS():void;

        function as_showWaiting(arg1:String, arg2:Object):void;

        function as_hideWaiting():void;

        function as_getGeometry():Array;

        function as_setGeometry(arg1:Number, arg2:Number, arg3:Number, arg4:Number):void;
    }
}
