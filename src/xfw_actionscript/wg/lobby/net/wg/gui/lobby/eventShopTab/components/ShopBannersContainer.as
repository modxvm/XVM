package net.wg.gui.lobby.eventShopTab.components
{
    import net.wg.gui.components.common.FrameStateCmpnt;
    import net.wg.gui.lobby.eventShopTab.data.EventPackVO;
    import org.idmedia.as3commons.util.StringUtils;
    import scaleform.clik.constants.InvalidationType;

    public class ShopBannersContainer extends FrameStateCmpnt
    {

        private static const STATE_BIG:String = "big";

        private static const STATE_SMALL:String = "small";

        private static const SMALL_HEIGHT:int = 900;

        private static const SMALL_WIDTH:int = 1500;

        private static const EXPIREDATE_INVALID:String = "expiredate_invalid";

        public var mainBanner:ShopMainBanner = null;

        public var itemsBanner:ShopItemsBanner = null;

        public var bannerPack1:ShopPackBanner = null;

        public var bannerPack2:ShopPackBanner = null;

        private var _isSmallSize:Boolean = false;

        private var _expireDate:String = "";

        private var _dataBannerPack1:EventPackVO = null;

        private var _dataBannerPack2:EventPackVO = null;

        public function ShopBannersContainer()
        {
            super();
        }

        public function get isSmallSize() : Boolean
        {
            return this._isSmallSize;
        }

        public function updateSize(param1:Number, param2:Number) : void
        {
            this._isSmallSize = param1 < SMALL_WIDTH || param2 < SMALL_HEIGHT;
            frameLabel = this._isSmallSize?STATE_SMALL:STATE_BIG;
            invalidateData();
            invalidate(EXPIREDATE_INVALID);
        }

        public function setExpireDate(param1:String) : void
        {
            if(StringUtils.isNotEmpty(param1))
            {
                this._expireDate = param1;
                invalidate(EXPIREDATE_INVALID);
            }
        }

        public function setBannersData(param1:EventPackVO, param2:EventPackVO) : void
        {
            this._dataBannerPack1 = param1;
            this._dataBannerPack2 = param2;
            invalidateData();
        }

        override protected function draw() : void
        {
            super.draw();
            if(this._dataBannerPack1 && this._dataBannerPack2 && isInvalid(InvalidationType.DATA))
            {
                this.bannerPack1.setData(this._dataBannerPack1);
                this.bannerPack2.setData(this._dataBannerPack2);
                this.itemsBanner.label = this._expireDate;
            }
            if(isInvalid(EXPIREDATE_INVALID))
            {
                this.itemsBanner.label = this._expireDate;
            }
        }

        override protected function onDispose() : void
        {
            this.bannerPack1.dispose();
            this.bannerPack1 = null;
            this.bannerPack2.dispose();
            this.bannerPack2 = null;
            this.itemsBanner.dispose();
            this.itemsBanner = null;
            this.mainBanner.dispose();
            this.mainBanner = null;
            this._dataBannerPack1 = null;
            this._dataBannerPack2 = null;
            super.onDispose();
        }
    }
}
