package net.wg.gui.lobby.premiumWindow.data
{
    import net.wg.data.daapi.base.DAAPIDataClass;
    import scaleform.clik.data.DataProvider;
    import net.wg.data.constants.Errors;
    import net.wg.infrastructure.interfaces.entity.IDisposable;

    public class PremiumWindowRatesVO extends DAAPIDataClass
    {

        private static const RATES_FIELD_NAME:String = "rates";

        public var header:String = "";

        public var headerTooltip:String = "";

        public var rates:DataProvider = null;

        public var selectedRateId:String = "";

        public function PremiumWindowRatesVO(param1:Object)
        {
            super(param1);
        }

        override protected function onDataWrite(param1:String, param2:Object) : Boolean
        {
            var _loc3_:Array = null;
            var _loc4_:Object = null;
            if(param1 == RATES_FIELD_NAME)
            {
                _loc3_ = param2 as Array;
                App.utils.asserter.assertNotNull(_loc3_,param1 + Errors.CANT_NULL);
                this.rates = new DataProvider();
                for each(_loc4_ in _loc3_)
                {
                    this.rates.push(new PremiumItemRendererVo(_loc4_));
                }
                return false;
            }
            return super.onDataWrite(param1,param2);
        }

        override protected function onDispose() : void
        {
            var _loc1_:IDisposable = null;
            if(this.rates != null)
            {
                for each(_loc1_ in this.rates)
                {
                    _loc1_.dispose();
                }
                this.rates.cleanUp();
                this.rates = null;
            }
            super.onDispose();
        }
    }
}
