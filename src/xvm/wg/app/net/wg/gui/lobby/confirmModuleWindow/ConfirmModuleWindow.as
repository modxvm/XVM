package net.wg.gui.lobby.confirmModuleWindow 
{
    import flash.text.*;
    import net.wg.data.constants.*;
    import net.wg.gui.components.advanced.*;
    import net.wg.gui.components.controls.*;
    import net.wg.infrastructure.base.meta.*;
    import net.wg.infrastructure.base.meta.impl.*;
    import net.wg.infrastructure.interfaces.*;
    import net.wg.utils.*;
    import scaleform.clik.data.*;
    import scaleform.clik.events.*;
    
    public class ConfirmModuleWindow extends net.wg.infrastructure.base.meta.impl.ConfirmModuleWindowMeta implements net.wg.infrastructure.base.meta.IConfirmModuleWindowMeta
    {
        public function ConfirmModuleWindow()
        {
            super();
            isModal = true;
            isCentered = true;
            canDrag = false;
            showWindowBg = false;
            return;
        }

        public override function setFocus():void
        {
            super.setFocus();
            this.moveFocusToSubmitButton();
            return;
        }

        protected override function draw():void
        {
            var loc1:*=null;
            var loc2:*=0;
            var loc3:*=0;
            var loc4:*=0;
            var loc5:*=0;
            var loc6:*=NaN;
            var loc7:*=null;
            var loc8:*=null;
            var loc9:*=null;
            var loc10:*=null;
            super.draw();
            if (isInvalid(DATA_INVALID)) 
            {
                if (this.moduleInfo) 
                {
                    this.moduleIcon.setValues(this.moduleInfo.type, this.moduleInfo.icon);
                    this.moduleIcon.extraIconSource = this.moduleInfo.extraModuleInfo;
                    this.moduleName.text = this.moduleInfo.name;
                    this.description.text = this.moduleInfo.descr;
                    loc1 = App.utils.locale;
                    loc2 = this.moduleInfo.price[0];
                    loc3 = this.moduleInfo.price[1];
                    if (this.moduleInfo.isActionNow) 
                    {
                        loc4 = this.dropdownMenu.selectedIndex == -1 ? 1 : this.dropdownMenu.selectedIndex;
                        this.dropdownMenu.dataProvider = new scaleform.clik.data.DataProvider([loc1.htmlTextWithIcon(loc1.integer(loc2), net.wg.data.constants.Currencies.CREDITS), loc1.htmlTextWithIcon(loc1.gold(loc3), net.wg.data.constants.Currencies.GOLD)]);
                        this.dropdownMenu.addEventListener(scaleform.clik.events.ListEvent.INDEX_CHANGE, this.currencyChangedHandler, false, 0, true);
                        this.dropdownMenu.selectedIndex = loc4;
                        this.priceLabel.textColor = ACTION_COLOR;
                        this.totalLabel.textColor = ACTION_COLOR;
                    }
                    else 
                    {
                        if (this.moduleInfo.currency != net.wg.data.constants.Currencies.GOLD) 
                        {
                            this.price.text = loc1.integer(loc2);
                        }
                        else 
                        {
                            this.price.text = loc1.gold(loc3);
                        }
                        this.priceLabel.textColor = NORMAL_COLOR;
                        this.totalLabel.textColor = NORMAL_COLOR;
                    }
                    this.dropdownMenu.visible = this.moduleInfo.isActionNow;
                    this.price.visible = !this.moduleInfo.isActionNow;
                    if (this.moduleInfo.defaultValue == -1) 
                    {
                        this.selectedCount = this.nsCount.value;
                    }
                    else 
                    {
                        this.selectedCount = this.moduleInfo.defaultValue;
                    }
                }
                invalidate(SELECTED_CURRENCY_INVALID);
            }
            if (isInvalid(SELECTED_CURRENCY_INVALID)) 
            {
                if (this.moduleInfo) 
                {
                    if (this.moduleInfo.isActionNow) 
                    {
                        if (this.dropdownMenu.selectedIndex != 0) 
                        {
                            loc5 = this.moduleInfo.maxAvailableCount[1];
                        }
                        else 
                        {
                            loc5 = this.moduleInfo.maxAvailableCount[0];
                        }
                    }
                    else if (this.moduleInfo.currency != net.wg.data.constants.Currencies.GOLD) 
                    {
                        loc5 = this.moduleInfo.maxAvailableCount[0];
                    }
                    else 
                    {
                        loc5 = this.moduleInfo.maxAvailableCount[1];
                    }
                    loc6 = Math.min(1, loc5);
                    this.nsCount.minimum = loc6;
                    this.nsCount.maximum = loc5;
                    this.nsCount.value = Math.min(this.selectedCount, loc5);
                    this.submitBtn.enabled = loc6 > 0;
                }
                invalidate(RESULT_INVALID);
            }
            if (isInvalid(RESULT_INVALID)) 
            {
                if (this.moduleInfo) 
                {
                    loc7 = App.utils.locale;
                    if (this.moduleInfo.isActionNow) 
                    {
                        if (this.dropdownMenu.selectedIndex != 0) 
                        {
                            loc9 = "0";
                            loc10 = loc8 = loc7.gold(this.nsCount.value * this.moduleInfo.price[1]);
                            this.currency = net.wg.data.constants.Currencies.GOLD;
                        }
                        else 
                        {
                            loc8 = "0";
                            loc10 = loc9 = loc7.integer(this.nsCount.value * this.moduleInfo.price[0]);
                            this.currency = net.wg.data.constants.Currencies.CREDITS;
                        }
                    }
                    else 
                    {
                        this.currency = this.moduleInfo.currency;
                        if (this.moduleInfo.currency != net.wg.data.constants.Currencies.GOLD) 
                        {
                            loc10 = loc9 = loc7.integer(this.nsCount.value * this.moduleInfo.price[0]);
                            loc8 = "0";
                        }
                        else 
                        {
                            loc10 = loc8 = loc7.gold(this.nsCount.value * this.moduleInfo.price[1]);
                            loc9 = "0";
                        }
                    }
                    this.resultGold.text = loc8;
                    this.resultCredits.text = loc9;
                    this.price.icon = this.currency;
                    this.price.textColor = net.wg.data.constants.Currencies.TEXT_COLORS[this.currency];
                    this.total.icon = this.currency;
                    this.total.textColor = net.wg.data.constants.Currencies.TEXT_COLORS[this.currency];
                    this.total.text = loc10;
                }
            }
            if (isInvalid(SETTINGS_INVALID)) 
            {
                if (window && this.settings) 
                {
                    window.title = this.settings.title;
                    this.submitBtn.label = this.settings.submitBtnLabel;
                    this.cancelBtn.label = this.settings.cancelBtnLabel;
                }
            }
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            this.cancelBtn.addEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.cancelBtnClickHandler, false, 0, true);
            this.submitBtn.addEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.submitBtnClickHandler, false, 0, true);
            var loc1:*=App.utils.locale;
            this.countLabel.text = loc1.makeString(DIALOGS.CONFIRMMODULEDIALOG_COUNTLABEL);
            this.priceLabel.text = loc1.makeString(DIALOGS.CONFIRMMODULEDIALOG_PRICELABEL);
            this.totalLabel.text = loc1.makeString(DIALOGS.CONFIRMMODULEDIALOG_TOTALLABEL);
            this.resultLabel.text = loc1.makeString(DIALOGS.CONFIRMMODULEDIALOG_TOTALLABEL);
            this.nsCount.addEventListener(scaleform.clik.events.IndexEvent.INDEX_CHANGE, this.selectedCountChangeHandler, false, 0, true);
            this.moveFocusToSubmitButton();
            return;
        }

        public override function set window(arg1:net.wg.infrastructure.interfaces.IWindow):void
        {
            super.window = arg1;
            if (arg1) 
            {
                invalidate(SETTINGS_INVALID);
            }
            return;
        }

        public function as_setSettings(arg1:Object):void
        {
            this.settings = new net.wg.gui.lobby.confirmModuleWindow.ConfirmModuleSettingsVO(arg1);
            invalidate(SETTINGS_INVALID);
            return;
        }

        public function as_setData(arg1:Object):void
        {
            this.moduleInfo = new net.wg.gui.lobby.confirmModuleWindow.ModuleInfoVo(arg1);
            invalidate(DATA_INVALID);
            return;
        }

        protected function cancelBtnClickHandler(arg1:scaleform.clik.events.ButtonEvent):void
        {
            onWindowCloseS();
            return;
        }

        internal function currencyChangedHandler(arg1:scaleform.clik.events.ListEvent):void
        {
            invalidate(SELECTED_CURRENCY_INVALID);
            return;
        }

        internal function submitBtnClickHandler(arg1:scaleform.clik.events.ButtonEvent):void
        {
            submitS(this.selectedCount, this.currency);
            return;
        }

        internal function selectedCountChangeHandler(arg1:scaleform.clik.events.IndexEvent):void
        {
            this.selectedCount = this.nsCount.value;
            invalidate(RESULT_INVALID);
            return;
        }

        protected override function onDispose():void
        {
            super.onDispose();
            if (this.dropdownMenu) 
            {
                this.dropdownMenu.removeEventListener(scaleform.clik.events.ListEvent.INDEX_CHANGE, this.currencyChangedHandler);
            }
            this.cancelBtn.removeEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.cancelBtnClickHandler);
            this.submitBtn.removeEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.submitBtnClickHandler);
            this.nsCount.removeEventListener(scaleform.clik.events.IndexEvent.INDEX_CHANGE, this.selectedCountChangeHandler);
            return;
        }

        public function moveFocusToSubmitButton():void
        {
            App.utils.focusHandler.setFocus(this.submitBtn);
            return;
        }

        internal static const SETTINGS_INVALID:String="settingsInv";

        internal static const NORMAL_COLOR:uint=6447189;

        internal static const ACTION_COLOR:uint=16777215;

        internal static const DATA_INVALID:String="dataInv";

        internal static const RESULT_INVALID:String="resultInv";

        internal static const SELECTED_CURRENCY_INVALID:String="currencyInv";

        public var submitBtn:net.wg.gui.components.controls.SoundButtonEx;

        public var cancelBtn:net.wg.gui.components.controls.SoundButtonEx;

        public var resultGold:net.wg.gui.components.controls.IconText;

        public var resultCredits:net.wg.gui.components.controls.IconText;

        public var countLabel:flash.text.TextField;

        public var priceLabel:flash.text.TextField;

        public var moduleIcon:net.wg.gui.components.advanced.ExtraModuleIcon;

        public var moduleName:flash.text.TextField;

        public var description:flash.text.TextField;

        public var nsCount:net.wg.gui.components.controls.NumericStepper;

        public var total:net.wg.gui.components.controls.IconText;

        public var price:net.wg.gui.components.controls.IconText;

        public var totalLabel:flash.text.TextField;

        public var resultLabel:flash.text.TextField;

        internal var dataInitialized:Boolean;

        internal var currency:String;

        internal var settings:net.wg.gui.lobby.confirmModuleWindow.ConfirmModuleSettingsVO;

        internal var moduleInfo:net.wg.gui.lobby.confirmModuleWindow.ModuleInfoVo;

        public var dropdownMenu:net.wg.gui.components.controls.DropdownMenu;

        internal var selectedCount:Number=0;
    }
}
