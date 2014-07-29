package net.wg.gui.lobby.window
{
    import net.wg.infrastructure.base.meta.impl.BaseExchangeWindowMeta;
    import net.wg.infrastructure.base.meta.IBaseExchangeWindowMeta;
    import flash.events.Event;
    
    public class BaseExchangeWindow extends BaseExchangeWindowMeta implements IBaseExchangeWindowMeta
    {
        
        public function BaseExchangeWindow()
        {
            super();
        }
        
        protected static var TOTAL_PRIMARY_CURRENCY_INVALID:String = "TotalPrimaryCurrencyInv";
        
        protected static var RATES_INVALID:String = "ratesInv";
        
        protected var totalPrimaryCurrency:int = -1;
        
        protected var rate:uint;
        
        protected var actionRate:uint;
        
        protected var actualRate:uint = 1;
        
        public function as_setPrimaryCurrency(param1:Number) : void
        {
            if(this.totalPrimaryCurrency != param1)
            {
                this.totalPrimaryCurrency = param1;
                invalidate(TOTAL_PRIMARY_CURRENCY_INVALID);
            }
        }
        
        public function as_exchangeRate(param1:Number, param2:Number) : void
        {
            if(!(this.rate == param1) || !(this.actionRate == param2))
            {
                this.rate = param1;
                this.actionRate = param2;
                this.actualRate = !(this.rate == this.actionRate) && !(this.actionRate == 0)?this.actionRate:this.rate;
                invalidate(RATES_INVALID);
            }
        }
        
        override protected function draw() : void
        {
            super.draw();
            if(isInvalid(RATES_INVALID))
            {
                this.applyRatesChanges();
            }
            if(isInvalid(TOTAL_PRIMARY_CURRENCY_INVALID))
            {
                this.applyPrimaryCurrencyChange();
            }
        }
        
        protected function applyPrimaryCurrencyChange() : void
        {
            var _loc1_:* = "Flash applyPrimaryCurrencyChange method have to be overridden";
            DebugUtils.LOG_ERROR(_loc1_,this);
            throw new Error(_loc1_);
        }
        
        protected function applyRatesChanges() : void
        {
            var _loc1_:* = "Flash applyRatesChanges method have to be overridden";
            DebugUtils.LOG_ERROR(_loc1_,this);
            throw new Error(_loc1_);
        }
        
        protected function cancelBtnClickHandler(param1:Event) : void
        {
            onWindowCloseS();
        }
    }
}
