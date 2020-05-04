package net.wg.gui.battle.pveEvent.views.eventStats
{
    import net.wg.infrastructure.base.meta.impl.EventStatsMeta;
    import net.wg.infrastructure.base.meta.IEventStatsMeta;
    import net.wg.data.constants.InvalidationType;
    import net.wg.gui.battle.pveEvent.views.eventStats.renderers.StatsPlayerRenderer;
    import net.wg.gui.battle.components.FullStatsTitle;
    import flash.display.MovieClip;
    import net.wg.gui.battle.pveEvent.views.eventStats.VO.EventStatsPlayerVO;
    import net.wg.data.VO.daapi.DAAPIQuestStatusVO;
    import net.wg.data.constants.Values;
    import net.wg.data.constants.generated.TEXT_MANAGER_STYLES;

    public class EventStats extends EventStatsMeta implements IEventStatsMeta
    {

        protected static const INVALID_STATS:uint = InvalidationType.SYSTEM_FLAGS_BORDER << 1;

        public var player0:StatsPlayerRenderer = null;

        public var player1:StatsPlayerRenderer = null;

        public var player2:StatsPlayerRenderer = null;

        public var player3:StatsPlayerRenderer = null;

        public var player4:StatsPlayerRenderer = null;

        public var teamVehiclesHeader:FullStatsTitle = null;

        public var dimmer:MovieClip = null;

        private var _players:Vector.<StatsPlayerRenderer> = null;

        private var _title:String = "";

        private var _description:String = "";

        public function EventStats()
        {
            super();
            this._players = new <StatsPlayerRenderer>[this.player0,this.player1,this.player2,this.player3,this.player4];
        }

        public function updateStageSize(param1:Number, param2:Number) : void
        {
            this.dimmer.width = param1;
            this.dimmer.height = param2;
        }

        public function as_updateTitle(param1:String, param2:String) : void
        {
            this._title = param1;
            this._description = param2;
            invalidate(INVALID_STATS);
        }

        override protected function updatePlayerStats(param1:EventStatsPlayerVO, param2:uint) : void
        {
            this._players[param2].update(param1);
        }

        override protected function configUI() : void
        {
            super.configUI();
            var _loc1_:DAAPIQuestStatusVO = new DAAPIQuestStatusVO({"status":Values.EMPTY_STR});
            this.teamVehiclesHeader.setStatus(_loc1_);
            this.teamVehiclesHeader.setTitle(App.textMgr.getTextStyleById(TEXT_MANAGER_STYLES.SUPER_PROMO_TITLE,App.utils.locale.makeString(EVENT.VEHICLE_SELECT_TAB_TEAM)));
        }

        override protected function onDispose() : void
        {
            var _loc1_:StatsPlayerRenderer = null;
            for each(_loc1_ in this._players)
            {
                _loc1_.dispose();
                _loc1_ = null;
            }
            this._players.splice(0,this._players.length);
            this._players = null;
            this.teamVehiclesHeader.dispose();
            this.teamVehiclesHeader = null;
            this.dimmer = null;
            super.onDispose();
        }
    }
}
