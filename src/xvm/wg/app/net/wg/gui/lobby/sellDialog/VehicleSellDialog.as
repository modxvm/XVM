package net.wg.gui.lobby.sellDialog
{
   import net.wg.infrastructure.base.meta.impl.VehicleSellDialogMeta;
   import net.wg.infrastructure.base.meta.IVehicleSellDialogMeta;
   import flash.display.MovieClip;
   import net.wg.gui.components.controls.SoundButtonEx;
   import __AS3__.vec.Vector;
   import net.wg.infrastructure.interfaces.ISaleItemBlockRenderer;
   import scaleform.clik.motion.Tween;
   import org.idmedia.as3commons.util.StringUtils;
   import net.wg.gui.events.VehicleSellDialogEvent;
   import scaleform.clik.events.ButtonEvent;
   import flash.events.Event;
   import scaleform.clik.constants.InvalidationType;
   import net.wg.utils.ILocale;
   import fl.transitions.easing.Strong;
   import flash.display.InteractiveObject;


   public class VehicleSellDialog extends VehicleSellDialogMeta implements IVehicleSellDialogMeta
   {
          
      public function VehicleSellDialog() {
         this.vehicleData = {};
         this.modulesData = {};
         this.shellsData = {};
         this.tweens = new Vector.<Tween>();
         super();
         isModal = true;
         isCentered = true;
         canDrag = false;
         showWindowBg = false;
         scaleX = scaleY = 1;
         this.controlQuestion.visible = false;
      }

      public static const ICONS_TEXT_OFFSET:Number = -2;

      private static const WINDOW_PADDING:int = 12;

      private static const SLIDING_SPEED:Number = 350;

      public var headerComponent:SellHeaderComponent;

      public var slidingComponent:SellSlidingComponent;

      public var devicesComponent:SellDevicesComponent;

      public var controlQuestion:ControlQuestionComponent;

      public var windBgForm:MovieClip;

      public var cancelBtn:SoundButtonEx;

      public var submitBtn:SoundButtonEx;

      public var result_mc:TotalResult;

      private var goldCommon:Number = 0;

      private var listVisibleHight:Number = 0;

      private var creditsComplDev:Number = 0;

      private var renderersArr:Vector.<ISaleItemBlockRenderer>;

      private var complexDeviceRenderers:Vector.<ISaleItemBlockRenderer>;

      private var vehicleData:Object;

      private var modulesData:Object;

      private var shellsData:Object;

      private var isOpen:Boolean = false;

      private var accGold:Number = 0;

      private var tweens:Vector.<Tween>;

      private var countTweenObjects:int = 0;

      private var countCallBack:int = 0;

      override public function updateStage(param1:Number, param2:Number) : void {
         super.updateStage(param1,param2);
         this.updateWindowPosition();
      }

      public function as_visibleControlBlock(param1:Boolean) : void {
         if(this.controlQuestion.visible != param1)
         {
            this.controlQuestion.visible = param1;
            if(!param1)
            {
               this.controlQuestion.y = 0;
            }
         }
      }

      public function as_enableButton(param1:Boolean) : void {
         var _loc2_:* = false;
         if(this.submitBtn)
         {
            _loc2_ = this.submitBtn.enabled;
            this.submitBtn.enabled = (this.controlQuestion.isValidControlInput) && (param1) && this.accGold >= this.isHasGold();
            if((this.submitBtn.enabled) && !_loc2_)
            {
               App.utils.scheduler.envokeInNextFrame(this.updateFocus,this.submitBtn);
            }
         }
      }

      public function as_setCtrlQuestion(param1:String) : void {
         if(this.controlQuestion)
         {
            this.controlQuestion.headerText = DIALOGS.VEHICLESELLDIALOG_CTRLQUESTION_HEADER;
            this.controlQuestion.errorText = DIALOGS.VEHICLESELLDIALOG_CTRLQUESTION_ERRORMESSAGE;
            this.controlQuestion.questionText = param1;
            this.controlQuestion.invalidateData();
         }
      }

      public function as_setControlNumber(param1:Boolean, param2:String) : void {
         var _loc3_:String = null;
         if(this.controlQuestion)
         {
            _loc3_ = null;
            if(param1)
            {
               _loc3_ = App.utils.locale.gold(param2);
               _loc3_ = StringUtils.trim(_loc3_);
            }
            else
            {
               _loc3_ = App.utils.locale.integer(param2);
            }
            this.controlQuestion.controlText = param2;
            this.controlQuestion.formattedControlText = _loc3_;
            this.controlQuestion.invalidateData();
         }
      }

      private function enabledSubmitBtn(param1:Boolean) : void {
         if(this.submitBtn.enabled != param1)
         {
            this.submitBtn.enabled = param1;
         }
      }

      private function isHasGold() : Number {
         return this.goldCommon - this.headerComponent.tankGoldPrice;
      }

      public function as_checkGold(param1:Number) : void {
         var _loc2_:* = NaN;
         this.accGold = param1;
         this.complexDeviceRenderers = this.devicesComponent.deviceItemRenderer;
         if(this.accGold < this.isHasGold())
         {
            _loc2_ = 16711680;
            this.enabledSubmitBtn(false);
         }
         else
         {
            _loc2_ = 16763253;
            this.enabledSubmitBtn(this.controlQuestion.visible?this.controlQuestion.isValidControlInput:true);
         }
         var _loc3_:uint = 0;
         while(_loc3_ < this.complexDeviceRenderers.length)
         {
            if(this.complexDeviceRenderers[_loc3_].inInventory)
            {
               if(!this.complexDeviceRenderers[_loc3_].isRemovable)
               {
                  this.complexDeviceRenderers[_loc3_].setColor(_loc2_);
                  this.complexDeviceRenderers[_loc3_].validateNow();
               }
            }
            _loc3_++;
         }
         this.result_mc.goldIT.textColor = _loc2_;
      }

      public function as_setData(param1:Object, param2:Object, param3:Object, param4:Object, param5:Number) : void {
         this.slidingComponent.sellData = [];
         this.accGold = param5;
         this.goldCommon = 0;
         this.vehicleData = param1;
         this.modulesData = param2;
         this.shellsData = param3;
         this.devicesComponent.removePrice = param4.hasOwnProperty("removePrice")?param4.removePrice:0;
         this.devicesComponent.defRemovePrice = param4.hasOwnProperty("defRemovePrice")?param4.defRemovePrice:0;
         this.devicesComponent.removeActionPrc = param4.hasOwnProperty("actionPrc")?param4.actionPrc:0;
         this.window.title = App.utils.locale.makeString(DIALOGS.VEHICLESELLDIALOG_TITLE,{"name":param1.userName});
         invalidateData();
      }

      override protected function configUI() : void {
         super.configUI();
         this.updateOpenedState();
         this.controlQuestion.addEventListener(ControlQuestionComponent.USER_INPUT_HANDLER,this.userInputHandler);
         this.slidingComponent.slidingScrList.addEventListener(VehicleSellDialogEvent.LIST_WAS_DRAWN,this.wasDrawnHandler,false,1);
         this.cancelBtn.label = DIALOGS.VEHICLESELLDIALOG_CANCEL;
         this.submitBtn.label = DIALOGS.VEHICLESELLDIALOG_SUBMIT;
         this.addEventListener(VehicleSellDialogEvent.UPDATE_RESULT,this.updateMoneyResult);
         this.cancelBtn.addEventListener(ButtonEvent.CLICK,this.handleClose);
         this.submitBtn.addEventListener(ButtonEvent.CLICK,this.handleSubmit);
         if(this.controlQuestion.visible)
         {
            App.utils.scheduler.envokeInNextFrame(this.updateFocus,this.controlQuestion.userInput);
         }
         else
         {
            App.utils.scheduler.envokeInNextFrame(this.updateFocus,this.submitBtn);
         }
      }

      override protected function onDispose() : void {
         var _loc1_:Tween = null;
         super.onDispose();
         App.utils.scheduler.cancelTask(this.updateFocus);
         this.slidingComponent.slidingScrList.removeEventListener(VehicleSellDialogEvent.LIST_WAS_DRAWN,this.wasDrawnHandler);
         this.removeEventListener(VehicleSellDialogEvent.UPDATE_RESULT,this.updateMoneyResult);
         this.slidingComponent.settingsBtn.setingsDropBtn.removeEventListener(Event.SELECT,this.playSlidingAnimation);
         this.controlQuestion.removeEventListener(ControlQuestionComponent.USER_INPUT_HANDLER,this.userInputHandler);
         this.cancelBtn.removeEventListener(ButtonEvent.CLICK,this.handleClose);
         for each (_loc1_ in this.tweens)
         {
            _loc1_.paused = true;
            _loc1_ = null;
         }
         this.headerComponent.dispose();
         this.slidingComponent.dispose();
         this.devicesComponent.dispose();
         this.controlQuestion.dispose();
         this.vehicleData = null;
         this.modulesData = null;
         this.shellsData = null;
         App.toolTipMgr.hide();
      }

      override protected function onPopulate() : void {
         super.onPopulate();
      }

      override protected function draw() : void {
         if((isInvalid("updateStage")) && (window))
         {
            this.updateWindowPosition();
         }
         if(isInvalid(InvalidationType.DATA))
         {
            this.setHeader(this.vehicleData);
            this.setDevices(this.vehicleData);
            this.setShells(this.vehicleData);
            this.setEquipment(this.vehicleData);
            this.setInventory(this.modulesData,this.shellsData);
            this.setGoldText(this.headerComponent.creditsCommon,this.goldCommon);
         }
      }

      private function updateWindowPosition() : void {
         var _loc1_:* = 0;
         var _loc2_:* = 0;
         if(isCentered)
         {
            window.x = App.appWidth - window.width >> 1;
            window.y = App.appHeight - window.getBackground().height >> 1;
         }
         else
         {
            _loc1_ = window.width + window.x;
            _loc2_ = window.getBackground().height + window.y;
            if(_loc1_ > App.appWidth)
            {
               window.x = window.x - (_loc1_ - App.appWidth);
            }
            if(_loc2_ > App.appHeight)
            {
               window.y = window.y - (_loc2_ - App.appHeight);
            }
         }
      }

      private function setGoldText(param1:Number, param2:Number) : void {
         var _loc5_:* = false;
         var _loc3_:ILocale = App.utils.locale;
         var _loc4_:String = _loc3_.gold(param1);
         _loc5_ = true;
         var _loc6_:Number = this.headerComponent.tankGoldPrice > 0?this.headerComponent.tankGoldPrice - param2:param2;
         if(_loc6_ >= 0)
         {
            _loc5_ = this.headerComponent.tankGoldPrice > 0?false:true;
         }
         else
         {
            _loc6_ = _loc6_ * -1;
         }
         var _loc7_:String = _loc3_.gold(_loc6_);
         var _loc8_:Number = param1 + this.creditsComplDev;
         if(_loc6_ != 0)
         {
            this.result_mc.goldIT.visible = true;
            this.result_mc.goldIT.text = _loc5_?"- " + _loc7_:"+ " + _loc7_;
         }
         else
         {
            this.result_mc.goldIT.text = "0";
         }
         if(_loc8_ > 0)
         {
            this.result_mc.creditsIT.text = "+ " + _loc3_.integer(_loc8_);
         }
         else
         {
            this.result_mc.creditsIT.text = "0";
         }
         if((this.controlQuestion) && (this.controlQuestion.visible))
         {
            this.controlQuestion.cleanField();
            setResultCreditS(Boolean(_loc8_ == 0),_loc8_ == 0?_loc6_:_loc8_);
            if(this.controlQuestion.userInput.focused == false)
            {
               App.utils.scheduler.envokeInNextFrame(this.updateFocus,this.controlQuestion.userInput);
            }
         }
         if(param1 - this.headerComponent.tankPrice > 0)
         {
            this.slidingComponent.settingsBtn.creditsIT.text = "+ " + _loc3_.integer(param1 - this.headerComponent.tankPrice);
            this.slidingComponent.settingsBtn.creditsIT.validateNow();
         }
         else
         {
            this.slidingComponent.settingsBtn.creditsIT.text = "0";
         }
         if(this.slidingComponent.settingsBtn.setingsDropBtn.selected)
         {
            this.slidingComponent.settingsBtn.creditsIT.alpha = 0;
            this.slidingComponent.settingsBtn.creditsIT.visible = false;
            this.slidingComponent.settingsBtn.creditsIT.validateNow();
         }
         else
         {
            this.slidingComponent.settingsBtn.creditsIT.alpha = 1;
            this.slidingComponent.settingsBtn.creditsIT.visible = true;
            this.slidingComponent.settingsBtn.creditsIT.validateNow();
         }
      }

      private function setHeader(param1:Object) : void {
         this.headerComponent.setData(param1);
      }

      private function setDevices(param1:Object) : void {
         this.devicesComponent.setData(param1);
         this.slidingComponent.sellData = this.devicesComponent.sellData;
      }

      private function setShells(param1:Object) : void {
         this.updateOpenedState();
         this.slidingComponent.setShells(param1);
      }

      private function setEquipment(param1:Object) : void {
         this.slidingComponent.setEquipment(param1);
      }

      private function setInventory(param1:Object, param2:Object) : void {
         this.slidingComponent.setInventory(param1,param2);
      }

      private function handleSubmit(param1:ButtonEvent) : void {
         var _loc9_:uint = 0;
         this.renderersArr = this.slidingComponent.slidingScrList.getRenderers();
         this.complexDeviceRenderers = this.devicesComponent.deviceItemRenderer;
         var _loc2_:Array = [];
         var _loc3_:Array = [];
         var _loc4_:Array = [];
         var _loc5_:Array = [];
         var _loc6_:Array = [];
         var _loc7_:* = false;
         var _loc8_:uint = 0;
         _loc8_ = 0;
         while(_loc8_ < this.renderersArr.length)
         {
            if(!this.renderersArr[_loc8_].inInventory)
            {
               switch(this.renderersArr[_loc8_].type)
               {
                  case SaleItemBlockRenderer.ITEM_TYPE_OPTIONAL_DEVICE:
                     _loc2_.push(this.renderersArr[_loc8_].dataInfo);
                     break;
                  case SaleItemBlockRenderer.ITEM_TYPE_SHELL:
                     if(this.renderersArr[_loc8_].itemInInventory)
                     {
                        _loc6_.push(this.renderersArr[_loc8_].dataInfo);
                     }
                     else
                     {
                        _loc3_.push(this.renderersArr[_loc8_].dataInfo);
                     }
                     break;
                  case SaleItemBlockRenderer.ITEM_TYPE_EQUIPMENT:
                     _loc4_.push(this.renderersArr[_loc8_].dataInfo);
                     break;
                  case SaleItemBlockRenderer.ITEM_TYPE_MODULE:
                     _loc9_ = 0;
                     while(_loc9_ < this.modulesData.length)
                     {
                        _loc6_.push(this.modulesData[_loc9_][0]);
                        _loc9_++;
                     }
                     break;
               }
            }
            _loc8_++;
         }
         _loc8_ = 0;
         while(_loc8_ < this.complexDeviceRenderers.length)
         {
            if(!this.complexDeviceRenderers[_loc8_].inInventory)
            {
               _loc2_.push(this.complexDeviceRenderers[_loc8_].dataInfo);
            }
            _loc8_++;
         }
         if(this.headerComponent.inBarracsDrop.selectedIndex == 1)
         {
            _loc7_ = true;
         }
         setDialogSettingsS(this.slidingComponent.settingsBtn.setingsDropBtn.selected);
         sellS(this.vehicleData,_loc3_,_loc4_,_loc2_,_loc6_,_loc7_);
         onWindowCloseS();
      }

      private function updateComponentsPosition() : void {
         this.slidingComponent.visible = !(this.listVisibleHight == 0);
         if(this.listVisibleHight != 0)
         {
            this.slidingComponent.settingsBtn.visible = true;
            this.slidingComponent.expandBg.visible = true;
         }
         var _loc1_:int = this.headerComponent.y + this.headerComponent.getNextPosition();
         if(this.devicesComponent.visible)
         {
            this.devicesComponent.y = _loc1_;
            _loc1_ = this.devicesComponent.y + this.devicesComponent.getNextPosition();
         }
         if(this.slidingComponent.visible)
         {
            this.slidingComponent.settingsBtn.setingsDropBtn.addEventListener(Event.SELECT,this.playSlidingAnimation);
            this.slidingComponent.y = _loc1_;
            _loc1_ = this.slidingComponent.y + this.slidingComponent.getNextPosition();
         }
         this.result_mc.y = _loc1_;
         if(this.controlQuestion.visible)
         {
            this.controlQuestion.y = this.result_mc.y + this.result_mc.getSize();
            _loc1_ = this.controlQuestion.y + this.controlQuestion.getNextPosition();
         }
         else
         {
            _loc1_ = this.result_mc.y + this.result_mc.getSize();
         }
         this.windBgForm.height = _loc1_;
         this.submitBtn.y = this.cancelBtn.y = this.windBgForm.y + this.windBgForm.height + 3;
         var _loc2_:int = this.submitBtn.y + this.submitBtn.height;
         window.updateSize(this.width,_loc2_,true);
         window.x = App.appWidth - window.width >> 1;
         window.y = App.appHeight - window.height >> 1;
         this.setGoldText(this.headerComponent.creditsCommon,this.goldCommon);
      }

      private function wasDrawnHandler(param1:VehicleSellDialogEvent) : void {
         this.listVisibleHight = param1.listVisibleHight;
         this.updateComponentsPosition();
      }

      private function updateMoneyResult(param1:VehicleSellDialogEvent) : void {
         this.headerComponent.creditsCommon = this.headerComponent.tankPrice;
         this.creditsComplDev = 0;
         this.goldCommon = 0;
         this.renderersArr = this.slidingComponent.slidingScrList.getRenderers();
         var _loc2_:uint = 0;
         while(_loc2_ < this.renderersArr.length)
         {
            if(!this.renderersArr[_loc2_].inInventory)
            {
               this.headerComponent.creditsCommon = this.headerComponent.creditsCommon + this.renderersArr[_loc2_].moneyValue;
            }
            _loc2_++;
         }
         this.complexDeviceRenderers = this.devicesComponent.deviceItemRenderer;
         var _loc3_:uint = 0;
         while(_loc3_ < this.complexDeviceRenderers.length)
         {
            if(this.complexDeviceRenderers[_loc3_].inInventory)
            {
               if(!this.complexDeviceRenderers[_loc3_].isRemovable)
               {
                  this.goldCommon = this.goldCommon + this.devicesComponent.removePrice;
               }
            }
            else
            {
               this.creditsComplDev = this.creditsComplDev + this.complexDeviceRenderers[_loc3_].moneyValue;
            }
            _loc3_++;
         }
         this.setGoldText(this.headerComponent.creditsCommon,this.goldCommon);
         this.as_checkGold(this.accGold);
      }

      private function playSlidingAnimation() : void {
         var _loc5_:Tween = null;
         var _loc6_:* = 0;
         var _loc7_:* = 0;
         var _loc8_:* = 0;
         var _loc9_:* = 0;
         var _loc10_:* = 0;
         var _loc11_:* = 0;
         var _loc12_:* = 0;
         if(!this.compCompletedTween())
         {
            this.slidingComponent.settingsBtn.setingsDropBtn.removeEventListener(Event.SELECT,this.playSlidingAnimation);
            this.slidingComponent.settingsBtn.setingsDropBtn.selected = !this.slidingComponent.settingsBtn.setingsDropBtn.selected;
            this.slidingComponent.settingsBtn.setingsDropBtn.addEventListener(Event.SELECT,this.playSlidingAnimation);
            return;
         }
         this.countCallBack = 0;
         var _loc1_:Number = SLIDING_SPEED;
         var _loc2_:int = this.slidingComponent.isOpened?-this.slidingComponent.resultExpand:this.slidingComponent.resultExpand;
         var _loc3_:int = this.windBgForm.height + window.contentPadding.top + window.contentPadding.bottom;
         _loc3_ = _loc3_ + _loc2_;
         var _loc4_:int = Math.floor((App.appHeight - _loc3_) / 2);
         _loc4_ = _loc4_ - WINDOW_PADDING;
         for each (_loc5_ in this.tweens)
         {
            _loc5_.paused = true;
            _loc5_ = null;
         }
         _loc6_ = this.slidingComponent.height + _loc2_;
         _loc7_ = this.submitBtn.y + _loc2_;
         _loc8_ = this.cancelBtn.y + _loc2_;
         _loc9_ = this.windBgForm.height + _loc2_;
         _loc10_ = window.getBackground().height + _loc2_;
         _loc11_ = this.result_mc.y + _loc2_;
         _loc12_ = this.slidingComponent.isOpened?0:this.slidingComponent.mask_mc.height + _loc2_;
         var _loc13_:int = this.slidingComponent.expandBg.height + _loc2_;
         var _loc14_:int = this.controlQuestion.visible?this.controlQuestion.y + _loc2_:0;
         var _loc15_:Number = this.slidingComponent.isOpened?1:0;
         var _loc16_:Number = this.slidingComponent.isOpened?0:1;
         this.slidingComponent.isOpened = !this.slidingComponent.isOpened;
         this.tweens = Vector.<Tween>([new Tween(_loc1_,this.slidingComponent,{"height":_loc6_},
            {
               "paused":false,
               "ease":Strong.easeOut,
               "onComplete":null
            }
         ),new Tween(_loc1_,this.windBgForm,{"height":_loc9_},
            {
               "paused":false,
               "ease":Strong.easeOut,
               "onComplete":null
            }
         ),new Tween(_loc1_,this.submitBtn,{"y":_loc7_},
            {
               "paused":false,
               "ease":Strong.easeOut,
               "onComplete":null
            }
         ),new Tween(_loc1_,this.cancelBtn,{"y":_loc8_},
            {
               "paused":false,
               "ease":Strong.easeOut,
               "onComplete":null
            }
         ),new Tween(_loc1_,this.result_mc,{"y":_loc11_},
            {
               "paused":false,
               "ease":Strong.easeOut,
               "onComplete":null
            }
         ),new Tween(_loc1_,this.slidingComponent.mask_mc,{"height":_loc12_},
            {
               "paused":false,
               "ease":Strong.easeOut,
               "onComplete":null
            }
         ),new Tween(_loc1_,this.slidingComponent.expandBg,{"height":_loc13_},
            {
               "paused":false,
               "ease":Strong.easeOut,
               "onComplete":null
            }
         ),new Tween(_loc1_,this.slidingComponent.settingsBtn.creditsIT,{"alpha":_loc15_},
            {
               "paused":false,
               "ease":Strong.easeOut,
               "onComplete":null
            }
         ),new Tween(_loc1_,this.slidingComponent.settingsBtn.ddLine,{"alpha":_loc16_},
            {
               "paused":false,
               "ease":Strong.easeOut,
               "onComplete":null
            }
         ),new Tween(_loc1_,this.controlQuestion,{"y":_loc14_},
            {
               "paused":false,
               "ease":Strong.easeOut,
               "onComplete":null
            }
         ),new Tween(_loc1_,window,{"y":_loc4_},
            {
               "paused":false,
               "ease":Strong.easeOut,
               "onComplete":null
            }
         ),new Tween(_loc1_,window.getBackground(),{"height":_loc10_},
            {
               "paused":false,
               "ease":Strong.easeOut,
               "onComplete":null
            }
         )]);
         this.countTweenObjects = this.tweens.length;
         var _loc17_:* = 0;
         while(_loc17_ < this.countTweenObjects)
         {
            Tween(this.tweens[_loc17_]).onComplete = this.motionCallBack;
            _loc17_++;
         }
         this.updateElements();
      }

      public function motionCallBack(param1:Tween) : void {
         this.countCallBack++;
      }

      public function compCompletedTween() : Boolean {
         return this.countTweenObjects == this.countCallBack;
      }

      private function updateElements() : void {
         this.slidingComponent.slidingScrList.y = this.slidingComponent.settingsBtn.y + this.slidingComponent.settingsBtn.height;
         this.slidingComponent.settingsBtn.creditsIT.visible = true;
         this.slidingComponent.slidingScrList.visible = this.slidingComponent.isOpened;
      }

      private function handleClose(param1:ButtonEvent) : void {
         onWindowCloseS();
      }

      private function userInputHandler(param1:Event) : void {
         setUserInputS(this.controlQuestion.getUserText());
      }

      private function updateFocus(param1:InteractiveObject) : void {
         App.utils.focusHandler.setFocus(param1);
      }

      private function updateOpenedState() : void {
         var _loc1_:Object = getDialogSettingsS();
         this.slidingComponent.isOpened = this.isOpen = _loc1_.isOpened;
      }
   }

}