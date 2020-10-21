package net.wg.infrastructure.base.meta.impl
{
    import net.wg.infrastructure.base.AbstractScreen;
    import net.wg.gui.lobby.eventItemsTrade.data.EventItemsTradeVO;
    import net.wg.data.constants.Errors;
    import net.wg.infrastructure.exceptions.AbstractException;

    public class EventItemsTradeMeta extends AbstractScreen
    {

        public var closeView:Function;

        public var backView:Function;

        public var onButtonPaymentPanelClick:Function;

        private var _eventItemsTradeVO:EventItemsTradeVO;

        public function EventItemsTradeMeta()
        {
            super();
        }

        override protected function onDispose() : void
        {
            if(this._eventItemsTradeVO)
            {
                this._eventItemsTradeVO.dispose();
                this._eventItemsTradeVO = null;
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

        public function onButtonPaymentPanelClickS(param1:int) : void
        {
            App.utils.asserter.assertNotNull(this.onButtonPaymentPanelClick,"onButtonPaymentPanelClick" + Errors.CANT_NULL);
            this.onButtonPaymentPanelClick(param1);
        }

        public final function as_setData(param1:Object) : void
        {
            var _loc2_:EventItemsTradeVO = this._eventItemsTradeVO;
            this._eventItemsTradeVO = new EventItemsTradeVO(param1);
            this.setData(this._eventItemsTradeVO);
            if(_loc2_)
            {
                _loc2_.dispose();
            }
        }

        protected function setData(param1:EventItemsTradeVO) : void
        {
            var _loc2_:String = "as_setData" + Errors.ABSTRACT_INVOKE;
            DebugUtils.LOG_ERROR(_loc2_);
            throw new AbstractException(_loc2_);
        }
    }
}
