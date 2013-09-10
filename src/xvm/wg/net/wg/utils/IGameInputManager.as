package net.wg.utils 
{
    import flash.events.*;
    import net.wg.infrastructure.base.meta.*;
    import net.wg.infrastructure.interfaces.entity.*;
    
    public interface IGameInputManager extends net.wg.infrastructure.interfaces.entity.IDisposable, net.wg.infrastructure.base.meta.IGameInputManagerMeta
    {
        function initStage(arg1:flash.events.IEventDispatcher):void;

        function setKeyHandler(arg1:Number, arg2:String, arg3:Function, arg4:Boolean):void;

        function clearKeyHandlers():void;

        function clearKeyHandler(arg1:Number, arg2:String):void;

        function setIgnoredKeyCode(arg1:Number):void;
    }
}
