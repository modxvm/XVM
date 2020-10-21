package net.wg.infrastructure.base.meta.impl
{
    import net.wg.gui.lobby.eventItemPackTrade.EventPackTrade;
    import net.wg.gui.lobby.eventItemPackTrade.data.EventItemPackTradeVO;
    import net.wg.data.constants.Errors;
    import net.wg.infrastructure.exceptions.AbstractException;

    public class EventItemPackTradeMeta extends EventPackTrade
    {

        public var closeView:Function;

        public var backView:Function;

        public var onButtonPaymentSetPanelClick:Function;

        private var _eventItemPackTradeVO:EventItemPackTradeVO;

        public function EventItemPackTradeMeta()
        {
            super();
        }

        override protected function onDispose() : void
        {
            if(this._eventItemPackTradeVO)
            {
                this._eventItemPackTradeVO.dispose();
                this._eventItemPackTradeVO = null;
            }
            super.onDispose();
        }

        public function closeViewS() : void
        {
            App.utils.asserter.assertNotNull(this.closeView,"closeView" + Errors.CANT_NULL);
            this.closeView();
        }

        public function backViewS() : void
        {
            App.utils.asserter.assertNotNull(this.backView,"backView" + Errors.CANT_NULL);
            this.backView();
        }

        public function onButtonPaymentSetPanelClickS(param1:int) : void
        {
            App.utils.asserter.assertNotNull(this.onButtonPaymentSetPanelClick,"onButtonPaymentSetPanelClick" + Errors.CANT_NULL);
            this.onButtonPaymentSetPanelClick(param1);
        }

        public final function as_setData(param1:Object) : void
        {
            var _loc2_:EventItemPackTradeVO = this._eventItemPackTradeVO;
            this._eventItemPackTradeVO = new EventItemPackTradeVO(param1);
            this.setData(this._eventItemPackTradeVO);
            if(_loc2_)
            {
                _loc2_.dispose();
            }
        }

        protected function setData(param1:EventItemPackTradeVO) : void
        {
            var _loc2_:String = "as_setData" + Errors.ABSTRACT_INVOKE;
            DebugUtils.LOG_ERROR(_loc2_);
            throw new AbstractException(_loc2_);
        }
    }
}
