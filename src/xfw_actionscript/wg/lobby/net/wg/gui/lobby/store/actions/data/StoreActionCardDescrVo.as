package net.wg.gui.lobby.store.actions.data
{
    import net.wg.data.daapi.base.DAAPIDataClass;

    public class StoreActionCardDescrVo extends DAAPIDataClass
    {

        private static const TABLE_OFFER_FILED:String = "tableOffers";

        public var descr:String = "";

        public var tableOffers:Vector.<StoreActionCardOffersItemVo> = null;

        public var ttcDataVO:Object = null;

        public function StoreActionCardDescrVo(param1:Object = null)
        {
            super(param1);
        }

        override protected function onDataWrite(param1:String, param2:Object) : Boolean
        {
            var _loc3_:* = NaN;
            var _loc4_:* = 0;
            if(param1 == TABLE_OFFER_FILED && param2 is Array)
            {
                _loc3_ = param2.length;
                if(_loc3_ > 0)
                {
                    this.tableOffers = new <StoreActionCardOffersItemVo>[null,null,null];
                    _loc4_ = 0;
                    while(_loc4_ < _loc3_)
                    {
                        this.tableOffers[_loc4_] = new StoreActionCardOffersItemVo(param2[_loc4_]);
                        _loc4_++;
                    }
                }
                return false;
            }
            return super.onDataWrite(param1,param2);
        }

        override protected function onDispose() : void
        {
            if(this.tableOffers)
            {
                this.tableOffers.splice(0,this.tableOffers.length);
                this.tableOffers = null;
            }
            if(this.ttcDataVO != null)
            {
                App.utils.data.cleanupDynamicObject(this.ttcDataVO);
                this.ttcDataVO = null;
            }
            super.onDispose();
        }
    }
}
