package net.wg.gui.lobby.confirmModuleWindow
{
    import net.wg.infrastructure.base.meta.impl.ConfirmModuleWindowMeta;
    import net.wg.infrastructure.base.meta.IConfirmModuleWindowMeta;
    import net.wg.data.VO.ItemDialogSettingsVO;
    import net.wg.infrastructure.interfaces.IWindow;
    import net.wg.utils.ILocale;
    import net.wg.gui.components.controls.VO.ActionPriceVO;
    import scaleform.clik.data.DataProvider;
    import net.wg.data.constants.Currencies;
    import scaleform.clik.events.ListEvent;
    import net.wg.gui.components.controls.ActionPrice;
    import scaleform.clik.events.IndexEvent;
    import scaleform.clik.events.ButtonEvent;
    
    public class ConfirmModuleWindow extends ConfirmModuleWindowMeta implements IConfirmModuleWindowMeta
    {
        
        public function ConfirmModuleWindow() {
            super();
            isModal = true;
            isCentered = true;
            canDrag = false;
            showWindowBg = false;
        }
        
        private static var NORMAL_COLOR:uint = 6447189;
        
        private static var ACTION_COLOR:uint = 16777215;
        
        private static var DATA_INVALID:String = "dataInv";
        
        private static var RESULT_INVALID:String = "resultInv";
        
        private static var SELECTED_CURRENCY_INVALID:String = "currencyInv";
        
        private static var SETTINGS_INVALID:String = "settingsInv";
        
        private var moduleInfo:ModuleInfoVo;
        
        private var settings:ItemDialogSettingsVO;
        
        private var currency:String;
        
        private var selectedCount:Number = 0;
        
        override public function setWindow(param1:IWindow) : void {
            super.setWindow(param1);
            if(param1)
            {
                invalidate(SETTINGS_INVALID);
            }
        }
        
        public function as_setData(param1:Object) : void {
            this.moduleInfo = new ModuleInfoVo(param1);
            invalidate(DATA_INVALID);
        }
        
        public function as_setSettings(param1:Object) : void {
            this.settings = new ItemDialogSettingsVO(param1);
            invalidate(SETTINGS_INVALID);
        }
        
        override protected function setLabels() : void {
            var _loc1_:ILocale = App.utils.locale;
            content.countLabel.text = _loc1_.makeString(DIALOGS.CONFIRMMODULEDIALOG_COUNTLABEL);
            content.leftLabel.text = _loc1_.makeString(DIALOGS.CONFIRMMODULEDIALOG_PRICELABEL);
            content.rightLabel.text = _loc1_.makeString(DIALOGS.CONFIRMMODULEDIALOG_TOTALLABEL);
            content.resultLabel.text = _loc1_.makeString(DIALOGS.CONFIRMMODULEDIALOG_TOTALLABEL);
        }
        
        override protected function draw() : void {
            var _loc1_:ILocale = null;
            var _loc2_:uint = 0;
            var _loc3_:uint = 0;
            var _loc4_:* = 0;
            var _loc5_:uint = 0;
            var _loc6_:* = NaN;
            var _loc7_:ILocale = null;
            var _loc8_:* = NaN;
            var _loc9_:* = NaN;
            var _loc10_:String = null;
            var _loc11_:String = null;
            var _loc12_:String = null;
            var _loc13_:ActionPriceVO = null;
            super.draw();
            if(isInvalid(DATA_INVALID))
            {
                if(this.moduleInfo)
                {
                    content.moduleIcon.setValues(this.moduleInfo.type,this.moduleInfo.icon);
                    content.moduleIcon.extraIconSource = this.moduleInfo.extraModuleInfo;
                    content.moduleName.text = this.moduleInfo.name;
                    content.description.text = this.moduleInfo.descr;
                    _loc1_ = App.utils.locale;
                    _loc2_ = this.moduleInfo.price[0];
                    _loc3_ = this.moduleInfo.price[1];
                    if(this.moduleInfo.isActionNow)
                    {
                        _loc4_ = content.dropdownMenu.selectedIndex != -1?content.dropdownMenu.selectedIndex:1;
                        content.dropdownMenu.dataProvider = new DataProvider([_loc1_.htmlTextWithIcon(_loc1_.integer(_loc2_),Currencies.CREDITS),_loc1_.htmlTextWithIcon(_loc1_.gold(_loc3_),Currencies.GOLD)]);
                        content.dropdownMenu.addEventListener(ListEvent.INDEX_CHANGE,this.currencyChangedHandler,false,0,true);
                        content.dropdownMenu.selectedIndex = _loc4_;
                        content.leftLabel.textColor = ACTION_COLOR;
                        content.rightLabel.textColor = ACTION_COLOR;
                    }
                    else
                    {
                        if(this.moduleInfo.currency == Currencies.GOLD)
                        {
                            content.leftIT.text = _loc1_.gold(_loc3_);
                        }
                        else
                        {
                            content.leftIT.text = _loc1_.integer(_loc2_);
                        }
                        content.leftLabel.textColor = NORMAL_COLOR;
                        content.rightLabel.textColor = NORMAL_COLOR;
                    }
                    content.dropdownMenu.visible = this.moduleInfo.isActionNow;
                    content.leftIT.visible = !this.moduleInfo.isActionNow;
                    if(this.moduleInfo.defaultValue != -1)
                    {
                        this.selectedCount = this.moduleInfo.defaultValue;
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
                if(this.moduleInfo)
                {
                    if(this.moduleInfo.isActionNow)
                    {
                        if(content.dropdownMenu.selectedIndex == 0)
                        {
                            _loc5_ = this.moduleInfo.maxAvailableCount[0];
                        }
                        else
                        {
                            _loc5_ = this.moduleInfo.maxAvailableCount[1];
                        }
                    }
                    else if(this.moduleInfo.currency == Currencies.GOLD)
                    {
                        _loc5_ = this.moduleInfo.maxAvailableCount[1];
                    }
                    else
                    {
                        _loc5_ = this.moduleInfo.maxAvailableCount[0];
                    }
                    
                    _loc6_ = Math.min(1,_loc5_);
                    content.nsCount.minimum = _loc6_;
                    content.nsCount.maximum = _loc5_;
                    content.nsCount.value = Math.min(this.selectedCount,_loc5_);
                    content.submitBtn.enabled = _loc6_ > 0;
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
                        if(content.dropdownMenu.selectedIndex == 0)
                        {
                            _loc10_ = "0";
                            _loc9_ = content.nsCount.value * this.moduleInfo.price[0];
                            _loc11_ = _loc7_.integer(_loc9_);
                            _loc12_ = _loc11_;
                            this.currency = Currencies.CREDITS;
                        }
                        else
                        {
                            _loc11_ = "0";
                            _loc8_ = content.nsCount.value * this.moduleInfo.price[1];
                            _loc10_ = _loc7_.gold(_loc8_);
                            _loc12_ = _loc10_;
                            this.currency = Currencies.GOLD;
                        }
                    }
                    else
                    {
                        this.currency = this.moduleInfo.currency;
                        if(this.moduleInfo.currency == Currencies.GOLD)
                        {
                            _loc8_ = content.nsCount.value * this.moduleInfo.price[1];
                            _loc10_ = _loc7_.gold(_loc8_);
                            _loc12_ = _loc10_;
                            _loc11_ = "0";
                        }
                        else
                        {
                            _loc9_ = content.nsCount.value * this.moduleInfo.price[0];
                            _loc11_ = _loc7_.integer(_loc9_);
                            _loc12_ = _loc11_;
                            _loc10_ = "0";
                        }
                    }
                    content.leftResultIT.text = _loc10_;
                    content.rightResultIT.text = _loc11_;
                    content.leftIT.icon = this.currency;
                    content.leftIT.textColor = Currencies.TEXT_COLORS[this.currency];
                    content.rightIT.icon = this.currency;
                    content.rightIT.textColor = Currencies.TEXT_COLORS[this.currency];
                    content.rightIT.text = _loc12_;
                    content.actionPrice.textColorType = ActionPrice.TEXT_COLOR_TYPE_ICON;
                    _loc13_ = null;
                    if(this.moduleInfo.actionPriceData)
                    {
                        _loc13_ = new ActionPriceVO(this.moduleInfo.actionPriceData);
                        if(this.currency == Currencies.CREDITS)
                        {
                            _loc13_.newPrices = [_loc9_,_loc13_.newPrices[1]];
                            _loc13_.oldPrices = [_loc13_.oldPrices[0] * content.nsCount.value,_loc13_.oldPrices[1]];
                            _loc13_.forCredits = true;
                        }
                        else
                        {
                            _loc13_.newPrices = [_loc13_.newPrices[0],_loc8_];
                            _loc13_.oldPrices = [_loc13_.oldPrices[0],_loc13_.oldPrices[1] * content.nsCount.value];
                            _loc13_.forCredits = false;
                        }
                    }
                    content.actionPrice.setData(_loc13_);
                    content.rightIT.visible = !content.actionPrice.visible;
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
        
        override protected function onDispose() : void {
            if(content)
            {
                content.dropdownMenu.removeEventListener(ListEvent.INDEX_CHANGE,this.currencyChangedHandler);
            }
            super.onDispose();
        }
        
        override protected function selectedCountChangeHandler(param1:IndexEvent) : void {
            this.selectedCount = content.nsCount.value;
            invalidate(RESULT_INVALID);
        }
        
        override protected function submitBtnClickHandler(param1:ButtonEvent) : void {
            submitS(this.selectedCount,this.currency);
        }
        
        protected function currencyChangedHandler(param1:ListEvent) : void {
            invalidate(SELECTED_CURRENCY_INVALID);
        }
    }
}
