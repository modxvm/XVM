package net.wg.infrastructure.base.meta.impl
{
    import net.wg.gui.battle.components.BattleDisplayable;
    import net.wg.gui.battle.eventBattle.views.eventStats.VO.EventStatsPlayerVO;
    import net.wg.data.constants.Errors;
    import net.wg.infrastructure.exceptions.AbstractException;

    public class EventStatsMeta extends BattleDisplayable
    {

        private var _eventStatsPlayerVO:EventStatsPlayerVO;

        public function EventStatsMeta()
        {
            super();
        }

        override protected function onDispose() : void
        {
            if(this._eventStatsPlayerVO)
            {
                this._eventStatsPlayerVO.dispose();
                this._eventStatsPlayerVO = null;
            }
            super.onDispose();
        }

        public final function as_updatePlayerStats(param1:Object, param2:uint) : void
        {
            var _loc3_:EventStatsPlayerVO = this._eventStatsPlayerVO;
            this._eventStatsPlayerVO = new EventStatsPlayerVO(param1);
            this.updatePlayerStats(this._eventStatsPlayerVO,param2);
            if(_loc3_)
            {
                _loc3_.dispose();
            }
        }

        protected function updatePlayerStats(param1:EventStatsPlayerVO, param2:uint) : void
        {
            var _loc3_:String = "as_updatePlayerStats" + Errors.ABSTRACT_INVOKE;
            DebugUtils.LOG_ERROR(_loc3_);
            throw new AbstractException(_loc3_);
        }
    }
}
