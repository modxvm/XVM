package net.wg.infrastructure.base.meta 
{
    import flash.events.*;
    
    public interface IMinimapLobbyMeta extends flash.events.IEventDispatcher
    {
        function setMapS(arg1:Number):void;

        function as_changeMap(arg1:String):void;

        function as_addPoint(arg1:Number, arg2:Number, arg3:String, arg4:String, arg5:String):void;

        function as_clear():void;
    }
}
