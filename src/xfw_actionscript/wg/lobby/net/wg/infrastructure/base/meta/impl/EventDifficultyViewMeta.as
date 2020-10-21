package net.wg.infrastructure.base.meta.impl
{
    import net.wg.infrastructure.base.AbstractScreen;
    import net.wg.gui.lobby.eventDifficulties.data.EventDifficultiesVO;
    import net.wg.data.constants.Errors;
    import net.wg.infrastructure.exceptions.AbstractException;

    public class EventDifficultyViewMeta extends AbstractScreen
    {

        public var closeView:Function;

        public var selectDifficulty:Function;

        private var _eventDifficultiesVO:EventDifficultiesVO;

        public function EventDifficultyViewMeta()
        {
            super();
        }

        override protected function onDispose() : void
        {
            if(this._eventDifficultiesVO)
            {
                this._eventDifficultiesVO.dispose();
                this._eventDifficultiesVO = null;
            }
            super.onDispose();
        }

        public function closeViewS() : void
        {
            App.utils.asserter.assertNotNull(this.closeView,"closeView" + Errors.CANT_NULL);
            this.closeView();
        }

        public function selectDifficultyS(param1:int) : void
        {
            App.utils.asserter.assertNotNull(this.selectDifficulty,"selectDifficulty" + Errors.CANT_NULL);
            this.selectDifficulty(param1);
        }

        public final function as_setData(param1:Object) : void
        {
            var _loc2_:EventDifficultiesVO = this._eventDifficultiesVO;
            this._eventDifficultiesVO = new EventDifficultiesVO(param1);
            this.setData(this._eventDifficultiesVO);
            if(_loc2_)
            {
                _loc2_.dispose();
            }
        }

        protected function setData(param1:EventDifficultiesVO) : void
        {
            var _loc2_:String = "as_setData" + Errors.ABSTRACT_INVOKE;
            DebugUtils.LOG_ERROR(_loc2_);
            throw new AbstractException(_loc2_);
        }
    }
}
