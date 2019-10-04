package net.wg.gui.lobby.vehiclePreview.interfaces
{
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import net.wg.infrastructure.interfaces.IUIComponentEx;
    import net.wg.gui.lobby.vehiclePreview.data.VehPreviewBuyingPanelDataVO;
    import net.wg.gui.interfaces.ISoundButtonEx;
    import net.wg.gui.components.controls.IconTextBigButton;
    import net.wg.gui.data.VehCompareEntrypointVO;

    public interface IVehPreviewBuyingPanel extends IDisposable, IUIComponentEx
    {

        function updateData(param1:VehPreviewBuyingPanelDataVO) : void;

        function get buyBtn() : ISoundButtonEx;

        function get addToCompareBtn() : IconTextBigButton;

        function update(param1:VehCompareEntrypointVO, param2:String, param3:Boolean) : void;
    }
}
