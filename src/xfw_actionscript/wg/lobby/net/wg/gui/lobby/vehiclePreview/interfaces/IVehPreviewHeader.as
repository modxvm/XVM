package net.wg.gui.lobby.vehiclePreview.interfaces
{
    import net.wg.gui.interfaces.IUpdatableComponent;
    import net.wg.gui.components.advanced.interfaces.IBackButton;
    import net.wg.gui.interfaces.ISoundButtonEx;

    public interface IVehPreviewHeader extends IUpdatableComponent
    {

        function get backBtn() : IBackButton;

        function get closeBtn() : ISoundButtonEx;
    }
}
