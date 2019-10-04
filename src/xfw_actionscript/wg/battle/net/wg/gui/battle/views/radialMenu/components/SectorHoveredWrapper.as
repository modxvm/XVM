package net.wg.gui.battle.views.radialMenu.components
{
    import flash.display.Sprite;
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import net.wg.gui.battle.components.BattleAtlasSprite;
    import net.wg.data.constants.generated.BATTLEATLAS;

    public class SectorHoveredWrapper extends Sprite implements IDisposable
    {

        public var content:Content = null;

        public var light:BattleAtlasSprite = null;

        public function SectorHoveredWrapper()
        {
            super();
            this.light.imageName = BATTLEATLAS.RADIAL_MENU_LIGHT;
        }

        public function dispose() : void
        {
            this.content.dispose();
            this.content = null;
            this.light = null;
        }
    }
}
