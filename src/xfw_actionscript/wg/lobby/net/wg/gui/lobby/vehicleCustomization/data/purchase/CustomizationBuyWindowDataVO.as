package net.wg.gui.lobby.vehicleCustomization.data.purchase
{
    import net.wg.data.daapi.base.DAAPIDataClass;
    import scaleform.clik.data.DataProvider;

    public class CustomizationBuyWindowDataVO extends DAAPIDataClass
    {

        private static const SUMMER_DATA:String = "summerData";

        private static const WINTER_DATA:String = "winterData";

        private static const DESERT_DATA:String = "desertData";

        public var summerData:DataProvider = null;

        public var winterData:DataProvider = null;

        public var desertData:DataProvider = null;

        public function CustomizationBuyWindowDataVO(param1:Object)
        {
            super(param1);
        }

        override protected function onDataWrite(param1:String, param2:Object) : Boolean
        {
            var _loc3_:Array = null;
            var _loc4_:Object = null;
            if(param1 == SUMMER_DATA)
            {
                _loc3_ = param2 as Array;
                this.summerData = new DataProvider();
                for each(_loc4_ in _loc3_)
                {
                    this.summerData.push(new PurchaseVO(_loc4_));
                }
                return false;
            }
            if(param1 == WINTER_DATA)
            {
                _loc3_ = param2 as Array;
                this.winterData = new DataProvider();
                for each(_loc4_ in _loc3_)
                {
                    this.winterData.push(new PurchaseVO(_loc4_));
                }
                return false;
            }
            if(param1 == DESERT_DATA)
            {
                _loc3_ = param2 as Array;
                this.desertData = new DataProvider();
                for each(_loc4_ in _loc3_)
                {
                    this.desertData.push(new PurchaseVO(_loc4_));
                }
                return false;
            }
            return super.onDataWrite(param1,param2);
        }

        override protected function onDispose() : void
        {
            var _loc1_:PurchaseVO = null;
            if(this.summerData)
            {
                for each(_loc1_ in this.summerData)
                {
                    _loc1_.dispose();
                }
                this.summerData.cleanUp();
                this.summerData = null;
            }
            if(this.winterData)
            {
                for each(_loc1_ in this.winterData)
                {
                    _loc1_.dispose();
                }
                this.winterData.cleanUp();
                this.winterData = null;
            }
            if(this.desertData)
            {
                for each(_loc1_ in this.summerData)
                {
                    _loc1_.dispose();
                }
                this.desertData.cleanUp();
                this.desertData = null;
                _loc1_ = null;
            }
            super.onDispose();
        }
    }
}
