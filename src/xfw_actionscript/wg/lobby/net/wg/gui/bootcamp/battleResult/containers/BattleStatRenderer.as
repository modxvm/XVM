package net.wg.gui.bootcamp.battleResult.containers
{
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import net.wg.gui.bootcamp.battleResult.data.BattleItemRendrerVO;

    public class BattleStatRenderer extends BattleItemRendererBase implements IDisposable
    {

        public var statContent:StatRendererContent;

        public function BattleStatRenderer()
        {
            super();
        }

        override protected function applyData(param1:BattleItemRendrerVO) : void
        {
            this.statContent.setData(param1.icon,param1.value);
        }

        override protected function onDispose() : void
        {
            this.statContent.dispose();
            this.statContent = null;
            super.onDispose();
        }
    }
}
