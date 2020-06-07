package net.wg.gui.lobby.hangar.maintenance
{
    import net.wg.infrastructure.base.meta.impl.TechnicalMaintenanceMeta;
    import net.wg.infrastructure.base.meta.ITechnicalMaintenanceMeta;
    import flash.text.TextField;
    import net.wg.gui.components.controls.CheckBox;
    import net.wg.gui.components.controls.IconText;
    import net.wg.gui.components.controls.SoundButtonEx;
    import net.wg.gui.components.controls.DynamicScrollingListEx;
    import net.wg.gui.components.controls.AlertIco;
    import scaleform.clik.controls.ButtonGroup;
    import net.wg.gui.lobby.components.maintenance.data.MaintenanceVO;
    import net.wg.infrastructure.managers.ITooltipMgr;
    import net.wg.gui.events.ShellRendererEvent;
    import scaleform.clik.events.ButtonEvent;
    import flash.text.TextFieldAutoSize;
    import scaleform.clik.constants.InvalidationType;
    import net.wg.data.constants.Values;
    import scaleform.clik.utils.Padding;
    import net.wg.data.constants.Errors;
    import net.wg.gui.events.ModuleInfoEvent;
    import net.wg.gui.events.EquipmentEvent;
    import net.wg.gui.lobby.components.maintenance.events.OnEquipmentRendererOver;
    import flash.events.Event;
    import flash.events.MouseEvent;
    import net.wg.data.constants.generated.CURRENCIES_CONSTANTS;
    import net.wg.data.constants.Currencies;
    import net.wg.gui.lobby.components.maintenance.data.MaintenanceShellVO;
    import scaleform.clik.data.DataProvider;
    import net.wg.gui.lobby.components.maintenance.data.ModuleVO;
    import net.wg.utils.ILocale;
    import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;

    public class TechnicalMaintenance extends TechnicalMaintenanceMeta implements ITechnicalMaintenanceMeta
    {

        private static const PERCENT_CHAR:String = "%";

        private static const SPLITTER_CHAR:String = "/";

        private static const MONEY:String = "money";

        protected static const EQUIPMENT:String = "equipment";

        private static const EQUIPMENT_CHANGED:String = "equipmentChanged";

        private static const PADDING_STR:String = "Padding";

        private static const SLOT_STR:String = "Slot";

        private static const BUTTON_GROUP_NAME:String = "buttonGroup";

        private static const ITEM_CHANGE_FROM:String = "itemChangeFrom";

        private static const ITEM_CHANGE_TO:String = "itemChangeTo";

        private static const EQUIPMENT_ITEM:String = "equipmentItem";

        private static const EMPTY_STR:String = "";

        private static const SHELLS_LIST_ROW_HEIGHT:int = 47;

        private static const SHELLS_LIST_GAP:int = 6;

        public var repairTextfield:TextField;

        public var repairIndicator:MaintenanceStatusIndicator;

        public var repairAuto:CheckBox;

        public var repairPrice:IconText;

        public var repairBtn:SoundButtonEx;

        public var shellsTextfield:TextField;

        public var casseteField:TextField;

        public var shellsIndicator:MaintenanceStatusIndicator;

        public var shellsAuto:CheckBox;

        public var shellsHeaderInventory:TextField;

        public var shellsHeaderBuy:TextField;

        public var shellsHeaderPrice:TextField;

        public var shellsTotalGold:IconText;

        public var shellsTotalCredits:IconText;

        public var shells:DynamicScrollingListEx;

        public var eqTextfield:TextField;

        public var eqIndicator:MaintenanceStatusIndicator;

        public var eqAuto:CheckBox;

        public var eqHeaderInventory:TextField;

        public var eqHeaderBuy:TextField;

        public var eqHeaderPrice:TextField;

        public var eqTotalGold:IconText;

        public var eqTotalCredits:IconText;

        public var eqItem1:EquipmentItem;

        public var eqItem2:EquipmentItem;

        public var eqItem3:EquipmentItem;

        public var applyBtn:SoundButtonEx;

        public var closeBtn:SoundButtonEx;

        public var totalCredits:IconText;

        public var totalGold:IconText;

        public var labelTotal:TextField;

        public var infoTF:TextField;

        public var infoAlertIcon:AlertIco;

        protected var btnGroup:ButtonGroup;

        private var _maintenanceData:MaintenanceVO;

        private var _totalPrice:Prices;

        private var _shellsCountChanged:Boolean = false;

        private var _shellsOrderChanged:Boolean = false;

        private var _equipmentList:Array;

        private var _equipmentSetup:Array;

        private var _equipmentInstalled:Array;

        private var _eqOrderChanged:Boolean = false;

        private var _prevVehicleId:String = "";

        private var _prevGunIntCD:Number = -1;

        private var _isApplyEnable:Boolean = false;

        private var _toolTipMgr:ITooltipMgr;

        public function TechnicalMaintenance()
        {
            this._toolTipMgr = App.toolTipMgr;
            super();
        }

        override protected function configUI() : void
        {
            super.configUI();
            this._isApplyEnable = false;
            this.btnGroup = new ButtonGroup(BUTTON_GROUP_NAME,this);
            this.repairTextfield.text = MENU.HANGAR_AMMUNITIONPANEL_TECHNICALMAITENANCE_REPAIR_LABEL;
            this.shellsTextfield.text = MENU.HANGAR_AMMUNITIONPANEL_TECHNICALMAITENANCE_AMMO_LABEL;
            this.shellsHeaderBuy.text = MENU.HANGAR_AMMUNITIONPANEL_TECHNICALMAITENANCE_AMMO_LIST_BUY;
            this.shellsHeaderInventory.text = MENU.HANGAR_AMMUNITIONPANEL_TECHNICALMAITENANCE_AMMO_LIST_INVENTORY;
            this.shellsHeaderPrice.text = MENU.HANGAR_AMMUNITIONPANEL_TECHNICALMAITENANCE_AMMO_LIST_PRICE;
            this.eqTextfield.text = MENU.HANGAR_AMMUNITIONPANEL_TECHNICALMAITENANCE_EQUIPMENT_LABEL;
            this.eqHeaderBuy.text = MENU.HANGAR_AMMUNITIONPANEL_TECHNICALMAITENANCE_EQUIPMENT_LIST_BUY;
            this.eqHeaderInventory.text = MENU.HANGAR_AMMUNITIONPANEL_TECHNICALMAITENANCE_EQUIPMENT_LIST_INVENTORY;
            this.eqHeaderPrice.text = MENU.HANGAR_AMMUNITIONPANEL_TECHNICALMAITENANCE_EQUIPMENT_LIST_PRICE;
            this.labelTotal.text = MENU.HANGAR_AMMUNITIONPANEL_TECHNICALMAITENANCE_BUTTONS_LABELTOTAL;
            this.shells.addEventListener(ShellRendererEvent.TOTAL_PRICE_CHANGED,this.onShellsTotalPriceChangedHandler);
            this.shells.addEventListener(ShellRendererEvent.CURRENCY_CHANGED,this.onShellsCurrencyChangedHandler);
            this.autoChBListeners();
            this.subscribeModules();
            this.repairBtn.addEventListener(ButtonEvent.CLICK,this.onRepairBtnClickHandler);
            this.applyBtn.addEventListener(ButtonEvent.CLICK,this.onApplyBtnClickHandler);
            this.closeBtn.addEventListener(ButtonEvent.CLICK,this.onCloseBtnClickHandler);
            this.infoTF.autoSize = TextFieldAutoSize.LEFT;
            this.infoAlertIcon.enabled = false;
        }

        override protected function draw() : void
        {
            super.draw();
            if(this._maintenanceData && isInvalid(InvalidationType.DATA))
            {
                this.updateRepairBlock();
                this.updateShellsBlock();
                this.updateTotalPrice();
                this.infoTF.htmlText = this._maintenanceData.infoAfterShellBlock;
                this.infoAlertIcon.visible = this.infoTF.visible = this._maintenanceData.infoAfterShellBlock != Values.EMPTY_STR;
                this.eqIndicator.visible = this.eqAuto.visible = this._maintenanceData.autoEquipVisible;
            }
            if(isInvalid(MONEY))
            {
                this.updateRepairBlock();
                this.updateShellsBlock();
            }
            if(isInvalid(EQUIPMENT))
            {
                this.updateEquipmentBlock(this._equipmentInstalled,this._equipmentSetup,this._equipmentList);
            }
            if(isInvalid(ShellRendererEvent.TOTAL_PRICE_CHANGED,MONEY,EQUIPMENT))
            {
                this.updateTotalPrice();
            }
            if(invalidate(EQUIPMENT_CHANGED))
            {
                this.requestEquipment();
            }
        }

        override protected function onPopulate() : void
        {
            super.onPopulate();
            window.title = MENU.HANGAR_AMMUNITIONPANEL_TECHNICALMAITENANCE_TITLE;
            window.useBottomBtns = true;
            var _loc1_:Padding = window.contentPadding as Padding;
            App.utils.asserter.assertNotNull(_loc1_,PADDING_STR + Errors.CANT_NULL);
            _loc1_.top = _loc1_.top + 1;
            window.contentPadding = _loc1_;
            _loc1_ = window.formBgPadding;
            _loc1_.top = _loc1_.top + 585;
            _loc1_.right = _loc1_.right + 1;
            window.formBgPadding = _loc1_;
            App.stage.addEventListener(ModuleInfoEvent.SHOW_INFO,this.onStageShowInfoHandler);
            App.stage.addEventListener(ShellRendererEvent.CHANGE_ORDER,this.onStageChangeOrderHandler);
        }

        override protected function onDispose() : void
        {
            this.subscribeModules(false);
            this.repairTextfield = null;
            this.repairIndicator.dispose();
            this.repairIndicator = null;
            this.repairPrice.dispose();
            this.repairPrice = null;
            this.shellsTextfield = null;
            this.casseteField = null;
            this.shellsIndicator.dispose();
            this.shellsIndicator = null;
            this.shellsHeaderInventory = null;
            this.shellsHeaderBuy = null;
            this.shellsHeaderPrice = null;
            this.shellsTotalGold.dispose();
            this.shellsTotalGold = null;
            this.shellsTotalCredits.dispose();
            this.shellsTotalCredits = null;
            this.eqTextfield = null;
            this.eqIndicator.dispose();
            this.eqIndicator = null;
            this.eqHeaderInventory = null;
            this.eqHeaderBuy = null;
            this.eqHeaderPrice = null;
            this.eqTotalGold.dispose();
            this.eqTotalGold = null;
            this.eqTotalCredits.dispose();
            this.eqTotalCredits = null;
            this.totalCredits.dispose();
            this.totalCredits = null;
            this.totalGold.dispose();
            this.totalGold = null;
            this.labelTotal = null;
            this.infoTF = null;
            this.infoAlertIcon.dispose();
            this.infoAlertIcon = null;
            this.eqItem1.dispose();
            this.eqItem1 = null;
            this.eqItem2.dispose();
            this.eqItem2 = null;
            this.eqItem3.dispose();
            this.eqItem3 = null;
            this._maintenanceData = null;
            App.stage.removeEventListener(ModuleInfoEvent.SHOW_INFO,this.onStageShowInfoHandler);
            App.stage.removeEventListener(ShellRendererEvent.CHANGE_ORDER,this.onStageChangeOrderHandler);
            this.shells.removeEventListener(ShellRendererEvent.TOTAL_PRICE_CHANGED,this.onShellsTotalPriceChangedHandler);
            this.shells.removeEventListener(ShellRendererEvent.CURRENCY_CHANGED,this.onShellsCurrencyChangedHandler);
            this.repairBtn.removeEventListener(ButtonEvent.CLICK,this.onRepairBtnClickHandler);
            this.applyBtn.removeEventListener(ButtonEvent.CLICK,this.onApplyBtnClickHandler);
            this.closeBtn.removeEventListener(ButtonEvent.CLICK,this.onCloseBtnClickHandler);
            if(this.btnGroup != null)
            {
                this.btnGroup.dispose();
                this.btnGroup = null;
            }
            this._equipmentList = null;
            this._equipmentSetup = null;
            this._equipmentInstalled = null;
            this._totalPrice = null;
            this.autoChBListeners(false);
            this.repairAuto.dispose();
            this.repairAuto = null;
            this.shellsAuto.dispose();
            this.shellsAuto = null;
            this.eqAuto.dispose();
            this.eqAuto = null;
            this.shells.dispose();
            this.shells = null;
            this.repairBtn.dispose();
            this.repairBtn = null;
            this.applyBtn.dispose();
            this.applyBtn = null;
            this.closeBtn.dispose();
            this.closeBtn = null;
            this._toolTipMgr = null;
            super.onDispose();
        }

        public function as_resetEquipment(param1:String) : void
        {
            var _loc3_:EquipmentItem = null;
            var _loc2_:Vector.<EquipmentItem> = new <EquipmentItem>[this.eqItem1,this.eqItem2,this.eqItem3];
            for each(_loc3_ in _loc2_)
            {
                if(_loc3_.getItemId() == param1)
                {
                    _loc3_.setEmptyItem();
                    break;
                }
            }
        }

        public function as_setCredits(param1:Number) : void
        {
            if(this._maintenanceData)
            {
                this._maintenanceData.credits = param1;
                invalidate(MONEY,EQUIPMENT);
            }
        }

        override protected function setData(param1:MaintenanceVO) : void
        {
            this.updateOldData();
            this._maintenanceData = param1;
            invalidateData();
        }

        override protected function setEquipment(param1:Array, param2:Array, param3:Array) : void
        {
            this._equipmentList = param3;
            this._equipmentSetup = param2;
            this._equipmentInstalled = param1;
            invalidate(EQUIPMENT);
        }

        public function as_setGold(param1:Number) : void
        {
            if(this._maintenanceData)
            {
                this._maintenanceData.gold = param1;
                invalidate(MONEY,EQUIPMENT);
            }
        }

        public function isResetWindow() : Boolean
        {
            return this._prevVehicleId != this._maintenanceData.vehicleId || this._prevGunIntCD != this._maintenanceData.gunIntCD;
        }

        private function subscribeModules(param1:Boolean = true) : void
        {
            var _loc3_:EquipmentItem = null;
            var _loc2_:Array = [this.eqItem1,this.eqItem2,this.eqItem3];
            for each(_loc3_ in _loc2_)
            {
                if(param1)
                {
                    this.btnGroup.addButton(_loc3_);
                    _loc3_.addEventListener(EquipmentEvent.NEED_UPDATE,this.onModuleNeedUpdateHandler);
                    _loc3_.addEventListener(EquipmentEvent.EQUIPMENT_CHANGE,this.onModuleEquipmentChangeHandler);
                    _loc3_.addEventListener(EquipmentEvent.TOTAL_PRICE_CHANGED,this.onModuleTotalPriceChangedHandler);
                    _loc3_.addEventListener(OnEquipmentRendererOver.ON_EQUIPMENT_RENDERER_OVER,this.onModuleOnEquipmentRendererOverHandler);
                }
                else
                {
                    this.btnGroup.removeButton(_loc3_);
                    _loc3_.removeEventListener(EquipmentEvent.NEED_UPDATE,this.onModuleNeedUpdateHandler);
                    _loc3_.removeEventListener(EquipmentEvent.EQUIPMENT_CHANGE,this.onModuleEquipmentChangeHandler);
                    _loc3_.removeEventListener(EquipmentEvent.TOTAL_PRICE_CHANGED,this.onModuleTotalPriceChangedHandler);
                    _loc3_.removeEventListener(OnEquipmentRendererOver.ON_EQUIPMENT_RENDERER_OVER,this.onModuleOnEquipmentRendererOverHandler);
                }
            }
        }

        private function updateOldData() : void
        {
            if(this._maintenanceData)
            {
                this._prevVehicleId = this._maintenanceData.vehicleId;
                this._prevGunIntCD = this._maintenanceData.gunIntCD;
            }
        }

        private function autoChBListeners(param1:Boolean = true) : void
        {
            var _loc3_:CheckBox = null;
            var _loc2_:Array = [this.repairAuto,this.shellsAuto,this.eqAuto];
            for each(_loc3_ in _loc2_)
            {
                if(param1)
                {
                    _loc3_.addEventListener(Event.SELECT,this.onAutoSelectHandler);
                    _loc3_.addEventListener(MouseEvent.ROLL_OVER,this.onAutoRollOverHandler);
                    _loc3_.addEventListener(MouseEvent.ROLL_OUT,this.onAutoRollOutHandler);
                    _loc3_.addEventListener(MouseEvent.CLICK,this.onAutoClickHandler);
                }
                else
                {
                    _loc3_.removeEventListener(Event.SELECT,this.onAutoSelectHandler);
                    _loc3_.removeEventListener(MouseEvent.ROLL_OVER,this.onAutoRollOverHandler);
                    _loc3_.removeEventListener(MouseEvent.ROLL_OUT,this.onAutoRollOutHandler);
                    _loc3_.removeEventListener(MouseEvent.CLICK,this.onAutoClickHandler);
                }
            }
        }

        private function updateRepairBlock() : void
        {
            var _loc2_:* = NaN;
            this.repairAuto.removeEventListener(Event.SELECT,this.onAutoSelectHandler);
            this.repairAuto.selected = this._maintenanceData.autoRepair;
            this.repairAuto.addEventListener(Event.SELECT,this.onAutoSelectHandler);
            var _loc1_:String = this._maintenanceData.repairCost > this._maintenanceData.credits?CURRENCIES_CONSTANTS.ERROR:CURRENCIES_CONSTANTS.CREDITS;
            this.repairPrice.textColor = Currencies.TEXT_COLORS[_loc1_];
            this.repairPrice.text = App.utils.locale.integer(this._maintenanceData.repairCost);
            this.repairIndicator.maximum = this._maintenanceData.maxRepairCost;
            this.repairIndicator.value = this._maintenanceData.maxRepairCost - this._maintenanceData.repairCost;
            if(this._maintenanceData.maxRepairCost != 0)
            {
                _loc2_ = Math.round((this._maintenanceData.maxRepairCost - this._maintenanceData.repairCost) * 100 / this._maintenanceData.maxRepairCost);
                if(_loc2_ < 0)
                {
                    _loc2_ = 0;
                }
                this.repairIndicator.label = _loc2_ + PERCENT_CHAR;
            }
            else
            {
                this.repairIndicator.label = EMPTY_STR;
            }
        }

        private function updateShellsBlock(param1:Boolean = false) : void
        {
            var _loc2_:MaintenanceShellVO = null;
            var _loc4_:MaintenanceShellVO = null;
            var _loc5_:MaintenanceShellVO = null;
            var _loc6_:MaintenanceShellVO = null;
            var _loc7_:Array = null;
            if(this.isResetWindow())
            {
                this._shellsOrderChanged = false;
            }
            else if(!param1)
            {
                _loc7_ = [];
                for each(_loc5_ in this.shells.dataProvider)
                {
                    for each(_loc6_ in this._maintenanceData.shells)
                    {
                        if(_loc5_.id == _loc6_.id)
                        {
                            _loc6_.setUserCount(_loc5_.userCount);
                            _loc6_.possibleMax = _loc5_.possibleMax;
                            _loc6_.currency = _loc5_.currency;
                            _loc7_.push(_loc6_);
                        }
                    }
                }
                for each(_loc6_ in _loc7_)
                {
                    _loc6_.list = _loc7_.slice();
                    _loc6_.list.splice(_loc7_.indexOf(_loc6_),1);
                }
                if(_loc7_.length)
                {
                    this._maintenanceData.shells = _loc7_;
                }
            }
            for each(_loc2_ in this._maintenanceData.shells)
            {
                _loc2_.userCredits = {
                    "credits":this._maintenanceData.credits,
                    "gold":this._maintenanceData.gold
                };
            }
            this.shells.rowHeight = SHELLS_LIST_ROW_HEIGHT;
            this.shells._gap = SHELLS_LIST_GAP;
            if(this.shells.dataProvider != this._maintenanceData.shells)
            {
                if(this.shells.dataProvider)
                {
                    this.shells.dataProvider.cleanUp();
                }
                this.shells.dataProvider = new DataProvider(this._maintenanceData.shells);
            }
            this.shellsAuto.removeEventListener(Event.SELECT,this.onAutoSelectHandler);
            this.shellsAuto.selected = this._maintenanceData.autoShells;
            this.shellsAuto.addEventListener(Event.SELECT,this.onAutoSelectHandler);
            this.casseteField.text = this._maintenanceData.casseteFieldText;
            var _loc3_:* = 0;
            for each(_loc4_ in this._maintenanceData.shells)
            {
                _loc3_ = _loc3_ + _loc4_.count;
            }
            this.shellsIndicator.maximum = this._maintenanceData.maxAmmo;
            this.shellsIndicator.value = this._maintenanceData.maxAmmo - _loc3_;
            this.shellsIndicator.setDivisor(_loc3_,this._maintenanceData.maxAmmo);
            this.shellsIndicator.textField.text = _loc3_ + SPLITTER_CHAR + this._maintenanceData.maxAmmo;
        }

        private function updateEquipmentBlock(param1:Array, param2:Array, param3:Array) : void
        {
            var _loc6_:EquipmentItem = null;
            var _loc8_:Array = null;
            var _loc9_:ModuleVO = null;
            this.eqAuto.removeEventListener(Event.SELECT,this.onAutoSelectHandler);
            this.eqAuto.selected = this._maintenanceData.autoEqip;
            this.eqAuto.addEventListener(Event.SELECT,this.onAutoSelectHandler);
            var _loc4_:* = 0;
            var _loc5_:Array = [this.eqItem1,this.eqItem2,this.eqItem3];
            var _loc7_:int = _loc5_.length;
            var _loc10_:int = param3.length;
            var _loc11_:* = 0;
            var _loc12_:* = 0;
            while(_loc12_ < _loc7_)
            {
                _loc8_ = [];
                _loc6_ = _loc5_[_loc12_] as EquipmentItem;
                App.utils.asserter.assertNotNull(_loc6_,SLOT_STR + Errors.CANT_NULL);
                if(_loc12_ > 0)
                {
                    _loc4_ = 0;
                    while(_loc4_ < _loc10_)
                    {
                        _loc9_ = param3[_loc4_].clone();
                        _loc9_.slotIndex = _loc12_;
                        _loc9_.userCredits = {
                            "credits":this._maintenanceData.credits,
                            "gold":this._maintenanceData.gold
                        };
                        _loc8_.push(_loc9_);
                        _loc4_++;
                    }
                }
                else
                {
                    _loc8_ = param3.slice(0);
                }
                _loc6_.setData(_loc8_,_loc12_,param2,param1.slice());
                if(!this._isApplyEnable && _loc6_.selectedItem)
                {
                    if(_loc6_.selectedItem.inventoryCount > 0 && param1.indexOf(_loc6_.selectedItem.compactDescr) == -1)
                    {
                        this.doApplyEnable();
                    }
                }
                if(param1[_loc12_] != undefined && param1[_loc12_] != 0)
                {
                    _loc11_ = _loc11_ + 1;
                }
                _loc12_++;
            }
            this.eqIndicator.maximum = _loc5_.length;
            this.eqIndicator.value = _loc11_;
            this.eqIndicator.setDivisor(_loc11_,_loc5_.length);
            this.eqIndicator.textField.text = _loc11_ + SPLITTER_CHAR + _loc5_.length;
        }

        private function updateTotalPrice() : void
        {
            var _loc1_:Prices = this.__getAmmoPrice();
            this.updatePriceLabels(this.shellsTotalCredits,this.shellsTotalGold,_loc1_);
            var _loc2_:Prices = this.__getEquipmentsPrice();
            this.updatePriceLabels(this.eqTotalCredits,this.eqTotalGold,_loc2_);
            this._totalPrice = new Prices(_loc1_.credits + _loc2_.credits + this._maintenanceData.repairCost,_loc1_.gold + _loc2_.gold);
            this.updatePriceLabels(this.totalCredits,this.totalGold,this._totalPrice);
            if(this._totalPrice.credits > 0 || this._totalPrice.gold > 0)
            {
                this.doApplyEnable();
            }
            this.updateButtonStates();
        }

        private function updateButtonStates() : void
        {
            var _loc2_:MaintenanceShellVO = null;
            var _loc3_:* = NaN;
            var _loc4_:Array = null;
            var _loc5_:EquipmentItem = null;
            this.repairBtn.enabled = this._maintenanceData.repairCost != 0 && this._maintenanceData.repairCost <= this._maintenanceData.credits;
            var _loc1_:Number = 0;
            this._shellsCountChanged = false;
            for each(_loc2_ in this._maintenanceData.shells)
            {
                _loc1_ = _loc1_ + _loc2_.userCount;
                if(_loc2_.userCount != _loc2_.count)
                {
                    this.doApplyEnable();
                    this._shellsCountChanged = true;
                }
            }
            this.shellsIndicator.maximum = this._maintenanceData.maxAmmo;
            this.shellsIndicator.value = _loc1_;
            this.shellsIndicator.label = _loc1_ + SPLITTER_CHAR + this._maintenanceData.maxAmmo;
            _loc3_ = 0;
            _loc4_ = [this.eqItem1,this.eqItem2,this.eqItem3];
            for each(_loc5_ in _loc4_)
            {
                if(_loc5_.selectedItem)
                {
                    _loc3_ = _loc3_ + 1;
                }
            }
            this.eqIndicator.value = _loc3_;
            this.eqIndicator.label = _loc3_ + SPLITTER_CHAR + 3;
            this.applyBtn.enabled = this._isApplyEnable && this._maintenanceData.credits >= this._totalPrice.credits && this._maintenanceData.gold >= this._totalPrice.gold;
        }

        private function __getAmmoPrice() : Prices
        {
            var _loc2_:MaintenanceShellVO = null;
            var _loc1_:Prices = new Prices();
            for each(_loc2_ in this._maintenanceData.shells)
            {
                _loc1_[_loc2_.currency] = _loc1_[_loc2_.currency] + _loc2_.buyShellsCount * _loc2_.price;
            }
            return _loc1_;
        }

        private function __getEquipmentsPrice() : Prices
        {
            var _loc3_:EquipmentItem = null;
            var _loc1_:Prices = new Prices();
            var _loc2_:Array = [this.eqItem1,this.eqItem2,this.eqItem3];
            for each(_loc3_ in _loc2_)
            {
                if(_loc3_.selectedItem && _loc3_.selectedItem.inventoryCount == 0 && this._equipmentInstalled.indexOf(_loc3_.selectedItem.compactDescr) == -1)
                {
                    _loc1_[_loc3_.selectedItem.currency] = _loc1_[_loc3_.selectedItem.currency] + _loc3_.selectedItem.price;
                }
            }
            return _loc1_;
        }

        private function updatePriceLabels(param1:IconText, param2:IconText, param3:Prices) : void
        {
            var _loc4_:String = param3.credits > this._maintenanceData.credits?CURRENCIES_CONSTANTS.ERROR:CURRENCIES_CONSTANTS.CREDITS;
            var _loc5_:String = param3.gold > this._maintenanceData.gold?CURRENCIES_CONSTANTS.ERROR:CURRENCIES_CONSTANTS.CREDITS;
            param1.textColor = Currencies.TEXT_COLORS[_loc4_];
            var _loc6_:ILocale = App.utils.locale;
            param1.text = _loc6_.integer(param3.credits || 0);
            var _loc7_:* = param3.gold > 0;
            param2.visible = _loc7_;
            if(_loc7_)
            {
                param2.textColor = Currencies.TEXT_COLORS[_loc5_];
                param2.text = _loc6_.gold(param3.gold || 0);
            }
        }

        private function doApplyEnable() : void
        {
            this._isApplyEnable = true;
        }

        private function onModuleOnEquipmentRendererOverHandler(param1:OnEquipmentRendererOver) : void
        {
            var _loc4_:EquipmentItem = null;
            var _loc5_:String = null;
            var _loc2_:Array = [];
            var _loc3_:Array = [this.eqItem1,this.eqItem2,this.eqItem3];
            for each(_loc4_ in _loc3_)
            {
                _loc5_ = _loc4_.selectedItem?_loc4_.selectedItem.id:null;
                _loc2_.push(_loc5_);
            }
            this._toolTipMgr.showSpecial(TOOLTIPS_CONSTANTS.TECH_MAIN_MODULE,null,param1.moduleID,param1.modulePrices,param1.inventoryCount,param1.vehicleCount,param1.moduleIndex,_loc2_);
        }

        private function onAutoRollOverHandler(param1:MouseEvent) : void
        {
            var _loc2_:String = null;
            if(param1.target == this.repairAuto)
            {
                _loc2_ = TOOLTIPS.REPAIR_AUTO;
            }
            else if(param1.target == this.shellsAuto)
            {
                _loc2_ = TOOLTIPS.AMMO_AUTO;
            }
            else if(param1.target == this.eqAuto)
            {
                _loc2_ = TOOLTIPS.EQUIPMENT_AUTO;
            }
            if(_loc2_)
            {
                this._toolTipMgr.showComplex(_loc2_,null);
            }
        }

        private function onAutoRollOutHandler(param1:MouseEvent) : void
        {
            this._toolTipMgr.hide();
        }

        private function onAutoClickHandler(param1:MouseEvent) : void
        {
            this._toolTipMgr.hide();
        }

        private function onModuleNeedUpdateHandler(param1:EquipmentEvent) : void
        {
            invalidate(EQUIPMENT_CHANGED);
        }

        private function onModuleEquipmentChangeHandler(param1:EquipmentEvent) : void
        {
            var _loc2_:Array = null;
            var _loc3_:EquipmentItem = null;
            var _loc4_:EquipmentItem = null;
            if(param1.changeIndex != -1)
            {
                _loc2_ = [this.eqItem1,this.eqItem2,this.eqItem3];
                _loc3_ = param1.currentTarget as EquipmentItem;
                _loc4_ = _loc2_[param1.changeIndex] as EquipmentItem;
                App.utils.asserter.assertNotNull(_loc3_,ITEM_CHANGE_FROM + Errors.CANT_NULL);
                App.utils.asserter.assertNotNull(_loc4_,ITEM_CHANGE_TO + Errors.CANT_NULL);
                this.lockEquipmentChangeEvents([_loc3_,_loc4_],false);
                _loc3_.setCurrency(_loc4_.getCurrency());
                _loc4_.selectByItemId(param1.itemId);
                _loc4_.setCurrency(param1.changeCurrency);
                this.lockEquipmentChangeEvents([_loc3_,_loc4_],true);
                this._eqOrderChanged = true;
            }
            this.doApplyEnable();
            this.requestEquipment();
        }

        private function lockEquipmentChangeEvents(param1:Array, param2:Boolean) : void
        {
            var _loc3_:EquipmentItem = null;
            for each(_loc3_ in param1)
            {
                if(param2)
                {
                    _loc3_.addEventListener(EquipmentEvent.EQUIPMENT_CHANGE,this.onModuleEquipmentChangeHandler);
                }
                else
                {
                    _loc3_.removeEventListener(EquipmentEvent.EQUIPMENT_CHANGE,this.onModuleEquipmentChangeHandler);
                }
                _loc3_.toggleSelectChange(param2);
            }
            param1.splice(0);
            var param1:Array = null;
        }

        private function onStageShowInfoHandler(param1:ModuleInfoEvent) : void
        {
            showModuleInfoS(param1.id);
        }

        private function onStageChangeOrderHandler(param1:ShellRendererEvent) : void
        {
            var _loc4_:Array = null;
            var _loc5_:Array = null;
            var _loc6_:MaintenanceShellVO = null;
            var _loc2_:MaintenanceShellVO = param1.shell;
            var _loc3_:MaintenanceShellVO = param1.shellToReplace;
            if(_loc2_ && _loc3_)
            {
                _loc4_ = this._maintenanceData.shells;
                _loc5_ = [];
                for each(_loc6_ in _loc4_)
                {
                    if(_loc6_ == _loc2_)
                    {
                        _loc5_.push(_loc3_);
                    }
                    else if(_loc6_ == _loc3_)
                    {
                        _loc5_.push(_loc2_);
                    }
                    else
                    {
                        _loc5_.push(_loc6_);
                    }
                }
                for each(_loc6_ in _loc5_)
                {
                    _loc6_.list = _loc5_.slice();
                    _loc6_.list.splice(_loc5_.indexOf(_loc6_),1);
                }
                this._maintenanceData.shells = _loc5_;
                this.updateShellsBlock(true);
                this.doApplyEnable();
                this._shellsOrderChanged = true;
            }
        }

        private function onAutoSelectHandler(param1:Event) : void
        {
            if(this._maintenanceData)
            {
                setRefillSettingsS(this._maintenanceData.vehicleId,this.repairAuto.selected,this.shellsAuto.selected,this.eqAuto.selected);
            }
        }

        private function onShellsTotalPriceChangedHandler(param1:ShellRendererEvent) : void
        {
            invalidate(ShellRendererEvent.TOTAL_PRICE_CHANGED);
        }

        private function onShellsCurrencyChangedHandler(param1:ShellRendererEvent) : void
        {
            this.doApplyEnable();
        }

        private function onModuleTotalPriceChangedHandler(param1:EquipmentEvent) : void
        {
            this.doApplyEnable();
            var _loc2_:EquipmentItem = param1.currentTarget as EquipmentItem;
            App.utils.asserter.assertNotNull(_loc2_,EQUIPMENT_ITEM + Errors.CANT_NULL);
            updateEquipmentCurrencyS(_loc2_.index,param1.changeCurrency);
            invalidate(ShellRendererEvent.TOTAL_PRICE_CHANGED);
        }

        private function onRepairBtnClickHandler(param1:ButtonEvent) : void
        {
            repairS();
        }

        private function onApplyBtnClickHandler(param1:ButtonEvent) : void
        {
            var _loc3_:MaintenanceShellVO = null;
            var _loc4_:* = false;
            var _loc5_:* = false;
            var _loc6_:Prices = null;
            var _loc7_:* = false;
            var _loc8_:Prices = null;
            var _loc9_:* = false;
            var _loc2_:* = false;
            for each(_loc3_ in this._maintenanceData.shells)
            {
                if(_loc3_.userCount - _loc3_.count > 0)
                {
                    _loc2_ = true;
                    break;
                }
            }
            _loc4_ = !_loc2_ && this._shellsCountChanged;
            _loc2_ = _loc2_ || this._totalPrice.credits - this._maintenanceData.repairCost > 0 || this._totalPrice.gold > 0 || this.eqItem1.changed && this.eqItem1.selectedItem && this._equipmentInstalled.indexOf(this.eqItem1.selectedItem.compactDescr) == -1 || this.eqItem2.changed && this.eqItem2.selectedItem && this._equipmentInstalled.indexOf(this.eqItem2.selectedItem.compactDescr) == -1 || this.eqItem3.changed && this.eqItem3.selectedItem && this._equipmentInstalled.indexOf(this.eqItem3.selectedItem.compactDescr) == -1;
            _loc5_ = this._shellsOrderChanged || this._eqOrderChanged;
            _loc6_ = this.__getAmmoPrice();
            _loc7_ = _loc6_.credits > 0 || _loc6_.gold > 0;
            _loc8_ = this.__getEquipmentsPrice();
            _loc9_ = _loc8_.credits > 0 || _loc8_.gold > 0;
            fillVehicleS(this.repairBtn.enabled,_loc7_,_loc9_,_loc2_,_loc4_,_loc5_,this._maintenanceData.shells,[this.eqItem1.selectedItem,this.eqItem2.selectedItem,this.eqItem3.selectedItem]);
        }

        private function onCloseBtnClickHandler(param1:ButtonEvent) : void
        {
            onWindowCloseS();
        }

        private function requestEquipment() : void
        {
            getEquipmentS(this.eqItem1.getItemId(),this.eqItem1.getCurrency(),this.eqItem2.getItemId(),this.eqItem2.getCurrency(),this.eqItem3.getItemId(),this.eqItem3.getCurrency());
        }
    }
}

class Prices extends Object
{

    public var credits:Number = 0;

    public var gold:Number = 0;

    public var crystal:Number = 0;

    function Prices(param1:Number = 0, param2:Number = 0, param3:Number = 0)
    {
        super();
        this.credits = param1;
        this.gold = param2;
        this.crystal = param3;
    }

    public function toString() : Object
    {
        return "credits: " + this.credits + ", gold: " + this.gold + ", crystal: " + this.crystal;
    }
}
