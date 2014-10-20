package net.wg.gui.lobby.vehicleBuyWindow
{
    import net.wg.infrastructure.base.meta.impl.VehicleBuyWindowMeta;
    import net.wg.infrastructure.base.meta.IVehicleBuyWindowMeta;
    import flash.display.Sprite;
    import flash.display.MovieClip;
    import net.wg.infrastructure.base.interfaces.IWindow;
    import flash.events.Event;
    import scaleform.clik.utils.Padding;
    import flash.display.InteractiveObject;
    import net.wg.utils.ILocale;
    import net.wg.gui.components.windows.Window;
    import scaleform.clik.events.ButtonEvent;
    import net.wg.gui.components.controls.VO.ActionPriceVO;
    import flash.filters.DropShadowFilter;
    import net.wg.infrastructure.constants.WindowViewInvalidationType;
    import net.wg.data.constants.IconsTypes;
    import net.wg.gui.components.controls.IconText;
    import net.wg.data.constants.Currencies;
    import scaleform.clik.data.DataProvider;
    import scaleform.clik.events.ListEvent;
    import scaleform.clik.utils.Constraints;
    
    public class VehicleBuyWindow extends VehicleBuyWindowMeta implements IVehicleBuyWindowMeta
    {
        
        public function VehicleBuyWindow()
        {
            super();
            isModal = true;
            isCentered = true;
            canDrag = false;
            showWindowBgForm = false;
        }
        
        private static var goldColor:uint;
        
        private static var creditsColor:uint;
        
        public static var WARNING_HEIGHT:int = 85;
        
        public static var UPDATE_STAGE_INVALID:String = "updateStage";
        
        private static var DD_MARGIN:Number = 5;
        
        public var footerMc:FooterMc;
        
        public var bodyMc:BodyMc;
        
        public var headerMc:HeaderMc;
        
        public var backgroundMc:Sprite;
        
        public var bodyMaskMc:MovieClip;
        
        private var animManager:VehicleBuyWindowAnimManager;
        
        private var _expand:Boolean = true;
        
        private var expandImmediate:Boolean;
        
        private var isExpandedValueChanged:Boolean;
        
        private var userTotalGold:Number;
        
        private var userTotalCredits:Number;
        
        private var initInfo:BuyingVehicleVO;
        
        private var windowBackgroundSizeInitialized:Boolean;
        
        private var isInitInfoChanged:Boolean;
        
        private var isTotalResultChanged:Boolean;
        
        private var selectedRentId:int = -1;
        
        override public function setWindow(param1:IWindow) : void
        {
            if(window != param1)
            {
                this.disposeWindowRefHandlers();
                if(param1)
                {
                    if(param1.getConstraints())
                    {
                        param1.getConstraints().addEventListener(Event.RESIZE,this.windowRefResizeHandler);
                    }
                }
            }
            super.setWindow(param1);
            var _loc2_:Padding = window.contentPadding as Padding;
            _loc2_.right = _loc2_.right - 4;
            _loc2_.bottom = _loc2_.bottom - 3;
            window.contentPadding = _loc2_;
        }
        
        public function expand(param1:Boolean, param2:Boolean) : void
        {
            if(this._expand != param1)
            {
                this._expand = param1;
                this.expandImmediate = param2;
                this.isExpandedValueChanged = true;
                invalidate();
            }
            this.footerMc.expandBtn.expanded = param1;
        }
        
        public function as_setGold(param1:Number) : void
        {
            this.userTotalGold = param1;
            this.isTotalResultChanged = true;
            invalidate();
        }
        
        public function as_setCredits(param1:Number) : void
        {
            this.userTotalCredits = param1;
            this.isTotalResultChanged = true;
            invalidate();
        }
        
        public function as_setInitData(param1:Object) : void
        {
            this.expand(param1.expanded,true);
            delete param1.expanded;
            true;
            this.initInfo = new BuyingVehicleVO(param1);
            this.isInitInfoChanged = true;
            invalidate();
        }
        
        public function moveFocusToSubmitButton() : void
        {
            setFocus(this.footerMc.submitBtn);
        }
        
        override protected function onInitModalFocus(param1:InteractiveObject) : void
        {
            super.onInitModalFocus(param1);
            this.moveFocusToSubmitButton();
        }
        
        override protected function onSetModalFocus(param1:InteractiveObject) : void
        {
            super.onSetModalFocus(param1);
        }
        
        override protected function onPopulate() : void
        {
            super.onPopulate();
        }
        
        override protected function configUI() : void
        {
            var _loc1_:ILocale = null;
            super.configUI();
            goldColor = this.footerMc.totalGoldPrice.textColor;
            creditsColor = this.footerMc.totalCreditsPrice.textColor;
            if(App.globalVarsMgr.isKoreaS())
            {
                this.footerMc.showWarning();
                this.backgroundMc.height = this.backgroundMc.height + WARNING_HEIGHT;
                _originalHeight = _originalHeight + WARNING_HEIGHT;
                setActualSize(width,height + WARNING_HEIGHT);
                setActualScale(1,1);
                (window as Window).invalidate();
                (window as Window).validateNow();
            }
            this.animManager = new VehicleBuyWindowAnimManager(this);
            _loc1_ = App.utils.locale;
            this.footerMc.submitBtn.label = _loc1_.makeString(DIALOGS.BUYVEHICLEDIALOG_SUBMITBTN);
            this.footerMc.cancelBtn.label = _loc1_.makeString(DIALOGS.BUYVEHICLEDIALOG_CANCELBTN);
            this.footerMc.expandBtn.addEventListener(ButtonEvent.CLICK,this.expandButtonClickHandler,false,0,true);
            this.footerMc.submitBtn.addEventListener(ButtonEvent.CLICK,this.submitButtonClickHandler,false,0,true);
            this.footerMc.cancelBtn.addEventListener(ButtonEvent.CLICK,this.cancelBtnClickHandler);
            this.moveFocusToSubmitButton();
            this.bodyMc.addEventListener(BodyMc.BUTTONS_GROUP_SELECTION_CHANGED,this.selectedPriceChangeHandler,false,0,true);
            this.bodyMc.ammoCheckbox.addEventListener(Event.SELECT,this.checkBoxSelectHandler,false,0,true);
            this.bodyMc.slotCheckbox.addEventListener(Event.SELECT,this.checkBoxSelectHandler,false,0,true);
            this.bodyMc.crewCheckbox.addEventListener(Event.SELECT,this.crewCheckBoxSelectHandler,false,0,true);
        }
        
        override protected function draw() : void
        {
            var _loc1_:ILocale = null;
            var _loc2_:* = 0;
            var _loc3_:* = 0;
            var _loc4_:Object = null;
            var _loc5_:String = null;
            var _loc6_:ActionPriceVO = null;
            var _loc7_:ActionPriceVO = null;
            var _loc8_:DropShadowFilter = null;
            var _loc9_:* = NaN;
            var _loc10_:* = NaN;
            var _loc11_:* = false;
            super.draw();
            if((window) && (isInvalid(WindowViewInvalidationType.POSITION_INVALID)))
            {
                if(isCentered)
                {
                    window.x = App.appWidth - window.width >> 1;
                    window.y = App.appHeight - window.getBackground().height >> 1;
                }
                else
                {
                    _loc2_ = window.width + window.x;
                    _loc3_ = window.getBackground().height + window.y;
                    if(_loc2_ > App.appWidth)
                    {
                        window.x = window.x - (_loc2_ - App.appWidth);
                    }
                    if(_loc3_ > App.appHeight)
                    {
                        window.y = window.y - (_loc3_ - App.appHeight);
                    }
                }
            }
            _loc1_ = App.utils.locale;
            if(this.isInitInfoChanged)
            {
                this.isInitInfoChanged = false;
                _loc4_ = {"vehiclename":this.initInfo.name};
                window.title = _loc1_.makeString(DIALOGS.BUYVEHICLEDIALOG_TITLE,_loc4_);
                this.headerMc.tankPriceLabel.text = _loc1_.makeString(DIALOGS.BUYVEHICLEDIALOG_PRICELABEL,_loc4_);
                this.headerMc.tankName.text = this.initInfo.longName;
                this.headerMc.tankDescr.text = this.initInfo.description;
                this.headerMc.icon.tankType = this.initInfo.type;
                this.headerMc.icon.iconLoader.source = this.initInfo.icon;
                this.headerMc.icon.nation = this.initInfo.nation;
                this.headerMc.icon.level = this.initInfo.level;
                this.updateVehiclePrice();
                this.headerMc.icon.isElite = this.initInfo.isElite;
                this.headerMc.icon.isPremium = this.initInfo.isPremium;
                _loc5_ = "<b>" + _loc1_.makeString(DIALOGS.BUYVEHICLEDIALOG_TANKMEN) + " " + this.initInfo.tankmenCount + "</b>";
                this.bodyMc.tankmenLabel.htmlText = _loc1_.makeString(DIALOGS.BUYVEHICLEDIALOG_TANKMENLABEL,{"count":_loc5_});
                this.bodyMc.scoolBtn.updatePrice(this.initInfo.studyPriceCredits,IconsTypes.CREDITS,this.initInfo.studyPriceCreditsActionDataVo);
                this.bodyMc.academyBtn.updatePrice(this.initInfo.studyPriceGold,IconsTypes.GOLD,this.initInfo.studyPriceGoldActionDataVo);
                this.bodyMc.freeBtn.updatePrice(0,"");
                this.bodyMc.scoolBtn.data = this.initInfo.studyPriceCredits;
                this.bodyMc.academyBtn.data = this.initInfo.studyPriceGold;
                this.bodyMc.freeBtn.data = 0;
                _loc6_ = this.initInfo.ammoActionPriceDataVo;
                this.bodyMc.ammoActionPrice.setData(_loc6_);
                this.bodyMc.ammoPrice.text = _loc1_.integer(this.initInfo.ammoPrice);
                this.bodyMc.ammoPrice.visible = !this.bodyMc.ammoActionPrice.visible;
                this.bodyMc.slotPrice.text = _loc1_.integer(this.initInfo.slotPrice);
                _loc7_ = this.initInfo.slotActionPriceDataVo;
                this.bodyMc.slotActionPrice.setData(_loc7_);
                this.bodyMc.slotPrice.visible = !this.bodyMc.slotActionPrice.visible;
                this.bodyMc.scoolBtn.nation = this.bodyMc.academyBtn.nation = this.bodyMc.freeBtn.nation = this.initInfo.nation;
                this.isTotalResultChanged = true;
                _loc8_ = this.headerMc.tankPriceLabel.filters[0];
                this.bodyMc.crewCheckbox.textField.filters = [_loc8_.clone()];
                this.bodyMc.ammoCheckbox.textField.filters = [_loc8_.clone()];
                this.bodyMc.slotCheckbox.textField.filters = [_loc8_.clone()];
                this.updateRentItems();
            }
            if((this.isExpandedValueChanged) && (this.windowBackgroundSizeInitialized))
            {
                this.isExpandedValueChanged = false;
                this.animManager.launch(this._expand,this.expandImmediate);
            }
            if(this.isTotalResultChanged)
            {
                this.isTotalResultChanged = false;
                _loc9_ = 0;
                _loc10_ = 0;
                _loc9_ = _loc9_ + (this.bodyMc.slotCheckbox.selected?this.initInfo.slotPrice:0);
                _loc10_ = _loc10_ + (this.bodyMc.ammoCheckbox.selected?this.initInfo.ammoPrice:0);
                if(this.initInfo.vehiclePrice.isGold)
                {
                    _loc9_ = _loc9_ + this.initInfo.vehiclePrice.price;
                }
                else
                {
                    _loc10_ = _loc10_ + this.initInfo.vehiclePrice.price;
                }
                if(!this.bodyMc.crewCheckbox.selected)
                {
                    if(this.bodyMc.isGoldPriceSelected)
                    {
                        _loc9_ = _loc9_ + this.bodyMc.selectedPrice;
                    }
                    else
                    {
                        _loc10_ = _loc10_ + this.bodyMc.selectedPrice;
                    }
                }
                this.footerMc.totalGoldPrice.text = _loc1_.gold(_loc9_);
                _loc10_ = isNaN(_loc10_)?0:_loc10_;
                this.footerMc.totalCreditsPrice.text = _loc1_.integer(_loc10_);
                _loc11_ = true;
                if(_loc9_ > this.userTotalGold)
                {
                    this.footerMc.totalGoldPrice.textColor = IconText.ERROR_COLOR;
                    _loc11_ = false;
                }
                else
                {
                    this.footerMc.totalGoldPrice.textColor = goldColor;
                }
                if(_loc10_ > this.userTotalCredits)
                {
                    this.footerMc.totalCreditsPrice.textColor = IconText.ERROR_COLOR;
                    _loc11_ = false;
                }
                else
                {
                    this.footerMc.totalCreditsPrice.textColor = creditsColor;
                }
                this.footerMc.submitBtn.enabled = _loc11_;
            }
        }
        
        private function updateVehiclePrice() : void
        {
            var _loc1_:ILocale = App.utils.locale;
            var _loc2_:ActionPriceVO = this.initInfo.actualActionPriceDataVo;
            this.headerMc.tankActionPrice.setData(_loc2_);
            this.headerMc.tankPrice.visible = !this.headerMc.tankActionPrice.visible;
            this.headerMc.tankPrice.icon = this.initInfo.vehiclePrice.isGold?Currencies.GOLD:Currencies.CREDITS;
            this.headerMc.tankPrice.textColor = this.initInfo.vehiclePrice.isGold?goldColor:creditsColor;
            this.headerMc.tankPrice.text = _loc1_.integer(this.initInfo.vehiclePrice.price);
        }
        
        private function updateRentItems() : void
        {
            var _loc1_:ILocale = null;
            this.headerMc.rentDD.visible = this.initInfo.isRentable;
            if(this.initInfo.isRentable)
            {
                this.headerMc.rentDD.dataProvider = new DataProvider(this.initInfo.rentDataProviderDD);
                this.headerMc.rentDD.x = this.headerMc.tankPriceLabel.x + this.headerMc.tankPriceLabel.textWidth + DD_MARGIN ^ 0;
                if(!this.headerMc.rentDD.hasEventListener(ListEvent.INDEX_CHANGE))
                {
                    this.headerMc.rentDD.addEventListener(ListEvent.INDEX_CHANGE,this.onRentChange);
                    this.headerMc.rentDD.selectedIndex = this.initInfo.defSelectedRentIndex;
                }
                if(this.initInfo.isNoAmmo)
                {
                    _loc1_ = App.utils.locale;
                    this.bodyMc.ammoActionPrice.setData(this.initInfo.ammoActionPriceDataVo);
                    this.bodyMc.ammoPrice.text = _loc1_.integer(this.initInfo.ammoPrice);
                    this.bodyMc.ammoPrice.visible = !this.bodyMc.ammoActionPrice.visible;
                    this.bodyMc.ammoCheckbox.selected = false;
                }
                else
                {
                    this.bodyMc.ammoPrice.visible = this.bodyMc.ammoActionPrice.visible = this.initInfo.isNoAmmo;
                }
                this.bodyMc.ammoCheckbox.visible = this.initInfo.isNoAmmo;
                if(this.initInfo.isStudyDisabled)
                {
                    this.bodyMc.crewCheckbox.selected = false;
                }
                this.bodyMc.btnGroupEnabled = !this.initInfo.isStudyDisabled;
                this.bodyMc.crewCheckbox.visible = !this.initInfo.isStudyDisabled;
                this.bodyMc.crewInVehicle.visible = this.initInfo.isStudyDisabled;
            }
            else
            {
                this.bodyMc.freeRentSlot.visible = this.bodyMc.crewInVehicle.visible = false;
            }
        }
        
        private function onRentChange(param1:ListEvent) : void
        {
            var _loc3_:ActionPriceVO = null;
            var _loc2_:VehicleBuyRentItemVO = VehicleBuyRentItemVO(param1.itemData.data);
            this.selectedRentId = _loc2_.itemId;
            if(_loc2_.itemId == VehicleBuyRentItemVO.DEF_ITEM_ID)
            {
                this.bodyMc.slotCheckbox.visible = true;
                _loc3_ = this.initInfo.slotActionPriceDataVo;
                this.bodyMc.slotActionPrice.setData(_loc3_);
                this.bodyMc.slotPrice.visible = !this.bodyMc.slotActionPrice.visible;
                this.bodyMc.freeRentSlot.visible = false;
            }
            else
            {
                this.bodyMc.slotCheckbox.selected = false;
                this.bodyMc.slotCheckbox.visible = false;
                this.bodyMc.slotActionPrice.visible = false;
                this.bodyMc.slotPrice.visible = false;
                this.bodyMc.freeRentSlot.visible = true;
            }
            this.initInfo.actualActionPriceDataVo = _loc2_.actionPriceDataVo;
            this.initInfo.vehiclePrice = _loc2_.price;
            this.updateVehiclePrice();
            this.isTotalResultChanged = true;
            invalidate();
        }
        
        override protected function onDispose() : void
        {
            super.onDispose();
            if(this.animManager)
            {
                this.animManager.dispose();
                this.animManager = null;
            }
            if(this.headerMc)
            {
                this.headerMc.rentDD.removeEventListener(ListEvent.INDEX_CHANGE,this.onRentChange);
                this.headerMc.dispose();
            }
            if(this.footerMc)
            {
                this.footerMc.expandBtn.removeEventListener(ButtonEvent.CLICK,this.expandButtonClickHandler);
                this.footerMc.submitBtn.removeEventListener(ButtonEvent.CLICK,this.submitButtonClickHandler);
                this.footerMc.cancelBtn.removeEventListener(ButtonEvent.CLICK,this.cancelBtnClickHandler);
            }
            if(this.bodyMc)
            {
                this.bodyMc.removeEventListener(BodyMc.BUTTONS_GROUP_SELECTION_CHANGED,this.selectedPriceChangeHandler);
                this.bodyMc.ammoCheckbox.removeEventListener(Event.SELECT,this.checkBoxSelectHandler);
                this.bodyMc.slotCheckbox.removeEventListener(Event.SELECT,this.checkBoxSelectHandler);
                this.bodyMc.crewCheckbox.removeEventListener(Event.SELECT,this.crewCheckBoxSelectHandler);
                this.bodyMc.dispose();
            }
            this.disposeWindowRefHandlers();
        }
        
        private function disposeWindowRefHandlers() : void
        {
            var _loc1_:Constraints = null;
            if(window)
            {
                _loc1_ = window.getConstraints();
                if(_loc1_)
                {
                    window.removeEventListener(Event.RESIZE,this.windowRefResizeHandler);
                }
            }
        }
        
        private function cancelBtnClickHandler(param1:ButtonEvent) : void
        {
            onWindowCloseS();
        }
        
        private function crewCheckBoxSelectHandler(param1:Event) : void
        {
            this.bodyMc.lastItemSelected = !this.bodyMc.crewCheckbox.selected;
            this.isTotalResultChanged = true;
            invalidate();
        }
        
        private function checkBoxSelectHandler(param1:Event) : void
        {
            this.isTotalResultChanged = true;
            invalidate();
        }
        
        private function selectedPriceChangeHandler(param1:Event) : void
        {
            this.bodyMc.crewCheckbox.selected = false;
            this.isTotalResultChanged = true;
            invalidate();
        }
        
        private function submitButtonClickHandler(param1:ButtonEvent) : void
        {
            var _loc2_:Object = {"buySlot":this.bodyMc.slotCheckbox.selected,
            "buyAmmo":this.bodyMc.ammoCheckbox.selected,
            "isHasBeenExpanded":this._expand,
            "crewType":this.bodyMc.crewType,
            "rentId":this.selectedRentId
        };
        submitS(_loc2_);
    }
    
    private function expandButtonClickHandler(param1:Event) : void
    {
        this.expand(!this._expand,false);
    }
    
    private function windowRefResizeHandler(param1:Event) : void
    {
        this.windowBackgroundSizeInitialized = true;
        invalidate(WindowViewInvalidationType.POSITION_INVALID);
    }
}
}
