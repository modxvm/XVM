package net.wg.infrastructure.base.meta.impl
{
    import net.wg.infrastructure.base.BaseDAAPIComponent;
    import net.wg.gui.lobby.eventTankRent.data.EventTankRentVO;
    import net.wg.data.constants.Errors;
    import net.wg.infrastructure.exceptions.AbstractException;

    public class EventTankRentMeta extends BaseDAAPIComponent
    {

        public var onEventRentClick:Function;

        public var onToQuestsClick:Function;

        private var _eventTankRentVO:EventTankRentVO;

        public function EventTankRentMeta()
        {
            super();
        }

        override protected function onDispose() : void
        {
            if(this._eventTankRentVO)
            {
                this._eventTankRentVO.dispose();
                this._eventTankRentVO = null;
            }
            super.onDispose();
        }

        public function onEventRentClickS() : void
        {
            App.utils.asserter.assertNotNull(this.onEventRentClick,"onEventRentClick" + Errors.CANT_NULL);
            this.onEventRentClick();
        }

        public function onToQuestsClickS() : void
        {
            App.utils.asserter.assertNotNull(this.onToQuestsClick,"onToQuestsClick" + Errors.CANT_NULL);
            this.onToQuestsClick();
        }

        public final function as_setRentData(param1:Object) : void
        {
            var _loc2_:EventTankRentVO = this._eventTankRentVO;
            this._eventTankRentVO = new EventTankRentVO(param1);
            this.setRentData(this._eventTankRentVO);
            if(_loc2_)
            {
                _loc2_.dispose();
            }
        }

        protected function setRentData(param1:EventTankRentVO) : void
        {
            var _loc2_:String = "as_setRentData" + Errors.ABSTRACT_INVOKE;
            DebugUtils.LOG_ERROR(_loc2_);
            throw new AbstractException(_loc2_);
        }
    }
}
