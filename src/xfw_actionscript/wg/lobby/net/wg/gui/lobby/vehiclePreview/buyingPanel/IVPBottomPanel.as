package net.wg.gui.lobby.vehiclePreview.buyingPanel
{
    import net.wg.infrastructure.interfaces.IMovieClip;
    import net.wg.gui.components.controls.SoundButtonEx;

    public interface IVPBottomPanel extends IMovieClip
    {

        function getBtn() : SoundButtonEx;

        function getTotalHeight() : Number;
    }
}
