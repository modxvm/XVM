package net.wg.infrastructure.base.meta.impl
{
    import net.wg.infrastructure.base.AbstractScreen;
    import net.wg.gui.lobby.eventStylesShopTab.data.EventStylesShopTabDataVO;
    import net.wg.data.constants.Errors;
    import net.wg.infrastructure.exceptions.AbstractException;

    public class EventStylesShopTabMeta extends AbstractScreen
    {

        public var closeView:Function;

        public var onTankClick:Function;

        public var onBannerClick:Function;

        private var _eventStylesShopTabDataVO:EventStylesShopTabDataVO;

        public function EventStylesShopTabMeta()
        {
            super();
        }

        override protected function onDispose() : void
        {
            if(this._eventStylesShopTabDataVO)
            {
                this._eventStylesShopTabDataVO.dispose();
                this._eventStylesShopTabDataVO = null;
            }
            super.onDispose();
        }

        public function closeViewS() : void
        {
            App.utils.asserter.assertNotNull(this.closeView,"closeView" + Errors.CANT_NULL);
            this.closeView();
        }

        public function onTankClickS(param1:int) : void
        {
            App.utils.asserter.assertNotNull(this.onTankClick,"onTankClick" + Errors.CANT_NULL);
            this.onTankClick(param1);
        }

        public function onBannerClickS(param1:int) : void
        {
            App.utils.asserter.assertNotNull(this.onBannerClick,"onBannerClick" + Errors.CANT_NULL);
            this.onBannerClick(param1);
        }

        public final function as_setData(param1:Object) : void
        {
            var _loc2_:EventStylesShopTabDataVO = this._eventStylesShopTabDataVO;
            this._eventStylesShopTabDataVO = new EventStylesShopTabDataVO(param1);
            this.setData(this._eventStylesShopTabDataVO);
            if(_loc2_)
            {
                _loc2_.dispose();
            }
        }

        protected function setData(param1:EventStylesShopTabDataVO) : void
        {
            var _loc2_:String = "as_setData" + Errors.ABSTRACT_INVOKE;
            DebugUtils.LOG_ERROR(_loc2_);
            throw new AbstractException(_loc2_);
        }
    }
}
