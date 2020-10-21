package net.wg.infrastructure.base.meta.impl
{
    import net.wg.gui.lobby.eventItemPackTrade.EventPackTrade;
    import net.wg.gui.lobby.eventPlayerPackTrade.data.EventPlayerPackTradeVO;
    import net.wg.data.constants.Errors;
    import net.wg.infrastructure.exceptions.AbstractException;

    public class EventPlayerPackTradeMeta extends EventPackTrade
    {

        public var closeView:Function;

        public var backView:Function;

        public var onButtonPaymentSetPanelClick:Function;

        private var _eventPlayerPackTradeVO:EventPlayerPackTradeVO;

        public function EventPlayerPackTradeMeta()
        {
            super();
        }

        override protected function onDispose() : void
        {
            if(this._eventPlayerPackTradeVO)
            {
                this._eventPlayerPackTradeVO.dispose();
                this._eventPlayerPackTradeVO = null;
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
            var _loc2_:EventPlayerPackTradeVO = this._eventPlayerPackTradeVO;
            this._eventPlayerPackTradeVO = new EventPlayerPackTradeVO(param1);
            this.setData(this._eventPlayerPackTradeVO);
            if(_loc2_)
            {
                _loc2_.dispose();
            }
        }

        protected function setData(param1:EventPlayerPackTradeVO) : void
        {
            var _loc2_:String = "as_setData" + Errors.ABSTRACT_INVOKE;
            DebugUtils.LOG_ERROR(_loc2_);
            throw new AbstractException(_loc2_);
        }
    }
}
