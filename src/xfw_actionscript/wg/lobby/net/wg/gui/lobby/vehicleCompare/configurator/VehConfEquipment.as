package net.wg.gui.lobby.vehicleCompare.configurator
{
    import net.wg.infrastructure.base.UIComponentEx;
    import net.wg.infrastructure.interfaces.IFocusChainContainer;
    import flash.text.TextField;
    import net.wg.gui.components.controls.SoundButtonEx;
    import scaleform.clik.controls.ButtonGroup;
    import net.wg.infrastructure.managers.ITooltipMgr;
    import net.wg.data.constants.generated.FITTING_TYPES;
    import net.wg.gui.lobby.vehicleCompare.events.ClosableEquipmentSlotEvent;
    import flash.events.Event;
    import scaleform.clik.events.ButtonEvent;
    import flash.events.MouseEvent;
    import flash.events.EventDispatcher;
    import flash.display.InteractiveObject;
    import net.wg.gui.components.controls.VO.ShellButtonVO;
    import net.wg.gui.lobby.components.data.DeviceSlotVO;
    import net.wg.gui.lobby.modulesPanel.data.FittingSelectPopoverParams;
    import net.wg.gui.components.popovers.PopOverConst;
    import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
    import net.wg.gui.lobby.vehicleCompare.events.VehConfEvent;
    import net.wg.gui.lobby.vehicleCompare.events.VehConfShellSlotEvent;
    import net.wg.data.Aliases;

    public class VehConfEquipment extends UIComponentEx implements IFocusChainContainer
    {

        private static const MODULES_PANEL_BTN_GROUP:String = "ModulesPanelBtnGroup";

        public var titleTf:TextField;

        public var optionalDevice1:ClosableEquipmentSlot = null;

        public var optionalDevice2:ClosableEquipmentSlot = null;

        public var optionalDevice3:ClosableEquipmentSlot = null;

        public var equipment1:ClosableEquipmentSlot = null;

        public var equipment2:ClosableEquipmentSlot = null;

        public var equipment3:ClosableEquipmentSlot = null;

        public var shell1:VehConfShellButton = null;

        public var shell2:VehConfShellButton = null;

        public var shell3:VehConfShellButton = null;

        public var camoBtn:SoundButtonEx = null;

        public var booster:ClosableEquipmentSlot = null;

        private var _shellsGoup:ButtonGroup;

        private var _shellsSelectedIndex:int = 0;

        private var _optionalDevices:Vector.<ClosableEquipmentSlot> = null;

        private var _equipment:Vector.<ClosableEquipmentSlot> = null;

        private var _shells:Vector.<VehConfShellButton> = null;

        private var _tooltipMgr:ITooltipMgr = null;

        public function VehConfEquipment()
        {
            super();
            this._optionalDevices = new <ClosableEquipmentSlot>[this.optionalDevice1,this.optionalDevice2,this.optionalDevice3];
            this._equipment = new <ClosableEquipmentSlot>[this.equipment1,this.equipment2,this.equipment3];
            this._shells = new <VehConfShellButton>[this.shell1,this.shell2,this.shell3];
            this._tooltipMgr = App.toolTipMgr;
        }

        override protected function configUI() : void
        {
            var _loc1_:ClosableEquipmentSlot = null;
            var _loc2_:VehConfShellButton = null;
            super.configUI();
            this.titleTf.text = VEH_COMPARE.VEHCONF_EQUIPMENT;
            for each(_loc1_ in this._optionalDevices)
            {
                _loc1_.slotIndex = this._optionalDevices.indexOf(_loc1_);
                _loc1_.focusable = true;
                _loc1_.type = FITTING_TYPES.OPTIONAL_DEVICE;
                _loc1_.addEventListener(ClosableEquipmentSlotEvent.LEFT_BTN_CLICK,this.onOptDeviceLeftBtnClickHandler);
            }
            for each(_loc1_ in this._equipment)
            {
                _loc1_.focusable = true;
                _loc1_.type = FITTING_TYPES.EQUIPMENT;
                _loc1_.slotIndex = this._equipment.indexOf(_loc1_);
                _loc1_.addEventListener(ClosableEquipmentSlotEvent.LEFT_BTN_CLICK,this.onEquipmentLeftBtnClickHandler);
            }
            this._shellsGoup = ButtonGroup.getGroup(MODULES_PANEL_BTN_GROUP,this);
            this._shellsGoup.addEventListener(Event.CHANGE,this.onShellsGroupChangeHandler);
            for each(_loc2_ in this._shells)
            {
                _loc2_.groupName = MODULES_PANEL_BTN_GROUP;
                _loc2_.toggle = true;
                _loc2_.allowDeselect = false;
            }
            this._shellsGoup.setSelectedButtonByIndex(this._shellsSelectedIndex);
            this.camoBtn.mouseEnabledOnDisabled = true;
            this.camoBtn.addEventListener(ButtonEvent.CLICK,this.onCamoBtnClickHandler);
            this.camoBtn.addEventListener(MouseEvent.ROLL_OVER,this.onCamoBtnRollOverHandler);
            this.camoBtn.addEventListener(MouseEvent.ROLL_OUT,this.onCamoBtnRollOutHandler);
            this.booster.focusable = true;
            this.booster.type = FITTING_TYPES.BOOSTER;
            this.booster.addEventListener(ClosableEquipmentSlotEvent.LEFT_BTN_CLICK,this.onBoosterLeftBtnClickHandler);
        }

        override protected function onDispose() : void
        {
            var _loc1_:EventDispatcher = null;
            this.titleTf = null;
            this._tooltipMgr = null;
            this.camoBtn.removeEventListener(ButtonEvent.CLICK,this.onCamoBtnClickHandler);
            this.camoBtn.removeEventListener(MouseEvent.ROLL_OVER,this.onCamoBtnRollOverHandler);
            this.camoBtn.removeEventListener(MouseEvent.ROLL_OUT,this.onCamoBtnRollOutHandler);
            this.camoBtn.dispose();
            this.camoBtn = null;
            this._shellsGoup.removeEventListener(Event.CHANGE,this.onShellsGroupChangeHandler);
            this._shellsGoup.dispose();
            this._shellsGoup = null;
            for each(_loc1_ in this._optionalDevices)
            {
                _loc1_.removeEventListener(ButtonEvent.CLICK,this.onOptDeviceLeftBtnClickHandler);
            }
            for each(_loc1_ in this._equipment)
            {
                _loc1_.removeEventListener(ButtonEvent.CLICK,this.onEquipmentLeftBtnClickHandler);
            }
            this.booster.removeEventListener(ClosableEquipmentSlotEvent.LEFT_BTN_CLICK,this.onBoosterLeftBtnClickHandler);
            this.booster.dispose();
            this.booster = null;
            this._optionalDevices.splice(0,this._shells.length);
            this._optionalDevices = null;
            this._equipment.splice(0,this._shells.length);
            this._equipment = null;
            this._shells.splice(0,this._shells.length);
            this._shells = null;
            this.optionalDevice1.dispose();
            this.optionalDevice1 = null;
            this.optionalDevice2.dispose();
            this.optionalDevice2 = null;
            this.optionalDevice3.dispose();
            this.optionalDevice3 = null;
            this.equipment1.dispose();
            this.equipment1 = null;
            this.equipment2.dispose();
            this.equipment2 = null;
            this.equipment3.dispose();
            this.equipment3 = null;
            this.shell1.dispose();
            this.shell1 = null;
            this.shell2.dispose();
            this.shell2 = null;
            this.shell3.dispose();
            this.shell3 = null;
            super.onDispose();
        }

        public function disableCamo() : void
        {
            this.camoBtn.setDisabled();
        }

        public function getFocusChain() : Vector.<InteractiveObject>
        {
            return new <InteractiveObject>[this.optionalDevice1,this.optionalDevice2,this.optionalDevice3,this.shell1,this.shell2,this.shell3,this.equipment1,this.equipment2,this.equipment3,this.booster,InteractiveObject(this.camoBtn)];
        }

        public function setAmmo(param1:Vector.<ShellButtonVO>) : void
        {
            var _loc4_:VehConfShellButton = null;
            var _loc5_:ShellButtonVO = null;
            var _loc2_:uint = this._shells.length;
            var _loc3_:uint = param1.length;
            var _loc6_:* = 0;
            while(_loc6_ < _loc2_)
            {
                _loc4_ = this._shells[_loc6_];
                _loc4_.clear();
                if(_loc6_ < _loc3_)
                {
                    _loc5_ = param1[_loc6_];
                    _loc4_.id = _loc5_.id;
                    _loc4_.ammunitionType = _loc5_.type;
                    _loc4_.icon = _loc5_.icon;
                    _loc4_.tooltip = _loc5_.tooltip;
                    _loc4_.tooltipType = _loc5_.tooltipType;
                    _loc4_.enabled = true;
                }
                else
                {
                    _loc4_.enabled = false;
                }
                _loc6_++;
            }
        }

        public function setCamoEnabled(param1:Boolean) : void
        {
            this.camoBtn.enabled = param1;
        }

        public function setData(param1:Vector.<DeviceSlotVO>) : void
        {
            var _loc2_:DeviceSlotVO = null;
            for each(_loc2_ in param1)
            {
                this.trySetupDevice(_loc2_);
            }
        }

        public function setSelectedAmmoIndex(param1:int) : void
        {
            this._shellsSelectedIndex = param1;
            if(this._shellsGoup)
            {
                this._shellsGoup.setSelectedButtonByIndex(this._shellsSelectedIndex);
            }
        }

        private function trySetupDevice(param1:DeviceSlotVO) : Boolean
        {
            if(FITTING_TYPES.OPTIONAL_DEVICE == param1.slotType)
            {
                this._optionalDevices[param1.slotIndex].setData(param1);
                return true;
            }
            if(FITTING_TYPES.EQUIPMENT == param1.slotType)
            {
                this._equipment[param1.slotIndex].setData(param1);
                return true;
            }
            if(FITTING_TYPES.BOOSTER == param1.slotType)
            {
                this.booster.setData(param1);
                return true;
            }
            return false;
        }

        private function showPopover(param1:ClosableEquipmentSlot, param2:String) : void
        {
            var _loc3_:Object = new FittingSelectPopoverParams(param1.type,param1.slotIndex,PopOverConst.ARROW_BOTTOM);
            App.popoverMgr.show(param1,param2,_loc3_);
        }

        public function get camoSelected() : Boolean
        {
            return this.camoBtn.selected;
        }

        public function set camoSelected(param1:Boolean) : void
        {
            this.camoBtn.selected = param1;
        }

        private function onCamoBtnRollOutHandler(param1:MouseEvent) : void
        {
            this._tooltipMgr.hide();
        }

        private function onCamoBtnRollOverHandler(param1:MouseEvent) : void
        {
            this._tooltipMgr.showSpecial(TOOLTIPS_CONSTANTS.VEH_CMP_CUSTOMIZATION,null,this.camoBtn.selected,this.camoBtn.enabled);
        }

        private function onCamoBtnClickHandler(param1:ButtonEvent) : void
        {
            dispatchEvent(new VehConfEvent(VehConfEvent.CAMO_CLICK));
        }

        private function onShellsGroupChangeHandler(param1:Event) : void
        {
            var _loc2_:VehConfShellButton = VehConfShellButton(this._shellsGoup.selectedButton);
            dispatchEvent(new VehConfShellSlotEvent(VehConfShellSlotEvent.SHELL_SLOT_CLICK,_loc2_.id,this._shellsGoup.selectedIndex));
        }

        private function onEquipmentLeftBtnClickHandler(param1:ClosableEquipmentSlotEvent) : void
        {
            var _loc2_:ClosableEquipmentSlot = ClosableEquipmentSlot(param1.currentTarget);
            this.showPopover(_loc2_,Aliases.FITTING_CMP_SELECT_POPOVER);
        }

        private function onOptDeviceLeftBtnClickHandler(param1:ClosableEquipmentSlotEvent) : void
        {
            var _loc2_:ClosableEquipmentSlot = ClosableEquipmentSlot(param1.currentTarget);
            this.showPopover(_loc2_,Aliases.OPT_DEVICES_CMP_SELECT_POPOVER);
        }

        private function onBoosterLeftBtnClickHandler(param1:ClosableEquipmentSlotEvent) : void
        {
            var _loc2_:ClosableEquipmentSlot = ClosableEquipmentSlot(param1.currentTarget);
            this.showPopover(_loc2_,Aliases.BOOSTER_CMP_SELECT_POPOVER);
        }
    }
}
