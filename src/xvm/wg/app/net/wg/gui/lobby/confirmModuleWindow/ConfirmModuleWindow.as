package net.wg.gui.lobby.confirmModuleWindow
{
   import net.wg.infrastructure.base.meta.impl.ConfirmModuleWindowMeta;
   import net.wg.infrastructure.base.meta.IConfirmModuleWindowMeta;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.gui.components.controls.IconText;
   import flash.text.TextField;
   import net.wg.gui.components.controls.NumericStepper;
   import net.wg.gui.components.advanced.ExtraModuleIcon;
   import net.wg.gui.components.controls.DropdownMenu;
   import net.wg.infrastructure.interfaces.IWindow;
   import scaleform.clik.events.ButtonEvent;
   import net.wg.utils.ILocale;
   import scaleform.clik.events.IndexEvent;
   import scaleform.clik.data.DataProvider;
   import net.wg.data.constants.Currencies;
   import scaleform.clik.events.ListEvent;


   public class ConfirmModuleWindow extends ConfirmModuleWindowMeta implements IConfirmModuleWindowMeta
   {
          
      public function ConfirmModuleWindow() {
         super();
         isModal = true;
         isCentered = true;
         canDrag = false;
         showWindowBg = false;
      }

      private static const NORMAL_COLOR:uint = 6447189;

      private static const ACTION_COLOR:uint = 16777215;

      private static const DATA_INVALID:String = "dataInv";

      private static const RESULT_INVALID:String = "resultInv";

      private static const SELECTED_CURRENCY_INVALID:String = "currencyInv";

      private static const SETTINGS_INVALID:String = "settingsInv";

      public var submitBtn:SoundButtonEx;

      public var cancelBtn:SoundButtonEx;

      public var resultGold:IconText;

      public var resultCredits:IconText;

      public var countLabel:TextField;

      public var priceLabel:TextField;

      public var resultLabel:TextField;

      public var totalLabel:TextField;

      public var price:IconText;

      public var total:IconText;

      public var nsCount:NumericStepper;

      public var description:TextField;

      public var moduleName:TextField;

      public var moduleIcon:ExtraModuleIcon;

      public var dropdownMenu:DropdownMenu;

      private var moduleInfo:ModuleInfoVo;

      private var settings:ConfirmModuleSettingsVO;

      private var currency:String;

      private var selectedCount:Number = 0;

      private var dataInitialized:Boolean;

      public function as_setData(param1:Object) : void {
         this.moduleInfo = new ModuleInfoVo(param1);
         invalidate(DATA_INVALID);
      }

      public function as_setSettings(param1:Object) : void {
         this.settings = new ConfirmModuleSettingsVO(param1);
         invalidate(SETTINGS_INVALID);
      }

      override public function set window(param1:IWindow) : void {
         super.window = param1;
         if(param1)
         {
            invalidate(SETTINGS_INVALID);
         }
      }

      override protected function configUI() : void {
         super.configUI();
         this.cancelBtn.addEventListener(ButtonEvent.CLICK,this.cancelBtnClickHandler,false,0,true);
         this.submitBtn.addEventListener(ButtonEvent.CLICK,this.submitBtnClickHandler,false,0,true);
         var _loc1_:ILocale = App.utils.locale;
         this.countLabel.text = _loc1_.makeString(DIALOGS.CONFIRMMODULEDIALOG_COUNTLABEL);
         this.priceLabel.text = _loc1_.makeString(DIALOGS.CONFIRMMODULEDIALOG_PRICELABEL);
         this.totalLabel.text = _loc1_.makeString(DIALOGS.CONFIRMMODULEDIALOG_TOTALLABEL);
         this.resultLabel.text = _loc1_.makeString(DIALOGS.CONFIRMMODULEDIALOG_TOTALLABEL);
         this.nsCount.addEventListener(IndexEvent.INDEX_CHANGE,this.selectedCountChangeHandler,false,0,true);
         this.moveFocusToSubmitButton();
      }

      override protected function draw() : void {
         var _loc1_:ILocale = null;
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:* = 0;
         var _loc5_:uint = 0;
         var _loc6_:* = NaN;
         var _loc7_:ILocale = null;
         var _loc8_:String = null;
         var _loc9_:String = null;
         var _loc10_:String = null;
         super.draw();
         if(isInvalid(DATA_INVALID))
         {
            if(this.moduleInfo)
            {
               this.moduleIcon.setValues(this.moduleInfo.type,this.moduleInfo.icon);
               this.moduleIcon.extraIconSource = this.moduleInfo.extraModuleInfo;
               this.moduleName.text = this.moduleInfo.name;
               this.description.text = this.moduleInfo.descr;
               _loc1_ = App.utils.locale;
               _loc2_ = this.moduleInfo.price[0];
               _loc3_ = this.moduleInfo.price[1];
               if(this.moduleInfo.isActionNow)
               {
                  _loc4_ = this.dropdownMenu.selectedIndex != -1?this.dropdownMenu.selectedIndex:1;
                  this.dropdownMenu.dataProvider = new DataProvider([_loc1_.htmlTextWithIcon(_loc1_.integer(_loc2_),Currencies.CREDITS),_loc1_.htmlTextWithIcon(_loc1_.gold(_loc3_),Currencies.GOLD)]);
                  this.dropdownMenu.addEventListener(ListEvent.INDEX_CHANGE,this.currencyChangedHandler,false,0,true);
                  this.dropdownMenu.selectedIndex = _loc4_;
                  this.priceLabel.textColor = ACTION_COLOR;
                  this.totalLabel.textColor = ACTION_COLOR;
               }
               else
               {
                  if(this.moduleInfo.currency == Currencies.GOLD)
                  {
                     this.price.text = _loc1_.gold(_loc3_);
                  }
                  else
                  {
                     this.price.text = _loc1_.integer(_loc2_);
                  }
                  this.priceLabel.textColor = NORMAL_COLOR;
                  this.totalLabel.textColor = NORMAL_COLOR;
               }
               this.dropdownMenu.visible = this.moduleInfo.isActionNow;
               this.price.visible = !this.moduleInfo.isActionNow;
               if(this.moduleInfo.defaultValue != -1)
               {
                  this.selectedCount = this.moduleInfo.defaultValue;
               }
               else
               {
                  this.selectedCount = this.nsCount.value;
               }
            }
            invalidate(SELECTED_CURRENCY_INVALID);
         }
         if(isInvalid(SELECTED_CURRENCY_INVALID))
         {
            if(this.moduleInfo)
            {
               if(this.moduleInfo.isActionNow)
               {
                  if(this.dropdownMenu.selectedIndex == 0)
                  {
                     _loc5_ = this.moduleInfo.maxAvailableCount[0];
                  }
                  else
                  {
                     _loc5_ = this.moduleInfo.maxAvailableCount[1];
                  }
               }
               else
               {
                  if(this.moduleInfo.currency == Currencies.GOLD)
                  {
                     _loc5_ = this.moduleInfo.maxAvailableCount[1];
                  }
                  else
                  {
                     _loc5_ = this.moduleInfo.maxAvailableCount[0];
                  }
               }
               _loc6_ = Math.min(1,_loc5_);
               this.nsCount.minimum = _loc6_;
               this.nsCount.maximum = _loc5_;
               this.nsCount.value = Math.min(this.selectedCount,_loc5_);
               this.submitBtn.enabled = _loc6_ > 0;
            }
            invalidate(RESULT_INVALID);
         }
         if(isInvalid(RESULT_INVALID))
         {
            if(this.moduleInfo)
            {
               _loc7_ = App.utils.locale;
               if(this.moduleInfo.isActionNow)
               {
                  if(this.dropdownMenu.selectedIndex == 0)
                  {
                     _loc8_ = "0";
                     _loc9_ = _loc7_.integer(this.nsCount.value * this.moduleInfo.price[0]);
                     _loc10_ = _loc9_;
                     this.currency = Currencies.CREDITS;
                  }
                  else
                  {
                     _loc9_ = "0";
                     _loc8_ = _loc7_.gold(this.nsCount.value * this.moduleInfo.price[1]);
                     _loc10_ = _loc8_;
                     this.currency = Currencies.GOLD;
                  }
               }
               else
               {
                  this.currency = this.moduleInfo.currency;
                  if(this.moduleInfo.currency == Currencies.GOLD)
                  {
                     _loc8_ = _loc7_.gold(this.nsCount.value * this.moduleInfo.price[1]);
                     _loc10_ = _loc8_;
                     _loc9_ = "0";
                  }
                  else
                  {
                     _loc9_ = _loc7_.integer(this.nsCount.value * this.moduleInfo.price[0]);
                     _loc10_ = _loc9_;
                     _loc8_ = "0";
                  }
               }
               this.resultGold.text = _loc8_;
               this.resultCredits.text = _loc9_;
               this.price.icon = this.currency;
               this.price.textColor = Currencies.TEXT_COLORS[this.currency];
               this.total.icon = this.currency;
               this.total.textColor = Currencies.TEXT_COLORS[this.currency];
               this.total.text = _loc10_;
            }
         }
         if(isInvalid(SETTINGS_INVALID))
         {
            if((window) && (this.settings))
            {
               window.title = this.settings.title;
               this.submitBtn.label = this.settings.submitBtnLabel;
               this.cancelBtn.label = this.settings.cancelBtnLabel;
            }
         }
      }

      override public function setFocus() : void {
         super.setFocus();
         this.moveFocusToSubmitButton();
      }

      public function moveFocusToSubmitButton() : void {
         App.utils.focusHandler.setFocus(this.submitBtn);
      }

      override protected function onDispose() : void {
         super.onDispose();
         if(this.dropdownMenu)
         {
            this.dropdownMenu.removeEventListener(ListEvent.INDEX_CHANGE,this.currencyChangedHandler);
         }
         this.cancelBtn.removeEventListener(ButtonEvent.CLICK,this.cancelBtnClickHandler);
         this.submitBtn.removeEventListener(ButtonEvent.CLICK,this.submitBtnClickHandler);
         this.nsCount.removeEventListener(IndexEvent.INDEX_CHANGE,this.selectedCountChangeHandler);
         this.cancelBtn.dispose();
         this.cancelBtn = null;
         this.submitBtn.dispose();
         this.submitBtn = null;
         this.nsCount.dispose();
         this.nsCount = null;
      }

      private function selectedCountChangeHandler(param1:IndexEvent) : void {
         this.selectedCount = this.nsCount.value;
         invalidate(RESULT_INVALID);
      }

      private function submitBtnClickHandler(param1:ButtonEvent) : void {
         submitS(this.selectedCount,this.currency);
      }

      private function currencyChangedHandler(param1:ListEvent) : void {
         invalidate(SELECTED_CURRENCY_INVALID);
      }

      protected function cancelBtnClickHandler(param1:ButtonEvent) : void {
         onWindowCloseS();
      }
   }

}