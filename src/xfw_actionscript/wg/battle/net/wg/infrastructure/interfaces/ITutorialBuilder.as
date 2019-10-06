package net.wg.infrastructure.interfaces
{
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import flash.events.IEventDispatcher;
    import flash.display.DisplayObject;

    public interface ITutorialBuilder extends IDisposable, IEventDispatcher
    {

        function updateData(param1:Object) : void;

        function stopEffect() : void;

        function setView(param1:IView) : void;

        function set component(param1:DisplayObject) : void;
    }
}
