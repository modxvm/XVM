package net.wg.infrastructure.base.meta.impl
{
    import net.wg.gui.battle.views.prebattleTimer.PrebattleTimer;
    import net.wg.gui.battle.views.prebattleTimer.data.PrebattleTimerMessageVO;
    import net.wg.data.constants.Errors;
    import net.wg.infrastructure.exceptions.AbstractException;

    public class EventPrebattleTimerMeta extends PrebattleTimer
    {

        public var highlightedMessageShown:Function;

        private var _prebattleTimerMessageVO:PrebattleTimerMessageVO;

        public function EventPrebattleTimerMeta()
        {
            super();
        }

        override protected function onDispose() : void
        {
            if(this._prebattleTimerMessageVO)
            {
                this._prebattleTimerMessageVO.dispose();
                this._prebattleTimerMessageVO = null;
            }
            super.onDispose();
        }

        public function highlightedMessageShownS(param1:String) : void
        {
            App.utils.asserter.assertNotNull(this.highlightedMessageShown,"highlightedMessageShown" + Errors.CANT_NULL);
            this.highlightedMessageShown(param1);
        }

        public final function as_queueHighlightedMessage(param1:Object, param2:Boolean) : void
        {
            var _loc3_:PrebattleTimerMessageVO = this._prebattleTimerMessageVO;
            this._prebattleTimerMessageVO = new PrebattleTimerMessageVO(param1);
            this.queueHighlightedMessage(this._prebattleTimerMessageVO,param2);
            if(_loc3_)
            {
                _loc3_.dispose();
            }
        }

        protected function queueHighlightedMessage(param1:PrebattleTimerMessageVO, param2:Boolean) : void
        {
            var _loc3_:String = "as_queueHighlightedMessage" + Errors.ABSTRACT_INVOKE;
            DebugUtils.LOG_ERROR(_loc3_);
            throw new AbstractException(_loc3_);
        }
    }
}
