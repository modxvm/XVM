package net.wg.infrastructure.base.meta.impl
{
    import net.wg.infrastructure.base.BaseDAAPIComponent;
    import net.wg.gui.lobby.eventBanInfo.data.EventBanInfoVO;
    import net.wg.data.constants.Errors;
    import net.wg.infrastructure.exceptions.AbstractException;

    public class EventBanInfoMeta extends BaseDAAPIComponent
    {

        private var _eventBanInfoVO:EventBanInfoVO;

        public function EventBanInfoMeta()
        {
            super();
        }

        override protected function onDispose() : void
        {
            if(this._eventBanInfoVO)
            {
                this._eventBanInfoVO.dispose();
                this._eventBanInfoVO = null;
            }
            super.onDispose();
        }

        public final function as_setEventBanInfo(param1:Object) : void
        {
            var _loc2_:EventBanInfoVO = this._eventBanInfoVO;
            this._eventBanInfoVO = new EventBanInfoVO(param1);
            this.setEventBanInfo(this._eventBanInfoVO);
            if(_loc2_)
            {
                _loc2_.dispose();
            }
        }

        protected function setEventBanInfo(param1:EventBanInfoVO) : void
        {
            var _loc2_:String = "as_setEventBanInfo" + Errors.ABSTRACT_INVOKE;
            DebugUtils.LOG_ERROR(_loc2_);
            throw new AbstractException(_loc2_);
        }
    }
}
