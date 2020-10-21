package net.wg.infrastructure.base.meta.impl
{
    import net.wg.infrastructure.base.AbstractScreen;
    import net.wg.gui.lobby.eventShopTab.data.EventPackVO;
    import net.wg.data.constants.Errors;
    import net.wg.infrastructure.exceptions.AbstractException;

    public class EventShopTabMeta extends AbstractScreen
    {

        public var closeView:Function;

        public var onItemsBannerClick:Function;

        public var onMainBannerClick:Function;

        public var onPackBannerClick:Function;

        private var _eventPackVO:EventPackVO;

        private var _eventPackVO1:EventPackVO;

        public function EventShopTabMeta()
        {
            super();
        }

        override protected function onDispose() : void
        {
            if(this._eventPackVO)
            {
                this._eventPackVO.dispose();
                this._eventPackVO = null;
            }
            if(this._eventPackVO1)
            {
                this._eventPackVO1.dispose();
                this._eventPackVO1 = null;
            }
            super.onDispose();
        }

        public function closeViewS() : void
        {
            App.utils.asserter.assertNotNull(this.closeView,"closeView" + Errors.CANT_NULL);
            this.closeView();
        }

        public function onItemsBannerClickS() : void
        {
            App.utils.asserter.assertNotNull(this.onItemsBannerClick,"onItemsBannerClick" + Errors.CANT_NULL);
            this.onItemsBannerClick();
        }

        public function onMainBannerClickS() : void
        {
            App.utils.asserter.assertNotNull(this.onMainBannerClick,"onMainBannerClick" + Errors.CANT_NULL);
            this.onMainBannerClick();
        }

        public function onPackBannerClickS(param1:int) : void
        {
            App.utils.asserter.assertNotNull(this.onPackBannerClick,"onPackBannerClick" + Errors.CANT_NULL);
            this.onPackBannerClick(param1);
        }

        public final function as_setPackBannersData(param1:Object, param2:Object) : void
        {
            var _loc3_:EventPackVO = this._eventPackVO;
            this._eventPackVO = new EventPackVO(param1);
            var _loc4_:EventPackVO = this._eventPackVO1;
            this._eventPackVO1 = new EventPackVO(param2);
            this.setPackBannersData(this._eventPackVO,this._eventPackVO1);
            if(_loc3_)
            {
                _loc3_.dispose();
            }
            if(_loc4_)
            {
                _loc4_.dispose();
            }
        }

        protected function setPackBannersData(param1:EventPackVO, param2:EventPackVO) : void
        {
            var _loc3_:String = "as_setPackBannersData" + Errors.ABSTRACT_INVOKE;
            DebugUtils.LOG_ERROR(_loc3_);
            throw new AbstractException(_loc3_);
        }
    }
}
