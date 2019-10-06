package net.wg.infrastructure.interfaces
{
    import flash.events.IEventDispatcher;
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import flash.display.DisplayObject;

    public interface ITriggerWatcher extends IEventDispatcher, IDisposable
    {

        function start(param1:DisplayObject) : void;

        function stop() : void;

        function get componentId() : String;

        function get type() : String;

        function get target() : DisplayObject;
    }
}
