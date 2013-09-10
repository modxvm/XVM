package net.wg.gui.lobby.sellDialog 
{
    import __AS3__.vec.*;
    import fl.transitions.easing.*;
    import flash.display.*;
    import flash.events.*;
    import net.wg.gui.components.controls.*;
    import net.wg.gui.events.*;
    import net.wg.infrastructure.base.meta.*;
    import net.wg.infrastructure.base.meta.impl.*;
    import net.wg.utils.*;
    import scaleform.clik.constants.*;
    import scaleform.clik.events.*;
    import scaleform.clik.motion.*;
    
    public class VehicleSellDialog extends net.wg.infrastructure.base.meta.impl.VehicleSellDialogMeta implements net.wg.infrastructure.base.meta.IVehicleSellDialogMeta
    {
        public function VehicleSellDialog()
        {
            this.vehicleData = {};
            this.modulesData = {};
            this.shellsData = {};
            this.tweens = new Vector.<scaleform.clik.motion.Tween>();
            super();
            isModal = true;
            isCentered = true;
            canDrag = false;
            showWindowBg = false;
            var loc1:*;
            scaleY = loc1 = 1;
            scaleX = loc1;
            this.controlQuestion.visible = false;
            return;
        }

        protected override function onPopulate():void
        {
            super.onPopulate();
            return;
        }

        protected override function draw():void
        {
            if (isInvalid("updateStage") && window) 
                this.updateWindowPosition();
            if (isInvalid(scaleform.clik.constants.InvalidationType.DATA)) 
            {
                this.setHeader(this.vehicleData);
                this.setDevices(this.vehicleData);
                this.setShells(this.vehicleData);
                this.setEquipment(this.vehicleData);
                this.setInventory(this.modulesData, this.shellsData);
                this.setGoldText(this.headerComponent.creditsCommon, this.goldCommon);
            }
            return;
        }

        internal function setGoldText(arg1:Number, arg2:Number):void
        {
            var loc1:*=App.utils.locale;
            var loc2:*=loc1.gold(arg1);
            var loc3:*=true;
            var loc4:*;
            if ((loc4 = this.headerComponent.tankGoldPrice > 0 ? this.headerComponent.tankGoldPrice - arg2 : arg2) >= 0) 
                loc3 = this.headerComponent.tankGoldPrice > 0 ? false : true;
            else 
                loc4 = loc4 * -1;
            var loc5:*=loc1.gold(loc4);
            var loc6:*=arg1 + this.creditsComplDev;
            if (loc4 == 0) 
                this.result_mc.goldIT.text = "0";
            else 
            {
                this.result_mc.goldIT.visible = true;
                this.result_mc.goldIT.text = loc3 ? "- " + loc5 : "+ " + loc5;
            }
            if (loc6 > 0) 
                this.result_mc.creditsIT.text = "+ " + loc1.gold(loc6);
            else 
                this.result_mc.creditsIT.text = "0";
            if (this.controlQuestion && this.controlQuestion.visible) 
            {
                this.controlQuestion.cleanField();
                setResultCreditS(loc6 != 0 ? loc6 : loc4);
                App.utils.scheduler.envokeInNextFrame(this.updateFocus, this.controlQuestion.userInput);
            }
            if (arg1 - this.headerComponent.tankPrice > 0) 
            {
                this.slidingComponent.settingsBtn.creditsIT.text = "+ " + loc1.gold(arg1 - this.headerComponent.tankPrice);
                this.slidingComponent.settingsBtn.creditsIT.validateNow();
            }
            else 
                this.slidingComponent.settingsBtn.creditsIT.text = "0";
            if (this.slidingComponent.settingsBtn.setingsDropBtn.selected) 
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
            return;
        }

        internal function setHeader(arg1:Object):void
        {
            this.headerComponent.setData(arg1);
            return;
        }

        internal function setDevices(arg1:Object):void
        {
            this.devicesComponent.setData(arg1);
            this.slidingComponent.sellData = this.devicesComponent.sellData;
            return;
        }

        internal function setShells(arg1:Object):void
        {
            this.updateOpenedState();
            this.slidingComponent.setShells(arg1);
            return;
        }

        internal function updateWindowPosition():void
        {
            var loc1:*=0;
            var loc2:*=0;
            if (isCentered) 
            {
                window.x = App.appWidth - window.width >> 1;
                window.y = App.appHeight - window.getBackground().height >> 1;
            }
            else 
            {
                loc1 = window.width + window.x;
                loc2 = window.getBackground().height + window.y;
                if (loc1 > App.appWidth) 
                    window.x = window.x - (loc1 - App.appWidth);
                if (loc2 > App.appHeight) 
                    window.y = window.y - (loc2 - App.appHeight);
            }
            return;
        }

        internal function setEquipment(arg1:Object):void
        {
            this.slidingComponent.setEquipment(arg1);
            return;
        }

        internal function setInventory(arg1:Object, arg2:Object):void
        {
            this.slidingComponent.setInventory(arg1, arg2);
            return;
        }

        internal function handleSubmit(arg1:scaleform.clik.events.ButtonEvent):void
        {
            var loc8:*=0;
            this.renderersArr = this.slidingComponent.slidingScrList.getRenderers();
            this.complexDeviceRenderers = this.devicesComponent.deviceItemRenderer;
            var loc1:*=[];
            var loc2:*=[];
            var loc3:*=[];
            var loc4:*=[];
            var loc5:*=[];
            var loc6:*=false;
            var loc7:*=0;
            loc7 = 0;
            while (loc7 < this.renderersArr.length) 
            {
                if (!this.renderersArr[loc7].inInventory) 
                {
                    var loc9:*=this.renderersArr[loc7].type;
                    switch (loc9) 
                    {
                        case "optDevices":
                            loc1.push(this.renderersArr[loc7].dataInfo);
                            break;
                        case "shells":
                            loc2.push(this.renderersArr[loc7].dataInfo);
                            break;
                        case "eqs":
                            loc3.push(this.renderersArr[loc7].dataInfo);
                            break;
                        case "modules":
                            loc8 = 0;
                            while (loc8 < this.modulesData.length) 
                            {
                                loc5.push(this.modulesData[loc8][0]);
                                ++loc8;
                            }
                            break;
                        case "invShells":
                            loc5.push(this.renderersArr[loc7].dataInfo);
                            break;
                    }
                }
                ++loc7;
            }
            loc7 = 0;
            while (loc7 < this.complexDeviceRenderers.length) 
            {
                if (!this.complexDeviceRenderers[loc7].inInventory) 
                    loc1.push(this.complexDeviceRenderers[loc7].dataInfo);
                ++loc7;
            }
            if (this.headerComponent.inBarracsDrop.selectedIndex == 1) 
                loc6 = true;
            setDialogSettingsS(this.slidingComponent.settingsBtn.setingsDropBtn.selected);
            sellS(this.vehicleData, loc2, loc3, loc1, loc5, loc6);
            onWindowCloseS();
            return;
        }

        internal function updateComponentsPosition():void
        {
            this.slidingComponent.visible = !(this.listVisibleHight == 0);
            if (this.listVisibleHight != 0) 
            {
                this.slidingComponent.settingsBtn.visible = true;
                this.slidingComponent.expandBg.visible = true;
            }
            var loc1:*=this.headerComponent.y + this.headerComponent.getNextPosition();
            if (this.devicesComponent.visible) 
            {
                this.devicesComponent.y = loc1;
                loc1 = this.devicesComponent.y + this.devicesComponent.getNextPosition();
            }
            if (this.slidingComponent.visible) 
            {
                this.slidingComponent.settingsBtn.setingsDropBtn.addEventListener(flash.events.Event.SELECT, this.playSlidingAnimation);
                this.slidingComponent.y = loc1;
                loc1 = this.slidingComponent.y + this.slidingComponent.getNextPosition();
            }
            this.result_mc.y = loc1;
            if (this.controlQuestion.visible) 
            {
                this.controlQuestion.y = this.result_mc.y + this.result_mc.getSize();
                loc1 = this.controlQuestion.y + this.controlQuestion.getNextPosition();
            }
            else 
                loc1 = this.result_mc.y + this.result_mc.getSize();
            this.windBgForm.height = loc1;
            var loc3:*;
            this.cancelBtn.y = loc3 = this.windBgForm.y + this.windBgForm.height + 3;
            this.submitBtn.y = loc3;
            var loc2:*=this.submitBtn.y + this.submitBtn.height;
            window.updateSize(this.width, loc2, true);
            window.x = App.appWidth - window.width >> 1;
            window.y = App.appHeight - window.height >> 1;
            this.setGoldText(this.headerComponent.creditsCommon, this.goldCommon);
            return;
        }

        internal function wasDrawnHandler(arg1:net.wg.gui.events.VehicleSellDialogEvent):void
        {
            this.listVisibleHight = arg1.listVisibleHight;
            this.updateComponentsPosition();
            return;
        }

        internal function updateMoneyResult(arg1:net.wg.gui.events.VehicleSellDialogEvent):void
        {
            this.headerComponent.creditsCommon = this.headerComponent.tankPrice;
            this.creditsComplDev = 0;
            this.goldCommon = 0;
            this.renderersArr = this.slidingComponent.slidingScrList.getRenderers();
            var loc1:*=0;
            while (loc1 < this.renderersArr.length) 
            {
                if (!this.renderersArr[loc1].inInventory) 
                    this.headerComponent.creditsCommon = this.headerComponent.creditsCommon + this.renderersArr[loc1].moneyValue;
                ++loc1;
            }
            this.complexDeviceRenderers = this.devicesComponent.deviceItemRenderer;
            var loc2:*=0;
            while (loc2 < this.complexDeviceRenderers.length) 
            {
                if (this.complexDeviceRenderers[loc2].inInventory) 
                    if (!this.complexDeviceRenderers[loc2].isRemovable) 
                        this.goldCommon = this.goldCommon + this.devicesComponent.removePrice;
                else 
                    this.creditsComplDev = this.creditsComplDev + this.complexDeviceRenderers[loc2].moneyValue;
                ++loc2;
            }
            this.setGoldText(this.headerComponent.creditsCommon, this.goldCommon);
            this.as_checkGold(this.accGold);
            return;
        }

        internal function playSlidingAnimation():void
        {
            var loc5:*=null;
            var loc6:*=0;
            var loc7:*=0;
            var loc8:*=0;
            var loc9:*=0;
            var loc10:*=0;
            var loc11:*=0;
            var loc12:*=0;
            if (!this.compCompletedTween()) 
            {
                this.slidingComponent.settingsBtn.setingsDropBtn.removeEventListener(flash.events.Event.SELECT, this.playSlidingAnimation);
                this.slidingComponent.settingsBtn.setingsDropBtn.selected = !this.slidingComponent.settingsBtn.setingsDropBtn.selected;
                this.slidingComponent.settingsBtn.setingsDropBtn.addEventListener(flash.events.Event.SELECT, this.playSlidingAnimation);
                return;
            }
            this.countCallBack = 0;
            var loc1:*=SLIDING_SPEED;
            var loc2:*=this.slidingComponent.isOpened ? -this.slidingComponent.resultExpand : this.slidingComponent.resultExpand;
            var loc3:*=this.windBgForm.height + window.contentPadding.top + window.contentPadding.bottom;
            loc3 = loc3 + loc2;
            var loc4:*=(loc4 = Math.floor((App.appHeight - loc3) / 2)) - WINDOW_PADDING;
            var loc18:*=0;
            var loc19:*=this.tweens;
            for each (loc5 in loc19) 
            {
                loc5.paused = true;
                loc5 = null;
            }
            loc6 = this.slidingComponent.height + loc2;
            loc7 = this.submitBtn.y + loc2;
            loc8 = this.cancelBtn.y + loc2;
            loc9 = this.windBgForm.height + loc2;
            loc10 = window.getBackground().height + loc2;
            loc11 = this.result_mc.y + loc2;
            loc12 = this.slidingComponent.isOpened ? 0 : this.slidingComponent.mask_mc.height + loc2;
            var loc13:*=this.slidingComponent.expandBg.height + loc2;
            var loc14:*=this.controlQuestion.visible ? this.controlQuestion.y + loc2 : 0;
            var loc15:*=this.slidingComponent.isOpened ? 1 : 0;
            var loc16:*=this.slidingComponent.isOpened ? 0 : 1;
            this.slidingComponent.isOpened = !this.slidingComponent.isOpened;
            this.tweens = Vector.<scaleform.clik.motion.Tween>([new scaleform.clik.motion.Tween(loc1, this.slidingComponent, {"height":loc6}, {"paused":false, "ease":fl.transitions.easing.Strong.easeOut, "onComplete":null}), new scaleform.clik.motion.Tween(loc1, this.windBgForm, {"height":loc9}, {"paused":false, "ease":fl.transitions.easing.Strong.easeOut, "onComplete":null}), new scaleform.clik.motion.Tween(loc1, this.submitBtn, {"y":loc7}, {"paused":false, "ease":fl.transitions.easing.Strong.easeOut, "onComplete":null}), new scaleform.clik.motion.Tween(loc1, this.cancelBtn, {"y":loc8}, {"paused":false, "ease":fl.transitions.easing.Strong.easeOut, "onComplete":null}), new scaleform.clik.motion.Tween(loc1, this.result_mc, {"y":loc11}, {"paused":false, "ease":fl.transitions.easing.Strong.easeOut, "onComplete":null}), new scaleform.clik.motion.Tween(loc1, this.slidingComponent.mask_mc, {"height":loc12}, {"paused":false, "ease":fl.transitions.easing.Strong.easeOut, "onComplete":null}), new scaleform.clik.motion.Tween(loc1, this.slidingComponent.expandBg, {"height":loc13}, {"paused":false, "ease":fl.transitions.easing.Strong.easeOut, "onComplete":null}), new scaleform.clik.motion.Tween(loc1, this.slidingComponent.settingsBtn.creditsIT, {"alpha":loc15}, {"paused":false, "ease":fl.transitions.easing.Strong.easeOut, "onComplete":null}), new scaleform.clik.motion.Tween(loc1, this.slidingComponent.settingsBtn.ddLine, {"alpha":loc16}, {"paused":false, "ease":fl.transitions.easing.Strong.easeOut, "onComplete":null}), new scaleform.clik.motion.Tween(loc1, this.controlQuestion, {"y":loc14}, {"paused":false, "ease":fl.transitions.easing.Strong.easeOut, "onComplete":null}), new scaleform.clik.motion.Tween(loc1, window, {"y":loc4}, {"paused":false, "ease":fl.transitions.easing.Strong.easeOut, "onComplete":null}), new scaleform.clik.motion.Tween(loc1, window.getBackground(), {"height":loc10}, {"paused":false, "ease":fl.transitions.easing.Strong.easeOut, "onComplete":null})]);
            this.countTweenObjects = this.tweens.length;
            var loc17:*=0;
            while (loc17 < this.countTweenObjects) 
            {
                scaleform.clik.motion.Tween(this.tweens[loc17]).onComplete = this.motionCallBack;
                ++loc17;
            }
            this.updateElements();
            return;
        }

        public function motionCallBack(arg1:scaleform.clik.motion.Tween):void
        {
            var loc1:*;
            var loc2:*=((loc1 = this).countCallBack + 1);
            loc1.countCallBack = loc2;
            return;
        }

        public function compCompletedTween():Boolean
        {
            return this.countTweenObjects == this.countCallBack;
        }

        internal function handleClose(arg1:scaleform.clik.events.ButtonEvent):void
        {
            onWindowCloseS();
            return;
        }

        internal function userInputHandler(arg1:flash.events.Event):void
        {
            setUserInputS(this.controlQuestion.getUserText());
            return;
        }

        internal function updateFocus(arg1:flash.display.InteractiveObject):void
        {
            App.utils.focusHandler.setFocus(arg1);
            return;
        }

        internal function updateOpenedState():void
        {
            var loc1:*=getDialogSettingsS();
            var loc2:*;
            this.isOpen = loc2 = loc1.isOpened;
            this.slidingComponent.isOpened = loc2;
            return;
        }

        internal function isHasGold():Number
        {
            return this.goldCommon - this.headerComponent.tankGoldPrice;
        }

        public override function updateStage(arg1:Number, arg2:Number):void
        {
            super.updateStage(arg1, arg2);
            this.updateWindowPosition();
            return;
        }

        public function as_visibleControlBlock(arg1:Boolean):void
        {
            if (this.controlQuestion.visible != arg1) 
            {
                this.controlQuestion.visible = arg1;
                if (arg1) 
                    App.utils.scheduler.envokeInNextFrame(this.updateFocus, this.controlQuestion.userInput);
                else 
                    this.controlQuestion.y = 0;
            }
            return;
        }

        public function as_enableButton(arg1:Boolean):void
        {
            var loc1:*=false;
            if (this.submitBtn) 
            {
                loc1 = this.submitBtn.enabled;
                this.submitBtn.enabled = this.controlQuestion.isValidControlInput && arg1 && this.accGold >= this.isHasGold();
                if (this.submitBtn.enabled && !loc1) 
                    App.utils.scheduler.envokeInNextFrame(this.updateFocus, this.submitBtn);
            }
            return;
        }

        public function as_setCtrlQuestion(arg1:String):void
        {
            if (this.controlQuestion) 
            {
                this.controlQuestion.headerText = DIALOGS.VEHICLESELLDIALOG_CTRLQUESTION_HEADER;
                this.controlQuestion.errorText = DIALOGS.VEHICLESELLDIALOG_CTRLQUESTION_ERRORMESSAGE;
                this.controlQuestion.questionText = arg1;
                this.controlQuestion.invalidateData();
            }
            return;
        }

        public function as_setControlNumber(arg1:String):void
        {
            if (this.controlQuestion) 
            {
                this.controlQuestion.controlText = arg1;
                this.controlQuestion.invalidateData();
            }
            return;
        }

        internal function enabledSubmitBtn(arg1:Boolean):void
        {
            if (this.submitBtn.enabled != arg1) 
                this.submitBtn.enabled = arg1;
            return;
        }

        internal function updateElements():void
        {
            this.slidingComponent.slidingScrList.y = this.slidingComponent.settingsBtn.y + this.slidingComponent.settingsBtn.height;
            this.slidingComponent.settingsBtn.creditsIT.visible = true;
            this.slidingComponent.slidingScrList.visible = this.slidingComponent.isOpened;
            return;
        }

        public function as_checkGold(arg1:Number):void
        {
            var loc1:*=NaN;
            this.accGold = arg1;
            this.complexDeviceRenderers = this.devicesComponent.deviceItemRenderer;
            if (this.accGold < this.isHasGold()) 
            {
                loc1 = 16711680;
                this.enabledSubmitBtn(false);
            }
            else 
            {
                loc1 = 16763253;
                this.enabledSubmitBtn(this.controlQuestion.visible ? this.controlQuestion.isValidControlInput : true);
            }
            var loc2:*=0;
            while (loc2 < this.complexDeviceRenderers.length) 
            {
                if (this.complexDeviceRenderers[loc2].inInventory) 
                    if (!this.complexDeviceRenderers[loc2].isRemovable) 
                    {
                        this.complexDeviceRenderers[loc2].setColor(loc1);
                        this.complexDeviceRenderers[loc2].validateNow();
                    }
                ++loc2;
            }
            this.result_mc.goldIT.textColor = loc1;
            return;
        }

        public function as_setData(arg1:Object, arg2:Object, arg3:Object, arg4:Number, arg5:Number):void
        {
            this.slidingComponent.sellData = [];
            this.accGold = arg5;
            this.goldCommon = 0;
            this.vehicleData = arg1;
            this.modulesData = arg2;
            this.shellsData = arg3;
            this.devicesComponent.removePrice = arg4;
            this.window.title = App.utils.locale.makeString(DIALOGS.VEHICLESELLDIALOG_TITLE, {"name":arg1.userName});
            invalidateData();
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            this.updateOpenedState();
            this.controlQuestion.addEventListener(net.wg.gui.lobby.sellDialog.ControlQuestionComponent.USER_INPUT_HANDLER, this.userInputHandler);
            this.slidingComponent.slidingScrList.addEventListener(net.wg.gui.events.VehicleSellDialogEvent.LIST_WAS_DRAWN, this.wasDrawnHandler, false, 1);
            this.cancelBtn.label = DIALOGS.VEHICLESELLDIALOG_CANCEL;
            this.submitBtn.label = DIALOGS.VEHICLESELLDIALOG_SUBMIT;
            this.addEventListener(net.wg.gui.events.VehicleSellDialogEvent.UPDATE_RESULT, this.updateMoneyResult);
            this.cancelBtn.addEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.handleClose);
            this.submitBtn.addEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.handleSubmit);
            if (this.controlQuestion.visible) 
                App.utils.scheduler.envokeInNextFrame(this.updateFocus, this.controlQuestion.userInput);
            else 
                App.utils.scheduler.envokeInNextFrame(this.updateFocus, this.submitBtn);
            return;
        }

        protected override function onDispose():void
        {
            var loc1:*=null;
            super.onDispose();
            App.utils.scheduler.cancelTask(this.updateFocus);
            this.slidingComponent.slidingScrList.removeEventListener(net.wg.gui.events.VehicleSellDialogEvent.LIST_WAS_DRAWN, this.wasDrawnHandler);
            this.removeEventListener(net.wg.gui.events.VehicleSellDialogEvent.UPDATE_RESULT, this.updateMoneyResult);
            this.slidingComponent.settingsBtn.setingsDropBtn.removeEventListener(flash.events.Event.SELECT, this.playSlidingAnimation);
            this.controlQuestion.removeEventListener(net.wg.gui.lobby.sellDialog.ControlQuestionComponent.USER_INPUT_HANDLER, this.userInputHandler);
            this.cancelBtn.removeEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.handleClose);
            var loc2:*=0;
            var loc3:*=this.tweens;
            for each (loc1 in loc3) 
            {
                loc1.paused = true;
                loc1 = null;
            }
            this.headerComponent.dispose();
            this.slidingComponent.dispose();
            this.devicesComponent.dispose();
            this.controlQuestion.dispose();
            this.vehicleData = null;
            this.modulesData = null;
            this.shellsData = null;
            App.toolTipMgr.hide();
            return;
        }

        public static const ICONS_TEXT_OFFSET:Number=-2;

        internal static const WINDOW_PADDING:int=12;

        internal static const SLIDING_SPEED:Number=350;

        public var headerComponent:net.wg.gui.lobby.sellDialog.SellHeaderComponent;

        public var slidingComponent:net.wg.gui.lobby.sellDialog.SellSlidingComponent;

        public var devicesComponent:net.wg.gui.lobby.sellDialog.SellDevicesComponent;

        public var controlQuestion:net.wg.gui.lobby.sellDialog.ControlQuestionComponent;

        public var windBgForm:flash.display.MovieClip;

        public var cancelBtn:net.wg.gui.components.controls.SoundButtonEx;

        public var result_mc:net.wg.gui.lobby.sellDialog.TotalResult;

        internal var goldCommon:Number=0;

        internal var listVisibleHight:Number=0;

        internal var creditsComplDev:Number=0;

        internal var renderersArr:__AS3__.vec.Vector.<net.wg.infrastructure.interfaces.ISaleItemBlockRenderer>;

        internal var complexDeviceRenderers:__AS3__.vec.Vector.<net.wg.infrastructure.interfaces.ISaleItemBlockRenderer>;

        internal var vehicleData:Object;

        internal var modulesData:Object;

        internal var shellsData:Object;

        internal var isOpen:Boolean=false;

        internal var accGold:Number=0;

        internal var tweens:__AS3__.vec.Vector.<scaleform.clik.motion.Tween>;

        internal var countTweenObjects:int=0;

        internal var countCallBack:int=0;

        public var submitBtn:net.wg.gui.components.controls.SoundButtonEx;
    }
}
