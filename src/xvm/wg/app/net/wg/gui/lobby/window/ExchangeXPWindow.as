package net.wg.gui.lobby.window
{
   import net.wg.infrastructure.base.meta.IExchangeXpWindowMeta;
   import net.wg.gui.components.advanced.SortableHeaderButtonBar;
   import flash.text.TextField;
   import net.wg.gui.components.controls.IconText;
   import net.wg.gui.components.controls.CompactCheckBox;
   import net.wg.gui.components.controls.NumericStepper;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.gui.components.controls.WalletResourcesStatus;
   import net.wg.infrastructure.interfaces.IWindow;
   import scaleform.clik.utils.Padding;
   import net.wg.utils.ILocale;
   import flash.text.TextFieldAutoSize;
   import scaleform.clik.events.IndexEvent;
   import scaleform.clik.events.ButtonEvent;
   import flash.events.Event;
   import net.wg.gui.components.advanced.SortingButton;
   import net.wg.data.constants.IconsTypes;
   import net.wg.data.constants.ColorSchemeNames;
   import scaleform.clik.data.DataProvider;


   public class ExchangeXPWindow extends BaseExchangeWindow implements IExchangeXpWindowMeta
   {
          
      public function ExchangeXPWindow() {
         super();
         isModal = false;
         canResize = false;
         canMinimize = false;
         isCentered = true;
      }

      private static const VEHICLES_DATA_INVALID:String = "listInv";

      private static const TOTAL_AVAILABLE_XP_INVALID:String = "totalAvailXP";

      private static const TOTAL_RESULT_INVALID:String = "resAll";

      public var buttonBar:SortableHeaderButtonBar;

      public var lblTotalAvailableXp:TextField;

      public var itTotalAvailableXp:IconText;

      public var cbSelectAll:CompactCheckBox;

      public var nsXpExchange:NumericStepper;

      public var nsGoldExchange:NumericStepper;

      public var itIconXp:IconText;

      public var itIconGold:IconText;

      public var warningScreen:ExchangeXPWarningScreen;

      public var itExperienceResult:IconText;

      public var itGoldResult:IconText;

      public var itGoldBefore:IconText;

      public var itExperienceBefore:IconText;

      public var scrollList:ExchangeXPList;

      public var submitBtn:SoundButtonEx;

      public var cancelBtn:SoundButtonEx;

      public var headerMC:ExchangeHeader;

      public var onHandHaveNotMoney:WalletResourcesStatus = null;

      public var resultHaveNotMoney:WalletResourcesStatus = null;

      public var onHandHaveNotFreeXp:WalletResourcesStatus = null;

      public var resultHaveNotFreeXp:WalletResourcesStatus = null;

      private var scrollListProvider:Array;

      private var isHaveEliteVehicles:Boolean;

      private var totalXP:Number = 0;

      private var selectedGold:int;

      override public function setWindow(param1:IWindow) : void {
         var _loc2_:Padding = null;
         super.setWindow(param1);
         if(window)
         {
            window.title = MENU.EXCHANGEXP_TITLE;
            _loc2_ = new Padding();
            _loc2_.top = 33;
            _loc2_.bottom = this.cancelBtn.height + 20;
            _loc2_.right = 11;
            _loc2_.left = 10;
            window.formBgPadding = _loc2_;
         }
      }

      public function as_totalExperienceChanged(param1:Number) : void {
         this.totalXP = param1;
         var _loc2_:ILocale = App.utils?App.utils.locale:null;
         this.itExperienceBefore.text = _loc2_?_loc2_.gold(this.totalXP):this.totalXP.toString();
         invalidate(TOTAL_RESULT_INVALID);
      }

      public function as_vehiclesDataChanged(param1:Boolean, param2:Array) : void {
         var vehicleInfo:ExchangeXPVehicleVO = null;
         var object:Object = null;
         var lng:uint = 0;
         var i:int = 0;
         var isHaveElite:Boolean = param1;
         var data_:Array = param2;
         try
         {
            this.scrollListProvider = [];
            this.isHaveEliteVehicles = isHaveElite;
            if(this.isHaveEliteVehicles)
            {
               lng = data_.length;
               i = 0;
               while(i < lng)
               {
                  object = data_[i];
                  vehicleInfo = new ExchangeXPVehicleVO(object);
                  this.scrollListProvider.push(vehicleInfo);
                  i++;
               }
            }
            invalidate(VEHICLES_DATA_INVALID);
         }
         catch(e:Error)
         {
            DebugUtils.LOG_DEBUG("Flash \'as_vehiclesDataChanged\' method ERROR:  ",e.message,e.getStackTrace());
         }
      }

      public function as_setWalletStatus(param1:Object) : void {
         var _loc2_:* = false;
         var _loc3_:* = false;
         App.utils.voMgr.walletStatusVO.update(param1);
         _loc2_ = !this.onHandHaveNotMoney.updateStatus(App.utils.voMgr.walletStatusVO.goldStatus);
         this.resultHaveNotMoney.updateStatus(App.utils.voMgr.walletStatusVO.goldStatus);
         _loc3_ = !this.onHandHaveNotFreeXp.updateStatus(App.utils.voMgr.walletStatusVO.freeXpStatus);
         this.resultHaveNotFreeXp.updateStatus(App.utils.voMgr.walletStatusVO.freeXpStatus);
         var _loc4_:Boolean = (_loc2_) && (_loc3_);
         this.itGoldBefore.visible = _loc2_;
         this.itGoldResult.visible = _loc2_;
         this.itExperienceBefore.visible = _loc3_;
         this.itExperienceResult.visible = _loc3_;
         this.submitBtn.enabled = _loc4_;
      }

      override protected function configUI() : void {
         var _loc2_:* = NaN;
         super.configUI();
         this.lblTotalAvailableXp.autoSize = TextFieldAutoSize.RIGHT;
         this.nsXpExchange.minimum = 0;
         this.nsGoldExchange.minimum = 0;
         this.nsGoldExchange.stepSize = 1;
         this.nsXpExchange.addEventListener(IndexEvent.INDEX_CHANGE,this.nsXpChangeHandler,false,0,true);
         this.nsGoldExchange.addEventListener(IndexEvent.INDEX_CHANGE,this.nsGoldChangeHandler,false,0,true);
         this.cancelBtn.addEventListener(ButtonEvent.CLICK,cancelBtnClickHandler,false,0,true);
         this.submitBtn.addEventListener(ButtonEvent.CLICK,this.submitBtnClickHandler,false,0,true);
         addEventListener(ExchangeXPFromVehicleIR.SELECTION_CHANGED,this.selectionIRChanged,false,0,true);
         this.scrollList.rowCount = 7;
         this.cbSelectAll.addEventListener(Event.SELECT,this.checkBoxSelectHandler,false,0,true);
         this.buttonBar.addEventListener(SortingButton.SORT_DIRECTION_CHANGED,this.sortingDirectionChanged,false,0,true);
         this.buttonBar.selectedIndex = 1;
         this.scrollList.sortByVehicleName(true);
         this.itGoldBefore.filters = ExchangeUtils.getGlow(this.itGoldBefore.icon);
         this.itGoldResult.filters = ExchangeUtils.getGlow(this.itGoldResult.icon);
         this.headerMC.rateTo.icon = IconsTypes.ELITE_XP;
         this.headerMC.rateTo.filters = ExchangeUtils.getGlow(this.headerMC.rateTo.icon);
         var _loc1_:Number = App.colorSchemeMgr.getRGB(ColorSchemeNames.TEXT_COLOR_FREE_XP);
         this.headerMC.rateTo.textColor = _loc1_;
         this.itExperienceResult.textColor = _loc1_;
         this.itExperienceBefore.textColor = _loc1_;
         this.nsXpExchange.textColor = _loc1_;
         _loc2_ = App.colorSchemeMgr.getRGB(ColorSchemeNames.TEXT_COLOR_GOLD);
         this.headerMC.rateFrom.textColor = _loc2_;
         this.headerMC.rateFrom.filters = ExchangeUtils.getGlow(this.headerMC.rateFrom.icon);
         this.itGoldResult.textColor = _loc2_;
         this.itGoldBefore.textColor = _loc2_;
         this.nsGoldExchange.textColor = _loc2_;
         this.itIconXp.filters = ExchangeUtils.getGlow(this.itIconXp.icon);
         this.itIconGold.filters = ExchangeUtils.getGlow(this.itIconGold.icon);
         this.itGoldResult.filters = ExchangeUtils.getGlow(this.itGoldResult.icon);
         this.itGoldBefore.filters = ExchangeUtils.getGlow(this.itGoldBefore.icon);
         this.itTotalAvailableXp.textColor = App.colorSchemeMgr.getRGB(ColorSchemeNames.TEXT_COLOR_CREDITS);
      }

      override protected function draw() : void {
         var _loc2_:* = NaN;
         var _loc3_:* = NaN;
         var _loc4_:* = NaN;
         var _loc5_:* = false;
         var _loc6_:uint = 0;
         var _loc7_:ExchangeXPVehicleVO = null;
         var _loc8_:* = 0;
         var _loc9_:uint = 0;
         var _loc10_:* = NaN;
         super.draw();
         if(isInvalid(VEHICLES_DATA_INVALID))
         {
            this.scrollList.dataProvider = new DataProvider(this.scrollListProvider);
            if(this.isHaveEliteVehicles)
            {
               if(this.scrollListProvider == null || this.scrollListProvider.length == 0)
               {
                  this.warningScreen.text = App.utils.locale.makeString(DIALOGS.EXCHANGEXPWINDOW_ERROR_NOVEHICLESWITHXP);
                  this.warningScreen.visible = true;
               }
               else
               {
                  this.warningScreen.visible = false;
               }
            }
            else
            {
               this.warningScreen.text = App.utils.locale.makeString(DIALOGS.EXCHANGEXPWINDOW_ERROR_NOELITEVEHICLEINHANGAR);
               this.warningScreen.visible = true;
            }
            invalidate(TOTAL_AVAILABLE_XP_INVALID);
         }
         var _loc1_:ILocale = App.utils?App.utils.locale:null;
         if(isInvalid(TOTAL_AVAILABLE_XP_INVALID))
         {
            _loc2_ = 0;
            _loc3_ = 0;
            _loc5_ = true;
            if(this.scrollListProvider)
            {
               _loc6_ = this.scrollListProvider.length;
               _loc8_ = 0;
               while(_loc8_ < _loc6_)
               {
                  _loc7_ = this.scrollListProvider[_loc8_];
                  _loc4_ = _loc7_.xp;
                  if(_loc7_.isSelectCandidate)
                  {
                     _loc3_ = _loc3_ + _loc4_;
                  }
                  _loc5_ = (_loc5_) && (_loc7_.isSelectCandidate);
                  _loc2_ = _loc2_ + _loc4_;
                  _loc8_++;
               }
            }
            this.cbSelectAll.removeEventListener(Event.SELECT,this.checkBoxSelectHandler);
            this.cbSelectAll.selected = _loc5_;
            this.cbSelectAll.addEventListener(Event.SELECT,this.checkBoxSelectHandler,false,0,true);
            this.itTotalAvailableXp.text = _loc1_?_loc1_.gold(_loc2_):_loc2_.toString();
            this.selectedGold = Math.max(0,Math.min(_loc3_ / actualRate,totalPrimaryCurrency));
            this.nsGoldExchange.maximum = this.selectedGold;
            this.nsXpExchange.maximum = this.selectedGold * actualRate;
            invalidate(TOTAL_RESULT_INVALID);
         }
         if(isInvalid(TOTAL_RESULT_INVALID))
         {
            this.nsXpExchange.stepSize = actualRate;
            this.nsGoldExchange.value = this.selectedGold;
            _loc9_ = this.selectedGold * actualRate;
            this.nsXpExchange.value = _loc9_;
            this.itGoldResult.text = _loc1_?_loc1_.gold(totalPrimaryCurrency - this.selectedGold):(totalPrimaryCurrency - this.selectedGold).toString();
            _loc10_ = this.totalXP + _loc9_;
            this.itExperienceResult.text = _loc1_?_loc1_.gold(_loc10_):_loc10_.toString();
            this.submitBtn.enabled = !(this.selectedGold == 0);
            this.buttonBar.enabled = this.scrollList.dataProvider.length > 0;
            this.itTotalAvailableXp.validateNow();
            this.lblTotalAvailableXp.x = this.itTotalAvailableXp.x + this.itTotalAvailableXp.width - this.itTotalAvailableXp.iconClip.width - this.itTotalAvailableXp.textField.textWidth - this.lblTotalAvailableXp.width - 13;
         }
      }

      override protected function applyPrimaryCurrencyChange() : void {
         var _loc1_:ILocale = App.utils?App.utils.locale:null;
         this.itGoldBefore.text = _loc1_?_loc1_.gold(totalPrimaryCurrency):totalPrimaryCurrency.toString();
         invalidate(TOTAL_AVAILABLE_XP_INVALID);
      }

      override protected function applyRatesChanges() : void {
         this.headerMC.setRates(rate,actionRate);
         invalidate(TOTAL_RESULT_INVALID);
      }

      override protected function onDispose() : void {
         this.cancelBtn.removeEventListener(ButtonEvent.CLICK,cancelBtnClickHandler);
         this.submitBtn.removeEventListener(ButtonEvent.CLICK,this.submitBtnClickHandler);
         removeEventListener(ExchangeXPFromVehicleIR.SELECTION_CHANGED,this.selectionIRChanged);
         this.nsXpExchange.removeEventListener(IndexEvent.INDEX_CHANGE,this.nsXpChangeHandler);
         this.nsGoldExchange.removeEventListener(IndexEvent.INDEX_CHANGE,this.nsGoldChangeHandler);
         this.buttonBar.removeEventListener(SortingButton.SORT_DIRECTION_CHANGED,this.sortingDirectionChanged);
         this.cancelBtn.dispose();
         this.cancelBtn = null;
         this.submitBtn.dispose();
         this.submitBtn = null;
         this.nsXpExchange.dispose();
         this.nsXpExchange = null;
         this.nsGoldExchange.dispose();
         this.nsGoldExchange = null;
         this.buttonBar.dispose();
         this.buttonBar = null;
         this.onHandHaveNotFreeXp.dispose();
         this.onHandHaveNotFreeXp = null;
         this.resultHaveNotFreeXp.dispose();
         this.resultHaveNotFreeXp = null;
         this.onHandHaveNotMoney.dispose();
         this.onHandHaveNotMoney = null;
         this.resultHaveNotMoney.dispose();
         this.resultHaveNotMoney = null;
         super.onDispose();
      }

      private function checkBoxSelectHandler(param1:Event) : void {
         this.scrollList.applySelection(this.cbSelectAll.selected);
         invalidate(TOTAL_AVAILABLE_XP_INVALID);
      }

      private function sortingDirectionChanged(param1:Event) : void {
         var _loc4_:String = null;
         param1.stopImmediatePropagation();
         var _loc2_:SortingButton = SortingButton(param1.target);
         var _loc3_:* = _loc2_.sortDirection == SortingButton.ASCENDING_SORT;
         if(_loc2_.sortDirection != SortingButton.WITHOUT_SORT)
         {
            if("btnOk" == _loc2_.id)
            {
               this.scrollList.sortSelection(_loc3_);
            }
            else
            {
               if("btnTank" == _loc2_.id)
               {
                  this.scrollList.sortByVehicleName(_loc3_);
               }
               else
               {
                  if("btnStar" == _loc2_.id)
                  {
                     this.scrollList.sortByExperience(_loc3_);
                  }
                  else
                  {
                     _loc4_ = "FLASH::Unexpected sorting button id! " + this;
                     DebugUtils.LOG_ERROR(_loc4_);
                     throw new Error(_loc4_);
                  }
               }
            }
         }
      }

      private function nsGoldChangeHandler(param1:IndexEvent) : void {
         this.selectedGold = this.nsGoldExchange.value;
         invalidate(TOTAL_RESULT_INVALID);
      }

      private function nsXpChangeHandler(param1:IndexEvent) : void {
         this.selectedGold = Math.floor(this.nsXpExchange.value / actualRate);
         invalidate(TOTAL_RESULT_INVALID);
      }

      private function selectionIRChanged(param1:Event) : void {
         param1.stopImmediatePropagation();
         invalidate(TOTAL_AVAILABLE_XP_INVALID);
      }

      private function submitBtnClickHandler(param1:ButtonEvent) : void {
         var _loc3_:ExchangeXPVehicleVO = null;
         var _loc2_:Array = [];
         var _loc4_:DataProvider = DataProvider(this.scrollList.dataProvider);
         var _loc5_:uint = _loc4_.length;
         var _loc6_:* = 0;
         while(_loc6_ < _loc5_)
         {
            _loc3_ = ExchangeXPVehicleVO(_loc4_[_loc6_]);
            if(_loc3_.isSelectCandidate)
            {
               _loc2_.push(_loc3_.id);
            }
            _loc6_++;
         }
         App.utils.asserter.assert(_loc2_.length > 0,"Flash Asserter warning: Exchange XP Window submit method have empty data array");
         var _loc7_:Object =
            {
               "exchangeXp":this.nsXpExchange.value,
               "selectedVehicles":_loc2_
            }
         ;
         exchangeS(_loc7_);
      }
   }

}