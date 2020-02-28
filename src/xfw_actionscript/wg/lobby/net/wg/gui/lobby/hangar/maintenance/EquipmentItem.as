package net.wg.gui.lobby.hangar.maintenance
{
    import net.wg.gui.components.controls.SoundButtonEx;
    import net.wg.gui.lobby.components.maintenance.data.ModuleVO;
    import flash.display.MovieClip;
    import net.wg.gui.lobby.components.maintenance.MaintenanceDropDown;
    import flash.text.TextField;
    import net.wg.gui.components.advanced.ModuleTypesUIWithFill;
    import net.wg.gui.components.controls.IconText;
    import net.wg.gui.components.controls.ActionPrice;
    import net.wg.gui.components.controls.DropdownMenu;
    import scaleform.clik.events.ListEvent;
    import net.wg.data.constants.SoundTypes;
    import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
    import scaleform.clik.data.DataProvider;
    import net.wg.gui.events.EquipmentEvent;
    import net.wg.data.constants.Linkages;
    import org.idmedia.as3commons.util.StringUtils;
    import net.wg.utils.ILocale;
    import net.wg.data.constants.Currencies;
    import net.wg.data.constants.generated.CURRENCIES_CONSTANTS;
    import net.wg.data.constants.Values;
    import net.wg.gui.components.controls.VO.ActionPriceVO;
    import flash.events.MouseEvent;
    import scaleform.gfx.MouseEventEx;
    import net.wg.data.constants.generated.CONTEXT_MENU_HANDLER_TYPE;
    import net.wg.data.constants.IconsTypes;

    public class EquipmentItem extends SoundButtonEx
    {

        private static const SLOTS_MAX_COUNT:int = 10;

        private static const MULTY_CHARS:String = " x ";

        private static const TO_BUY_POS:int = 775;

        private static const BUY_BTN_LEFT_PADDING:int = 10;

        private static const INV_UPDATE:String = "invalidateUpdate";

        private static const INV_CLEAR:String = "invalidateClear";

        private static const EMPTY_LABEL:String = "empty";

        private static const EMPTY_COUNT:String = "-";

        public var slotBg:MovieClip;

        public var select:MaintenanceDropDown;

        public var title:TextField;

        public var descr:TextField;

        public var countLabel:TextField;

        public var emptyFocusIndicator:MovieClip;

        public var moduleType:ModuleTypesUIWithFill;

        public var slotOverlay:MovieClip;

        public var toBuy:IconText;

        public var price:IconText;

        public var actionPrice:ActionPrice;

        public var toBuyTf:TextField;

        public var toBuyDropdown:DropdownMenu;

        public var index:int;

        private var _defaultInitialized:Boolean = false;

        private var _slotArtifacts:Array;

        private var _installedItem:ModuleVO;

        private var _setupItem:ModuleVO;

        private var _installedData:Array;

        public function EquipmentItem()
        {
            super();
            this.select.handleScroll = false;
            this.select.focusIndicator = this.emptyFocusIndicator;
        }

        private static function getModuleById(param1:String, param2:Array) : ModuleVO
        {
            var _loc3_:ModuleVO = null;
            for each(_loc3_ in param2)
            {
                if(_loc3_.id == param1)
                {
                    return _loc3_;
                }
            }
            return null;
        }

        private static function getOnlyInstalledModules(param1:Array) : Array
        {
            var _loc3_:ModuleVO = null;
            var _loc2_:Array = [];
            for each(_loc3_ in param1)
            {
                if(_loc3_.isInstalled)
                {
                    _loc2_.push(_loc3_);
                }
            }
            return _loc2_;
        }

        override protected function onDispose() : void
        {
            this.toBuyDropdown.removeEventListener(ListEvent.INDEX_CHANGE,this.onToBuyDropdownIndexChangeHandler);
            this.select.removeEventListener(ListEvent.INDEX_CHANGE,this.onSelectIndexChangeHandler);
            this.cleanupData();
            this.actionPrice.dispose();
            this.actionPrice = null;
            this.moduleType.dispose();
            this.moduleType = null;
            this.slotOverlay = null;
            this.select.dispose();
            this.select = null;
            this.toBuy.dispose();
            this.toBuy = null;
            this.toBuyDropdown.dispose();
            this.toBuyDropdown = null;
            this.price.dispose();
            this.price = null;
            this.title = null;
            this.descr = null;
            this.countLabel = null;
            this.emptyFocusIndicator = null;
            this.toBuyTf = null;
            this.slotBg = null;
            super.onDispose();
        }

        override protected function configUI() : void
        {
            super.configUI();
            focusTarget = this.select;
            _focusable = tabEnabled = tabChildren = mouseChildren = true;
            this.slotBg.mouseEnabled = this.slotBg.mouseChildren = false;
            this.moduleType.mouseEnabled = this.moduleType.mouseChildren = false;
            this.slotOverlay.visible = false;
            this.slotOverlay.mouseEnabled = this.slotOverlay.mouseChildren = false;
            mouseEnabled = false;
            this.title.mouseEnabled = false;
            this.descr.mouseEnabled = false;
            this.countLabel.mouseEnabled = false;
            this.toBuy.mouseEnabled = this.toBuy.mouseChildren = false;
            this.price.mouseEnabled = this.price.mouseChildren = false;
            this.toBuyDropdown.addEventListener(ListEvent.INDEX_CHANGE,this.onToBuyDropdownIndexChangeHandler);
            this.soundType = SoundTypes.ARTEFACT_RENDERER;
            preventAutosizing = true;
        }

        override protected function showTooltip() : void
        {
            var _loc1_:ModuleVO = this.selectedItem;
            if(_loc1_)
            {
                App.toolTipMgr.showSpecial(TOOLTIPS_CONSTANTS.TECH_MAIN_MODULE,null,_loc1_.id,_loc1_.prices,_loc1_.inventoryCount,_loc1_.vehicleCount);
            }
            else
            {
                App.toolTipMgr.showComplex(TOOLTIPS.EQUIPMENT_EMPTY,null);
            }
        }

        public function setData(param1:Array, param2:int, param3:Array, param4:Array) : void
        {
            this.select.dataProvider.cleanUp();
            this.cleanupData();
            this.index = param2;
            this._installedData = param4;
            this._setupItem = getModuleById(param3[param2],param1);
            this._installedItem = getModuleById(param4[param2],param1);
            this.select.visible = !this._setupItem || !this._setupItem.disabledOption;
            if(this._setupItem && this._setupItem.builtIn)
            {
                this._slotArtifacts = getOnlyInstalledModules(param1);
            }
            else
            {
                this._slotArtifacts = param1;
            }
            this.select.close();
            this.select.removeEventListener(ListEvent.INDEX_CHANGE,this.onSelectIndexChangeHandler);
            this.select.dataProvider = new DataProvider(this._slotArtifacts);
            this.select.rowCount = Math.min(SLOTS_MAX_COUNT,this._slotArtifacts.length);
            if(this._setupItem)
            {
                this.selectByItemId(this._setupItem.id);
                if(!this._defaultInitialized)
                {
                    this._defaultInitialized = true;
                    dispatchEvent(new EquipmentEvent(EquipmentEvent.NEED_UPDATE));
                }
            }
            else
            {
                this.select.selectedIndex = -1;
            }
            this.select.scrollBar = param1.length > this.select.menuRowCount?Linkages.SCROLL_BAR:null;
            this.select.addEventListener(ListEvent.INDEX_CHANGE,this.onSelectIndexChangeHandler);
            invalidate(this.select.selectedIndex != -1?INV_UPDATE:INV_CLEAR);
        }

        public function setEmptyItem() : void
        {
            this.select.removeEventListener(ListEvent.INDEX_CHANGE,this.onSelectIndexChangeHandler);
            this._setupItem = null;
            this.select.selectedIndex = -1;
            this.select.addEventListener(ListEvent.INDEX_CHANGE,this.onSelectIndexChangeHandler);
            dispatchEvent(new EquipmentEvent(EquipmentEvent.EQUIPMENT_CHANGE));
        }

        public function toggleSelectChange(param1:Boolean) : void
        {
            if(param1)
            {
                this.select.addEventListener(ListEvent.INDEX_CHANGE,this.onSelectIndexChangeHandler);
            }
            else
            {
                this.select.removeEventListener(ListEvent.INDEX_CHANGE,this.onSelectIndexChangeHandler);
            }
        }

        override protected function draw() : void
        {
            super.draw();
            if(this.select.selectedIndex == -1 && isInvalid(INV_CLEAR))
            {
                this.clear();
            }
            if(this.select.selectedIndex != -1 && isInvalid(INV_UPDATE))
            {
                this.update();
            }
        }

        private function cleanupData() : void
        {
            if(this._installedData)
            {
                this._installedData.splice(0);
                this._installedData = null;
            }
            if(this._slotArtifacts)
            {
                this._slotArtifacts.splice(0);
                this._slotArtifacts = null;
            }
        }

        private function update() : void
        {
            var _loc1_:ModuleVO = null;
            var _loc5_:* = false;
            _loc1_ = this.selectedItem;
            this.toBuyDropdown.visible = false;
            this.toBuyTf.visible = false;
            App.utils.asserter.assertFrameExists(_loc1_.moduleLabel,this.moduleType);
            this.moduleType.gotoAndStop(_loc1_.moduleLabel);
            var _loc2_:String = _loc1_.highlightType;
            var _loc3_:Boolean = StringUtils.isNotEmpty(_loc2_);
            this.slotOverlay.visible = _loc3_;
            if(_loc3_)
            {
                this.slotOverlay.gotoAndStop(_loc2_);
            }
            this.title.text = _loc1_.name;
            this.descr.text = _loc1_.desc;
            this.countLabel.visible = this.toBuy.visible = true;
            this.actionPrice.setup(this);
            this.price.visible = !this.actionPrice.visible;
            this.countLabel.alpha = _loc1_.count > 0?1:0.3;
            var _loc4_:ILocale = App.utils.locale;
            if(_loc1_.builtIn)
            {
                this.countLabel.text = EMPTY_COUNT;
            }
            else
            {
                this.countLabel.text = _loc4_.integer(_loc1_.count);
            }
            _loc5_ = Currencies.checkSeveralPrices(_loc1_.prices);
            if(_loc5_)
            {
                this.toBuyTf.visible = _loc5_;
                this.toBuy.visible = !_loc5_;
                this.toBuyDropdown.visible = _loc5_;
                this.toBuyDropdown.removeEventListener(ListEvent.INDEX_CHANGE,this.onToBuyDropdownIndexChangeHandler);
                this.toBuyDropdown.dataProvider = new DataProvider([_loc4_.htmlTextWithIcon(_loc4_.integer(_loc1_.prices[0]),CURRENCIES_CONSTANTS.CREDITS),_loc4_.htmlTextWithIcon(_loc4_.gold(_loc1_.prices[1]),CURRENCIES_CONSTANTS.GOLD)]);
                this.toBuyDropdown.selectedIndex = _loc1_.currency == CURRENCIES_CONSTANTS.CREDITS?0:1;
                this.toBuyDropdown.addEventListener(ListEvent.INDEX_CHANGE,this.onToBuyDropdownIndexChangeHandler);
            }
            else
            {
                this.toBuyDropdown.visible = false;
                this.toBuyTf.visible = false;
                this.toBuy.visible = true;
            }
            this.updateModulePrice();
        }

        private function clear() : void
        {
            this.toBuyDropdown.visible = false;
            this.toBuyTf.visible = false;
            this.moduleType.gotoAndStop(EMPTY_LABEL);
            this.slotOverlay.visible = false;
            this.title.text = Values.EMPTY_STR;
            this.descr.text = Values.EMPTY_STR;
            this.countLabel.visible = this.toBuy.visible = this.price.visible = this.actionPrice.visible = false;
        }

        private function updateModulePrice() : void
        {
            var _loc1_:ModuleVO = this.selectedItem;
            this.price.icon = this.toBuy.icon = _loc1_.currency;
            var _loc2_:* = 0;
            var _loc3_:* = 0;
            if(_loc1_.inventoryCount == 0 && this.changed && this._installedData.indexOf(_loc1_.compactDescr) == -1)
            {
                _loc2_ = 1;
            }
            if(this.toBuyDropdown.visible)
            {
                _loc3_ = _loc1_.prices[this.toBuyDropdown.selectedIndex];
            }
            else
            {
                _loc3_ = _loc1_.prices[_loc1_.currency == CURRENCIES_CONSTANTS.CREDITS?0:1];
            }
            var _loc4_:ILocale = App.utils.locale;
            var _loc5_:Number = _loc3_ * _loc2_;
            this.toBuy.textColor = Currencies.TEXT_COLORS[_loc1_.currency];
            var _loc6_:String = _loc5_ > _loc1_.userCredits[_loc1_.currency]?CURRENCIES_CONSTANTS.ERROR:_loc1_.currency;
            this.price.textColor = Currencies.TEXT_COLORS[_loc6_];
            this.price.text = _loc1_.currency == CURRENCIES_CONSTANTS.CREDITS?_loc4_.integer(_loc5_):_loc4_.gold(_loc5_);
            var _loc7_:ActionPriceVO = null;
            if(_loc1_.actionPriceVo)
            {
                _loc7_ = _loc1_.actionPriceVo;
                _loc7_.forCredits = _loc1_.currency == CURRENCIES_CONSTANTS.CREDITS;
            }
            this.actionPrice.setData(_loc7_);
            this.price.visible = !this.actionPrice.visible;
            if(this.actionPrice.visible)
            {
                if(_loc1_.status == MENU.MODULEFITS_NOT_WITH_INSTALLED_EQUIPMENT)
                {
                    this.actionPrice.textColorType = ActionPrice.TEXT_COLOR_TYPE_DISABLE;
                }
                else if(_loc1_.price < _loc1_.userCredits[_loc1_.currency])
                {
                    this.actionPrice.textColorType = ActionPrice.TEXT_COLOR_TYPE_ICON;
                }
                else
                {
                    this.actionPrice.textColorType = ActionPrice.TEXT_COLOR_TYPE_ERROR;
                }
            }
            this.toBuy.text = _loc2_ + MULTY_CHARS + this.price.text;
            this.toBuyTf.text = _loc2_ + MULTY_CHARS;
            this.toBuy.enabled = this.price.enabled = _loc2_ != 0;
            this.toBuy.mouseEnabled = this.price.mouseEnabled = false;
            this.toBuy.validateNow();
            this.toBuy.x = TO_BUY_POS - this.toBuy.width + (this.toBuy.textField.textWidth >> 1) + BUY_BTN_LEFT_PADDING ^ 0;
            this.toBuyTf.alpha = _loc2_ != 0?1:0.3;
        }

        public function get changed() : Boolean
        {
            return this.selectedItem != this._installedItem;
        }

        public function get selectedItem() : ModuleVO
        {
            if(this._slotArtifacts && this.select.selectedIndex != -1)
            {
                return this._slotArtifacts[this.select.selectedIndex];
            }
            return null;
        }

        override protected function onMouseDownHandler(param1:MouseEvent) : void
        {
            var _loc2_:* = false;
            super.onMouseDownHandler(param1);
            if(this.selectedItem && param1 is MouseEventEx)
            {
                if(App.utils.commons.isRightButton(param1))
                {
                    _loc2_ = this.changed && this.selectedItem.inventoryCount == 0 && this._installedData.indexOf(this.selectedItem.compactDescr) == -1;
                    App.contextMenuMgr.show(CONTEXT_MENU_HANDLER_TYPE.TECHNICAL_MAINTENANCE,this,{
                        "isCanceled":_loc2_,
                        "equipmentCD":this.selectedItem.id
                    });
                }
            }
        }

        private function onToBuyDropdownIndexChangeHandler(param1:ListEvent) : void
        {
            this.price.icon = this.toBuyDropdown.selectedIndex == 0?CURRENCIES_CONSTANTS.CREDITS:CURRENCIES_CONSTANTS.GOLD;
            this.actionPrice.ico = this.toBuyDropdown.selectedIndex == 0?IconsTypes.CREDITS:IconsTypes.GOLD;
            this.selectedItem.currency = this.toBuyDropdown.selectedIndex == 0?CURRENCIES_CONSTANTS.CREDITS:CURRENCIES_CONSTANTS.GOLD;
            invalidate(INV_UPDATE);
            dispatchEvent(new EquipmentEvent(EquipmentEvent.TOTAL_PRICE_CHANGED,-1,this.selectedItem.currency,this.getItemId()));
        }

        private function onSelectIndexChangeHandler(param1:ListEvent) : void
        {
            var _loc2_:EquipmentEvent = null;
            var _loc3_:String = null;
            var _loc4_:String = null;
            if(this.selectedItem && this.selectedItem.isInstalled)
            {
                _loc3_ = this._setupItem?this._setupItem.currency:Values.EMPTY_STR;
                _loc4_ = this._setupItem?this._setupItem.id:Values.EMPTY_STR;
                _loc2_ = new EquipmentEvent(EquipmentEvent.EQUIPMENT_CHANGE,this.selectedItem.index,_loc3_,_loc4_);
            }
            else
            {
                _loc2_ = new EquipmentEvent(EquipmentEvent.EQUIPMENT_CHANGE);
            }
            if(this.select.hitTestPoint(App.stage.mouseX,App.stage.mouseY))
            {
                this.showTooltip();
            }
            dispatchEvent(_loc2_);
        }

        public function setCurrency(param1:String) : void
        {
            if(this.selectedItem)
            {
                this.selectedItem.currency = param1;
            }
        }

        public function selectByItemId(param1:String) : void
        {
            var itemId:String = param1;
            var success:Boolean = this._slotArtifacts && this._slotArtifacts.some(function(param1:ModuleVO, param2:int):Boolean
            {
                if(param1.id == itemId)
                {
                    select.selectedIndex = param2;
                    return true;
                }
                return false;
            });
            if(!success)
            {
                this.select.selectedIndex = -1;
            }
        }

        public function getCurrency() : String
        {
            if(this.selectedItem)
            {
                return this.selectedItem.currency;
            }
            return Values.EMPTY_STR;
        }

        public function getItemId() : String
        {
            if(this.selectedItem)
            {
                return this.selectedItem.id;
            }
            return null;
        }
    }
}
