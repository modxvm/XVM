package net.wg.gui.lobby.fortifications.cmp.build
{
    import flash.events.IEventDispatcher;
    import net.wg.infrastructure.interfaces.IClosePopoverCallback;
    import net.wg.gui.lobby.fortifications.interfaces.ITransportModeClient;
    import net.wg.gui.lobby.fortifications.interfaces.IDirectionModeClient;
    import net.wg.gui.lobby.fortifications.interfaces.ICommonModeClient;
    
    public interface IFortBuildingUIBase extends IEventDispatcher, IClosePopoverCallback, ITransportModeClient, IDirectionModeClient, ICommonModeClient
    {
        
        function get exportArrow() : IArrowWithNut;
        
        function set exportArrow(param1:IArrowWithNut) : void;
        
        function get importArrow() : IArrowWithNut;
        
        function set importArrow(param1:IArrowWithNut) : void;
    }
}
