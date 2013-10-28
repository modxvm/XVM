package net.wg.gui.lobby.window
{
   import net.wg.infrastructure.base.meta.IExchangeVcoinWindowMeta;
   import flash.display.MovieClip;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.gui.utils.ExcludeTweenManager;
   import net.wg.data.constants.Errors;
   import net.wg.infrastructure.interfaces.IWindow;
   import scaleform.clik.utils.Constraints;
   import scaleform.clik.constants.ConstrainMode;
   import flash.display.Sprite;
   import net.wg.gui.components.controls.IconText;
   import net.wg.data.constants.ColorSchemeNames;
   import scaleform.clik.events.ButtonEvent;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import scaleform.clik.motion.Tween;
   import fl.transitions.easing.Strong;


   public class ExchangeVcoinWindow extends ExchangeCurrencyWindow implements IExchangeVcoinWindowMeta
   {
          
      public function ExchangeVcoinWindow() {
         this.animationManager = new ExcludeTweenManager();
         super();
         this.tweenSet = {};
         this.tweenSet.ease = Strong.easeOut;
         this.tweenSet.onComplete = this.onTweenComplete;
      }

      private static var tweenObj:Object;

      private static const tweenDuration:uint = 350;

      private static function rateLabelFunction(param1:Number) : String {
         return App.utils.locale.float(param1);
      }

      public var warningMc:ExchangeVcoinWarningMC;

      public var mainBackgroundMc:MovieClip;

      public var buyVcoinBtn:SoundButtonEx;

      public var buyVcoin:Function = null;

      private var animationManager:ExcludeTweenManager;

      private var windowOriginalHeight:Number = NaN;

      private var tweenSet:Object;

      private var exchangeData:VcoinExchangeDataVO;

      public function buyVcoinS() : void {
         App.utils.asserter.assertNotNull(this.buyVcoin,"exchange" + Errors.CANT_NULL);
         this.buyVcoin();
      }

      public function as_setTargetCurrencyData(param1:Object) : void {
         this.exchangeData = new VcoinExchangeDataVO(param1);
         selectedPrimaryCurrency = this.exchangeData.minTransactVal;
         exchangeStep = this.exchangeData.countStep;
      }

      override public function set window(param1:IWindow) : void {
         super.window = param1;
         if(param1)
         {
            window.title = MENU.EXCHANGEVCOIN_TITLE;
            this.windowOriginalHeight = window.sourceView.height + window.contentPadding.vertical;
            invalidate(TOTAL_PRIMARY_CURRENCY_INVALID);
         }
      }

      override protected function preInitialize() : void {
         super.preInitialize();
         constraints = new Constraints(this,ConstrainMode.REFLOW);
      }

      override protected function configUI() : void {
         super.configUI();
         this.buyVcoinBtn.label = App.utils.locale.makeString(MENU.EXCHANGEVCOIN_BUYVCOINBTNNAME);
         this.warningMc.visible = false;
         var _loc1_:int = this.warningMc.parent.getChildIndex(this.warningMc)-1;
         var _loc2_:Sprite = new Sprite();
         addChildAt(_loc2_,_loc1_);
         _loc2_.addChild(lblToExchange);
         _loc2_.addChild(lblExchangeResult);
         _loc2_.addChild(resultPrimaryCurrencyText);
         _loc2_.addChild(resultSecondaryCurrencyText);
         _loc2_.addChild(toExchangePrimaryCurrencyIco);
         _loc2_.addChild(toExchangeSecondaryCurrencyIco);
         _loc2_.addChild(submitBtn);
         _loc2_.addChild(cancelBtn);
         _loc2_.addChild(this.buyVcoinBtn);
         _loc2_.name = "movingContainer";
         _loc2_.addChild(nsPrimaryCurrency);
         _loc2_.addChild(nsSecondaryCurrency);
         constraints.addElement(this.mainBackgroundMc.name,this.mainBackgroundMc,Constraints.ALL);
         constraints.addElement(_loc2_.name,_loc2_,Constraints.BOTTOM);
         onHandPrimaryCurrencyText.filters = ExchangeUtils.getGlow(IconText.VCOIN);
         onHandSecondaryCurrencyText.filters = ExchangeUtils.getGlow(IconText.GOLD);
         resultPrimaryCurrencyText.filters = ExchangeUtils.getGlow(IconText.VCOIN);
         resultSecondaryCurrencyText.filters = ExchangeUtils.getGlow(IconText.GOLD);
         toExchangePrimaryCurrencyIco.filters = ExchangeUtils.getGlow(IconText.VCOIN);
         toExchangeSecondaryCurrencyIco.filters = ExchangeUtils.getGlow(IconText.GOLD);
         resultPrimaryCurrencyText.icon = IconText.VCOIN;
         resultSecondaryCurrencyText.icon = IconText.GOLD;
         toExchangePrimaryCurrencyIco.icon = IconText.VCOIN;
         toExchangeSecondaryCurrencyIco.icon = IconText.GOLD;
         onHandPrimaryCurrencyText.icon = IconText.VCOIN;
         onHandSecondaryCurrencyText.icon = IconText.GOLD;
         var _loc3_:uint = App.colorSchemeMgr.getRGB(ColorSchemeNames.TEXT_COLOR_VCOIN);
         var _loc4_:uint = App.colorSchemeMgr.getRGB(ColorSchemeNames.TEXT_COLOR_GOLD);
         onHandPrimaryCurrencyText.textColor = _loc3_;
         onHandSecondaryCurrencyText.textColor = _loc4_;
         resultPrimaryCurrencyText.icon = IconText.VCOIN;
         resultSecondaryCurrencyText.icon = IconText.GOLD;
         resultPrimaryCurrencyText.textColor = _loc3_;
         resultSecondaryCurrencyText.textColor = _loc4_;
         nsPrimaryCurrency.textColor = _loc3_;
         nsSecondaryCurrency.textColor = _loc4_;
         headerMC.rate_part_1.icon = IconText.VCOIN;
         headerMC.rate_part_1.textColor = _loc3_;
         headerMC.rate_part_1.filters = ExchangeUtils.getGlow(IconText.VCOIN);
         headerMC.rate_part_2.icon = IconText.GOLD;
         headerMC.rate_part_2.textColor = _loc4_;
         headerMC.rate_part_2.filters = ExchangeUtils.getGlow(IconText.GOLD);
         this.buyVcoinBtn.addEventListener(ButtonEvent.CLICK,this.buyVcoinBtnHandler,false,0,true);
         this.warningMc.buyVcoinBtn.addEventListener(ButtonEvent.CLICK,this.buyVcoinBtnHandler,false,0,true);
         headerMC.rateLabelFunction = rateLabelFunction;
      }

      override protected function draw() : void {
         var _loc1_:* = NaN;
         super.draw();
         if(!isNaN(this.windowOriginalHeight) && (isInvalid(TOTAL_PRIMARY_CURRENCY_INVALID)))
         {
            if(this.isSubmitOperationAllowed())
            {
               this.warningMc.visible = false;
               _loc1_ = this.windowOriginalHeight;
               onHandPrimaryCurrencyText.textColor = App.colorSchemeMgr.getRGB(ColorSchemeNames.TEXT_COLOR_VCOIN);
            }
            else
            {
               this.warningMc.visible = true;
               _loc1_ = this.warningMc.bg.height + this.windowOriginalHeight - this.warningMc.contentPadding;
               onHandPrimaryCurrencyText.textColor = App.colorSchemeMgr.getRGB(ColorSchemeNames.TEXT_COLOR_ERROR);
            }
            if(window.height != _loc1_)
            {
               tweenObj.height = _loc1_;
               this.animationManager.registerAndLaunch(tweenDuration,window,tweenObj,this.tweenSet);
            }
         }
      }

      override protected function applyWaitingChanges() : void {
         var _loc1_:DisplayObject = null;
         super.applyWaitingChanges();
         var _loc2_:int = numChildren;
         var _loc3_:* = 0;
         while(_loc3_ < _loc2_)
         {
            _loc1_ = this.getChildAt(_loc3_);
            if(_loc1_ != waiting)
            {
               _loc1_.visible = !showWaiting;
            }
            _loc3_++;
         }
      }

      override protected function isSubmitOperationAllowed() : Boolean {
         var _loc1_:Number = -1;
         if(this.exchangeData)
         {
            _loc1_ = this.exchangeData.minTransactVal;
         }
         return totalPrimaryCurrency >= _loc1_;
      }

      override protected function applyResultUpdating() : void {
         var _loc1_:uint = 0;
         var _loc2_:uint = 0;
         super.applyResultUpdating();
         if(this.exchangeData)
         {
            _loc1_ = Math.min(this.exchangeData.maxTransactVal,totalPrimaryCurrency);
            _loc2_ = Math.min(this.exchangeData.minTransactVal,totalPrimaryCurrency);
            nsPrimaryCurrency.minimum = _loc2_;
            nsPrimaryCurrency.maximum = _loc1_;
            nsSecondaryCurrency.minimum = _loc2_ * actualRate;
            nsSecondaryCurrency.maximum = _loc1_ * actualRate;
            this.warningMc.minTransactValue = this.exchangeData.minTransactVal;
            invalidate(TOTAL_PRIMARY_CURRENCY_INVALID);
         }
      }

      override protected function onDispose() : void {
         super.onDispose();
         if(this.animationManager)
         {
            this.animationManager.dispose();
            this.animationManager = null;
         }
         this.buyVcoinBtn.removeEventListener(ButtonEvent.CLICK,this.buyVcoinBtnHandler);
         this.warningMc.buyVcoinBtn.removeEventListener(ButtonEvent.CLICK,this.buyVcoinBtnHandler);
      }

      override protected function submitBtnClickHandler(param1:Event) : void {
         if(!showWaiting)
         {
            super.submitBtnClickHandler(param1);
         }
      }

      override protected function cancelBtnClickHandler(param1:Event) : void {
         if(!showWaiting)
         {
            super.cancelBtnClickHandler(param1);
         }
      }

      private function onTweenComplete(param1:Tween) : void {
         this.animationManager.unregister(param1);
      }

      private function buyVcoinBtnHandler(param1:ButtonEvent) : void {
         if(!showWaiting)
         {
            this.buyVcoinS();
         }
      }
   }

}