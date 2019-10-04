package net.wg.gui.lobby.vehiclePreview.interfaces
{
    import net.wg.gui.interfaces.IUpdatableComponent;
    import scaleform.clik.data.DataProvider;

    public interface IVehPreviewInfoPanel extends IUpdatableComponent
    {

        function updateTabButtonsData(param1:DataProvider) : void;
    }
}
