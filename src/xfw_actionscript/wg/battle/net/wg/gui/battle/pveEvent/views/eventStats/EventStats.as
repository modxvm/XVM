package net.wg.gui.battle.pveEvent.views.eventStats
{
    import net.wg.infrastructure.base.meta.impl.EventStatsMeta;
    import net.wg.infrastructure.base.meta.IEventStatsMeta;
    import net.wg.data.constants.InvalidationType;
    import net.wg.gui.battle.pveEvent.views.eventStats.renderers.StatsPlayerRenderer;
    import flash.text.TextField;
    import net.wg.gui.components.common.FrameStateCmpnt;
    import net.wg.gui.battle.components.FullStatsTitle;
    import flash.display.MovieClip;
    import net.wg.gui.battle.pveEvent.views.eventStats.VO.EventStatsPlayerVO;
    import net.wg.data.VO.daapi.DAAPIQuestStatusVO;
    import net.wg.data.constants.Values;
    import net.wg.data.constants.generated.TEXT_MANAGER_STYLES;

    public class EventStats extends EventStatsMeta implements IEventStatsMeta
    {

        protected static const INVALID_STATS:uint = InvalidationType.SYSTEM_FLAGS_BORDER << 1;

        private static const DIFFICULTY_LABEL:String = "difficulty";

        private static const DIFFICULTY_OFFSET:int = 7;

        private static const DIFFICULTY_WIDTH:int = 9;

        public var player0:StatsPlayerRenderer = null;

        public var player1:StatsPlayerRenderer = null;

        public var player2:StatsPlayerRenderer = null;

        public var player3:StatsPlayerRenderer = null;

        public var player4:StatsPlayerRenderer = null;

        public var titleTF:TextField = null;

        public var difficultyTF:TextField = null;

        public var descriptionTF:TextField = null;

        public var difficulty:FrameStateCmpnt = null;

        public var teamVehiclesHeader:FullStatsTitle = null;

        public var dimmer:MovieClip = null;

        private var _players:Vector.<StatsPlayerRenderer> = null;

        private var _title:String = "";

        private var _description:String = "";

        private var _difficulty:int = 0;

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

        public function as_updateTitle(param1:String, param2:String, param3:int) : void
        {
            this._title = param1;
            this._description = param2;
            this._difficulty = param3;
            invalidate(INVALID_STATS);
        }

        override protected function updatePlayerStats(param1:Vector.<EventStatsPlayerVO>) : void
        {
            var _loc2_:uint = Math.min(param1.length,this._players.length);
            var _loc3_:uint = 0;
            while(_loc3_ < _loc2_)
            {
                this._players[_loc3_].update(param1[_loc3_]);
                _loc3_++;
            }
        }

        override protected function configUI() : void
        {
            super.configUI();
            var _loc1_:DAAPIQuestStatusVO = new DAAPIQuestStatusVO({"status":Values.EMPTY_STR});
            this.teamVehiclesHeader.setStatus(_loc1_);
            this.teamVehiclesHeader.setTitle(App.textMgr.getTextStyleById(TEXT_MANAGER_STYLES.SUPER_PROMO_TITLE,App.utils.locale.makeString(INGAME_GUI.STATISTICS_TAB_LINE_UP_TITLE)));
            this.difficultyTF.text = EVENT.STATS_DIFFICULTY;
        }

        override protected function draw() : void
        {
            var _loc1_:* = 0;
            if(isInvalid(INVALID_STATS))
            {
                this.titleTF.text = this._title;
                this.descriptionTF.text = this._description;
                this.difficulty.frameLabel = DIFFICULTY_LABEL + this._difficulty.toString();
                _loc1_ = DIFFICULTY_WIDTH * this._difficulty + this._difficulty - 1;
                this.difficultyTF.x = -(this.difficultyTF.textWidth + DIFFICULTY_OFFSET + _loc1_) >> 1;
                this.difficulty.x = this.difficultyTF.x + this.difficultyTF.textWidth + DIFFICULTY_OFFSET;
            }
            super.draw();
        }

        override protected function onDispose() : void
        {
            var _loc1_:StatsPlayerRenderer = null;
            for each(_loc1_ in this._players)
            {
                _loc1_.dispose();
            }
            this.player0 = null;
            this.player1 = null;
            this.player2 = null;
            this.player3 = null;
            this.player4 = null;
            this._players.splice(0,this._players.length);
            this._players = null;
            this.teamVehiclesHeader.dispose();
            this.teamVehiclesHeader = null;
            this.dimmer = null;
            this.titleTF = null;
            this.descriptionTF = null;
            this.difficultyTF = null;
            this.difficulty.dispose();
            this.difficulty = null;
            super.onDispose();
        }
    }
}
