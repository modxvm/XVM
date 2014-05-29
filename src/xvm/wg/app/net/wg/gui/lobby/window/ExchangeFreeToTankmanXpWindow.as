package net.wg.gui.lobby.window
{
   import net.wg.infrastructure.base.meta.impl.ExchangeFreeToTankmanXpWindowMeta;
   import net.wg.infrastructure.base.meta.IExchangeFreeToTankmanXpWindowMeta;
   import net.wg.gui.components.controls.NumericStepper;
   import flash.display.MovieClip;
   import net.wg.gui.components.controls.IconText;
   import net.wg.gui.components.controls.ActionPrice;
   import net.wg.gui.components.controls.WalletResourcesStatus;
   import flash.display.Sprite;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.gui.components.advanced.SkillsItemRenderer;
   import flash.text.TextField;
   import net.wg.infrastructure.interfaces.IWindow;
   import scaleform.clik.utils.Padding;
   import flash.events.Event;
   import scaleform.clik.utils.Constraints;
   import scaleform.clik.constants.ConstrainMode;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.clik.events.IndexEvent;
   import net.wg.gui.components.controls.VO.ActionPriceVO;
   import net.wg.data.constants.IconsTypes;


   public class ExchangeFreeToTankmanXpWindow extends ExchangeFreeToTankmanXpWindowMeta implements IExchangeFreeToTankmanXpWindowMeta
   {
          
      public function ExchangeFreeToTankmanXpWindow() {
         super();
         isModal = false;
         canResize = false;
         canMinimize = false;
         isCentered = true;
         showWindowBg = false;
      }

      public static const INIT_DATA_INVALID:String = "initDataInv";

      public static const SELECTED_VALUE_INVALID:String = "selValInvalid";

      public static const RECALC_VALUE_INVALID:String = "recalcValueInvalid";

      public static const WALLET_STATE_INVALID:String = "walletStateInvalid";

      public static const WARNING_INVALID:String = "warningInvalid";

      private static const MOVINGCONTAINER_NAME:String = "movingContainer";

      public var nsLevel:NumericStepper;

      public var form_bg:MovieClip;

      public var itToPay:IconText;

      public var actionPrice:ActionPrice;

      public var walletStatus:WalletResourcesStatus;

      public var background:Sprite;

      public var warningMc:ExchangeFreeToTankmanXpWarning;

      public var submitBtn:SoundButtonEx;

      public var cancelBtn:SoundButtonEx;

      public var skillAfter:SkillsItemRenderer;

      public var skillBefore:SkillsItemRenderer;

      public var afterTeachingHeader:TextField;

      public var blockMc:MovieClip;

      private var initData:ExchangeFreeToTankmanInitVO;

      private var selectedValue:uint;

      private var originalWindowHeight:Number = NaN;

      private var expandedWindowHeight:Number = NaN;

      private var isAlertWalletVisible:Boolean = false;

      private var _price:Number = 0;

      private var _actionPriceData:Object = null;

      private var _initMax:Boolean = false;

      override public function setWindow(param1:IWindow) : void {
         var _loc2_:Padding = null;
         super.setWindow(param1);
         if(param1)
         {
            window.title = MENU.TEACHINGSKILL_TITLE;
            _loc2_ = window.contentPadding as Padding;
            _loc2_.right = _loc2_.right - 4;
            window.contentPadding = _loc2_;
            addEventListener(Event.ENTER_FRAME,this.calcHeightInNextFrame,false,0,true);
         }
      }

      public function as_setInitData(param1:Object) : void {
         this.initData = new ExchangeFreeToTankmanInitVO(param1);
         invalidate(INIT_DATA_INVALID);
      }

      public function as_setCalcValueResponse(param1:Number, param2:Object) : void {
         this._price = param1;
         this._actionPriceData = param2;
         invalidate(RECALC_VALUE_INVALID);
      }

      public function as_setWalletStatus(param1:Object) : void {
         App.utils.voMgr.walletStatusVO.update(param1);
         this.updateWalletStatus();
      }

      override protected function preInitialize() : void {
         super.preInitialize();
         constraints = new Constraints(this,ConstrainMode.REFLOW);
      }

      override protected function configUI() : void {
         super.configUI();
         this.submitBtn.addEventListener(ButtonEvent.CLICK,this.onClickSubmitButton,false,0,true);
         this.cancelBtn.addEventListener(ButtonEvent.CLICK,this.onClickCancelButton,false,0,true);
         this.nsLevel.addEventListener(IndexEvent.INDEX_CHANGE,this.nsFirstCurrencyChangeHandler,false,0,true);
         try
         {
            this.warningMc.textField.text = App.utils.locale.makeString(MENU.TEACHINGSKILL_FREEXPISTIGHT);
         }
         catch(e:Error)
         {
         }
         this.warningMc.visible = false;
         this.blockMc.visible = false;
         var _loc1_:int = this.background.parent.getChildIndex(this.background) + 1;
         var _loc2_:Sprite = new Sprite();
         addChildAt(_loc2_,_loc1_);
         _loc2_.addChild(this.afterTeachingHeader);
         _loc2_.addChild(this.skillAfter);
         _loc2_.addChild(this.submitBtn);
         _loc2_.addChild(this.cancelBtn);
         constraints.addElement(this.background.name,this.background,Constraints.ALL);
         constraints.addElement(this.form_bg.name,this.form_bg,Constraints.ALL);
         constraints.addElement(MOVINGCONTAINER_NAME,_loc2_,Constraints.BOTTOM);
      }

      override protected function draw() : void {
         var _loc1_:* = false;
         var _loc2_:ActionPriceVO = null;
         super.draw();
         if(isInvalid(INIT_DATA_INVALID))
         {
            if(this.initData)
            {
               this.nsLevel.minimum = this.initData.lastSkillLevel;
               this.nsLevel.maximum = this.initData.nextSkillLevel;
               if(!this._initMax)
               {
                  this.nsLevel.value = this.nsLevel.maximum;
                  this._initMax = true;
               }
               else
               {
                  if(this.nsLevel.value >= this.nsLevel.maximum)
                  {
                     this.nsLevel.value = this.nsLevel.maximum;
                  }
               }
               this.nsLevel.enabled = !this.isAlertWalletVisible && !(this.initData.lastSkillLevel == this.initData.nextSkillLevel);
               this.skillBefore.data = this.initData.beforeSkill;
               this.skillAfter.data = this.initData.afterSkill;
               this.selectedValue = this.nsLevel.value;
               invalidate(SELECTED_VALUE_INVALID);
               invalidate(WARNING_INVALID);
            }
         }
         if(isInvalid(SELECTED_VALUE_INVALID))
         {
            if(this.initData)
            {
               calcValueRequestS(this.selectedValue);
            }
         }
         if((isInvalid(WARNING_INVALID)) && !isNaN(this.originalWindowHeight))
         {
            _loc1_ = !this.nsLevel.enabled && !this.isAlertWalletVisible;
            if(_loc1_ != this.warningMc.visible)
            {
               this.warningMc.visible = _loc1_;
               if(_loc1_)
               {
                  window.height = this.expandedWindowHeight;
               }
               else
               {
                  window.height = this.originalWindowHeight;
               }
            }
         }
         if(isInvalid(WALLET_STATE_INVALID))
         {
            if(!this.isAlertWalletVisible && (this.initData))
            {
               this.nsLevel.enabled = !(this.initData.lastSkillLevel == this.initData.nextSkillLevel);
            }
            else
            {
               this.nsLevel.enabled = false;
            }
            invalidate(WARNING_INVALID);
         }
         if(isInvalid(RECALC_VALUE_INVALID))
         {
            if(this.initData)
            {
               this.nsLevel.enabled = !this.isAlertWalletVisible && !(this.initData.lastSkillLevel == this.initData.nextSkillLevel);
            }
            else
            {
               this.nsLevel.enabled = !this.isAlertWalletVisible;
            }
            if(!this.isAlertWalletVisible)
            {
               _loc2_ = null;
               if(this._actionPriceData)
               {
                  _loc2_ = new ActionPriceVO(this._actionPriceData);
                  _loc2_.ico = IconsTypes.FREE_XP;
               }
               this.actionPrice.setData(_loc2_);
               this.itToPay.visible = !this.actionPrice.visible;
               this.itToPay.text = App.utils.locale.integer(this._price);
               this.submitBtn.enabled = this._price > 0;
               this.initData.afterSkill.level = this.selectedValue;
               this.skillAfter.data = this.initData.afterSkill;
            }
            else
            {
               this.actionPrice.visible = false;
               this.itToPay.visible = false;
               this.submitBtn.enabled = false;
            }
         }
      }

      override protected function onDispose() : void {
         super.onDispose();
         this.submitBtn.addEventListener(ButtonEvent.CLICK,this.onClickSubmitButton,false,0,true);
         this.cancelBtn.addEventListener(ButtonEvent.CLICK,this.onClickCancelButton,false,0,true);
         removeEventListener(Event.ENTER_FRAME,this.calcHeightInNextFrame);
         this.submitBtn.dispose();
         this.submitBtn = null;
         this.cancelBtn.dispose();
         this.cancelBtn = null;
         this.nsLevel.dispose();
         this.nsLevel = null;
         this.skillAfter.dispose();
         this.skillAfter = null;
         this.skillBefore.dispose();
         this.skillBefore = null;
         if(this.walletStatus)
         {
            this.walletStatus.dispose();
            this.walletStatus = null;
         }
      }

      private function updateWalletStatus() : void {
         if(App.utils)
         {
            this.isAlertWalletVisible = this.walletStatus.updateStatus(App.utils.voMgr.walletStatusVO.freeXpStatus);
            invalidate(WALLET_STATE_INVALID,RECALC_VALUE_INVALID);
         }
      }

      private function nsFirstCurrencyChangeHandler(param1:IndexEvent) : void {
         this.selectedValue = this.nsLevel.value;
         invalidate(SELECTED_VALUE_INVALID);
      }

      private function calcHeightInNextFrame(param1:Event) : void {
         removeEventListener(Event.ENTER_FRAME,this.calcHeightInNextFrame);
         this.originalWindowHeight = window.height;
         this.expandedWindowHeight = this.originalWindowHeight + this.warningMc.height - 30;
         invalidate(WARNING_INVALID);
      }

      private function onClickSubmitButton(param1:ButtonEvent) : void {
         applyS();
      }

      private function onClickCancelButton(param1:ButtonEvent) : void {
         onWindowCloseS();
      }
   }

}