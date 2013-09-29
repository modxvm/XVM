package net.wg.infrastructure.base.meta 
{
    import flash.events.*;
    
    public interface IBrowserMeta extends flash.events.IEventDispatcher
    {
        function browserActionS(arg1:String):void;

        function browserMoveS(arg1:int, arg2:int, arg3:int):void;

        function browserDownS(arg1:int, arg2:int, arg3:int):void;

        function browserUpS(arg1:int, arg2:int, arg3:int):void;

        function browserFocusOutS():void;

        function onBrowserShowS(arg1:Boolean):void;

        function onBrowserHideS():void;

        function as_loadingStart():void;

        function as_loadingStop():void;
    }
}
