package net.wg.gui.bootcamp.battleResult.containers
{
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import net.wg.gui.bootcamp.controls.LoaderContainer;
    import net.wg.gui.bootcamp.battleResult.data.BattleItemRendrerVO;

    public class BattleMedalRenderer extends BattleItemRendererBase implements IDisposable
    {

        public var loaderContainer:LoaderContainer;

        public function BattleMedalRenderer()
        {
            super();
        }

        override protected function applyData(param1:BattleItemRendrerVO) : void
        {
            this.loaderContainer.source = param1.icon;
        }

        override protected function onDispose() : void
        {
            this.loaderContainer.dispose();
            this.loaderContainer = null;
            super.onDispose();
        }

        override protected function configUI() : void
        {
            super.configUI();
            this.loaderContainer.centered = true;
        }
    }
}
