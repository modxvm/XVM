package net.wg.gui.lobby.window 
{
    import flash.events.*;
    import flash.text.*;
    import net.wg.gui.components.controls.*;
    import net.wg.infrastructure.base.meta.*;
    import net.wg.utils.*;
    import scaleform.clik.events.*;
    
    public class ExchangeCurrencyWindow extends net.wg.gui.lobby.window.BaseExchangeWindow implements net.wg.infrastructure.base.meta.IExchangeWindowMeta
    {
        public function ExchangeCurrencyWindow()
        {
            super();
            isModal = false;
            canResize = false;
            canMinimize = false;
            isCentered = true;
            showWindowBg = false;
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            this.submitBtn.addEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.submitBtnClickHandler);
            this.cancelBtn.addEventListener(scaleform.clik.events.ButtonEvent.CLICK, cancelBtnClickHandler);
            var loc1:*;
            this.nsSecondaryCurrency.minimum = loc1 = 0;
            this.nsPrimaryCurrency.minimum = loc1;
            this.nsPrimaryCurrency.addEventListener(scaleform.clik.events.IndexEvent.INDEX_CHANGE, this.nsFirstCurrencyChangeHandler);
            this.nsSecondaryCurrency.addEventListener(scaleform.clik.events.IndexEvent.INDEX_CHANGE, this.nsSecondaryCurrencyChangeHandler);
            return;
        }

        public function set exchangeStep(arg1:Number):void
        {
            this._exchangeStep = arg1;
            invalidate(RATES_INVALID);
            return;
        }

        public function get exchangeStep():Number
        {
            return this._exchangeStep;
        }

        protected override function onDispose():void
        {
            super.onDispose();
            this.submitBtn.removeEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.submitBtnClickHandler);
            this.cancelBtn.removeEventListener(scaleform.clik.events.ButtonEvent.CLICK, cancelBtnClickHandler);
            this.nsPrimaryCurrency.removeEventListener(scaleform.clik.events.IndexEvent.INDEX_CHANGE, this.nsFirstCurrencyChangeHandler);
            this.nsSecondaryCurrency.removeEventListener(scaleform.clik.events.IndexEvent.INDEX_CHANGE, this.nsSecondaryCurrencyChangeHandler);
            return;
        }

        protected override function onPopulate():void
        {
            super.onPopulate();
            return;
        }

        protected override function applyPrimaryCurrencyChange():void
        {
            var loc1:*=totalPrimaryCurrency >= 0 ? totalPrimaryCurrency : 0;
            this.onHandPrimaryCurrencyText.text = App.utils.locale.gold(loc1);
            this.isUpdateResult = true;
            return;
        }

        protected override function applyRatesChanges():void
        {
            this.nsPrimaryCurrency.stepSize = this._exchangeStep;
            this.nsSecondaryCurrency.stepSize = actualRate * this._exchangeStep;
            this.headerMC.setRates(rate, actionRate);
            this.headerMC.validateNow();
            invalidate(SELECTED_PRIMARY_CURRENCY_INVALID);
            return;
        }

        protected function applyResultUpdating():void
        {
            var loc1:*=App.utils.locale;
            var loc2:*=totalPrimaryCurrency - this.selectedPrimaryCurrency;
            this.resultPrimaryCurrencyText.text = loc1.gold(loc2 >= 0 ? loc2 : 0);
            this.resultSecondaryCurrencyText.text = loc1.gold(this.totalSecondaryCurrency + this.selectedPrimaryCurrency * actualRate);
            return;
        }

        protected function isSubmitOperationAllowed():Boolean
        {
            return this.selectedPrimaryCurrency > 0;
        }

        protected override function draw():void
        {
            super.draw();
            if (isInvalid(TOTAL_SECONDARY_CURRENCY_CHANGED)) 
            {
                invalidate(SELECTED_PRIMARY_CURRENCY_INVALID);
                this.onHandSecondaryCurrencyText.text = App.utils.locale.gold(this.totalSecondaryCurrency);
                this.isUpdateResult = true;
            }
            if (isInvalid(SELECTED_PRIMARY_CURRENCY_INVALID)) 
            {
                this.isUpdateResult = true;
                this.nsPrimaryCurrency.value = this.selectedPrimaryCurrency;
                this.nsSecondaryCurrency.value = this.selectedPrimaryCurrency * actualRate;
                this.submitBtn.enabled = this.isSubmitOperationAllowed();
            }
            if (this.isUpdateResult) 
            {
                this.applyResultUpdating();
            }
            return;
        }

        public function as_setSecondaryCurrency(arg1:Number):void
        {
            if (this.totalSecondaryCurrency != arg1) 
            {
                this.totalSecondaryCurrency = arg1;
                invalidate(TOTAL_SECONDARY_CURRENCY_CHANGED);
            }
            return;
        }

        protected function submitBtnClickHandler(arg1:flash.events.Event):void
        {
            exchangeS(this.selectedPrimaryCurrency);
            return;
        }

        internal function nsFirstCurrencyChangeHandler(arg1:scaleform.clik.events.IndexEvent):void
        {
            this.selectedPrimaryCurrency = this.nsPrimaryCurrency.value;
            invalidate(SELECTED_PRIMARY_CURRENCY_INVALID);
            return;
        }

        internal function nsSecondaryCurrencyChangeHandler(arg1:scaleform.clik.events.IndexEvent):void
        {
            this.selectedPrimaryCurrency = Math.floor(this.nsSecondaryCurrency.value / actualRate);
            invalidate(SELECTED_PRIMARY_CURRENCY_INVALID);
            return;
        }

        public override function as_setPrimaryCurrency(arg1:Number):void
        {
            if (totalPrimaryCurrency != arg1) 
            {
                totalPrimaryCurrency = arg1;
                if (totalPrimaryCurrency - this.selectedPrimaryCurrency < 0) 
                {
                    this.selectedPrimaryCurrency = 0;
                    invalidate(SELECTED_PRIMARY_CURRENCY_INVALID);
                }
                invalidate(TOTAL_PRIMARY_CURRENCY_INVALID);
            }
            return;
        }

        internal static const SELECTED_PRIMARY_CURRENCY_INVALID:String="selectedPrimaryCurrencyInv";

        internal static const TOTAL_SECONDARY_CURRENCY_CHANGED:String="totalSecondaryCurrensyChanged";

        public var submitBtn:net.wg.gui.components.controls.SoundButtonEx;

        public var toExchangeSecondaryCurrencyIco:net.wg.gui.components.controls.IconText;

        public var toExchangePrimaryCurrencyIco:net.wg.gui.components.controls.IconText;

        public var resultSecondaryCurrencyText:net.wg.gui.components.controls.IconText;

        public var resultPrimaryCurrencyText:net.wg.gui.components.controls.IconText;

        public var onHandSecondaryCurrencyText:net.wg.gui.components.controls.IconText;

        public var onHandPrimaryCurrencyText:net.wg.gui.components.controls.IconText;

        public var lblExchangeResult:flash.text.TextField;

        public var lblToExchange:flash.text.TextField;

        protected var isUpdateResult:Boolean;

        internal var selectedPrimaryCurrency:uint=0;

        public var nsSecondaryCurrency:net.wg.gui.components.controls.NumericStepper;

        public var nsPrimaryCurrency:net.wg.gui.components.controls.NumericStepper;

        public var headerMC:net.wg.gui.lobby.window.ExchangeHeader;

        public var cancelBtn:net.wg.gui.components.controls.SoundButtonEx;

        internal var _exchangeStep:Number=1;

        internal var totalSecondaryCurrency:Number=0;
    }
}
