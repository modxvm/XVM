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
    import net.wg.gui.lobby.fortifications.cmp.drctn.IFortDirectionsContainer;
    import net.wg.gui.lobby.profile.components.SimpleLoader;
    
    public interface IFortBuildingCmp extends IDAAPIModule, IFortBuildingComponentMeta, IDAAPIComponent, ITransportingHandler, IUIComponentEx, ICommonModeClient, ITransportModeClient, IDirectionModeClient
    {
        
        function updateControlPositions() : void;
        
        function get buildingContainer() : IFortBuildingsContainer;
        
        function set buildingContainer(param1:IFortBuildingsContainer) : void;
        
        function get directionsContainer() : IFortDirectionsContainer;
        
        function set directionsContainer(param1:IFortDirectionsContainer) : void;
        
        function get landscapeBG() : SimpleLoader;
        
        function set landscapeBG(param1:SimpleLoader) : void;
    }
}
