package net.wg.gui.lobby.fortifications.cmp.build
{
    import net.wg.infrastructure.interfaces.IDAAPIModule;
    import net.wg.infrastructure.base.meta.IFortBuildingComponentMeta;
    import net.wg.infrastructure.interfaces.IDAAPIComponent;
    import net.wg.gui.lobby.fortifications.interfaces.ITransportingHandler;
    import net.wg.infrastructure.interfaces.IUIComponentEx;
    import net.wg.gui.lobby.fortifications.interfaces.ICommonModeClient;
    import net.wg.gui.lobby.fortifications.interfaces.ITransportModeClient;
    import net.wg.gui.lobby.fortifications.interfaces.IDirectionModeClient;
    
    public interface IFortBuildingCmp extends IDAAPIModule, IFortBuildingComponentMeta, IDAAPIComponent, ITransportingHandler, IUIComponentEx, ICommonModeClient, ITransportModeClient, IDirectionModeClient
    {
        
        function updateControlPositions() : void;
        
        function get buildingContainer() : IFortBuildingsContainer;
        
        function set buildingContainer(param1:IFortBuildingsContainer) : void;
    }
}
