package net.wg.gui.lobby.fortifications.windows.impl
{
   import net.wg.infrastructure.base.meta.impl.FortOrderConfirmationWindowMeta;
   import net.wg.infrastructure.base.meta.IFortOrderConfirmationWindowMeta;
   import net.wg.gui.lobby.fortifications.data.ConfirmOrderVO;
   import net.wg.data.VO.ItemDialogSettingsVO;
   import net.wg.infrastructure.interfaces.IWindow;
   import flash.text.TextFieldAutoSize;
   import net.wg.data.constants.IconsTypes;
   import net.wg.utils.ILocale;
   import net.wg.data.constants.FittingTypes;
   import scaleform.clik.events.IndexEvent;
   import net.wg.data.constants.generated.EVENT_LOG_CONSTANTS;
   import scaleform.clik.events.ButtonEvent;
   
   public class FortOrderConfirmationWindow extends FortOrderConfirmationWindowMeta implements IFortOrderConfirmationWindowMeta
   {
      
      public function FortOrderConfirmationWindow() {
         super();
         isModal = true;
         isCentered = true;
         canDrag = false;
         showWindowBg = false;
         content.submitBtn.UIID = 81;
         content.cancelBtn.UIID = 82;
         UIID = 83;
      }
      
      private static const DATA_INVALID:String = "dataInv";
      
      private static const RESULT_INVALID:String = "resultInv";
      
      private static const SELECTED_CURRENCY_INVALID:String = "currencyInv";
      
      private static const SETTINGS_INVALID:String = "settingsInv";
      
      private static const LABEL_PADDING:int = 155;
      
      private static const TIME_COLOR:int = 9211006;
      
      private static const PURPLE_COLOR:int = 10656624;
      
      private static const TEXT_PADDING:int = 5;
      
      private var orderInfo:ConfirmOrderVO;
      
      private var settings:ItemDialogSettingsVO;
      
      private var selectedCount:Number = 0;
      
      override public function setWindow(param1:IWindow) : void {
         super.setWindow(param1);
         if(param1)
         {
            invalidate(SETTINGS_INVALID);
         }
      }
      
      public function as_setData(param1:Object) : void {
         this.orderInfo = new ConfirmOrderVO(param1);
         invalidate(DATA_INVALID);
      }
      
      public function as_setSettings(param1:Object) : void {
         this.settings = new ItemDialogSettingsVO(param1);
         invalidate(SETTINGS_INVALID);
      }
      
      override protected function configUI() : void {
         super.configUI();
         content.dropdownMenu.visible = content.actionPrice.visible = false;
         content.leftIT.iconPosition = content.leftResultIT.iconPosition = TextFieldAutoSize.LEFT;
         content.leftIT.icon = content.leftResultIT.icon = IconsTypes.EMPTY;
         content.rightIT.icon = content.rightResultIT.icon = IconsTypes.DEFRES;
         content.leftResultIT.x = content.leftLabel.x = content.leftIT.x = LABEL_PADDING;
         content.leftResultIT.textColor = content.leftIT.textColor = TIME_COLOR;
         content.rightResultIT.textColor = content.rightIT.textColor = PURPLE_COLOR;
      }
      
      override protected function onDispose() : void {
         if(this.orderInfo)
         {
            this.orderInfo.dispose();
            this.orderInfo = null;
         }
         if(this.settings)
         {
            this.settings.dispose();
            this.settings = null;
         }
         super.onDispose();
      }
      
      override protected function setLabels() : void {
         var _loc1_:ILocale = App.utils.locale;
         content.countLabel.text = _loc1_.makeString(DIALOGS.CONFIRMMODULEDIALOG_COUNTLABEL);
         content.leftLabel.text = _loc1_.makeString(FORTIFICATIONS.ORDERS_ORDERCONFIRMATIONWINDOW_PREPARATIONTIME);
         content.rightLabel.text = _loc1_.makeString(FORTIFICATIONS.ORDERS_ORDERCONFIRMATIONWINDOW_COST);
         content.resultLabel.text = _loc1_.makeString(DIALOGS.CONFIRMMODULEDIALOG_TOTALLABEL);
      }
      
      override protected function draw() : void {
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:* = NaN;
         var _loc5_:* = NaN;
         var _loc6_:* = NaN;
         var _loc7_:* = NaN;
         var _loc8_:String = null;
         var _loc9_:String = null;
         super.draw();
         var _loc1_:ILocale = App.utils.locale;
         if(isInvalid(DATA_INVALID))
         {
            if(this.orderInfo)
            {
               content.moduleIcon.setValuesWithType(FittingTypes.ORDER,this.orderInfo.orderIcon,this.orderInfo.level);
               content.moduleName.text = this.orderInfo.name;
               content.description.htmlText = this.orderInfo.description;
               content.description.height = content.description.textHeight + TEXT_PADDING;
               _loc2_ = this.orderInfo.productionTime;
               _loc3_ = this.orderInfo.productionCost;
               content.leftIT.text = getTimeStrS(_loc2_);
               content.rightIT.text = _loc1_.gold(_loc3_);
               if(this.orderInfo.defaultValue != -1)
               {
                  this.selectedCount = this.orderInfo.defaultValue;
               }
               else
               {
                  this.selectedCount = content.nsCount.value;
               }
            }
            invalidate(SELECTED_CURRENCY_INVALID);
         }
         if(isInvalid(SELECTED_CURRENCY_INVALID))
         {
            if(this.orderInfo)
            {
               _loc4_ = this.orderInfo.maxAvailableCount;
               _loc5_ = Math.min(1,_loc4_);
               content.nsCount.minimum = _loc5_;
               content.nsCount.maximum = _loc4_;
               content.nsCount.value = Math.min(this.selectedCount,_loc4_);
               content.submitBtn.enabled = _loc5_ > 0;
               if(!content.submitBtn.enabled && lastFocusedElement == content.submitBtn)
               {
                  setFocus(content.cancelBtn);
               }
            }
            invalidate(RESULT_INVALID);
         }
         if(isInvalid(RESULT_INVALID))
         {
            if(this.orderInfo)
            {
               _loc6_ = content.nsCount.value * this.orderInfo.productionTime;
               _loc7_ = content.nsCount.value * this.orderInfo.productionCost;
               _loc8_ = getTimeStrS(_loc6_);
               _loc9_ = _loc1_.gold(_loc7_);
               content.leftResultIT.text = _loc8_;
               content.rightResultIT.text = _loc9_;
            }
         }
         if(isInvalid(SETTINGS_INVALID))
         {
            if((window) && (this.settings))
            {
               window.title = this.settings.title;
               content.submitBtn.label = this.settings.submitBtnLabel;
               content.cancelBtn.label = this.settings.cancelBtnLabel;
            }
         }
      }
      
      override protected function selectedCountChangeHandler(param1:IndexEvent) : void {
         this.selectedCount = content.nsCount.value;
         invalidate(RESULT_INVALID);
      }
      
      override protected function onClosingApproved() : void {
         App.eventLogManager.logUIElement(this,EVENT_LOG_CONSTANTS.EVENT_TYPE_ON_WINDOW_CLOSE,0);
      }
      
      override protected function cancelBtnClickHandler(param1:ButtonEvent) : void {
         App.eventLogManager.logUIEvent(param1,this.selectedCount);
         super.cancelBtnClickHandler(param1);
      }
      
      override protected function submitBtnClickHandler(param1:ButtonEvent) : void {
         App.eventLogManager.logUIEvent(param1,this.selectedCount);
         submitS(this.selectedCount);
      }
   }
}
