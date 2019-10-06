package net.wg.utils
{
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import net.wg.infrastructure.base.meta.IGameInputManagerMeta;
    import flash.events.IEventDispatcher;

    public interface IGameInputManager extends IDisposable, IGameInputManagerMeta
    {

        function initStage(param1:IEventDispatcher) : void;

        function setKeyHandler(param1:Number, param2:String, param3:Function, param4:Boolean, param5:String = null, param6:Number = 0) : void;

        function clearKeyHandlers() : void;

        function clearKeyHandler(param1:Number, param2:String, param3:Function) : void;

        function setIgnoredKeyCode(param1:Number) : void;
    }
}
