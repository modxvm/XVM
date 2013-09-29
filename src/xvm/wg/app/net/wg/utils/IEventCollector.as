package net.wg.utils 
{
    import flash.display.*;
    import flash.events.*;
    import net.wg.infrastructure.interfaces.*;
    import net.wg.infrastructure.interfaces.entity.*;
    
    public interface IEventCollector extends net.wg.infrastructure.interfaces.entity.IDisposable
    {
        function setEnabled(arg1:Boolean):void;

        function addEvent(arg1:flash.events.IEventDispatcher, arg2:String, arg3:Function, arg4:Boolean=false, arg5:int=0, arg6:Boolean=false):void;

        function removeEvent(arg1:Object, arg2:String, arg3:Function, arg4:Boolean=false):void;

        function removeAllEvents():void;

        function removeModuleEvents(arg1:net.wg.infrastructure.interfaces.IDAAPIModule):void;

        function removeObjectEvents(arg1:Object, arg2:Boolean=true):void;

        function enableDisposingForObj(arg1:flash.display.DisplayObject):void;

        function disableDisposingForObj(arg1:flash.display.DisplayObject):void;

        function hasRegisteredEvent(arg1:Object, arg2:String, arg3:Function, arg4:Boolean):Boolean;

        function objectIsRegistered(arg1:Object):Boolean;

        function logState():void;
    }
}
