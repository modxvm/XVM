package net.wg.infrastructure.managers
{
    import flash.events.*;
    import net.wg.infrastructure.base.meta.*;
    import net.wg.infrastructure.interfaces.*;

    public interface IContainerManager extends flash.events.IEventDispatcher
    {
        function get loader():net.wg.infrastructure.base.meta.ILoaderManagerMeta;

        function set loader(arg1:net.wg.infrastructure.base.meta.ILoaderManagerMeta):void;

        function registerContainer(arg1:net.wg.infrastructure.interfaces.IManagedContainer):void;

        function updateStage(arg1:Number, arg2:Number):void;

        function get lastFocusedView():net.wg.infrastructure.interfaces.IView;

        function set lastFocusedView(arg1:net.wg.infrastructure.interfaces.IView):void;
    }
}
