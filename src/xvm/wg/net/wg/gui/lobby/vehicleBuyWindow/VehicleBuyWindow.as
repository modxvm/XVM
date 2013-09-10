package net.wg.gui.lobby.vehicleBuyWindow 
{
    import flash.display.*;
    import flash.events.*;
    import flash.filters.*;
    import net.wg.data.constants.*;
    import net.wg.infrastructure.base.meta.*;
    import net.wg.infrastructure.base.meta.impl.*;
    import net.wg.infrastructure.interfaces.*;
    import net.wg.utils.*;
    import scaleform.clik.events.*;
    import scaleform.clik.utils.*;
    
    public class VehicleBuyWindow extends net.wg.infrastructure.base.meta.impl.VehicleBuyWindowMeta implements net.wg.infrastructure.base.meta.IVehicleBuyWindowMeta
    {
        public function VehicleBuyWindow()
        {
            super();
            isModal = true;
            isCentered = true;
            canDrag = false;
            showWindowBg = false;
            return;
        }

        public function as_setInitData(arg1:Object):void
        {
            this.expand(arg1.expanded, true);
            delete arg1.expanded;
            this.initInfo = new net.wg.gui.lobby.vehicleBuyWindow.BuyingVehicleVO(arg1);
            this.isInitInfoChanged = true;
            invalidate();
            return;
        }

        public override function set window(arg1:net.wg.infrastructure.interfaces.IWindow):void
        {
            if (window != arg1) 
            {
                this.disposeWindowRefHandlers();
                if (arg1) 
                    if (arg1.getConstraints()) 
                        arg1.getConstraints().addEventListener(flash.events.Event.RESIZE, this.windowRefResizeHandler);
            }
            super.window = arg1;
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            goldColor = this.footerMc.totalGoldPrice.textColor;
            creditsColor = this.footerMc.totalCreditsPrice.textColor;
            this.animManager = new net.wg.gui.lobby.vehicleBuyWindow.VehicleBuyWindowAnimManager(this);
            var loc1:*=App.utils.locale;
            this.footerMc.submitBtn.label = loc1.makeString(DIALOGS.BUYVEHICLEDIALOG_SUBMITBTN);
            this.footerMc.cancelBtn.label = loc1.makeString(DIALOGS.BUYVEHICLEDIALOG_CANCELBTN);
            this.footerMc.expandBtn.addEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.expandButtonClickHandler, false, 0, true);
            this.footerMc.submitBtn.addEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.submitButtonClickHandler, false, 0, true);
            this.footerMc.cancelBtn.addEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.cancelBtnClickHandler);
            this.moveFocusToSubmitButton();
            this.bodyMc.addEventListener(net.wg.gui.lobby.vehicleBuyWindow.BodyMc.BUTTONS_GROUP_SELECTION_CHANGED, this.selectedPriceChangeHandler, false, 0, true);
            this.bodyMc.ammoCheckbox.addEventListener(flash.events.Event.SELECT, this.checkBoxSelectHandler, false, 0, true);
            this.bodyMc.slotCheckbox.addEventListener(flash.events.Event.SELECT, this.checkBoxSelectHandler, false, 0, true);
            this.bodyMc.crewCheckbox.addEventListener(flash.events.Event.SELECT, this.crewCheckBoxSelectHandler, false, 0, true);
            return;
        }

        public function moveFocusToSubmitButton():void
        {
            App.utils.focusHandler.setFocus(this.footerMc.submitBtn);
            return;
        }

        protected override function draw():void
        {
            var loc2:*=0;
            var loc3:*=0;
            var loc4:*=null;
            var loc5:*=null;
            var loc6:*=null;
            var loc7:*=NaN;
            var loc8:*=NaN;
            var loc9:*=false;
            if (isInvalid(UPDATE_STAGE_INVALID) && window) 
                if (isCentered) 
                {
                    window.x = App.appWidth - window.width >> 1;
                    window.y = App.appHeight - window.getBackground().height >> 1;
                }
                else 
                {
                    loc2 = window.width + window.x;
                    loc3 = window.getBackground().height + window.y;
                    if (loc2 > App.appWidth) 
                        window.x = window.x - (loc2 - App.appWidth);
                    if (loc3 > App.appHeight) 
                        window.y = window.y - (loc3 - App.appHeight);
                }
            var loc1:*=App.utils.locale;
            if (this.isInitInfoChanged) 
            {
                this.isInitInfoChanged = false;
                loc4 = {"vehiclename":this.initInfo.name};
                window.title = loc1.makeString(DIALOGS.BUYVEHICLEDIALOG_TITLE, loc4);
                this.headerMc.tankPriceLabel.text = loc1.makeString(DIALOGS.BUYVEHICLEDIALOG_PRICELABEL, loc4);
                this.headerMc.tankName.text = this.initInfo.longName;
                this.headerMc.tankDescr.text = this.initInfo.description;
                this.headerMc.icon.tankType = this.initInfo.type;
                this.headerMc.icon.iconLoader.source = this.initInfo.icon;
                this.headerMc.icon.nation = this.initInfo.nation;
                this.headerMc.icon.level = this.initInfo.level;
                this.headerMc.tankPrice.icon = this.initInfo.isPremium ? net.wg.data.constants.Currencies.GOLD : net.wg.data.constants.Currencies.CREDITS;
                this.headerMc.tankPrice.textColor = this.initInfo.isPremium ? goldColor : creditsColor;
                this.headerMc.tankPrice.text = loc1.integer(this.initInfo.actualPrice);
                this.headerMc.icon.isElite = this.initInfo.isElite;
                this.headerMc.icon.isPremium = this.initInfo.isPremium;
                loc5 = "<b>" + loc1.makeString(DIALOGS.BUYVEHICLEDIALOG_TANKMEN) + " " + this.initInfo.tankmenCount + "</b>";
                this.bodyMc.tankmenLabel.htmlText = loc1.makeString(DIALOGS.BUYVEHICLEDIALOG_TANKMENLABEL, {"count":loc5});
                this.bodyMc.scoolBtn.price = this.initInfo.studyPriceCredits.toString();
                this.bodyMc.academyBtn.price = this.initInfo.studyPriceGold.toString();
                this.bodyMc.freeBtn.price = "0";
                this.bodyMc.scoolBtn.data = this.initInfo.studyPriceCredits;
                this.bodyMc.academyBtn.data = this.initInfo.studyPriceGold;
                this.bodyMc.freeBtn.data = 0;
                this.bodyMc.ammoPrice.text = loc1.integer(this.initInfo.ammoPrice);
                this.bodyMc.slotPrice.text = loc1.integer(this.initInfo.slotPrice);
                var loc10:*;
                this.bodyMc.freeBtn.nation = loc10 = this.initInfo.nation;
                this.bodyMc.academyBtn.nation = loc10 = loc10;
                this.bodyMc.scoolBtn.nation = loc10;
                this.isTotalResultChanged = true;
                loc6 = this.headerMc.tankPriceLabel.filters[0];
                this.bodyMc.crewCheckbox.textField.filters = [loc6.clone()];
                this.bodyMc.ammoCheckbox.textField.filters = [loc6.clone()];
                this.bodyMc.slotCheckbox.textField.filters = [loc6.clone()];
            }
            if (this.isExpandedValueChanged && this.windowBackgroundSizeInitialized) 
            {
                this.isExpandedValueChanged = false;
                this.animManager.launch(this._expand, this.expandImmediate);
            }
            if (this.isTotalResultChanged) 
            {
                this.isTotalResultChanged = false;
                loc7 = 0;
                loc8 = 0;
                loc7 = loc7 + (this.bodyMc.slotCheckbox.selected ? this.initInfo.slotPrice : 0);
                loc8 = loc8 + (this.bodyMc.ammoCheckbox.selected ? this.initInfo.ammoPrice : 0);
                if (this.initInfo.isPremium) 
                    loc7 = loc7 + this.initInfo.actualPrice;
                else 
                    loc8 = loc8 + this.initInfo.actualPrice;
                if (!this.bodyMc.crewCheckbox.selected) 
                    if (this.bodyMc.isGoldPriceSelected) 
                        loc7 = loc7 + this.bodyMc.selectedPrice;
                    else 
                        loc8 = loc8 + this.bodyMc.selectedPrice;
                this.footerMc.totalGoldPrice.text = loc1.gold(loc7);
                loc8 = isNaN(loc8) ? 0 : loc8;
                this.footerMc.totalCreditsPrice.text = loc1.integer(loc8);
                loc9 = true;
                if (loc7 > this.userTotalGold) 
                {
                    this.footerMc.totalGoldPrice.textColor = errorColor;
                    loc9 = false;
                }
                else 
                    this.footerMc.totalGoldPrice.textColor = goldColor;
                if (loc8 > this.userTotalCredits) 
                {
                    this.footerMc.totalCreditsPrice.textColor = errorColor;
                    loc9 = false;
                }
                else 
                    this.footerMc.totalCreditsPrice.textColor = creditsColor;
                this.footerMc.submitBtn.enabled = loc9;
            }
            return;
        }

        protected override function onDispose():void
        {
            super.onDispose();
            if (this.animManager) 
            {
                this.animManager.dispose();
                this.animManager = null;
            }
            if (this.footerMc) 
            {
                this.footerMc.expandBtn.removeEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.expandButtonClickHandler);
                this.footerMc.submitBtn.removeEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.submitButtonClickHandler);
                this.footerMc.cancelBtn.removeEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.cancelBtnClickHandler);
            }
            if (this.bodyMc) 
            {
                this.bodyMc.removeEventListener(net.wg.gui.lobby.vehicleBuyWindow.BodyMc.BUTTONS_GROUP_SELECTION_CHANGED, this.selectedPriceChangeHandler);
                this.bodyMc.ammoCheckbox.removeEventListener(flash.events.Event.SELECT, this.checkBoxSelectHandler);
                this.bodyMc.slotCheckbox.removeEventListener(flash.events.Event.SELECT, this.checkBoxSelectHandler);
                this.bodyMc.crewCheckbox.removeEventListener(flash.events.Event.SELECT, this.crewCheckBoxSelectHandler);
            }
            this.disposeWindowRefHandlers();
            return;
        }

        internal function disposeWindowRefHandlers():void
        {
            var loc1:*=null;
            if (window) 
            {
                loc1 = window.getConstraints();
                if (loc1) 
                    window.removeEventListener(flash.events.Event.RESIZE, this.windowRefResizeHandler);
            }
            return;
        }

        internal function cancelBtnClickHandler(arg1:scaleform.clik.events.ButtonEvent):void
        {
            onWindowCloseS();
            return;
        }

        internal function crewCheckBoxSelectHandler(arg1:flash.events.Event):void
        {
            this.bodyMc.groupEnabled = !this.bodyMc.crewCheckbox.selected;
            this.isTotalResultChanged = true;
            invalidate();
            return;
        }

        internal function checkBoxSelectHandler(arg1:flash.events.Event):void
        {
            this.isTotalResultChanged = true;
            invalidate();
            return;
        }

        internal function selectedPriceChangeHandler(arg1:flash.events.Event):void
        {
            this.bodyMc.crewCheckbox.selected = false;
            this.isTotalResultChanged = true;
            invalidate();
            return;
        }

        internal function submitButtonClickHandler(arg1:scaleform.clik.events.ButtonEvent):void
        {
            var loc1:*={"buySlot":this.bodyMc.slotCheckbox.selected, "buyAmmo":this.bodyMc.ammoCheckbox.selected, "isHasBeenExpanded":this._expand, "crewType":this.bodyMc.crewType};
            submitS(loc1);
            return;
        }

        internal function expandButtonClickHandler(arg1:flash.events.Event):void
        {
            this.expand(!this._expand, false);
            return;
        }

        public override function setFocus():void
        {
            super.setFocus();
            this.moveFocusToSubmitButton();
            return;
        }

        internal function windowRefResizeHandler(arg1:flash.events.Event):void
        {
            this.windowBackgroundSizeInitialized = true;
            invalidate(UPDATE_STAGE_INVALID);
            return;
        }

        protected override function onPopulate():void
        {
            super.onPopulate();
            return;
        }

        public function expand(arg1:Boolean, arg2:Boolean):void
        {
            if (this._expand != arg1) 
            {
                this._expand = arg1;
                this.expandImmediate = arg2;
                this.isExpandedValueChanged = true;
                invalidate();
            }
            this.footerMc.expandBtn.expanded = arg1;
            return;
        }

        public function as_setGold(arg1:Number):void
        {
            this.userTotalGold = arg1;
            this.isTotalResultChanged = true;
            invalidate();
            return;
        }

        public function as_setCredits(arg1:Number):void
        {
            this.userTotalCredits = arg1;
            this.isTotalResultChanged = true;
            invalidate();
            return;
        }

        public static const UPDATE_STAGE_INVALID:String="updateStage";

        internal static const errorColor:uint=16711680;

        public var footerMc:net.wg.gui.lobby.vehicleBuyWindow.FooterMc;

        public var bodyMc:net.wg.gui.lobby.vehicleBuyWindow.BodyMc;

        public var headerMc:net.wg.gui.lobby.vehicleBuyWindow.HeaderMc;

        public var backgroundMc:flash.display.MovieClip;

        public var bodyMaskMc:flash.display.MovieClip;

        internal var animManager:net.wg.gui.lobby.vehicleBuyWindow.VehicleBuyWindowAnimManager;

        internal var _expand:Boolean=true;

        internal var expandImmediate:Boolean;

        internal var isExpandedValueChanged:Boolean;

        internal var userTotalGold:Number;

        internal var userTotalCredits:Number;

        internal var initInfo:net.wg.gui.lobby.vehicleBuyWindow.BuyingVehicleVO;

        internal var windowBackgroundSizeInitialized:Boolean;

        internal var isInitInfoChanged:Boolean;

        internal var isTotalResultChanged:Boolean;

        internal static var goldColor:uint;

        internal static var creditsColor:uint;
    }
}
