package net.wg.gui.lobby.hangar.ammunitionPanel
{
    import net.wg.infrastructure.base.meta.impl.AmmunitionPanelMeta;
    import net.wg.infrastructure.interfaces.IHelpLayoutComponent;
    import net.wg.infrastructure.base.meta.IAmmunitionPanelMeta;
    import net.wg.utils.IEventCollector;
    import flash.text.TextField;
    import net.wg.gui.components.controls.IconTextButton;
    import net.wg.gui.components.advanced.ShellButton;
    import flash.display.DisplayObject;
    import net.wg.utils.IHelpLayout;
    import net.wg.data.constants.Directions;
    import net.wg.gui.events.ModuleInfoEvent;
    import net.wg.gui.events.DeviceEvent;
    import net.wg.gui.events.ParamsEvent;
    import scaleform.clik.events.ButtonEvent;
    import flash.events.MouseEvent;
    import net.wg.data.constants.FittingTypes;
    import scaleform.clik.events.InputEvent;
    import scaleform.clik.ui.InputDetails;
    import scaleform.clik.constants.NavigationCode;
    import scaleform.clik.constants.InputValue;
    import scaleform.gfx.MouseEventEx;
    import flash.text.TextFormat;
    
    public class AmmunitionPanel extends AmmunitionPanelMeta implements IHelpLayoutComponent, IAmmunitionPanelMeta
    {
        
        public function AmmunitionPanel()
        {
            this.events = App.utils.events;
            super();
        }
        
        private static var SHELLS_COUNT:int = 3;
        
        private static var YELLOW_COLOR:uint = 13814699;
        
        private static var RED_COLOR:uint = 10158594;
        
        private static var GREEN_COLOR:uint = 4813330;
        
        private var events:IEventCollector;
        
        public var vehicleStateMsg:TextField;
        
        public var maitenanceBtn:IconTextButton;
        
        public var tuningBtn:IconTextButton;
        
        public var gun:ModuleSlot;
        
        public var turret:ModuleSlot;
        
        public var engine:ModuleSlot;
        
        public var chassis:ModuleSlot;
        
        public var radio:ModuleSlot;
        
        public var optionalDevice1:EquipmentSlot;
        
        public var optionalDevice2:EquipmentSlot;
        
        public var optionalDevice3:EquipmentSlot;
        
        public var equipment1:EquipmentSlot;
        
        public var equipment2:EquipmentSlot;
        
        public var equipment3:EquipmentSlot;
        
        public var shell1:ShellButton;
        
        public var shell2:ShellButton;
        
        public var shell3:ShellButton;
        
        public var historicalOverlay:HistoricalModulesOverlay;
        
        private var _modulesHL:DisplayObject;
        
        private var _devicesHL:DisplayObject;
        
        private var _hasTurret:Boolean;
        
        private var _inHistoricalMode:Boolean = false;
        
        private var _panelEnabled:Boolean = true;
        
        private var storeData:Object;
        
        public function showHelpLayout() : void
        {
            var _loc1_:IHelpLayout = App.utils.helpLayout;
            var _loc2_:Number = this.radio.x + this.radio.width - this.gun.x;
            var _loc3_:Object = _loc1_.getProps(_loc2_,this.gun.height,Directions.TOP,LOBBY_HELP.HANGAR_MODULES,this.gun.x,this.gun.y);
            this._modulesHL = _loc1_.create(root,_loc3_,this);
            _loc2_ = this.optionalDevice3.x + this.optionalDevice3.width - this.optionalDevice1.x;
            _loc3_ = _loc1_.getProps(_loc2_,this.optionalDevice1.height,Directions.BOTTOM,LOBBY_HELP.HANGAR_OPTIONAL_DEVICES,this.optionalDevice1.x,this.optionalDevice1.y);
            this._devicesHL = _loc1_.create(root,_loc3_,this);
            this.maitenanceBtn.showHelpLayout();
            this.tuningBtn.showHelpLayout();
        }
        
        public function closeHelpLayout() : void
        {
            var _loc1_:IHelpLayout = App.utils.helpLayout;
            _loc1_.destroy(this._modulesHL);
            _loc1_.destroy(this._devicesHL);
            this.maitenanceBtn.closeHelpLayout();
            this.tuningBtn.closeHelpLayout();
        }
        
        public function disableAmmunitionPanel(param1:Boolean) : void
        {
            this._panelEnabled = !param1;
            this.maitenanceBtn.enabled = !param1;
            if(this.storeData)
            {
                this.as_setAmmo(this.storeData);
            }
            var _loc2_:Array = [this.gun,this.turret,this.engine,this.chassis,this.radio,this.optionalDevice1,this.optionalDevice2,this.optionalDevice3,this.equipment1,this.equipment2,this.equipment3];
            this.setItemsEnabled(_loc2_,!param1);
        }
        
        public function disableTuningButton(param1:Boolean) : void
        {
            this.tuningBtn.enabled = !param1;
        }
        
        public function updateStage(param1:Number, param2:Number) : void
        {
            var _loc3_:DeviceSlot = null;
            var _loc4_:Array = [this.gun,this.turret,this.engine,this.chassis,this.radio,this.optionalDevice1,this.optionalDevice2,this.optionalDevice3];
            for each(_loc3_ in _loc4_)
            {
                _loc3_.updateStage(param1,param2);
            }
        }
        
        override protected function onDispose() : void
        {
            var _loc1_:DeviceSlot = null;
            var _loc2_:ShellButton = null;
            super.onDispose();
            if(this.storeData)
            {
                this.storeData = null;
            }
            this.events.removeEvent(App.stage,ModuleInfoEvent.SHOW_INFO,this.onShowModuleInfo);
            this.events.removeEvent(App.stage,DeviceEvent.DEVICE_REMOVE,this.onDeviceRemove);
            this.events.removeEvent(this,ParamsEvent.HIGHLIGHT_PARAMS,this.onHighlightParams);
            this.events.removeEvent(this.maitenanceBtn,ButtonEvent.CLICK,this.onMaintenanceClick);
            this.events.removeEvent(this.maitenanceBtn,MouseEvent.ROLL_OVER,this.showTooltip);
            this.events.removeEvent(this.maitenanceBtn,MouseEvent.ROLL_OUT,this.hideTooltip);
            this.events.removeEvent(this.tuningBtn,ButtonEvent.CLICK,this.onCustomizationClick);
            this.events.removeEvent(this.tuningBtn,MouseEvent.ROLL_OVER,this.showTooltip);
            this.events.removeEvent(this.tuningBtn,MouseEvent.ROLL_OUT,this.hideTooltip);
            var _loc3_:Array = [this.gun,this.turret,this.chassis,this.engine,this.radio,this.optionalDevice1,this.optionalDevice2,this.optionalDevice3,this.equipment1,this.equipment2,this.equipment3];
            for each(_loc1_ in _loc3_)
            {
                this.unsubscribeSlot(_loc1_);
                _loc1_.dispose();
            }
            _loc3_ = [this.shell1,this.shell2,this.shell3];
            for each(_loc2_ in _loc3_)
            {
                this.events.removeEvent(_loc2_,ButtonEvent.CLICK,this.onModuleClick);
                _loc2_.dispose();
            }
            this.events = null;
            this.historicalOverlay.dispose();
            this.historicalOverlay = null;
        }
        
        public function as_setData(param1:Array, param2:String) : void
        {
            var data:Array = param1;
            var type:String = param2;
            try
            {
                switch(type)
                {
                    case FittingTypes.VEHICLE_CHASSIS:
                        this.chassis.setValues(data);
                        break;
                    case FittingTypes.VEHICLE_TURRET:
                        this.turret.setValues(data);
                        break;
                    case FittingTypes.VEHICLE_GUN:
                        this.gun.setValues(data);
                        break;
                    case FittingTypes.VEHICLE_ENGINE:
                        this.engine.setValues(data);
                        break;
                    case FittingTypes.VEHICLE_RADIO:
                        this.radio.setValues(data);
                        break;
                    case FittingTypes.OPTIONAL_DEVICE:
                        this.optionalDevice1.setValues(data[0]);
                        this.optionalDevice2.setValues(data[1]);
                        this.optionalDevice3.setValues(data[2]);
                        break;
                    case FittingTypes.EQUIPMENT:
                        this.equipment1.setValues(data[0]);
                        this.equipment2.setValues(data[1]);
                        this.equipment3.setValues(data[2]);
                        break;
                }
            }
            catch(e:Error)
            {
                DebugUtils.LOG_ERROR("AmmunitionPanel.as_setData error",e.getStackTrace());
            }
        }
        
        public function as_setAmmo(param1:Object) : void
        {
            var loaded:int = 0;
            var shell:ShellButton = null;
            var i:int = 0;
            var shellsCount:int = 0;
            var shells:Array = null;
            var data:Object = param1;
            this.storeData = data;
            try
            {
                this.__setVehicleStatus(data.stateMsg,this.__stateLevelToColor(data.stateLevel));
                loaded = 0;
                i = 0;
                shellsCount = data.shells.length;
                shells = [this.shell1,this.shell2,this.shell3];
                i = 0;
                while(i < SHELLS_COUNT)
                {
                    shell = shells[i] as ShellButton;
                    App.toolTipMgr.hide();
                    shell.clear();
                    shell.enabled = false;
                    if(shells.indexOf(shell) < shellsCount)
                    {
                        shell.enabled = this._panelEnabled;
                        shell.id = data.shells[i].id;
                        shell.ammunitionType = data.shells[i].type;
                        shell.ammunitionIcon = data.shells[i].icon;
                        shell.count = data.shells[i].count;
                        shell.inventoryCount = data.shells[i].inventoryCount;
                        shell.label = data.shells[i].label;
                        shell.historicalBattleID = data.shells[i].historicalBattleID;
                        loaded = loaded + int(data.shells[i].count);
                    }
                    i++;
                }
                this.maitenanceBtn.alertMC.visible = data.stateWarning > 0;
            }
            catch(e:Error)
            {
                DebugUtils.LOG_ERROR("AmmunitionPanel.as_setAmmo error",e.getStackTrace());
            }
        }
        
        public function as_setVehicleHasTurret(param1:Boolean) : void
        {
            this._hasTurret = param1;
            this.turret.enabled = (this._hasTurret) && (this._panelEnabled);
        }
        
        public function as_setHistoricalBattle(param1:Number) : void
        {
            this._inHistoricalMode = !(param1 == -1);
            this.historicalOverlay.historicalBattleID = param1;
            this.historicalOverlay.visible = this._inHistoricalMode;
        }
        
        public function as_setModulesEnabled(param1:Boolean) : void
        {
            var _loc2_:Array = [this.gun,this.turret,this.engine,this.chassis,this.radio];
            this.setItemsEnabled(_loc2_,(param1) && (this._panelEnabled));
        }
        
        public function setVehicleStatus(param1:String, param2:String) : void
        {
            var param1:String = App.utils.locale.makeString(param1);
            if((initialized) && param1.length > 0)
            {
                this.__setVehicleStatus(param1,this.__stateLevelToColor(param2));
            }
        }
        
        override protected function configUI() : void
        {
            var _loc1_:DeviceSlot = null;
            var _loc2_:ShellButton = null;
            super.configUI();
            this.vehicleStateMsg.mouseEnabled = false;
            this.historicalOverlay.visible = this._inHistoricalMode;
            this.events.addEvent(this,ParamsEvent.HIGHLIGHT_PARAMS,this.onHighlightParams);
            this.events.addEvent(this.maitenanceBtn,ButtonEvent.CLICK,this.onMaintenanceClick);
            this.events.addEvent(this.maitenanceBtn,MouseEvent.ROLL_OVER,this.showTooltip);
            this.events.addEvent(this.maitenanceBtn,MouseEvent.ROLL_OUT,this.hideTooltip);
            this.events.addEvent(this.tuningBtn,ButtonEvent.CLICK,this.onCustomizationClick);
            this.events.addEvent(this.tuningBtn,MouseEvent.ROLL_OVER,this.showTooltip);
            this.events.addEvent(this.tuningBtn,MouseEvent.ROLL_OUT,this.hideTooltip);
            var _loc3_:Array = [this.gun,this.turret,this.chassis,this.engine,this.radio];
            for each(_loc1_ in _loc3_)
            {
                this.subscribeSlot(_loc1_);
                _loc1_.type = FittingTypes.MANDATORY_SLOTS[_loc3_.indexOf(_loc1_)];
            }
            _loc3_ = [this.optionalDevice1,this.optionalDevice2,this.optionalDevice3];
            for each(_loc1_ in _loc3_)
            {
                _loc1_.slotIndex = _loc3_.indexOf(_loc1_);
                _loc1_.type = FittingTypes.OPTIONAL_DEVICE;
                this.subscribeSlot(_loc1_);
            }
            _loc3_ = [this.equipment1,this.equipment2,this.equipment3];
            for each(_loc1_ in _loc3_)
            {
                _loc1_.type = FittingTypes.EQUIPMENT;
                this.subscribeSlot(_loc1_);
            }
            _loc3_ = [this.shell1,this.shell2,this.shell3];
            for each(_loc2_ in _loc3_)
            {
                this.events.addEvent(_loc2_,ButtonEvent.CLICK,this.onModuleClick);
                this.events.addEvent(_loc2_,InputEvent.INPUT,this.handleInputTest);
            }
            this.events.addEvent(App.stage,ModuleInfoEvent.SHOW_INFO,this.onShowModuleInfo);
            this.events.addEvent(App.stage,DeviceEvent.DEVICE_REMOVE,this.onDeviceRemove);
        }
        
        private function handleInputTest(param1:InputEvent) : void
        {
            var _loc2_:InputDetails = param1.details;
            if(_loc2_.navEquivalent == NavigationCode.ENTER)
            {
                if(_loc2_.value == InputValue.KEY_DOWN)
                {
                    showTechnicalMaintenanceS();
                    param1.handled = true;
                }
            }
        }
        
        private function subscribeSlot(param1:DeviceSlot) : void
        {
            this.events.addEvent(param1,ButtonEvent.CLICK,this.onModuleClick);
            this.events.addEvent(param1,DeviceEvent.DEVICE_CHANGE,this.onDeviceChange);
            if(param1.type == FittingTypes.EQUIPMENT)
            {
                this.events.addEvent(param1,InputEvent.INPUT,this.handleInputTest);
            }
        }
        
        private function unsubscribeSlot(param1:DeviceSlot) : void
        {
            this.events.removeEvent(param1,ButtonEvent.CLICK,this.onModuleClick);
            this.events.removeEvent(param1,DeviceEvent.DEVICE_CHANGE,this.onDeviceChange);
            if(param1.type == FittingTypes.EQUIPMENT)
            {
                this.events.removeEvent(param1,InputEvent.INPUT,this.handleInputTest);
            }
        }
        
        private function onDeviceChange(param1:DeviceEvent) : void
        {
            var _loc2_:String = param1.oldDevice?param1.oldDevice.id:null;
            setVehicleModuleS(param1.newDevice.id,(param1.target as DeviceSlot).slotIndex,_loc2_,false);
        }
        
        private function onDeviceRemove(param1:DeviceEvent) : void
        {
            var _loc2_:String = param1.useGold?param1.oldDevice.id:null;
            setVehicleModuleS(param1.newDevice.id,param1.newDevice.slotIndex,_loc2_,true);
        }
        
        public function onModuleClick(param1:ButtonEvent) : void
        {
            var _loc2_:Array = null;
            var _loc3_:* = 0;
            App.toolTipMgr.hide();
            if(param1.buttonIdx == MouseEventEx.RIGHT_BUTTON)
            {
                if(param1.currentTarget.id)
                {
                    showModuleInfoS(param1.currentTarget.id);
                }
            }
            else if(param1.buttonIdx == MouseEventEx.LEFT_BUTTON && !([this.shell1,this.shell2,this.shell3,this.equipment1,this.equipment2,this.equipment3].indexOf(param1.currentTarget) == -1))
            {
                _loc2_ = [this.equipment1,this.equipment2,this.equipment3];
                _loc3_ = _loc2_.indexOf(param1.currentTarget);
                if(_loc3_ != -1)
                {
                    EquipmentSlot(_loc2_[_loc3_]).select.selected = false;
                }
                showTechnicalMaintenanceS();
            }
            
        }
        
        private function onShowModuleInfo(param1:ModuleInfoEvent) : void
        {
            showModuleInfoS(param1.id);
        }
        
        private function onMaintenanceClick(param1:ButtonEvent) : void
        {
            showTechnicalMaintenanceS();
        }
        
        private function onHighlightParams(param1:ParamsEvent) : void
        {
            if([this.gun,this.turret,this.engine,this.chassis,this.radio].indexOf(param1.target) > -1)
            {
                highlightParamsS(param1.paramsType);
            }
        }
        
        private function onCustomizationClick(param1:ButtonEvent) : void
        {
            showCustomizationS();
        }
        
        private function showTooltip(param1:MouseEvent) : void
        {
            var _loc2_:String = null;
            if(param1.target == this.maitenanceBtn)
            {
                _loc2_ = TOOLTIPS.HANGAR_MAINTENANCE;
            }
            else if(param1.target == this.tuningBtn)
            {
                _loc2_ = TOOLTIPS.HANGAR_TUNING;
            }
            
            App.toolTipMgr.showComplex(_loc2_);
        }
        
        private function hideTooltip(param1:MouseEvent) : void
        {
            App.toolTipMgr.hide();
        }
        
        private function __setVehicleStatus(param1:String, param2:uint) : void
        {
            var _loc3_:TextFormat = null;
            if(this.vehicleStateMsg)
            {
                this.vehicleStateMsg.text = param1;
                _loc3_ = this.vehicleStateMsg.getTextFormat();
                _loc3_.color = param2;
                this.vehicleStateMsg.setTextFormat(_loc3_);
                this.vehicleStateMsg.width = this.vehicleStateMsg.textWidth;
                this.vehicleStateMsg.x = (width - this.vehicleStateMsg.width) / 2;
            }
        }
        
        private function __stateLevelToColor(param1:String) : uint
        {
            switch(param1)
            {
                case "info":
                    return GREEN_COLOR;
                case "warning":
                    return YELLOW_COLOR;
                case "critical":
                    return RED_COLOR;
                default:
                    return GREEN_COLOR;
            }
        }
        
        public function setItemsEnabled(param1:Array, param2:Boolean) : void
        {
            var _loc3_:DeviceSlot = null;
            for each(_loc3_ in param1)
            {
                if(_loc3_ != this.turret)
                {
                    _loc3_.enabled = param2;
                }
                else
                {
                    _loc3_.enabled = (param2) && (this._hasTurret);
                }
            }
        }
    }
}
