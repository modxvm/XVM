package net.wg.gui.lobby.window
{
   import net.wg.infrastructure.base.meta.IExchangeWindowMeta;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.gui.components.controls.NumericStepper;
   import flash.text.TextField;
   import net.wg.gui.components.controls.IconText;
   import net.wg.gui.components.controls.WalletResourcesStatus;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.clik.events.IndexEvent;
   import flash.events.Event;
   import net.wg.utils.ILocale;
   
   public class ExchangeCurrencyWindow extends BaseExchangeWindow implements IExchangeWindowMeta
   {
      
      public function ExchangeCurrencyWindow() {
         super();
         isModal = false;
         canResize = false;
         canMinimize = false;
         isCentered = true;
      }
      
      private static const SELECTED_PRIMARY_CURRENCY_INVALID:String = "selectedPrimaryCurrencyInv";
      
      private static const TOTAL_SECONDARY_CURRENCY_CHANGED:String = "totalSecondaryCurrensyChanged";
      
      public var submitBtn:SoundButtonEx;
      
      public var cancelBtn:SoundButtonEx;
      
      public var headerMC:ExchangeHeader;
      
      public var nsPrimaryCurrency:NumericStepper;
      
      public var nsSecondaryCurrency:NumericStepper;
      
      private var _selectedPrimaryCurrency:uint = 0;
      
      protected var isUpdateResult:Boolean;
      
      public var lblToExchange:TextField;
      
      public var lblExchangeResult:TextField;
      
      public var onHandPrimaryCurrencyText:IconText;
      
      public var onHandSecondaryCurrencyText:IconText;
      
      public var resultPrimaryCurrencyText:IconText;
      
      public var resultSecondaryCurrencyText:IconText;
      
      public var toExchangePrimaryCurrencyIco:IconText;
      
      public var toExchangeSecondaryCurrencyIco:IconText;
      
      public var onHandHaveNotGold:WalletResourcesStatus = null;
      
      public var resultHaveNotGold:WalletResourcesStatus = null;
      
      private var _exchangeStep:Number = 1;
      
      private var totalSecondaryCurrency:Number = 0;
      
      override protected function configUI() : void {
         super.configUI();
         this.submitBtn.addEventListener(ButtonEvent.CLICK,this.submitBtnClickHandler);
         this.cancelBtn.addEventListener(ButtonEvent.CLICK,cancelBtnClickHandler);
         this.nsPrimaryCurrency.minimum = this.nsSecondaryCurrency.minimum = 0;
         this.nsPrimaryCurrency.addEventListener(IndexEvent.INDEX_CHANGE,this.nsFirstCurrencyChangeHandler);
         this.nsSecondaryCurrency.addEventListener(IndexEvent.INDEX_CHANGE,this.nsSecondaryCurrencyChangeHandler);
      }
      
      override public function as_setPrimaryCurrency(param1:Number) : void {
         if(totalPrimaryCurrency != param1)
         {
            totalPrimaryCurrency = param1;
            if(totalPrimaryCurrency - this.selectedPrimaryCurrency < 0)
            {
               this.selectedPrimaryCurrency = 0;
               invalidate(SELECTED_PRIMARY_CURRENCY_INVALID);
            }
            invalidate(TOTAL_PRIMARY_CURRENCY_INVALID);
         }
      }
      
      private function nsSecondaryCurrencyChangeHandler(param1:IndexEvent) : void {
         this.selectedPrimaryCurrency = Math.floor(this.nsSecondaryCurrency.value / actualRate);
         invalidate(SELECTED_PRIMARY_CURRENCY_INVALID);
      }
      
      private function nsFirstCurrencyChangeHandler(param1:IndexEvent) : void {
         this.selectedPrimaryCurrency = this.nsPrimaryCurrency.value;
         invalidate(SELECTED_PRIMARY_CURRENCY_INVALID);
      }
      
      protected function submitBtnClickHandler(param1:Event) : void {
         exchangeS(this.selectedPrimaryCurrency);
      }
      
      public function as_setSecondaryCurrency(param1:Number) : void {
         if(this.totalSecondaryCurrency != param1)
         {
            this.totalSecondaryCurrency = param1;
            invalidate(TOTAL_SECONDARY_CURRENCY_CHANGED);
         }
      }
      
      override protected function draw() : void {
         super.draw();
         if(isInvalid(TOTAL_SECONDARY_CURRENCY_CHANGED))
         {
            invalidate(SELECTED_PRIMARY_CURRENCY_INVALID);
            this.onHandSecondaryCurrencyText.text = App.utils.locale.gold(this.totalSecondaryCurrency);
            this.isUpdateResult = true;
         }
         if(isInvalid(SELECTED_PRIMARY_CURRENCY_INVALID))
         {
            this.isUpdateResult = true;
            this.nsPrimaryCurrency.value = this.selectedPrimaryCurrency;
            this.nsSecondaryCurrency.value = this.selectedPrimaryCurrency * actualRate;
            this.submitBtn.enabled = this.isSubmitOperationAllowed();
         }
         if(this.isUpdateResult)
         {
            this.applyResultUpdating();
         }
      }
      
      protected function isSubmitOperationAllowed() : Boolean {
         return this.selectedPrimaryCurrency > 0;
      }
      
      protected function applyResultUpdating() : void {
         var _loc1_:ILocale = App.utils.locale;
         var _loc2_:Number = totalPrimaryCurrency - this.selectedPrimaryCurrency;
         this.resultPrimaryCurrencyText.text = _loc1_.gold(_loc2_);
         this.resultSecondaryCurrencyText.text = _loc1_.gold(this.totalSecondaryCurrency + this.selectedPrimaryCurrency * actualRate);
      }
      
      override protected function applyRatesChanges() : void {
         this.nsPrimaryCurrency.stepSize = this._exchangeStep;
         this.nsSecondaryCurrency.stepSize = actualRate * this._exchangeStep;
         this.headerMC.setRates(rate,actionRate);
         this.headerMC.validateNow();
         invalidate(SELECTED_PRIMARY_CURRENCY_INVALID);
      }
      
      override protected function applyPrimaryCurrencyChange() : void {
         this.onHandPrimaryCurrencyText.text = App.utils.locale.gold(totalPrimaryCurrency);
         this.isUpdateResult = true;
      }
      
      override protected function onPopulate() : void {
         super.onPopulate();
      }
      
      override protected function onDispose() : void {
         super.onDispose();
         this.submitBtn.removeEventListener(ButtonEvent.CLICK,this.submitBtnClickHandler);
         this.cancelBtn.removeEventListener(ButtonEvent.CLICK,cancelBtnClickHandler);
         this.nsPrimaryCurrency.removeEventListener(IndexEvent.INDEX_CHANGE,this.nsFirstCurrencyChangeHandler);
         this.nsSecondaryCurrency.removeEventListener(IndexEvent.INDEX_CHANGE,this.nsSecondaryCurrencyChangeHandler);
         this.nsPrimaryCurrency.dispose();
         this.nsPrimaryCurrency = null;
         this.nsSecondaryCurrency.dispose();
         this.nsPrimaryCurrency = null;
         if(this.onHandHaveNotGold)
         {
            this.onHandHaveNotGold.dispose();
            this.onHandHaveNotGold = null;
         }
         if(this.resultHaveNotGold)
         {
            this.resultHaveNotGold.dispose();
            this.resultHaveNotGold = null;
         }
      }
      
      public function get exchangeStep() : Number {
         return this._exchangeStep;
      }
      
      public function set exchangeStep(param1:Number) : void {
         this._exchangeStep = param1;
         invalidate(RATES_INVALID);
      }
      
      public function get selectedPrimaryCurrency() : Number {
         return this._selectedPrimaryCurrency;
      }
      
      public function set selectedPrimaryCurrency(param1:Number) : void {
         if(this._selectedPrimaryCurrency == param1)
         {
            return;
         }
         this._selectedPrimaryCurrency = param1;
      }
      
      public function as_setWalletStatus(param1:Object) : void {
         App.utils.voMgr.walletStatusVO.update(param1);
         var _loc2_:* = false;
         if((this.onHandHaveNotGold) && (this.resultHaveNotGold))
         {
            _loc2_ = !this.onHandHaveNotGold.updateStatus(App.utils.voMgr.walletStatusVO.goldStatus);
            this.resultHaveNotGold.updateStatus(App.utils.voMgr.walletStatusVO.goldStatus);
         }
         if(this.onHandPrimaryCurrencyText)
         {
            this.onHandPrimaryCurrencyText.visible = _loc2_;
         }
         if(this.resultPrimaryCurrencyText)
         {
            this.resultPrimaryCurrencyText.visible = _loc2_;
         }
         this.submitBtn.enabled = _loc2_;
      }
   }
}
