package net.wg.gui.lobby.eventStylesShopTab.data
{
    import net.wg.data.daapi.base.DAAPIDataClass;
    import scaleform.clik.data.DataProvider;
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import net.wg.gui.lobby.eventStylesTrade.data.SkinVO;

    public class EventStylesShopTabDataVO extends DAAPIDataClass
    {

        private static const SKINS_FIELD:String = "skins";

        private static const BANNERS_FIELD:String = "banners";

        private var _banners:DataProvider = null;

        private var _skins:DataProvider = null;

        public function EventStylesShopTabDataVO(param1:Object)
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
            super.onDispose();
        }

        override protected function onDataWrite(param1:String, param2:Object) : Boolean
        {
            var _loc3_:Array = null;
            var _loc4_:* = 0;
            var _loc5_:* = 0;
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
    }
}
