package net.wg.gui.lobby.sessionStats
{
    import net.wg.gui.components.tooltips.inblocks.blocks.BaseTooltipBlock;
    import net.wg.gui.components.containers.GroupEx;

    public class SessionStatsParamsListBlock extends BaseTooltipBlock
    {

        public var list:GroupEx = null;

        public function SessionStatsParamsListBlock()
        {
            super();
            this.initLayout();
        }

        public function initLayout() : void
        {
        }

        override public function setBlockWidth(param1:int) : void
        {
        }

        override public function setBlockData(param1:Object) : void
        {
        }

        protected function applyData() : void
        {
        }

        override protected function onDispose() : void
        {
            this.list.dispose();
            this.list = null;
            super.onDispose();
        }
    }
}
