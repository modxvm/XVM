package net.wg.infrastructure.base.meta 
{
    import flash.events.*;
    
    public interface IContainerManagerMeta extends flash.events.IEventDispatcher
    {
        function as_getView(arg1:String):Boolean;

        function as_show(arg1:String, arg2:int=0, arg3:int=0):Boolean;

        function as_hide(arg1:String):Boolean;

        function as_registerContainer(arg1:String, arg2:String):void;

        function as_unregisterContainer(arg1:String):void;

        function as_closePopUps():void;

        function as_isOnTop(arg1:String, arg2:String):Boolean;

        function as_bringToFront(arg1:String, arg2:String):void;
    }
}
