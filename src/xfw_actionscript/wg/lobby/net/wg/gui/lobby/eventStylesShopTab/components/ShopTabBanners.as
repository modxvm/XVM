package net.wg.gui.lobby.eventStylesShopTab.components
{
    import flash.display.Sprite;
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import scaleform.clik.data.DataProvider;

    public class ShopTabBanners extends Sprite implements IDisposable
    {

        public var banner1:ShopTabBanner = null;

        public var banner2:ShopTabBanner = null;

        public var banner3:ShopTabBanner = null;

        private var _banners:Vector.<ShopTabBanner> = null;

        public function ShopTabBanners()
        {
            super();
            this._banners = new <ShopTabBanner>[this.banner1,this.banner2,this.banner3];
        }

        public function setData(param1:DataProvider) : void
        {
            var _loc2_:int = Math.min(param1.length,this._banners.length);
            var _loc3_:* = 0;
            while(_loc3_ < _loc2_)
            {
                this._banners[_loc3_].setData(param1[_loc3_],_loc3_);
                _loc3_++;
            }
        }

        public final function dispose() : void
        {
            this._banners.splice(0,this._banners.length);
            this._banners = null;
            this.banner1.dispose();
            this.banner1 = null;
            this.banner2.dispose();
            this.banner2 = null;
            this.banner3.dispose();
            this.banner3 = null;
        }
    }
}
