package net.wg.infrastructure.base.meta.impl
{
    import net.wg.gui.prebattle.squads.SquadView;
    import net.wg.gui.prebattle.squads.event.data.EventSquadDifficultyVO;
    import net.wg.data.constants.Errors;
    import net.wg.infrastructure.exceptions.AbstractException;

    public class EventSquadViewMeta extends SquadView
    {

        public var selectDifficulty:Function;

        private var _eventSquadDifficultyVO:EventSquadDifficultyVO;

        public function EventSquadViewMeta()
        {
            super();
        }

        override protected function onDispose() : void
        {
            if(this._eventSquadDifficultyVO)
            {
                this._eventSquadDifficultyVO.dispose();
                this._eventSquadDifficultyVO = null;
            }
            super.onDispose();
        }

        public function selectDifficultyS(param1:int) : void
        {
            App.utils.asserter.assertNotNull(this.selectDifficulty,"selectDifficulty" + Errors.CANT_NULL);
            this.selectDifficulty(param1);
        }

        public final function as_updateDifficulty(param1:Object) : void
        {
            var _loc2_:EventSquadDifficultyVO = this._eventSquadDifficultyVO;
            this._eventSquadDifficultyVO = new EventSquadDifficultyVO(param1);
            this.updateDifficulty(this._eventSquadDifficultyVO);
            if(_loc2_)
            {
                _loc2_.dispose();
            }
        }

        protected function updateDifficulty(param1:EventSquadDifficultyVO) : void
        {
            var _loc2_:String = "as_updateDifficulty" + Errors.ABSTRACT_INVOKE;
            DebugUtils.LOG_ERROR(_loc2_);
            throw new AbstractException(_loc2_);
        }
    }
}
