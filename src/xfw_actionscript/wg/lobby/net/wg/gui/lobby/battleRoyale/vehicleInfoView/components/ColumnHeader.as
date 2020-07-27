package net.wg.gui.lobby.battleRoyale.vehicleInfoView.components
{
    import net.wg.gui.components.battleRoyale.ColumnHeader;
    import flash.display.BlendMode;

    public class ColumnHeader extends net.wg.gui.components.battleRoyale.ColumnHeader
    {

        public function ColumnHeader()
        {
            super();
            this.blendMode = BlendMode.LAYER;
            label.blendMode = BlendMode.ERASE;
        }

        override protected function updateEnabled() : void
        {
        }
    }
}
