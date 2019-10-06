package net.wg.gui.lobby.vehiclePreview.interfaces
{
    import net.wg.gui.interfaces.IUpdatableComponent;
    import net.wg.gui.lobby.vehiclePreview.data.VehPreviewBuyingPanelDataVO;
    import net.wg.gui.lobby.modulesPanel.interfaces.IModulesPanel;

    public interface IVehPreviewBottomPanel extends IUpdatableComponent
    {

        function updateBuyingPanel(param1:VehPreviewBuyingPanelDataVO) : void;

        function updateVehicleStatus(param1:String) : void;

        function get modules() : IModulesPanel;

        function get buyingPanel() : IVehPreviewBuyingPanel;
    }
}
