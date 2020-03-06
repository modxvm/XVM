package net.wg.gui.lobby.hangar.ammunitionPanel
{
    import net.wg.infrastructure.base.meta.impl.AmmunitionPanelMeta;
    import net.wg.gui.components.controls.IconTextButton;
    import net.wg.gui.components.advanced.ShellButton;
    import net.wg.gui.components.controls.SoundButtonEx;
    import net.wg.gui.lobby.modulesPanel.components.DeviceSlot;
    import net.wg.gui.components.controls.VO.ShellButtonVO;
    import net.wg.infrastructure.managers.ITooltipMgr;
    import net.wg.utils.IUtils;
    import net.wg.gui.lobby.hangar.ammunitionPanel.data.VehicleMessageVO;
    import net.wg.utils.IScheduler;
    import net.wg.utils.ICounterManager;
    import net.wg.gui.lobby.modulesPanel.data.DevicesDataVO;
    import net.wg.infrastructure.events.ChildVisibilityEvent;
    import flash.events.MouseEvent;
    import flash.events.Event;
    import scaleform.clik.events.ButtonEvent;
    import net.wg.gui.lobby.hangar.ammunitionPanel.events.AmmunitionPanelEvents;
    import net.wg.data.constants.generated.FITTING_TYPES;
    import scaleform.clik.events.ComponentEvent;
    import net.wg.gui.lobby.components.data.DeviceSlotVO;
    import net.wg.data.constants.Values;
    import net.wg.infrastructure.interfaces.IUIComponentEx;
    import flash.display.InteractiveObject;
    import net.wg.utils.helpLayout.HelpLayoutVO;
    import net.wg.infrastructure.managers.counter.CounterProps;
    import flash.display.BitmapData;
    import net.wg.data.constants.Linkages;
    import net.wg.data.constants.Directions;
    import net.wg.infrastructure.events.FocusRequestEvent;
    import net.wg.utils.ICounterProps;
    import flash.text.TextFormatAlign;
    import net.wg.infrastructure.events.IconLoaderEvent;
    import scaleform.gfx.MouseEventEx;
    import net.wg.gui.lobby.modulesPanel.data.FittingSelectPopoverParams;
    import net.wg.data.Aliases;
    import net.wg.infrastructure.managers.ITooltipFormatter;

    public class AmmunitionPanel extends AmmunitionPanelMeta implements IAmmunitionPanel
    {

        private static const VEHICLE_STATUS_INVALID:String = "vehicleStatusInvalid";

        private static const TO_RENT_LEFT_MARGIN:int = 10;

        private static const INV_SHELL_BUTTONS:String = "InvShellButtons";

        private static const INV_MAINTENANCE_STATE:String = "InvMaintenanceState";

        private static const INV_TUNING_BUTTON_STATE:String = "InvTuningState";

        private static const OFFSET_BTN_TO_RENT:Number = 2;

        private static const SHELLS_VO_SIZE_CORRECTION:int = 10;

        private static const HELP_LAYOUT_ID_DELIMITER:String = "_";

        private static const LAST_ELEMENT_FOCUS_FIX:String = "lastElementFocusFix must be the last element in AmmunitionPanel for property focus work, WOTD-40089";

        private static const BREAKPOINT_SLOT_CENTERING:int = 1036;

        private static const OFFSET_MINRES_LEFT:int = 98;

        private static const OFFSET_LAST_ELEMENT_FOCUS_FIX:int = 60;

        private static const BATTLE_ABILITIES_HIGHLIGHTER_NAME:String = "battleAbilitiesHighlighter";

        private static const HIGHLIGHTER_CREATE_DELAY:int = 1000;

        private static const INDENT_BETWEEN_BUTTONS:int = 11;

        public static const SLOTS_HEIGHT:int = 47;

        public static const SLOTS_BOTTOM_OFFSET:int = 11;

        private static const VEHICLE_STATE_MSG_OFFSET:int = 16;

        public var vehicleStateMsg:VehicleStateMsg = null;

        public var maintenanceBtn:IconTextButton = null;

        public var tuningBtn:IconTextButton = null;

        public var changeNationBtn:IconTextButton = null;

        public var optionalDevice1:EquipmentSlot = null;

        public var optionalDevice2:EquipmentSlot = null;

        public var optionalDevice3:EquipmentSlot = null;

        public var equipment1:EquipmentSlot = null;

        public var equipment2:EquipmentSlot = null;

        public var equipment3:EquipmentSlot = null;

        public var shell1:ShellButton = null;

        public var shell2:ShellButton = null;

        public var shell3:ShellButton = null;

        public var lastElementFocusFix:EquipmentSlot = null;

        public var toRent:SoundButtonEx = null;

        public var booster:EquipmentSlot = null;

        public var battleAbility1:BattleAbilitySlot = null;

        public var battleAbility2:BattleAbilitySlot = null;

        public var battleAbility3:BattleAbilitySlot = null;

        private var _modulesHelpLayoutId:String = "";

        private var _devicesHelpLayoutId:String = "";

        private var _shellsHelpLayoutId:String = "";

        private var _equipmentHelpLayoutId:String = "";

        private var _boosterHelpLayoutId:String = "";

        private var _panelEnabled:Boolean = true;

        private var _battleAbilitiesVisible:Boolean = false;

        private var _maintenanceTooltip:String = "";

        private var _tuningTooltip:String = "";

        private var _optionalDevices:Vector.<DeviceSlot> = null;

        private var _equipment:Vector.<DeviceSlot> = null;

        private var _battleAbilities:Vector.<DeviceSlot> = null;

        private var _shells:Vector.<ShellButton> = null;

        private var _shellsData:Vector.<ShellButtonVO> = null;

        private var _maintenanceStateWarning:Boolean = false;

        private var _toolTipMgr:ITooltipMgr;

        private var _utils:IUtils;

        private var _msgVo:VehicleMessageVO = null;

        private var _screenWidth:int = 0;

        private var _fakeWidth:int = 0;

        private var _battleAbilitiesHighlighter:BattleAbilitiesHighlighter = null;

        private var _highlighterLeftX:int = -1;

        private var _highlighterRightX:int = -1;

        private var _scheduler:IScheduler;

        private var _showBattleAbilitiesHighlighter:Boolean = false;

        private var _lastActiveAbility:int = -1;

        private var _counterManager:ICounterManager;

        private var _tuningBtnEnabled:Boolean = true;

        private var _changeNationBtnEnabled:Boolean;

        private var _changeNationTooltip:String;

        private var _changeNationBtnVisible:Boolean;

        private var _changeNationIsNew:Boolean;

        private var _boosterCounter:int;

        private var _animations:Vector.<SlotAnimation>;

        private var _animationEquipmentSlot:EquipmentSlot;

        private var _postponedData:DevicesDataVO;

        private var _buttonWidth:Number = 131;

        private var _buttonsList:Array;

        public function AmmunitionPanel()
        {
            this._toolTipMgr = App.toolTipMgr;
            this._utils = App.utils;
            this._scheduler = App.utils.scheduler;
            super();
            addSlots(this.optionalDevice1,this.optionalDevice2,this.optionalDevice3,this.equipment1,this.equipment2,this.equipment3,this.booster,this.battleAbility1,this.battleAbility2,this.battleAbility3);
            this._optionalDevices = new <DeviceSlot>[this.optionalDevice1,this.optionalDevice2,this.optionalDevice3];
            this._equipment = new <DeviceSlot>[this.equipment1,this.equipment2,this.equipment3];
            this._shells = new <ShellButton>[this.shell1,this.shell2,this.shell3];
            this._battleAbilities = new <DeviceSlot>[this.battleAbility1,this.battleAbility2,this.battleAbility3];
            this._fakeWidth = this.booster.x + this.booster.width >> 0;
            this.lastElementFocusFix.x = this.booster.x + OFFSET_LAST_ELEMENT_FOCUS_FIX;
            this._buttonsList = [this.maintenanceBtn,this.tuningBtn,this.changeNationBtn];
            this._counterManager = App.utils.counterManager;
            this._animations = new Vector.<SlotAnimation>(0);
            this._animationEquipmentSlot = App.utils.classFactory.getComponent(Linkages.EQUIPMENT_SLOT_UI,EquipmentSlot);
        }

        override protected function initialize() : void
        {
            super.initialize();
            this.tuningBtn.enabled = false;
            App.waiting.addEventListener(ChildVisibilityEvent.CHILD_SHOWN,this.onChildShownHandler);
            App.waiting.addEventListener(ChildVisibilityEvent.CHILD_HIDDEN,this.onChildHiddenHandler);
        }

        override protected function onBeforeDispose() : void
        {
            var _loc1_:IconTextButton = null;
            for each(_loc1_ in this._buttonsList)
            {
                _loc1_.removeEventListener(MouseEvent.ROLL_OVER,this.onBtnRollOverHandler);
                _loc1_.removeEventListener(MouseEvent.ROLL_OUT,this.onBtnRollOutHandler);
                _loc1_.removeEventListener(Event.RESIZE,this.onResizeHandler);
            }
            this.maintenanceBtn.removeEventListener(ButtonEvent.CLICK,this.onMaintenanceBtnClickHandler);
            this.tuningBtn.removeEventListener(ButtonEvent.CLICK,this.onTuningBtnClickHandler);
            this.changeNationBtn.removeEventListener(ButtonEvent.CLICK,this.onChangeNationBtnClickHandler);
            this._scheduler.cancelTask(this.createBattleAbilitiesHighlighter);
            this.disposeSlots();
            this._shellsData = null;
            App.waiting.removeEventListener(ChildVisibilityEvent.CHILD_SHOWN,this.onChildShownHandler);
            App.waiting.removeEventListener(ChildVisibilityEvent.CHILD_HIDDEN,this.onChildHiddenHandler);
            removeEventListener(AmmunitionPanelEvents.VEHICLE_STATE_MSG_RESIZE,this.onAmmunitionPanelVehicleStateMsgResizeHandler);
            this.toRent.removeEventListener(MouseEvent.ROLL_OVER,this.onBtnRollOverHandler);
            this.toRent.removeEventListener(MouseEvent.ROLL_OUT,this.onBtnRollOutHandler);
            this.toRent.removeEventListener(ButtonEvent.CLICK,this.onToRentClickHandler);
            super.onBeforeDispose();
        }

        override protected function onDispose() : void
        {
            var _loc1_:SlotAnimation = null;
            this._counterManager.removeCounter(this.tuningBtn);
            this._counterManager.removeCounter(this.changeNationBtn);
            this._counterManager = null;
            this.maintenanceBtn.dispose();
            this.maintenanceBtn = null;
            this.tuningBtn.dispose();
            this.tuningBtn = null;
            this.changeNationBtn.dispose();
            this.changeNationBtn = null;
            this.vehicleStateMsg.dispose();
            this.vehicleStateMsg = null;
            this.toRent.dispose();
            this.toRent = null;
            if(this._battleAbilitiesHighlighter != null)
            {
                this._battleAbilitiesHighlighter.dispose();
                this._battleAbilitiesHighlighter = null;
            }
            this._msgVo = null;
            this._toolTipMgr = null;
            this._utils = null;
            this._scheduler = null;
            this._buttonsList = null;
            for each(_loc1_ in this._animations)
            {
                this.disposeAnimation(_loc1_);
            }
            this._animations.splice(0,this._animations.length);
            this._animations = null;
            if(this._postponedData != null)
            {
                this._postponedData = null;
            }
            this._animationEquipmentSlot.dispose();
            this._animationEquipmentSlot = null;
            super.onDispose();
        }

        override protected function draw() : void
        {
            super.draw();
            if(isInvalid(VEHICLE_STATUS_INVALID) && this._msgVo != null)
            {
                this.setVehicleStatus();
            }
            if(isInvalid(INV_SHELL_BUTTONS) && this._shellsData)
            {
                this.updateShellButtons();
            }
            if(isInvalid(INV_MAINTENANCE_STATE))
            {
                this.maintenanceBtn.alertMC.visible = this._maintenanceStateWarning;
            }
            if(isInvalid(INV_TUNING_BUTTON_STATE))
            {
                if(App.waiting)
                {
                    this.tuningBtn.enabled = this._tuningBtnEnabled && !App.waiting.isOnStage;
                }
                else
                {
                    this.tuningBtn.enabled = this._tuningBtnEnabled;
                }
            }
        }

        override protected function configUI() : void
        {
            var _loc1_:DeviceSlot = null;
            var _loc2_:ShellButton = null;
            var _loc3_:DeviceSlot = null;
            super.configUI();
            this.configButton(this.maintenanceBtn,MENU.HANGAR_AMMUNITIONPANEL_MAITENANCEBTN,RES_ICONS.MAPS_ICONS_BUTTONS_MAITENANCE,this.onMaintenanceBtnClickHandler);
            this.configButton(this.tuningBtn,MENU.HANGAR_AMMUNITIONPANEL_TUNINGBTN,RES_ICONS.MAPS_ICONS_BUTTONS_TUNING,this.onTuningBtnClickHandler);
            this.configButton(this.changeNationBtn,MENU.HANGAR_AMMUNITIONPANEL_NATIONCHANGEBTN,RES_ICONS.MAPS_ICONS_BUTTONS_NATION_CHANGE,this.onChangeNationBtnClickHandler);
            for each(_loc1_ in this._optionalDevices)
            {
                _loc1_.slotIndex = this._optionalDevices.indexOf(_loc1_);
                _loc1_.type = FITTING_TYPES.OPTIONAL_DEVICE;
                _loc1_.addEventListener(ButtonEvent.CLICK,this.onOptDeviceSlotClickHandler);
            }
            for each(_loc1_ in this._equipment)
            {
                _loc1_.type = FITTING_TYPES.EQUIPMENT;
                _loc1_.addEventListener(ButtonEvent.CLICK,this.onEquipmentSlotClickHandler);
            }
            for each(_loc2_ in this._shells)
            {
                _loc2_.mouseEnabledOnDisabled = true;
                _loc2_.addEventListener(ButtonEvent.CLICK,this.onShellSlotClickHandler);
                addToButtonGroup(_loc2_);
            }
            for each(_loc3_ in this._battleAbilities)
            {
                _loc3_.slotIndex = this._battleAbilities.indexOf(_loc3_);
                _loc3_.type = FITTING_TYPES.BATTLE_ABILITY;
                _loc3_.addEventListener(ButtonEvent.CLICK,this.onAbilitySlotClickHandler);
            }
            this.booster.type = FITTING_TYPES.BOOSTER;
            this.booster.addEventListener(ButtonEvent.CLICK,this.onBoosterSlotClickHandler);
            this.booster.addEventListener(ComponentEvent.SHOW,this.onBoosterVisibilityChanged);
            this.booster.addEventListener(ComponentEvent.HIDE,this.onBoosterVisibilityChanged);
            this.toRent.addEventListener(MouseEvent.ROLL_OVER,this.onBtnRollOverHandler);
            this.toRent.addEventListener(MouseEvent.ROLL_OUT,this.onBtnRollOutHandler);
            this.toRent.addEventListener(ButtonEvent.CLICK,this.onToRentClickHandler);
            this._utils.asserter.assert(this.width - this.lastElementFocusFix.x < this.lastElementFocusFix.width << 1,LAST_ELEMENT_FOCUS_FIX);
            addEventListener(AmmunitionPanelEvents.VEHICLE_STATE_MSG_RESIZE,this.onAmmunitionPanelVehicleStateMsgResizeHandler);
            this._utils.helpLayout.registerComponent(this);
            _deferredDispose = true;
        }

        override protected function updateVehicleStatus(param1:VehicleMessageVO) : void
        {
            this._msgVo = param1;
            invalidate(VEHICLE_STATUS_INVALID);
        }

        override protected function updateButtonsEnabled() : void
        {
            super.updateButtonsEnabled();
            this.maintenanceBtn.enabled = this._panelEnabled;
            setItemsEnabled(this._optionalDevices,this._panelEnabled);
            setItemsEnabled(this._equipment,this._panelEnabled);
            this.booster.enabled = this._panelEnabled;
            setItemsEnabled(this._battleAbilities,this._panelEnabled);
        }

        override protected function trySetupDevice(param1:DeviceSlotVO) : Boolean
        {
            if(super.trySetupDevice(param1))
            {
                return true;
            }
            if(FITTING_TYPES.OPTIONAL_DEVICE == param1.slotType)
            {
                this._optionalDevices[param1.slotIndex].update(param1);
                return true;
            }
            if(FITTING_TYPES.EQUIPMENT == param1.slotType)
            {
                this._equipment[param1.slotIndex].update(param1);
                return true;
            }
            if(FITTING_TYPES.BOOSTER == param1.slotType)
            {
                this.booster.update(param1);
                return true;
            }
            if(FITTING_TYPES.BATTLE_ABILITY == param1.slotType)
            {
                this._battleAbilities[param1.slotIndex].update(param1);
                return true;
            }
            return false;
        }

        override protected function setAmmo(param1:Vector.<ShellButtonVO>, param2:Boolean) : void
        {
            this._shellsData = param1;
            invalidate(INV_SHELL_BUTTONS);
            this._maintenanceStateWarning = param2;
            invalidate(INV_MAINTENANCE_STATE);
        }

        override protected function resetSelection() : void
        {
            var _loc1_:DeviceSlot = null;
            var _loc2_:BattleAbilitySlot = null;
            super.resetSelection();
            for each(_loc1_ in this._battleAbilities)
            {
                _loc2_ = _loc1_ as BattleAbilitySlot;
                if(_loc2_)
                {
                    _loc2_.isAvailable = false;
                }
            }
        }

        override protected function setData(param1:DevicesDataVO) : void
        {
            if(this.hasLoadingAnimations)
            {
                this._postponedData = param1;
            }
            else
            {
                super.setData(param1);
                this.invalidateBattleAbilities();
            }
        }

        public function as_setBoosterBtnCounter(param1:int) : void
        {
            if(this._boosterCounter != param1)
            {
                this._boosterCounter = param1;
                this.onBoosterCounterUpdate();
            }
        }

        public function as_setCustomizationBtnCounter(param1:int) : void
        {
            if(param1 > 0)
            {
                this._counterManager.setCounter(this.tuningBtn,param1.toString());
            }
            else
            {
                this._counterManager.removeCounter(this.tuningBtn);
            }
        }

        public function as_showAnimation(param1:String, param2:int, param3:String) : void
        {
            var _loc4_:DeviceSlot = null;
            var _loc5_:SlotAnimation = null;
            switch(param1)
            {
                case FITTING_TYPES.OPTIONAL_DEVICE:
                    _loc4_ = this._optionalDevices[param2];
                    break;
                case FITTING_TYPES.EQUIPMENT:
                    _loc4_ = this._equipment[param2];
                    break;
                case FITTING_TYPES.BOOSTER:
                    _loc4_ = this.booster;
                    break;
            }
            if(_loc4_ != null)
            {
                _loc5_ = this.createAnimation();
                _loc5_.setData(param3,this.getSlotBitmapData(_loc4_.slotData));
                _loc5_.x = _loc4_.x;
                _loc5_.y = _loc4_.y;
                this._animations.push(_loc5_);
            }
        }

        public function as_showBattleAbilitiesAlert(param1:Boolean) : void
        {
            this._showBattleAbilitiesHighlighter = param1;
            if(this._battleAbilitiesHighlighter != null)
            {
                this._battleAbilitiesHighlighter.visible = this._showBattleAbilitiesHighlighter && this._battleAbilitiesVisible && this._lastActiveAbility > Values.DEFAULT_INT;
            }
        }

        public function disposeSlots() : void
        {
            var _loc1_:IUIComponentEx = null;
            for each(_loc1_ in this._optionalDevices)
            {
                _loc1_.removeEventListener(ButtonEvent.CLICK,this.onOptDeviceSlotClickHandler);
            }
            for each(_loc1_ in this._equipment)
            {
                _loc1_.removeEventListener(ButtonEvent.CLICK,this.onEquipmentSlotClickHandler);
            }
            for each(_loc1_ in this._shells)
            {
                _loc1_.removeEventListener(ButtonEvent.CLICK,this.onShellSlotClickHandler);
                _loc1_.dispose();
            }
            for each(_loc1_ in this._battleAbilities)
            {
                _loc1_.removeEventListener(ButtonEvent.CLICK,this.onAbilitySlotClickHandler);
            }
            this.booster.removeEventListener(ButtonEvent.CLICK,this.onBoosterSlotClickHandler);
            this.booster.removeEventListener(ComponentEvent.SHOW,this.onBoosterVisibilityChanged);
            this.booster.removeEventListener(ComponentEvent.HIDE,this.onBoosterVisibilityChanged);
            this._optionalDevices.splice(0,this._optionalDevices.length);
            this._optionalDevices = null;
            this._equipment.splice(0,this._equipment.length);
            this._equipment = null;
            this._shells.splice(0,this._shells.length);
            this._shells = null;
            this._battleAbilities.splice(0,this._battleAbilities.length);
            this._battleAbilities = null;
            this.optionalDevice1 = null;
            this.optionalDevice2 = null;
            this.optionalDevice3 = null;
            this.equipment1 = null;
            this.equipment2 = null;
            this.equipment3 = null;
            this.shell1 = null;
            this.shell2 = null;
            this.shell3 = null;
            this.lastElementFocusFix.dispose();
            this.lastElementFocusFix = null;
            this.booster = null;
            this.battleAbility1 = null;
            this.battleAbility3 = null;
            this.battleAbility2 = null;
        }

        public function getComponentForFocus() : InteractiveObject
        {
            return this.toRent;
        }

        public function getLayoutProperties() : Vector.<HelpLayoutVO>
        {
            this.setHelpLayoutIds();
            var _loc1_:HelpLayoutVO = this.createHelpLayoutData(gun.x,gun.y,radio.x + radio.width - gun.x,gun.height,LOBBY_HELP.HANGAR_MODULES,this._modulesHelpLayoutId);
            var _loc2_:HelpLayoutVO = this.createHelpLayoutData(this.optionalDevice1.x,this.optionalDevice1.y,this.optionalDevice3.x + this.optionalDevice3.width - this.optionalDevice1.x,this.optionalDevice1.height,LOBBY_HELP.HANGAR_OPTIONAL_DEVICES,this._devicesHelpLayoutId);
            var _loc3_:HelpLayoutVO = this.createHelpLayoutData(this.shell1.x,this.shell1.y,this.shell3.x + this.shell3.width - this.shell1.x - SHELLS_VO_SIZE_CORRECTION,this.shell1.height - SHELLS_VO_SIZE_CORRECTION,LOBBY_HELP.HANGAR_SHELLS,this._shellsHelpLayoutId);
            var _loc4_:HelpLayoutVO = this.createHelpLayoutData(this.equipment1.x,this.equipment1.y,this.equipment3.x + this.equipment3.width - this.equipment1.x,this.equipment1.height,LOBBY_HELP.HANGAR_EQUIPMENT,this._equipmentHelpLayoutId);
            var _loc5_:HelpLayoutVO = this.createHelpLayoutData(this.booster.x,this.booster.y,this.booster.width,this.booster.height,LOBBY_HELP.HANGAR_BOOSTER,this._boosterHelpLayoutId);
            return new <HelpLayoutVO>[_loc1_,_loc2_,_loc3_,_loc4_,_loc5_];
        }

        public function setBattleAbilitiesVisibility(param1:Boolean) : void
        {
            this._battleAbilitiesVisible = param1;
            this.invalidateBattleAbilities();
        }

        public function updateAmmunitionPanel(param1:Boolean, param2:String) : void
        {
            this._panelEnabled = param1;
            this._maintenanceTooltip = param2;
            invalidateButtonsEnabled();
        }

        public function updateChangeNationButton(param1:Boolean, param2:Boolean, param3:String, param4:Boolean) : void
        {
            var _loc5_:* = this._changeNationBtnVisible != param1;
            this._changeNationBtnVisible = param1;
            this.changeNationBtn.visible = this._changeNationBtnVisible;
            this._changeNationBtnEnabled = param2;
            this._changeNationIsNew = param4;
            if(this._changeNationIsNew && this._changeNationBtnVisible)
            {
                this._counterManager.setCounter(this.changeNationBtn,"!",null,new CounterProps(3,-1));
            }
            else
            {
                this._counterManager.removeCounter(this.changeNationBtn);
            }
            if(App.waiting)
            {
                this.changeNationBtn.enabled = this._changeNationBtnEnabled && !App.waiting.isOnStage;
            }
            else
            {
                this.changeNationBtn.enabled = this._changeNationBtnEnabled;
            }
            this._changeNationTooltip = param3;
            if(_loc5_)
            {
                this.centerPanel();
            }
        }

        public function updateStage(param1:Number, param2:Number) : void
        {
            this.vehicleStateMsg.updateStage(param1,param2);
            this._screenWidth = param1;
            this.centerPanel();
        }

        public function updateTuningButton(param1:Boolean, param2:String) : void
        {
            this._tuningBtnEnabled = param1;
            this._tuningTooltip = param2;
            invalidate(INV_TUNING_BUTTON_STATE);
        }

        protected function getSlotBitmapData(param1:DeviceSlotVO) : BitmapData
        {
            this._animationEquipmentSlot.update(param1);
            this._animationEquipmentSlot.validateNow();
            if(this._animationEquipmentSlot.background != null)
            {
                this._animationEquipmentSlot.background.visible = false;
            }
            var _loc2_:BitmapData = new BitmapData(this._animationEquipmentSlot.width,this._animationEquipmentSlot.height,true,NaN);
            _loc2_.draw(this._animationEquipmentSlot);
            return _loc2_;
        }

        private function createBattleAbilitiesHighlighter() : void
        {
            this._battleAbilitiesHighlighter = App.utils.classFactory.getComponent(Linkages.BATTLE_ABILITIES_HIGHLIGHTER_UI,BattleAbilitiesHighlighter);
            this._battleAbilitiesHighlighter.name = BATTLE_ABILITIES_HIGHLIGHTER_NAME;
            this._battleAbilitiesHighlighter.mouseChildren = this._battleAbilitiesHighlighter.mouseEnabled = false;
            addChild(this._battleAbilitiesHighlighter);
            this.positionBattleAbilitiesHighlighter();
        }

        private function positionBattleAbilitiesHighlighter() : void
        {
            this._battleAbilitiesHighlighter.visible = false;
            this._battleAbilitiesHighlighter.x = this._highlighterLeftX;
            this._battleAbilitiesHighlighter.y = this._battleAbilities[0].y;
            this._battleAbilitiesHighlighter.width = this._highlighterRightX - this._highlighterLeftX;
            this._battleAbilitiesHighlighter.visible = this._showBattleAbilitiesHighlighter && this._battleAbilitiesVisible && this._lastActiveAbility > Values.DEFAULT_INT;
        }

        private function invalidateBattleAbilities() : void
        {
            var _loc1_:DeviceSlot = null;
            var _loc3_:BattleAbilitySlot = null;
            this._lastActiveAbility = Values.DEFAULT_INT;
            for each(_loc1_ in this._battleAbilities)
            {
                _loc3_ = _loc1_ as BattleAbilitySlot;
                if(_loc3_ && _loc3_.isAvailable)
                {
                    this._lastActiveAbility = this._lastActiveAbility + 1;
                    _loc1_.visible = this._battleAbilitiesVisible;
                    if(this._battleAbilitiesVisible)
                    {
                        if(this._highlighterLeftX == Values.DEFAULT_INT)
                        {
                            this._highlighterLeftX = _loc1_.x;
                        }
                        this._highlighterRightX = _loc1_.x + _loc1_.width;
                    }
                }
                else
                {
                    _loc1_.visible = false;
                }
            }
            if(this._lastActiveAbility > Values.DEFAULT_INT && this._battleAbilitiesVisible)
            {
                if(this._battleAbilitiesHighlighter == null)
                {
                    this._scheduler.scheduleTask(this.createBattleAbilitiesHighlighter,HIGHLIGHTER_CREATE_DELAY);
                }
                else
                {
                    this.positionBattleAbilitiesHighlighter();
                }
            }
            else if(this._battleAbilitiesHighlighter != null)
            {
                this._battleAbilitiesHighlighter.visible = false;
            }
            var _loc2_:* = -1;
            if(this._battleAbilitiesVisible && this._lastActiveAbility > -1)
            {
                _loc2_ = this._battleAbilities[this._lastActiveAbility].x + OFFSET_LAST_ELEMENT_FOCUS_FIX;
            }
            else
            {
                _loc2_ = this.booster.x + OFFSET_LAST_ELEMENT_FOCUS_FIX;
            }
            if(_loc2_ != this.lastElementFocusFix.x)
            {
                this.lastElementFocusFix.x = _loc2_;
                this._fakeWidth = this.lastElementFocusFix.x + this.lastElementFocusFix.width - OFFSET_LAST_ELEMENT_FOCUS_FIX >> 0;
                this.centerPanel();
            }
        }

        private function centerPanel() : void
        {
            var _loc2_:* = NaN;
            var _loc1_:Number = 2 * this._buttonWidth + INDENT_BETWEEN_BUTTONS;
            if(this._changeNationBtnVisible)
            {
                _loc1_ = _loc1_ + (this._buttonWidth + INDENT_BETWEEN_BUTTONS);
            }
            var _loc3_:Number = 0;
            if(this._battleAbilitiesVisible && this._screenWidth <= BREAKPOINT_SLOT_CENTERING)
            {
                this.x = OFFSET_MINRES_LEFT;
                _loc2_ = (this._screenWidth - this.vehicleStateMsg.width >> 1) - OFFSET_MINRES_LEFT;
                _loc3_ = (this._screenWidth - _loc1_ >> 1) - OFFSET_MINRES_LEFT;
            }
            else
            {
                this.x = this._screenWidth - this._fakeWidth >> 1;
                _loc2_ = this._fakeWidth - this.vehicleStateMsg.width >> 1;
                _loc3_ = this._fakeWidth - _loc1_ >> 1;
            }
            this.maintenanceBtn.x = _loc3_;
            this.tuningBtn.x = this.maintenanceBtn.x + this._buttonWidth + INDENT_BETWEEN_BUTTONS;
            this.changeNationBtn.x = this.tuningBtn.x + this._buttonWidth + INDENT_BETWEEN_BUTTONS;
            dispatchEvent(new Event(Event.RESIZE));
        }

        private function configButton(param1:IconTextButton, param2:String, param3:String, param4:Function) : void
        {
            param1.label = param2;
            param1.iconSource = param3;
            param1.textFieldPaddingHorizontal = 16;
            param1.dynamicSizeByText = true;
            param1.changeSizeOnlyUpwards = true;
            param1.addEventListener(ButtonEvent.CLICK,param4);
            param1.addEventListener(MouseEvent.ROLL_OVER,this.onBtnRollOverHandler);
            param1.addEventListener(MouseEvent.ROLL_OUT,this.onBtnRollOutHandler);
            param1.addEventListener(Event.RESIZE,this.onResizeHandler);
            param1.mouseEnabledOnDisabled = true;
        }

        private function setHelpLayoutIds() : void
        {
            if(this._modulesHelpLayoutId == Values.EMPTY_STR)
            {
                this._modulesHelpLayoutId = this.generateHelpLayoutId();
            }
            if(this._devicesHelpLayoutId == Values.EMPTY_STR)
            {
                this._devicesHelpLayoutId = this.generateHelpLayoutId();
            }
            if(this._shellsHelpLayoutId == Values.EMPTY_STR)
            {
                this._shellsHelpLayoutId = this.generateHelpLayoutId();
            }
            if(this._equipmentHelpLayoutId == Values.EMPTY_STR)
            {
                this._equipmentHelpLayoutId = this.generateHelpLayoutId();
            }
            if(this._boosterHelpLayoutId == Values.EMPTY_STR)
            {
                this._boosterHelpLayoutId = this.generateHelpLayoutId();
            }
        }

        private function createHelpLayoutData(param1:int, param2:int, param3:int, param4:int, param5:String, param6:String) : HelpLayoutVO
        {
            var _loc7_:HelpLayoutVO = new HelpLayoutVO();
            _loc7_.x = param1;
            _loc7_.y = param2;
            _loc7_.width = param3;
            _loc7_.height = param4;
            _loc7_.extensibilityDirection = Directions.RIGHT;
            _loc7_.message = param5;
            _loc7_.id = param6;
            _loc7_.scope = this;
            return _loc7_;
        }

        private function generateHelpLayoutId() : String
        {
            return name + HELP_LAYOUT_ID_DELIMITER + Math.random();
        }

        private function updateShellButtons() : void
        {
            var _loc3_:ShellButton = null;
            var _loc4_:ShellButtonVO = null;
            var _loc1_:uint = this._shells.length;
            var _loc2_:uint = this._shellsData.length;
            var _loc5_:* = 0;
            while(_loc5_ < _loc1_)
            {
                _loc3_ = this._shells[_loc5_];
                _loc3_.clear();
                _loc3_.enabled = false;
                if(_loc5_ < _loc2_)
                {
                    _loc4_ = this._shellsData[_loc5_];
                    _loc3_.enabled = this._panelEnabled;
                    _loc3_.id = _loc4_.id;
                    _loc3_.ammunitionType = _loc4_.type;
                    _loc3_.icon = _loc4_.icon;
                    _loc3_.count = String(_loc4_.count);
                    _loc3_.inventoryCount = _loc4_.inventoryCount;
                    _loc3_.label = _loc4_.label;
                    _loc3_.tooltip = _loc4_.tooltip;
                    _loc3_.tooltipType = _loc4_.tooltipType;
                }
                _loc5_++;
            }
        }

        private function setVehicleStatus() : void
        {
            this.vehicleStateMsg.setVehicleStatus(this._msgVo);
            if(this._msgVo.rentAvailable)
            {
                dispatchEvent(new FocusRequestEvent(FocusRequestEvent.REQUEST_FOCUS,this));
            }
        }

        private function onBoosterCounterUpdate() : void
        {
            var _loc1_:ICounterProps = null;
            if(this.booster.visible && this._boosterCounter > 0)
            {
                _loc1_ = new CounterProps(CounterProps.DEFAULT_OFFSET_X,0,TextFormatAlign.LEFT,true,Linkages.COUNTER_UI,CounterProps.DEFAULT_TF_PADDING,false);
                this._counterManager.setCounter(this.booster.hitMc,"1",null,_loc1_);
            }
            else
            {
                this._counterManager.removeCounter(this.booster.hitMc);
            }
        }

        private function createAnimation() : SlotAnimation
        {
            var _loc1_:SlotAnimation = new SlotAnimation();
            _loc1_.mouseChildren = _loc1_.mouseEnabled = false;
            _loc1_.addEventListener(SlotAnimation.ANIMATION_COMPLETE,this.animationCompleteHandler,false,0,true);
            _loc1_.addEventListener(IconLoaderEvent.ICON_LOADED,this.animationLoadedHandler,false,0,true);
            addChild(_loc1_);
            return _loc1_;
        }

        private function disposeAnimation(param1:SlotAnimation) : void
        {
            param1.removeEventListener(SlotAnimation.ANIMATION_COMPLETE,this.animationCompleteHandler);
            param1.removeEventListener(IconLoaderEvent.ICON_LOADED,this.animationLoadedHandler);
            removeChild(param1);
            param1.dispose();
        }

        override public function get width() : Number
        {
            return this._fakeWidth;
        }

        override protected function get modulesEnabled() : Boolean
        {
            return super.modulesEnabled && this._panelEnabled;
        }

        private function get hasLoadingAnimations() : Boolean
        {
            var _loc1_:int = this._animations.length;
            var _loc2_:* = 0;
            while(_loc2_ < _loc1_)
            {
                if(!this._animations[_loc2_].loaded)
                {
                    return true;
                }
                _loc2_++;
            }
            return false;
        }

        private function onAbilitySlotClickHandler(param1:ButtonEvent) : void
        {
            var _loc2_:BattleAbilitySlot = null;
            if(param1.buttonIdx == MouseEventEx.LEFT_BUTTON)
            {
                _loc2_ = param1.target as BattleAbilitySlot;
                if(_loc2_)
                {
                    showFittingPopover(DeviceSlot(param1.currentTarget));
                }
            }
        }

        private function onShellSlotClickHandler(param1:ButtonEvent) : void
        {
            this._toolTipMgr.hide();
            if(param1.buttonIdx == MouseEventEx.LEFT_BUTTON)
            {
                showTechnicalMaintenanceS();
            }
            else if(param1.buttonIdx == MouseEventEx.RIGHT_BUTTON)
            {
                showModuleInfoS(ShellButton(param1.currentTarget).id);
            }
        }

        private function onEquipmentSlotClickHandler(param1:ButtonEvent) : void
        {
            if(param1.buttonIdx == MouseEventEx.LEFT_BUTTON)
            {
                showTechnicalMaintenanceS();
            }
        }

        private function onBoosterSlotClickHandler(param1:ButtonEvent) : void
        {
            var _loc2_:DeviceSlot = null;
            var _loc3_:FittingSelectPopoverParams = null;
            if(param1.buttonIdx == MouseEventEx.LEFT_BUTTON)
            {
                _loc2_ = DeviceSlot(param1.currentTarget);
                _loc3_ = new FittingSelectPopoverParams(_loc2_.type,_loc2_.slotIndex);
                App.popoverMgr.show(_loc2_,Aliases.BOOSTER_SELECT_POPOVER,_loc3_);
            }
        }

        private function onBoosterVisibilityChanged(param1:Event) : void
        {
            this.onBoosterCounterUpdate();
        }

        private function onOptDeviceSlotClickHandler(param1:ButtonEvent) : void
        {
            if(param1.buttonIdx == MouseEventEx.LEFT_BUTTON)
            {
                showFittingPopover(DeviceSlot(param1.currentTarget));
            }
        }

        private function onAmmunitionPanelVehicleStateMsgResizeHandler(param1:AmmunitionPanelEvents) : void
        {
            this.vehicleStateMsg.x = (parent.width >> 1) - x;
            this.vehicleStateMsg.y = this.maintenanceBtn.y - this.vehicleStateMsg.height - VEHICLE_STATE_MSG_OFFSET;
            if(this._msgVo != null)
            {
                this.toRent.x = this.vehicleStateMsg.textX + TO_RENT_LEFT_MARGIN ^ 0;
                this.toRent.y = this.vehicleStateMsg.textY + OFFSET_BTN_TO_RENT ^ 0;
                this.toRent.visible = this._msgVo.rentAvailable;
            }
        }

        private function onMaintenanceBtnClickHandler(param1:ButtonEvent) : void
        {
            showTechnicalMaintenanceS();
        }

        private function onTuningBtnClickHandler(param1:ButtonEvent) : void
        {
            showCustomizationS();
        }

        private function onChangeNationBtnClickHandler(param1:ButtonEvent) : void
        {
            showChangeNationS();
        }

        private function onBtnRollOverHandler(param1:MouseEvent) : void
        {
            var _loc2_:String = null;
            var _loc3_:ITooltipFormatter = null;
            if(param1.target == this.toRent)
            {
                _loc3_ = this._toolTipMgr.getNewFormatter();
                _loc3_.addBody(TOOLTIPS.HANGAR_STATUS_TORENT,true);
                _loc2_ = _loc3_.make();
            }
            else if(param1.target == this.maintenanceBtn)
            {
                _loc2_ = this._maintenanceTooltip;
            }
            else if(param1.target == this.tuningBtn)
            {
                _loc2_ = this._tuningTooltip;
            }
            else if(param1.target == this.changeNationBtn)
            {
                _loc2_ = this._changeNationTooltip;
            }
            this._toolTipMgr.showComplex(_loc2_);
        }

        private function onBtnRollOutHandler(param1:MouseEvent) : void
        {
            this._toolTipMgr.hide();
        }

        private function onToRentClickHandler(param1:ButtonEvent) : void
        {
            if(this._msgVo.rentAvailable)
            {
                toRentContinueS();
            }
        }

        private function onChildShownHandler(param1:ChildVisibilityEvent) : void
        {
            if(this.tuningBtn)
            {
                this.tuningBtn.enabled = false;
            }
        }

        private function onChildHiddenHandler(param1:ChildVisibilityEvent) : void
        {
            this.updateTuningButton(this._tuningBtnEnabled,this._tuningTooltip);
            this.updateChangeNationButton(this._changeNationBtnVisible,this._changeNationBtnEnabled,this._changeNationTooltip,this._changeNationIsNew);
        }

        private function onResizeHandler(param1:Event) : void
        {
            var _loc2_:IconTextButton = null;
            var _loc3_:* = 0;
            if(param1.currentTarget.width > this._buttonWidth)
            {
                this._buttonWidth = param1.currentTarget.width;
                _loc3_ = 0;
                while(_loc3_ < this._buttonsList.length)
                {
                    _loc2_ = this._buttonsList[_loc3_];
                    if(_loc2_.width != this._buttonWidth)
                    {
                        _loc2_.setSize(this._buttonWidth,_loc2_.height);
                    }
                    _loc3_++;
                }
                this.centerPanel();
            }
        }

        private function animationCompleteHandler(param1:Event) : void
        {
            /*
            var _loc2_:int = this._animations.indexOf(param1.currentTarget);
            if(_loc2_ != -1)
            {
                this.disposeAnimation(this._animations[_loc2_]);
                this._animations.splice(_loc2_,1);
            }
            */
        }

        private function animationLoadedHandler(param1:IconLoaderEvent) : void
        {
            var _loc2_:DevicesDataVO = null;
            if(!this.hasLoadingAnimations && this._postponedData != null)
            {
                _loc2_ = this._postponedData;
                this._postponedData = null;
                this.setData(_loc2_);
            }
        }
    }
}
