package net.wg.gui.lobby.bob
{
    import flash.display.Sprite;
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import net.wg.gui.components.UnboundComponent;

    public class HangarComponentsContainer extends Sprite implements IDisposable
    {

        public var widget:UnboundComponent = null;

        public function HangarComponentsContainer()
        {
            super();
            this.widget = new UnboundComponent();
            addChild(this.widget);
        }

        public function dispose() : void
        {
            this.widget = null;
        }
    }
}
