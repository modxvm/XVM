package net.wg.gui.lobby.vehiclePreview.interfaces
{
    import net.wg.infrastructure.interfaces.IViewStackContent;
    import net.wg.infrastructure.interfaces.IUIComponentEx;

    public interface IVehPreviewInfoPanelTab extends IViewStackContent, IUIComponentEx
    {

        function get bottomMargin() : int;
    }
}
