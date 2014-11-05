package net.wg.gui.lobby.sellDialog
{
    import net.wg.infrastructure.base.meta.impl.VehicleSellDialogMeta;
    import net.wg.infrastructure.base.meta.IVehicleSellDialogMeta;
    import flash.display.Sprite;
    import net.wg.gui.components.controls.SoundButtonEx;
    import net.wg.gui.interfaces.ISaleItemBlockRenderer;
    import scaleform.clik.motion.Tween;
    import net.wg.gui.lobby.sellDialog.VO.SellVehicleVo;
    import net.wg.gui.lobby.sellDialog.VO.SellInInventoryModuleVo;
    import net.wg.gui.lobby.sellDialog.VO.SellInInventoryShellVo;
    import net.wg.gui.lobby.sellDialog.VO.SellOnVehicleOptionalDeviceVo;
    import net.wg.gui.lobby.sellDialog.VO.SellOnVehicleShellVo;
    import net.wg.gui.lobby.sellDialog.VO.SellOnVehicleEquipmentVo;
    import net.wg.infrastructure.base.interfaces.IWindow;
    import scaleform.clik.utils.Padding;
    import org.idmedia.as3commons.util.StringUtils;
    import net.wg.gui.events.VehicleSellDialogEvent;
    import scaleform.clik.events.ButtonEvent;
    import scaleform.clik.events.ListEvent;
    import flash.events.Event;
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import scaleform.clik.constants.InvalidationType;
    import net.wg.utils.ILocale;
    import fl.transitions.easing.Strong;
    import net.wg.data.constants.FittingTypes;
    
    public class VehicleSellDialog extends VehicleSellDialogMeta implements IVehicleSellDialogMeta
    {
        
        public function VehicleSellDialog()
        {
            this.tweens = new Vector.<Tween>();
            super();
            isModal = true;
            isCentered = true;
            canDrag = false;
            showWindowBgForm = false;
            scaleX = scaleY = 1;
            this.controlQuestion.visible = false;
        }
        
        public static var ICONS_TEXT_OFFSET:Number = -2;
        
        private static var SLIDING_SPEED:Number = 350;
        
        private static var INV_CONTROL_QUESTION:String = "invControlQuestion";
        
        private static var INV_BARRACKS_DROP:String = "invBarracksDrop";
        
        private static var DISSMIS_TANKMEN:int = 1;
        
        public var headerComponent:SellHeaderComponent;
        
        public var slidingComponent:SellSlidingComponent;
        
        public var devicesComponent:SellDevicesComponent;
        
        public var controlQuestion:ControlQuestionComponent;
        
        public var windBgForm:Sprite;
        
        public var cancelBtn:SoundButtonEx;
        
        public var submitBtn:SoundButtonEx;
        
        public var result_mc:TotalResult;
        
        private var goldCommon:Number = 0;
        
        private var listVisibleHight:Number = 0;
        
        private var creditsComplDev:Number = 0;
        
        private var renderersArr:Vector.<ISaleItemBlockRenderer>;
        
        private var complexDeviceRenderers:Vector.<ISaleItemBlockRenderer>;
        
        private var accGold:Number = 0;
        
        private var tweens:Vector.<Tween>;
        
        private var countTweenObjects:int = 0;
        
        private var countCallBack:int = 0;
        
        private var vehicleVo:SellVehicleVo = null;
        
        private var inInventoryModules:Vector.<SellInInventoryModuleVo>;
        
        private var inInventoryShells:Vector.<SellInInventoryShellVo>;
        
        private var onVehicleOptionalDevices:Vector.<SellOnVehicleOptionalDeviceVo>;
        
        private var onVehicleShells:Vector.<SellOnVehicleShellVo>;
        
        private var onVehicleEquipments:Vector.<SellOnVehicleEquipmentVo>;
        
        private var _isPopulated:Boolean = false;
        
        override public function setWindow(param1:IWindow) : void
        {
            var _loc2_:Padding = null;
            super.setWindow(param1);
            if(param1)
            {
                _loc2_ = window.contentPadding as Padding;
                _loc2_.right = _loc2_.right - 4;
                window.contentPadding = _loc2_;
            }
        }
        
        override public function updateStage(param1:Number, param2:Number) : void
        {
            super.updateStage(param1,param2);
            this.updateWindowPosition();
        }
        
        public function as_visibleControlBlock(param1:Boolean) : void
        {
            if(this.controlQuestion.visible != param1)
            {
                this.controlQuestion.visible = param1;
                if(!param1)
                {
                    this.controlQuestion.y = 0;
                    this.as_checkGold(this.accGold);
                }
            }
            invalidate(INV_CONTROL_QUESTION);
        }
        
        public function as_enableButton(param1:Boolean) : void
        {
            var _loc2_:* = false;
            if(this.submitBtn)
            {
                _loc2_ = this.submitBtn.enabled;
                this.submitBtn.enabled = (this.controlQuestion.isValidControlInput) && (param1) && this.accGold >= this.isHasGold();
                if((this.submitBtn.enabled) && !_loc2_)
                {
                    App.utils.scheduler.envokeInNextFrame(setFocus,this.submitBtn);
                }
            }
        }
        
        public function as_setCtrlQuestion(param1:String) : void
        {
            if(this.controlQuestion)
            {
                this.controlQuestion.headerText = DIALOGS.VEHICLESELLDIALOG_CTRLQUESTION_HEADER;
                this.controlQuestion.errorText = DIALOGS.VEHICLESELLDIALOG_CTRLQUESTION_ERRORMESSAGE;
                this.controlQuestion.questionText = param1;
                this.controlQuestion.invalidateData();
            }
        }
        
        public function as_setControlNumber(param1:Boolean, param2:String) : void
        {
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
        
        public function as_checkGold(param1:Number) : void
        {
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
                if(this.complexDeviceRenderers[_loc3_].toInventory)
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
        
        public function as_setData(param1:Object, param2:Object, param3:Object, param4:Object, param5:Number) : void
        {
            var _loc8_:SellInInventoryModuleVo = null;
            var _loc9_:SellInInventoryShellVo = null;
            var _loc10_:SellOnVehicleOptionalDeviceVo = null;
            var _loc11_:SellOnVehicleShellVo = null;
            var _loc12_:SellOnVehicleEquipmentVo = null;
            this.slidingComponent.sellData = [];
            this.accGold = param5;
            var _loc6_:Number = 0;
            var _loc7_:Number = 0;
            this.goldCommon = 0;
            this.vehicleVo = new SellVehicleVo(param1);
            this.inInventoryModules = new Vector.<SellInInventoryModuleVo>(0);
            this.inInventoryShells = new Vector.<SellInInventoryShellVo>(0);
            this.onVehicleOptionalDevices = new Vector.<SellOnVehicleOptionalDeviceVo>();
            this.onVehicleShells = new Vector.<SellOnVehicleShellVo>();
            this.onVehicleEquipments = new Vector.<SellOnVehicleEquipmentVo>();
            if(param3)
            {
                if((param3.hasOwnProperty("modules")) && param3.modules.length > 0)
                {
                    _loc7_ = param3.modules.length;
                    _loc8_ = null;
                    _loc6_ = 0;
                    while(_loc6_ < _loc7_)
                    {
                        if(param3.modules[_loc6_])
                        {
                            _loc8_ = new SellInInventoryModuleVo(param3.modules[_loc6_]);
                            this.inInventoryModules.push(_loc8_);
                        }
                        _loc6_++;
                    }
                }
                if((param3.hasOwnProperty("shells")) && param3.shells.length > 0)
                {
                    _loc7_ = param3.shells.length;
                    _loc9_ = null;
                    _loc6_ = 0;
                    while(_loc6_ < _loc7_)
                    {
                        if(param3.shells[_loc6_])
                        {
                            _loc9_ = new SellInInventoryShellVo(param3.shells[_loc6_]);
                            this.inInventoryShells.push(_loc9_);
                        }
                        _loc6_++;
                    }
                }
            }
            if(param2)
            {
                if((param2.hasOwnProperty("optionalDevices")) && param2.optionalDevices.length > 0)
                {
                    _loc7_ = param2.optionalDevices.length;
                    _loc10_ = null;
                    _loc6_ = 0;
                    while(_loc6_ < _loc7_)
                    {
                        if(param2.optionalDevices[_loc6_])
                        {
                            _loc10_ = new SellOnVehicleOptionalDeviceVo(param2.optionalDevices[_loc6_]);
                            this.onVehicleOptionalDevices.push(_loc10_);
                        }
                        _loc6_++;
                    }
                }
                if((param2.hasOwnProperty("shells")) && param2.shells.length > 0)
                {
                    _loc7_ = param2.shells.length;
                    _loc11_ = null;
                    _loc6_ = 0;
                    while(_loc6_ < _loc7_)
                    {
                        if(param2.shells[_loc6_])
                        {
                            _loc11_ = new SellOnVehicleShellVo(param2.shells[_loc6_]);
                            this.onVehicleShells.push(_loc11_);
                        }
                        _loc6_++;
                    }
                }
                if((param2.hasOwnProperty("equipments")) && param2.equipments.length > 0)
                {
                    _loc7_ = param2.optionalDevices.length;
                    _loc12_ = null;
                    _loc6_ = 0;
                    while(_loc6_ < _loc7_)
                    {
                        if(param2.equipments[_loc6_])
                        {
                            _loc12_ = new SellOnVehicleEquipmentVo(param2.equipments[_loc6_]);
                            this.onVehicleEquipments.push(_loc12_);
                        }
                        _loc6_++;
                    }
                }
            }
            this.devicesComponent.removePrices = param4.hasOwnProperty("removePrice")?param4.removePrice:null;
            this.devicesComponent.removeActionPriceData = param4.hasOwnProperty("action")?param4.action:null;
            this.window.title = this.vehicleVo.isRented?App.utils.locale.makeString(DIALOGS.VEHICLEREMOVEDIALOG_TITLE,{"name":param1.userName}):App.utils.locale.makeString(DIALOGS.VEHICLESELLDIALOG_TITLE,{"name":param1.userName});
            this.updateSubmitBtnLabel();
            invalidateData();
        }
        
        private function updateSubmitBtnLabel() : void
        {
            this.submitBtn.label = this.vehicleVo.isRented?DIALOGS.VEHICLESELLDIALOG_REMOVE:DIALOGS.VEHICLESELLDIALOG_SUBMIT;
        }
        
        public function motionCallBack(param1:Tween) : void
        {
            this.countCallBack++;
            if(this.compCompletedTween())
            {
                this.updateComponentsPosition();
            }
        }
        
        public function compCompletedTween() : Boolean
        {
            return this.countTweenObjects == this.countCallBack;
        }
        
        override protected function configUI() : void
        {
            super.configUI();
            this.updateOpenedState();
            this.controlQuestion.addEventListener(ControlQuestionComponent.USER_INPUT_HANDLER,this.userInputHandler);
            this.slidingComponent.slidingScrList.addEventListener(VehicleSellDialogEvent.LIST_WAS_DRAWN,this.wasDrawnHandler,false,1);
            this.cancelBtn.label = DIALOGS.VEHICLESELLDIALOG_CANCEL;
            this.updateSubmitBtnLabel();
            this.addEventListener(VehicleSellDialogEvent.UPDATE_RESULT,this.updateMoneyResult);
            this.cancelBtn.addEventListener(ButtonEvent.CLICK,this.handleClose);
            this.submitBtn.addEventListener(ButtonEvent.CLICK,this.handleSubmit);
            this.headerComponent.inBarracsDrop.addEventListener(ListEvent.INDEX_CHANGE,this.handleDissmisClick);
            if(this.controlQuestion.visible)
            {
                App.utils.scheduler.envokeInNextFrame(setFocus,this.controlQuestion.userInput);
            }
            else
            {
                App.utils.scheduler.envokeInNextFrame(setFocus,this.submitBtn);
            }
        }
        
        override protected function onDispose() : void
        {
            var _loc1_:Tween = null;
            super.onDispose();
            App.utils.scheduler.cancelTask(setFocus);
            this.slidingComponent.slidingScrList.removeEventListener(VehicleSellDialogEvent.LIST_WAS_DRAWN,this.wasDrawnHandler);
            this.removeEventListener(VehicleSellDialogEvent.UPDATE_RESULT,this.updateMoneyResult);
            this.slidingComponent.settingsBtn.setingsDropBtn.removeEventListener(Event.SELECT,this.playSlidingAnimation);
            this.controlQuestion.removeEventListener(ControlQuestionComponent.USER_INPUT_HANDLER,this.userInputHandler);
            this.cancelBtn.removeEventListener(ButtonEvent.CLICK,this.handleClose);
            this.headerComponent.inBarracsDrop.removeEventListener(ListEvent.INDEX_CHANGE,this.handleDissmisClick);
            for each(_loc1_ in this.tweens)
            {
                _loc1_.paused = true;
                _loc1_ = null;
            }
            this.headerComponent.dispose();
            this.slidingComponent.dispose();
            this.devicesComponent.dispose();
            this.controlQuestion.dispose();
            this.vehicleVo.dispose();
            this.vehicleVo = null;
            this.clearVectorWithDisposableVo(this.inInventoryModules as Vector.<IDisposable>);
            this.clearVectorWithDisposableVo(this.inInventoryShells as Vector.<IDisposable>);
            this.clearVectorWithDisposableVo(this.onVehicleOptionalDevices as Vector.<IDisposable>);
            this.clearVectorWithDisposableVo(this.onVehicleShells as Vector.<IDisposable>);
            this.clearVectorWithDisposableVo(this.onVehicleEquipments as Vector.<IDisposable>);
            this.inInventoryModules = null;
            this.inInventoryShells = null;
            this.onVehicleOptionalDevices = null;
            this.onVehicleShells = null;
            this.onVehicleEquipments = null;
            App.toolTipMgr.hide();
        }
        
        override protected function onPopulate() : void
        {
            super.onPopulate();
            this._isPopulated = true;
        }
        
        override protected function draw() : void
        {
            if((isInvalid(INV_BARRACKS_DROP)) && (this._isPopulated))
            {
                checkControlQuestionS(this.headerComponent.inBarracsDrop.selectedIndex == DISSMIS_TANKMEN);
            }
            if((isInvalid("updateStage")) && (window))
            {
                this.updateWindowPosition();
            }
            if(isInvalid(InvalidationType.DATA))
            {
                this.setHeader(this.vehicleVo);
                this.setDevices(this.onVehicleOptionalDevices);
                this.setShells(this.onVehicleShells);
                this.setEquipment(this.onVehicleEquipments);
                this.setInventory(this.inInventoryModules,this.inInventoryShells);
                this.setGoldText(this.headerComponent.creditsCommon,this.goldCommon);
            }
            if(isInvalid(INV_CONTROL_QUESTION))
            {
                this.updateComponentsPosition();
            }
        }
        
        private function clearVectorWithDisposableVo(param1:Vector.<IDisposable>) : void
        {
            var _loc2_:IDisposable = null;
            if(param1)
            {
                while(param1.length > 0)
                {
                    _loc2_ = param1.pop();
                    _loc2_.dispose();
                    _loc2_ = null;
                }
            }
        }
        
        private function enabledSubmitBtn(param1:Boolean) : void
        {
            if(this.submitBtn.enabled != param1)
            {
                this.submitBtn.enabled = param1;
            }
        }
        
        private function isHasGold() : Number
        {
            return this.goldCommon - this.headerComponent.tankGoldPrice;
        }
        
        private function updateWindowPosition() : void
        {
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
        
        private function setGoldText(param1:Number, param2:Number) : void
        {
            var _loc8_:* = false;
            var _loc9_:* = 0;
            var _loc3_:ILocale = App.utils.locale;
            var _loc4_:* = true;
            var _loc5_:Number = this.headerComponent.tankGoldPrice > 0?this.headerComponent.tankGoldPrice - param2:param2;
            if(_loc5_ >= 0)
            {
                _loc4_ = !(this.headerComponent.tankGoldPrice > 0);
            }
            else
            {
                _loc5_ = _loc5_ * -1;
            }
            var _loc6_:String = _loc3_.gold(_loc5_);
            var _loc7_:Number = param1 + this.creditsComplDev;
            if(_loc5_ != 0)
            {
                this.result_mc.goldIT.visible = true;
                this.result_mc.goldIT.text = _loc4_?"- " + _loc6_:"+ " + _loc6_;
            }
            else
            {
                this.result_mc.goldIT.text = "0";
            }
            if(_loc7_ > 0)
            {
                this.result_mc.creditsIT.text = "+ " + _loc3_.integer(_loc7_);
            }
            else
            {
                this.result_mc.creditsIT.text = "0";
            }
            if((this.controlQuestion) && (this.controlQuestion.visible))
            {
                this.controlQuestion.cleanField();
                _loc8_ = _loc7_ == 0;
                _loc9_ = _loc8_?_loc5_:_loc7_;
                setResultCreditS(_loc8_,_loc9_);
                if(this.controlQuestion.userInput.focused == false)
                {
                    App.utils.scheduler.envokeInNextFrame(setFocus,this.controlQuestion.userInput);
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
        
        private function setHeader(param1:SellVehicleVo) : void
        {
            this.headerComponent.setData(param1);
        }
        
        private function setDevices(param1:Vector.<SellOnVehicleOptionalDeviceVo>) : void
        {
            this.devicesComponent.setData(param1);
            this.slidingComponent.sellData = this.devicesComponent.sellData;
        }
        
        private function setShells(param1:Vector.<SellOnVehicleShellVo>) : void
        {
            this.updateOpenedState();
            this.slidingComponent.setShells(param1);
        }
        
        private function setEquipment(param1:Vector.<SellOnVehicleEquipmentVo>) : void
        {
            this.slidingComponent.setEquipment(param1);
        }
        
        private function setInventory(param1:Vector.<SellInInventoryModuleVo>, param2:Vector.<SellInInventoryShellVo>) : void
        {
            this.slidingComponent.setInventory(param1,param2);
        }
        
        private function updateComponentsPosition() : void
        {
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
        
        private function playSlidingAnimation() : void
        {
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
            var _loc3_:int = window.height;
            _loc3_ = _loc3_ + _loc2_;
            var _loc4_:int = Math.floor((App.appHeight - window.getBackground().height - _loc2_) / 2);
            for each(_loc5_ in this.tweens)
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
            this.tweens = Vector.<Tween>([new Tween(_loc1_,this.slidingComponent,{"height":_loc6_},{"paused":false,
            "ease":Strong.easeOut,
            "onComplete":null
        }),new Tween(_loc1_,this.windBgForm,{"height":_loc9_},{"paused":false,
        "ease":Strong.easeOut,
        "onComplete":null
    }),new Tween(_loc1_,this.submitBtn,{"y":_loc7_},{"paused":false,
    "ease":Strong.easeOut,
    "onComplete":null
}),new Tween(_loc1_,this.cancelBtn,{"y":_loc8_},{"paused":false,
"ease":Strong.easeOut,
"onComplete":null
}),new Tween(_loc1_,this.result_mc,{"y":_loc11_},{"paused":false,
"ease":Strong.easeOut,
"onComplete":null
}),new Tween(_loc1_,this.slidingComponent.mask_mc,{"height":_loc12_},{"paused":false,
"ease":Strong.easeOut,
"onComplete":null
}),new Tween(_loc1_,this.slidingComponent.expandBg,{"height":_loc13_},{"paused":false,
"ease":Strong.easeOut,
"onComplete":null
}),new Tween(_loc1_,this.slidingComponent.settingsBtn.creditsIT,{"alpha":_loc15_},{"paused":false,
"ease":Strong.easeOut,
"onComplete":null
}),new Tween(_loc1_,this.slidingComponent.settingsBtn.ddLine,{"alpha":_loc16_},{"paused":false,
"ease":Strong.easeOut,
"onComplete":null
}),new Tween(_loc1_,this.controlQuestion,{"y":_loc14_},{"paused":false,
"ease":Strong.easeOut,
"onComplete":null
}),new Tween(_loc1_,window,{"y":_loc4_},{"paused":false,
"ease":Strong.easeOut,
"onComplete":null
}),new Tween(_loc1_,window.getBackground(),{"height":_loc10_},{"paused":false,
"ease":Strong.easeOut,
"onComplete":null
})]);
this.countTweenObjects = this.tweens.length;
var _loc17_:* = 0;
while(_loc17_ < this.countTweenObjects)
{
this.tweens[_loc17_].onComplete = this.motionCallBack;
this.tweens[_loc17_].fastTransform = false;
_loc17_++;
}
this.updateElements();
}

private function updateElements() : void
{
this.slidingComponent.slidingScrList.y = this.slidingComponent.settingsBtn.y + this.slidingComponent.settingsBtn.height;
this.slidingComponent.settingsBtn.creditsIT.visible = true;
this.slidingComponent.slidingScrList.visible = this.slidingComponent.isOpened;
}

private function updateOpenedState() : void
{
var _loc1_:Object = getDialogSettingsS();
this.slidingComponent.isOpened = _loc1_.isOpened;
}

private function handleSubmit(param1:ButtonEvent) : void
{
/*
 * Decompilation error
 * Code may be obfuscated
 * Error type: TranslateException
 */
throw new Error("Not decompiled due to error");
}

private function wasDrawnHandler(param1:VehicleSellDialogEvent) : void
{
this.listVisibleHight = param1.listVisibleHight;
this.updateComponentsPosition();
}

private function updateMoneyResult(param1:VehicleSellDialogEvent) : void
{
this.headerComponent.creditsCommon = this.headerComponent.tankPrice;
this.creditsComplDev = 0;
this.goldCommon = 0;
this.renderersArr = this.slidingComponent.slidingScrList.getRenderers();
var _loc2_:uint = 0;
while(_loc2_ < this.renderersArr.length)
{
if(!this.renderersArr[_loc2_].toInventory)
{
this.headerComponent.creditsCommon = this.headerComponent.creditsCommon + this.renderersArr[_loc2_].moneyValue;
}
_loc2_++;
}
this.complexDeviceRenderers = this.devicesComponent.deviceItemRenderer;
var _loc3_:uint = 0;
while(_loc3_ < this.complexDeviceRenderers.length)
{
if(this.complexDeviceRenderers[_loc3_].toInventory)
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

private function handleClose(param1:ButtonEvent) : void
{
onWindowCloseS();
}

private function userInputHandler(param1:Event) : void
{
setUserInputS(this.controlQuestion.getUserText());
}

private function handleDissmisClick(param1:ListEvent) : void
{
invalidate(INV_BARRACKS_DROP);
}
}
}
