package net.wg.gui.lobby.eventShopConfirmation.data
{
    import net.wg.data.daapi.base.DAAPIDataClass;
    import scaleform.clik.data.DataProvider;
    import net.wg.infrastructure.interfaces.entity.IDisposable;

    public class ConfirmationDataVO extends DAAPIDataClass
    {

        private static const REWARDS:String = "rewards";

        private static const GIFT:String = "gift";

        public var title:String = "";

        public var descr:String = "";

        public var giftTitle:String = "";

        public var giftDescr:String = "";

        public var price:String = "";

        public var currency:String = "";

        public var money:String = "";

        private var _rewards:DataProvider;

        private var _gift:ConfirmationRewardVO = null;

        public function ConfirmationDataVO(param1:Object)
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
                    this._rewards.push(new ConfirmationRewardVO(_loc3_[_loc5_]));
                    _loc5_++;
                }
                return false;
            }
            if(param1 == GIFT)
            {
                this._gift = new ConfirmationRewardVO(param2);
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
            this._gift.dispose();
            this._gift = null;
            super.onDispose();
        }

        public function get rewards() : DataProvider
        {
            return this._rewards;
        }

        public function get gift() : ConfirmationRewardVO
        {
            return this._gift;
        }
    }
}
