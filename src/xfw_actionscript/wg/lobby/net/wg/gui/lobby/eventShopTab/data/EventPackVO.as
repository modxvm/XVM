package net.wg.gui.lobby.eventShopTab.data
{
    import net.wg.data.daapi.base.DAAPIDataClass;
    import scaleform.clik.data.DataProvider;
    import net.wg.gui.lobby.eventStylesShopTab.data.BannerRewardVO;
    import net.wg.infrastructure.interfaces.entity.IDisposable;

    public class EventPackVO extends DAAPIDataClass
    {

        private static const REWARDS:String = "rewards";

        public var title:String = "";

        public var price:int = -1;

        public var oldPrice:int = -1;

        public var discount:String = "";

        public var description:String = "";

        public var descriptionFull:String = "";

        public var buyQuantity:String = "";

        public var packIcon:String = "";

        public var id:int = -1;

        public var canBuy:Boolean = true;

        private var _rewards:DataProvider;

        public function EventPackVO(param1:Object)
        {
            this._rewards = new DataProvider();
            super(param1);
        }

        override protected function onDataWrite(param1:String, param2:Object) : Boolean
        {
            var _loc3_:Array = null;
            var _loc4_:* = 0;
            var _loc5_:* = 0;
            if(param1 == REWARDS)
            {
                _loc3_ = param2 as Array;
                _loc4_ = _loc3_.length;
                _loc5_ = 0;
                while(_loc5_ < _loc4_)
                {
                    this._rewards.push(new BannerRewardVO(_loc3_[_loc5_]));
                    _loc5_++;
                }
                return false;
            }
            return super.onDataWrite(param1,param2);
        }

        override protected function onDispose() : void
        {
            var _loc1_:IDisposable = null;
            for each(_loc1_ in this._rewards)
            {
                _loc1_.dispose();
            }
            this._rewards.cleanUp();
            this._rewards = null;
            super.onDispose();
        }

        public function get rewards() : DataProvider
        {
            return this._rewards;
        }
    }
}
