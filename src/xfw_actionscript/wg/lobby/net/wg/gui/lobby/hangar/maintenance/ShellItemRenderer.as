package net.wg.gui.lobby.hangar.maintenance
{
    import net.wg.gui.components.controls.SoundListItemRenderer;
    import net.wg.gui.lobby.components.maintenance.MaintenanceDropDown;
    import flash.text.TextField;
    import net.wg.gui.components.controls.IconText;
    import net.wg.gui.components.controls.DropdownMenu;
    import flash.display.MovieClip;
    import net.wg.gui.components.controls.Slider;
    import net.wg.gui.components.controls.NumericStepper;
    import net.wg.gui.components.controls.UILoaderAlt;
    import net.wg.gui.components.controls.ActionPrice;
    import net.wg.gui.lobby.components.maintenance.data.MaintenanceShellVO;
    import net.wg.infrastructure.managers.ITooltipMgr;
    import net.wg.data.constants.Errors;
    import net.wg.gui.events.ShellRendererEvent;
    import scaleform.clik.constants.InvalidationType;
    import scaleform.clik.events.SliderEvent;
    import flash.events.MouseEvent;
    import scaleform.clik.events.IndexEvent;
    import scaleform.clik.events.ListEvent;
    import net.wg.utils.ILocale;
    import net.wg.gui.components.controls.VO.ActionPriceVO;
    import net.wg.data.constants.Currencies;
    import scaleform.clik.data.DataProvider;
    import net.wg.data.constants.generated.CURRENCIES_CONSTANTS;
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import net.wg.data.constants.IconsTypes;
    import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
    import scaleform.gfx.MouseEventEx;
    import net.wg.gui.events.ModuleInfoEvent;
    import net.wg.data.constants.SoundTypes;
    import flash.text.TextFieldAutoSize;

    public class ShellItemRenderer extends SoundListItemRenderer
    {

        private static const RENDERER_HEIGHT:Number = 57;

        private static const MULTY_CHARS:String = " x ";

        private static const TO_BUY_POS:int = 775;

        private static const DEFAULT_ALPHA:Number = 0.3;

        private static const CHANGED_LABEL_ALPHA:Number = 1;

        private static const BUY_LEFT_PADDING:int = 10;

        private static const EMPTY_STR:String = "";

        private static const MAINTENANCE_SHELL_VO_TYPE:String = "MaintenanceShellVO";

        public var initCounterBgWidth:int = 0;

        public var select:MaintenanceDropDown;

        public var countLabel:TextField;

        public var toBuy:IconText;

        public var price:IconText;

        public var toBuyTf:TextField;

        public var toBuyDropdown:DropdownMenu;

        public var countSliderBg:MovieClip;

        public var countSlider:Slider;

        public var countStepper:NumericStepper;

        public var nameLbl:TextField;

        public var descrLbl:TextField;

        public var icon:UILoaderAlt;

        public var emptyFocusIndicator:MovieClip;

        public var actionPrice:ActionPrice;

        private var _rendererData:MaintenanceShellVO;

        private var _changeableShellsList:Array;

        private var _toolTipMgr:ITooltipMgr;

        public function ShellItemRenderer()
        {
            this._toolTipMgr = App.toolTipMgr;
            super();
            this.select.handleScroll = false;
            soundType = SoundTypes.SHELL_ITEM_RENDERER;
            this.initCounterBgWidth = this.countSliderBg.width;
            this.select.focusIndicator = this.emptyFocusIndicator;
            this.nameLbl.autoSize = TextFieldAutoSize.LEFT;
        }

        override public function setData(param1:Object) : void
        {
            if(param1 != null)
            {
                this._rendererData = param1 as MaintenanceShellVO;
                App.utils.asserter.assertNotNull(this._rendererData,Errors.INVALID_TYPE + MAINTENANCE_SHELL_VO_TYPE);
                this._rendererData.removeEventListener(ShellRendererEvent.USER_COUNT_CHANGED,this.onRendererDataUserCountChangedHandler);
                super.setData(param1);
                this._rendererData.addEventListener(ShellRendererEvent.USER_COUNT_CHANGED,this.onRendererDataUserCountChangedHandler);
            }
            else
            {
                this._rendererData = null;
            }
            invalidate(InvalidationType.DATA);
        }

        override protected function onDispose() : void
        {
            this.countSlider.removeEventListener(SliderEvent.VALUE_CHANGE,this.onCountSliderValueChangeHandler);
            this.countSlider.removeEventListener(MouseEvent.ROLL_OVER,this.onCountSliderRollOverHandler);
            this.countStepper.removeEventListener(IndexEvent.INDEX_CHANGE,this.onCountStepperIndexChangeHandler);
            this.toBuyDropdown.removeEventListener(ListEvent.INDEX_CHANGE,this.onToBuyDropdownIndexChangeHandler);
            this.select.removeEventListener(ListEvent.INDEX_CHANGE,this.onSelectIndexChangeHandler);
            removeEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
            removeEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
            removeEventListener(MouseEvent.CLICK,this.onClickHandler);
            this.select.dispose();
            this.select = null;
            this.countLabel = null;
            this.toBuy.dispose();
            this.toBuy = null;
            this.price.dispose();
            this.price = null;
            this.actionPrice.dispose();
            this.actionPrice = null;
            this.toBuyTf = null;
            this.toBuyDropdown.dispose();
            this.toBuyDropdown = null;
            this.countSliderBg = null;
            this.countSlider.dispose();
            this.countSlider = null;
            this.countStepper.dispose();
            this.countStepper = null;
            this.nameLbl = null;
            this.descrLbl = null;
            this.icon.dispose();
            this.icon = null;
            this.emptyFocusIndicator = null;
            this.clearChangeableShells();
            this._rendererData = null;
            this._toolTipMgr = null;
            super.onDispose();
        }

        override protected function configUI() : void
        {
            super.configUI();
            focusTarget = this.select;
            _focusable = tabEnabled = tabChildren = mouseChildren = true;
            this.countSliderBg.mouseEnabled = this.countSliderBg.mouseChildren = false;
            this.icon.mouseEnabled = this.icon.mouseChildren = false;
            this.nameLbl.mouseEnabled = false;
            this.descrLbl.mouseEnabled = false;
            this.countLabel.mouseEnabled = false;
            this.toBuy.mouseEnabled = this.toBuy.mouseChildren = false;
            this.toBuyTf.mouseEnabled = false;
            this.price.mouseEnabled = this.price.mouseChildren = false;
            this.countSlider.addEventListener(SliderEvent.VALUE_CHANGE,this.onCountSliderValueChangeHandler);
            this.countSlider.addEventListener(MouseEvent.ROLL_OVER,this.onCountSliderRollOverHandler);
            this.countStepper.addEventListener(IndexEvent.INDEX_CHANGE,this.onCountStepperIndexChangeHandler);
            this.toBuyDropdown.addEventListener(ListEvent.INDEX_CHANGE,this.onToBuyDropdownIndexChangeHandler);
            this.select.addEventListener(ListEvent.INDEX_CHANGE,this.onSelectIndexChangeHandler);
            addEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
            addEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
            addEventListener(MouseEvent.CLICK,this.onClickHandler);
        }

        override protected function draw() : void
        {
            var _loc1_:* = false;
            var _loc2_:* = 0;
            var _loc3_:ILocale = null;
            var _loc4_:ActionPriceVO = null;
            super.draw();
            if(isInvalid(InvalidationType.DATA))
            {
                this.toBuyDropdown.visible = false;
                this.toBuyTf.visible = false;
                mouseChildren = true;
                this.icon.mouseEnabled = false;
                this.nameLbl.mouseEnabled = false;
                this.descrLbl.mouseEnabled = false;
                focusable = true;
                if(this._rendererData != null)
                {
                    this.icon.source = this._rendererData.icon;
                    if(this.actionPrice)
                    {
                        this.actionPrice.visible = false;
                    }
                    _loc1_ = Currencies.checkSeveralPrices(this._rendererData.prices);
                    if(_loc1_)
                    {
                        this.toBuyDropdown.visible = _loc1_;
                        this.toBuyTf.visible = _loc1_;
                        this.toBuy.visible = !_loc1_;
                        _loc3_ = App.utils.locale;
                        this.toBuyDropdown.dataProvider = new DataProvider([_loc3_.htmlTextWithIcon(_loc3_.integer(this._rendererData.prices[0]),CURRENCIES_CONSTANTS.CREDITS),_loc3_.htmlTextWithIcon(_loc3_.gold(this._rendererData.prices[1]),CURRENCIES_CONSTANTS.GOLD)]);
                        this.toBuyDropdown.selectedIndex = this._rendererData.currency == CURRENCIES_CONSTANTS.CREDITS?0:1;
                        this.price.icon = this._rendererData.currency;
                        _loc4_ = null;
                        if(this._rendererData.actionPriceData)
                        {
                            _loc4_ = new ActionPriceVO(this._rendererData.actionPriceData);
                            _loc4_.forCredits = this._rendererData.currency == CURRENCIES_CONSTANTS.CREDITS;
                        }
                        this.actionPrice.setData(_loc4_);
                        this.actionPrice.setup(this);
                        this.price.visible = !this.actionPrice.visible;
                    }
                    else
                    {
                        this.toBuyDropdown.visible = false;
                        this.toBuyTf.visible = false;
                        this.toBuy.visible = true;
                    }
                    this.nameLbl.text = this._rendererData.ammoName;
                    this.descrLbl.text = this._rendererData.tableName;
                    this.onRendererDataUserCountChangedHandler();
                    this.clearChangeableShells();
                    _loc2_ = this._rendererData.list.length;
                    this.select.menuRowCount = _loc2_;
                    this.select.dataProvider = new DataProvider(this._rendererData.list);
                    this.select.menuOffset.top = -RENDERER_HEIGHT - ((_loc2_ - 1) * RENDERER_HEIGHT >> 1);
                    this.select.selectedIndex = -1;
                    visible = true;
                    if(this.select.isOpen())
                    {
                        this.select.close();
                        this.select.open();
                    }
                    if(this.select.hitTestPoint(App.stage.mouseX,App.stage.mouseY))
                    {
                        this.onRollOverHandler();
                    }
                }
                else
                {
                    visible = false;
                }
            }
        }

        private function clearChangeableShells() : void
        {
            var _loc1_:* = 0;
            var _loc2_:* = 0;
            if(this._changeableShellsList != null)
            {
                _loc1_ = this._changeableShellsList.length;
                _loc2_ = 0;
                while(_loc2_ < _loc1_)
                {
                    IDisposable(this._changeableShellsList[_loc2_]).dispose();
                    _loc2_++;
                }
                this._changeableShellsList.splice(0,_loc1_);
                this._changeableShellsList = null;
            }
        }

        private function updateShellsPrice() : void
        {
            var _loc1_:int = this._rendererData.buyShellsCount;
            var _loc2_:* = 0;
            var _loc3_:String = EMPTY_STR;
            var _loc4_:ILocale = App.utils.locale;
            var _loc5_:String = this._rendererData.currency;
            if(this.toBuyDropdown.visible)
            {
                _loc2_ = this._rendererData.prices[this.toBuyDropdown.selectedIndex];
            }
            else
            {
                _loc2_ = this._rendererData.prices[Currencies.INDEX_FROM_NAME[_loc5_]];
                _loc3_ = _loc5_ == CURRENCIES_CONSTANTS.CREDITS?_loc4_.integer(_loc2_):_loc4_.gold(_loc2_);
            }
            var _loc6_:Number = _loc2_ * _loc1_;
            this.toBuy.icon = _loc5_;
            this.price.icon = _loc5_;
            this.toBuy.textColor = Currencies.TEXT_COLORS[_loc5_];
            var _loc7_:String = _loc6_ > this._rendererData.userCredits[_loc5_]?CURRENCIES_CONSTANTS.ERROR:_loc5_;
            this.price.textColor = Currencies.TEXT_COLORS[_loc7_];
            this.toBuyTf.text = _loc1_ + MULTY_CHARS;
            this.toBuy.text = _loc1_ + MULTY_CHARS + _loc3_;
            this.price.text = _loc5_ == CURRENCIES_CONSTANTS.CREDITS?_loc4_.integer(_loc6_):_loc4_.gold(_loc6_);
            var _loc8_:ActionPriceVO = null;
            if(this._rendererData.actionPriceData)
            {
                _loc8_ = new ActionPriceVO(this._rendererData.actionPriceData);
                _loc8_.forCredits = _loc5_ == CURRENCIES_CONSTANTS.CREDITS;
                if(_loc8_.forCredits)
                {
                    _loc8_.newPrice = _loc1_ * _loc8_.newPrices[CURRENCIES_CONSTANTS.CREDITS_INDEX];
                    _loc8_.oldPrice = _loc1_ * _loc8_.oldPrices[CURRENCIES_CONSTANTS.CREDITS_INDEX];
                }
                else
                {
                    _loc8_.newPrice = _loc1_ * _loc8_.newPrices[CURRENCIES_CONSTANTS.GOLD_INDEX];
                    _loc8_.oldPrice = _loc1_ * _loc8_.oldPrices[CURRENCIES_CONSTANTS.GOLD_INDEX];
                }
                this.actionPrice.textColorType = _loc6_ > this._rendererData.userCredits[_loc5_]?ActionPrice.TEXT_COLOR_TYPE_ERROR:ActionPrice.TEXT_COLOR_TYPE_ICON;
            }
            this.actionPrice.setData(_loc8_);
            this.price.visible = !this.actionPrice.visible;
            this.toBuy.enabled = this.price.enabled = _loc1_ != 0;
            this.toBuy.mouseEnabled = this.price.mouseEnabled = false;
            this.toBuyTf.alpha = _loc1_ == 0?DEFAULT_ALPHA:CHANGED_LABEL_ALPHA;
            this.toBuy.validateNow();
            this.toBuy.x = TO_BUY_POS - this.toBuy.width + (this.toBuy.textField.textWidth >> 1) + BUY_LEFT_PADDING ^ 0;
            dispatchEvent(new ShellRendererEvent(ShellRendererEvent.TOTAL_PRICE_CHANGED));
        }

        private function onCountSliderValueChangeHandler(param1:SliderEvent) : void
        {
            this._toolTipMgr.hide();
            if(this.countStepper.value != this.countSlider.value)
            {
                this._rendererData.userCount = this.countStepper.value = this.countSlider.value;
            }
        }

        private function onCountStepperIndexChangeHandler(param1:IndexEvent) : void
        {
            if(this.countStepper.value != this.countSlider.value)
            {
                this._rendererData.userCount = this.countSlider.value = this.countStepper.value;
            }
        }

        private function onToBuyDropdownIndexChangeHandler(param1:ListEvent) : void
        {
            this.price.icon = this.toBuyDropdown.selectedIndex == 0?CURRENCIES_CONSTANTS.CREDITS:CURRENCIES_CONSTANTS.GOLD;
            this.actionPrice.ico = this.toBuyDropdown.selectedIndex == 0?IconsTypes.CREDITS:IconsTypes.GOLD;
            var _loc2_:String = this.toBuyDropdown.selectedIndex == 0?CURRENCIES_CONSTANTS.CREDITS:CURRENCIES_CONSTANTS.GOLD;
            if(this._rendererData.currency != _loc2_)
            {
                dispatchEvent(new ShellRendererEvent(ShellRendererEvent.CURRENCY_CHANGED));
            }
            this._rendererData.currency = _loc2_;
            this.onRendererDataUserCountChangedHandler();
        }

        private function onSelectIndexChangeHandler(param1:ListEvent) : void
        {
            if(this.select.selectedIndex == -1 || this._rendererData.id == this._rendererData.list[this.select.selectedIndex].id)
            {
                return;
            }
            dispatchEvent(new ShellRendererEvent(ShellRendererEvent.CHANGE_ORDER,this._rendererData,this._rendererData.list[this.select.selectedIndex]));
        }

        private function onRendererDataUserCountChangedHandler(param1:ShellRendererEvent = null) : void
        {
            this.countStepper.removeEventListener(IndexEvent.INDEX_CHANGE,this.onCountStepperIndexChangeHandler);
            this.countSlider.removeEventListener(SliderEvent.VALUE_CHANGE,this.onCountSliderValueChangeHandler);
            this.countSlider.snapInterval = this.countStepper.stepSize = this._rendererData.step;
            this.countSlider.maximum = this.countStepper.maximum = this._rendererData.maxAmmo;
            this.countStepper.addEventListener(IndexEvent.INDEX_CHANGE,this.onCountStepperIndexChangeHandler);
            this.countSlider.addEventListener(SliderEvent.VALUE_CHANGE,this.onCountSliderValueChangeHandler);
            this.countSlider.value = this.countStepper.value = this._rendererData.userCount;
            this.countSliderBg.width = this.initCounterBgWidth * this._rendererData.possibleMax / this._rendererData.maxAmmo;
            var _loc2_:Number = data.count - this.countSlider.value + data.inventoryCount;
            this.countLabel.text = App.utils.locale.integer(_loc2_ > 0?_loc2_:0);
            this.countLabel.alpha = _loc2_ > 0?CHANGED_LABEL_ALPHA:DEFAULT_ALPHA;
            this.updateShellsPrice();
        }

        private function onRollOverHandler(param1:MouseEvent = null) : void
        {
            this._toolTipMgr.showSpecial(TOOLTIPS_CONSTANTS.TECH_MAIN_SHELL,null,data.id,data.prices,data.inventoryCount,data.count);
        }

        private function onCountSliderRollOverHandler(param1:MouseEvent) : void
        {
            this._toolTipMgr.hide();
        }

        private function onRollOutHandler(param1:MouseEvent) : void
        {
            this._toolTipMgr.hide();
        }

        private function onClickHandler(param1:MouseEvent) : void
        {
            this._toolTipMgr.hide();
            if(param1 is MouseEventEx)
            {
                if(App.utils.commons.isRightButton(param1))
                {
                    dispatchEvent(new ModuleInfoEvent(ModuleInfoEvent.SHOW_INFO,MaintenanceShellVO(data).id));
                }
            }
        }
    }
}
