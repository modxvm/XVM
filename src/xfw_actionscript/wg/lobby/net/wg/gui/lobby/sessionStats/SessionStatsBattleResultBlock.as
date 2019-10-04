package net.wg.gui.lobby.sessionStats
{
    import net.wg.gui.lobby.sessionStats.data.SessionBattleStatsViewVO;
    import net.wg.gui.components.common.containers.TiledLayout;
    import net.wg.data.constants.generated.TEXT_ALIGN;
    import net.wg.data.constants.Linkages;

    public class SessionStatsBattleResultBlock extends SessionStatsParamsListBlock
    {

        private var _dataVO:SessionBattleStatsViewVO = null;

        public function SessionStatsBattleResultBlock()
        {
            super();
        }

        override public function initLayout() : void
        {
            var _loc1_:TiledLayout = new TiledLayout(SessionBattleStatsView.TILE_WIDTH,SessionBattleStatsView.TILE_HEIGHT,SessionBattleStatsView.TILE_COLS,TEXT_ALIGN.LEFT);
            _loc1_.gap = SessionBattleStatsView.TILE_GAP;
            list.layout = _loc1_;
            list.itemRendererLinkage = Linkages.SESSION_LAST_BATTLE_STATS_RENDERER_UI;
        }

        override public function setBlockWidth(param1:int) : void
        {
        }

        override public function setBlockData(param1:Object) : void
        {
            this._dataVO = new SessionBattleStatsViewVO(param1);
            this.applyData();
        }

        override protected function applyData() : void
        {
            list.dataProvider = this._dataVO.lastBattle;
        }

        override protected function onDispose() : void
        {
            if(this._dataVO)
            {
                this._dataVO.dispose();
                this._dataVO = null;
            }
            super.onDispose();
        }

        protected function get dataVO() : SessionBattleStatsViewVO
        {
            return this._dataVO;
        }
    }
}
