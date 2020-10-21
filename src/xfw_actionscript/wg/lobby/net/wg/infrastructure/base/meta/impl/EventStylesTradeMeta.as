package net.wg.infrastructure.base.meta.impl
{
    import net.wg.infrastructure.base.AbstractScreen;
    import net.wg.gui.lobby.eventStylesTrade.data.EventStylesTradeDataVO;
    import net.wg.data.constants.Errors;
    import net.wg.infrastructure.exceptions.AbstractException;

    public class EventStylesTradeMeta extends AbstractScreen
    {

        public var closeView:Function;

        public var onBackClick:Function;

        public var onBuyClick:Function;

        public var onUseClick:Function;

        public var showBlur:Function;

        public var hideBlur:Function;

        public var onBannerClick:Function;

        public var onSelect:Function;

        public var onBundleClick:Function;

        private var _eventStylesTradeDataVO:EventStylesTradeDataVO;

        public function EventStylesTradeMeta()
        {
            super();
        }

        override protected function onDispose() : void
        {
            if(this._eventStylesTradeDataVO)
            {
                this._eventStylesTradeDataVO.dispose();
                this._eventStylesTradeDataVO = null;
            }
            super.onDispose();
        }

        public function closeViewS() : void
        {
            App.utils.asserter.assertNotNull(this.closeView,"closeView" + Errors.CANT_NULL);
            this.closeView();
        }

        public function onBackClickS() : void
        {
            App.utils.asserter.assertNotNull(this.onBackClick,"onBackClick" + Errors.CANT_NULL);
            this.onBackClick();
        }

        public function onBuyClickS() : void
        {
            App.utils.asserter.assertNotNull(this.onBuyClick,"onBuyClick" + Errors.CANT_NULL);
            this.onBuyClick();
        }

        public function onUseClickS() : void
        {
            App.utils.asserter.assertNotNull(this.onUseClick,"onUseClick" + Errors.CANT_NULL);
            this.onUseClick();
        }

        public function showBlurS() : void
        {
            App.utils.asserter.assertNotNull(this.showBlur,"showBlur" + Errors.CANT_NULL);
            this.showBlur();
        }

        public function hideBlurS() : void
        {
            App.utils.asserter.assertNotNull(this.hideBlur,"hideBlur" + Errors.CANT_NULL);
            this.hideBlur();
        }

        public function onBannerClickS(param1:int) : void
        {
            App.utils.asserter.assertNotNull(this.onBannerClick,"onBannerClick" + Errors.CANT_NULL);
            this.onBannerClick(param1);
        }

        public function onSelectS(param1:int) : void
        {
            App.utils.asserter.assertNotNull(this.onSelect,"onSelect" + Errors.CANT_NULL);
            this.onSelect(param1);
        }

        public function onBundleClickS() : void
        {
            App.utils.asserter.assertNotNull(this.onBundleClick,"onBundleClick" + Errors.CANT_NULL);
            this.onBundleClick();
        }

        public final function as_setData(param1:Object) : void
        {
            var _loc2_:EventStylesTradeDataVO = this._eventStylesTradeDataVO;
            this._eventStylesTradeDataVO = new EventStylesTradeDataVO(param1);
            this.setData(this._eventStylesTradeDataVO);
            if(_loc2_)
            {
                _loc2_.dispose();
            }
        }

        protected function setData(param1:EventStylesTradeDataVO) : void
        {
            var _loc2_:String = "as_setData" + Errors.ABSTRACT_INVOKE;
            DebugUtils.LOG_ERROR(_loc2_);
            throw new AbstractException(_loc2_);
        }
    }
}
