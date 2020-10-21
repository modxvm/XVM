package net.wg.infrastructure.base.meta.impl
{
    import net.wg.infrastructure.base.BaseDAAPIComponent;
    import net.wg.gui.lobby.eventManageCrewPanel.data.EventManageCrewVO;
    import net.wg.data.constants.Errors;
    import net.wg.infrastructure.exceptions.AbstractException;

    public class EventManageCrewMeta extends BaseDAAPIComponent
    {

        public var onApply:Function;

        private var _eventManageCrewVO:EventManageCrewVO;

        public function EventManageCrewMeta()
        {
            super();
        }

        override protected function onDispose() : void
        {
            if(this._eventManageCrewVO)
            {
                this._eventManageCrewVO.dispose();
                this._eventManageCrewVO = null;
            }
            super.onDispose();
        }

        public function onApplyS() : void
        {
            App.utils.asserter.assertNotNull(this.onApply,"onApply" + Errors.CANT_NULL);
            this.onApply();
        }

        public final function as_setData(param1:Object) : void
        {
            var _loc2_:EventManageCrewVO = this._eventManageCrewVO;
            this._eventManageCrewVO = new EventManageCrewVO(param1);
            this.setData(this._eventManageCrewVO);
            if(_loc2_)
            {
                _loc2_.dispose();
            }
        }

        protected function setData(param1:EventManageCrewVO) : void
        {
            var _loc2_:String = "as_setData" + Errors.ABSTRACT_INVOKE;
            DebugUtils.LOG_ERROR(_loc2_);
            throw new AbstractException(_loc2_);
        }
    }
}
