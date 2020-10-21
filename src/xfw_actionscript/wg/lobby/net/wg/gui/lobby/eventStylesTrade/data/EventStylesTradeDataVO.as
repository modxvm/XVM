package net.wg.gui.lobby.eventStylesTrade.data
{
    import net.wg.data.daapi.base.DAAPIDataClass;
    import scaleform.clik.data.DataProvider;
    import net.wg.gui.components.paginator.vo.ToolTipVO;
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import net.wg.gui.lobby.eventStylesShopTab.data.BannerDataVO;

    public class EventStylesTradeDataVO extends DAAPIDataClass
    {

        private static const SKINS_FIELD:String = "skins";

        private static const BANNERS_FIELD:String = "banners";

        private static const BUNDLE_TOOLTIP:String = "bundleTooltip";

        public var useConfirm:Boolean = false;

        public var isShowAuthor:Boolean = false;

        public var canBuyBundle:Boolean = false;

        public var bundlePrice:String = "";

        public var selectedIndex:int = -1;

        public var noOneInHangar:Boolean = false;

        public var bundleNotEnough:Boolean = false;

        public var header:String = "";

        public var description:String = "";

        private var _skins:DataProvider = null;

        private var _banners:DataProvider = null;

        private var _bundleTooltip:ToolTipVO = null;

        public function EventStylesTradeDataVO(param1:Object)
        {
            super(param1);
        }

        override protected function onDispose() : void
        {
            var _loc1_:IDisposable = null;
            for each(_loc1_ in this._skins)
            {
                _loc1_.dispose();
            }
            this._skins.cleanUp();
            this._skins = null;
            for each(_loc1_ in this._banners)
            {
                _loc1_.dispose();
            }
            this._banners.cleanUp();
            this._banners = null;
            if(this._bundleTooltip != null)
            {
                this._bundleTooltip.dispose();
                this._bundleTooltip = null;
            }
            super.onDispose();
        }

        override protected function onDataWrite(param1:String, param2:Object) : Boolean
        {
            var _loc3_:Array = null;
            var _loc4_:* = 0;
            var _loc5_:* = 0;
            if(param1 == BUNDLE_TOOLTIP)
            {
                this._bundleTooltip = new ToolTipVO(param2);
                return false;
            }
            if(param1 == SKINS_FIELD)
            {
                this._skins = new DataProvider();
                _loc3_ = param2 as Array;
                _loc4_ = _loc3_.length;
                _loc5_ = 0;
                while(_loc5_ < _loc4_)
                {
                    this._skins.push(new SkinVO(_loc3_[_loc5_]));
                    _loc5_++;
                }
                return false;
            }
            if(param1 == BANNERS_FIELD)
            {
                this._banners = new DataProvider();
                _loc3_ = param2 as Array;
                _loc4_ = _loc3_.length;
                _loc5_ = 0;
                while(_loc5_ < _loc4_)
                {
                    this._banners.push(new BannerDataVO(_loc3_[_loc5_]));
                    _loc5_++;
                }
                return false;
            }
            return super.onDataWrite(param1,param2);
        }

        public function get skins() : DataProvider
        {
            return this._skins;
        }

        public function get banners() : DataProvider
        {
            return this._banners;
        }

        public function get bundleTooltip() : ToolTipVO
        {
            return this._bundleTooltip;
        }
    }
}
