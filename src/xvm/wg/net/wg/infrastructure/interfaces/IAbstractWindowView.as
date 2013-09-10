package net.wg.infrastructure.interfaces 
{
    import net.wg.infrastructure.base.meta.*;
    
    public interface IAbstractWindowView extends net.wg.infrastructure.base.meta.IWindowViewMeta, net.wg.infrastructure.interfaces.IView
    {
        function handleWindowMinimize():void;

        function get canDrag():Boolean;

        function get showWindowBg():Boolean;

        function get canMinimize():Boolean;

        function get canResize():Boolean;

        function get canClose():Boolean;

        function get enabledCloseBtn():Boolean;

        function get isCentered():Boolean;

        function get isModal():Boolean;

        function get window():net.wg.infrastructure.interfaces.IWindow;

        function set window(arg1:net.wg.infrastructure.interfaces.IWindow):void;

        function get geometry():net.wg.infrastructure.interfaces.IWindowGeometry;
    }
}
