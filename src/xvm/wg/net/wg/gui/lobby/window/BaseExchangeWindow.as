package net.wg.gui.lobby.window 
{
    import flash.events.*;
    import net.wg.infrastructure.base.meta.*;
    import net.wg.infrastructure.base.meta.impl.*;
    
    public class BaseExchangeWindow extends net.wg.infrastructure.base.meta.impl.BaseExchangeWindowMeta implements net.wg.infrastructure.base.meta.IBaseExchangeWindowMeta
    {
        public function BaseExchangeWindow()
        {
            super();
            return;
        }

        public function as_setPrimaryCurrency(arg1:Number):void
        {
            if (this.totalPrimaryCurrency != arg1) 
            {
                this.totalPrimaryCurrency = arg1;
                invalidate(TOTAL_PRIMARY_CURRENCY_INVALID);
            }
            return;
        }

        public function as_exchangeRate(arg1:Number, arg2:Number):void
        {
            if (!(this.rate == arg1) || !(this.actionRate == arg2)) 
            {
                this.rate = arg1;
                this.actionRate = arg2;
                this.actualRate = !(this.rate == this.actionRate) && !(this.actionRate == 0) ? this.actionRate : this.rate;
                invalidate(RATES_INVALID);
            }
            return;
        }

        protected override function draw():void
        {
            super.draw();
            if (isInvalid(RATES_INVALID)) 
                this.applyRatesChanges();
            if (isInvalid(TOTAL_PRIMARY_CURRENCY_INVALID)) 
                this.applyPrimaryCurrencyChange();
            return;
        }

        protected function applyPrimaryCurrencyChange():void
        {
            var loc1:*="Flash applyPrimaryCurrencyChange method have to be overridden";
            DebugUtils.LOG_ERROR(loc1, this);
            throw new Error(loc1);
        }

        protected function applyRatesChanges():void
        {
            var loc1:*="Flash applyRatesChanges method have to be overridden";
            DebugUtils.LOG_ERROR(loc1, this);
            throw new Error(loc1);
        }

        protected function cancelBtnClickHandler(arg1:flash.events.Event):void
        {
            onWindowCloseS();
            return;
        }

        protected static const TOTAL_PRIMARY_CURRENCY_INVALID:String="TotalPrimaryCurrencyInv";

        protected static const RATES_INVALID:String="ratesInv";

        protected var totalPrimaryCurrency:int=-1;

        protected var rate:uint;

        protected var actionRate:uint;

        protected var actualRate:uint=1;
    }
}
