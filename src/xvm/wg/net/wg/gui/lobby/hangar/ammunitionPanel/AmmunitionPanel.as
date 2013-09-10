package net.wg.gui.lobby.hangar.ammunitionPanel
{
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;
    import net.wg.data.constants.*;
    import net.wg.gui.components.advanced.*;
    import net.wg.gui.components.controls.*;
    import net.wg.gui.events.*;
    import net.wg.infrastructure.base.meta.*;
    import net.wg.infrastructure.base.meta.impl.*;
    import net.wg.infrastructure.interfaces.*;
    import net.wg.utils.*;
    import scaleform.clik.events.*;
    import scaleform.gfx.*;

    public class AmmunitionPanel extends net.wg.infrastructure.base.meta.impl.AmmunitionPanelMeta implements net.wg.infrastructure.interfaces.IHelpLayoutComponent, net.wg.infrastructure.base.meta.IAmmunitionPanelMeta
    {
        public function AmmunitionPanel()
        {
            this.events = App.utils.events;
            super();
            return;
        }

        internal function hideTooltip(arg1:flash.events.MouseEvent):void
        {
            App.toolTipMgr.hide();
            return;
        }

        public function updateStage(arg1:Number, arg2:Number):void
        {
            var loc1:*=null;
            var loc2:*=[this.gun, this.turret, this.engine, this.chassis, this.radio, this.optionalDevice1, this.optionalDevice2, this.optionalDevice3];
            var loc3:*=0;
            var loc4:*=loc2;
            for each (loc1 in loc4)
                loc1.updateStage(arg1, arg2);
            return;
        }

        protected override function onDispose():void
        {
            var loc1:*=null;
            var loc2:*=null;
            super.onDispose();
            this.events.removeEvent(App.stage, net.wg.gui.events.ModuleInfoEvent.SHOW_INFO, this.onShowModuleInfo);
            this.events.removeEvent(App.stage, net.wg.gui.events.DeviceEvent.DEVICE_REMOVE, this.onDeviceRemove);
            this.events.removeEvent(this, net.wg.gui.events.ParamsEvent.HIGHLIGHT_PARAMS, this.onHighlightParams);
            this.events.removeEvent(this.maitenanceBtn, scaleform.clik.events.ButtonEvent.CLICK, this.onMaintenanceClick);
            this.events.removeEvent(this.maitenanceBtn, flash.events.MouseEvent.ROLL_OVER, this.showTooltip);
            this.events.removeEvent(this.maitenanceBtn, flash.events.MouseEvent.ROLL_OUT, this.hideTooltip);
            this.events.removeEvent(this.tuningBtn, scaleform.clik.events.ButtonEvent.CLICK, this.onCustomizationClick);
            this.events.removeEvent(this.tuningBtn, flash.events.MouseEvent.ROLL_OVER, this.showTooltip);
            this.events.removeEvent(this.tuningBtn, flash.events.MouseEvent.ROLL_OUT, this.hideTooltip);
            var loc3:*=[this.gun, this.turret, this.chassis, this.engine, this.radio, this.optionalDevice1, this.optionalDevice2, this.optionalDevice3, this.equipment1, this.equipment2, this.equipment3];
            var loc4:*=0;
            var loc5:*=loc3;
            for each (loc1 in loc5)
            {
                this.unsubscribeSlot(loc1);
                loc1.dispose();
            }
            loc3 = [this.shell1, this.shell2, this.shell3];
            loc4 = 0;
            loc5 = loc3;
            for each (loc2 in loc5)
            {
                this.events.removeEvent(loc2, flash.events.MouseEvent.CLICK, this.onModuleClick);
                loc2.dispose();
            }
            this.events = null;
            return;
        }

        public function as_setData(arg1:Array, arg2:String):void
        {
            var data:Array;
            var type:String;

            var loc1:*;
            data = arg1;
            type = arg2;
            try
            {
                var loc2:* = type;
                switch (loc2)
                {
                    case net.wg.data.constants.FittingTypes.VEHICLE_CHASSIS:
                        this.chassis.setValues(data);
                        break;
                    case net.wg.data.constants.FittingTypes.VEHICLE_TURRET:
                        this.turret.setValues(data);
                        break;
                    case net.wg.data.constants.FittingTypes.VEHICLE_GUN:
                        this.gun.setValues(data);
                        break;
                    case net.wg.data.constants.FittingTypes.VEHICLE_ENGINE:
                        this.engine.setValues(data);
                        break;
                    case net.wg.data.constants.FittingTypes.VEHICLE_RADIO:
                        this.radio.setValues(data);
                        break;
                    case net.wg.data.constants.FittingTypes.OPTIONAL_DEVICE:
                        this.optionalDevice1.setValues(data[0]);
                        this.optionalDevice2.setValues(data[1]);
                        this.optionalDevice3.setValues(data[2]);
                        break;
                    case net.wg.data.constants.FittingTypes.EQUIPMENT:
                        this.equipment1.setValues(data[0]);
                        this.equipment2.setValues(data[1]);
                        this.equipment3.setValues(data[2]);
                        break;
                }
            }
            catch (e:Error)
            {
                DebugUtils.LOG_ERROR("AmmunitionPanel.as_setData error", e.getStackTrace());
            }
            return;
        }

        public function as_setAmmo(arg1:Object):void
        {
            var data:Object;
            var loaded:int;
            var shell:net.wg.gui.components.advanced.ShellButton;
            var i:int;
            var shellsCount:int;
            var shells:Array;
            var isFlashBtn:Boolean;

            var loc1:*;
            loaded = 0;
            shell = null;
            i = 0;
            shellsCount = 0;
            shells = null;
            isFlashBtn = false;
            data = arg1;
            try
            {
                this.__setVehicleStatus(data.stateMsg, this.__stateLevelToColor(data.stateLevel));
                loaded = 0;
                i = 0;
                shellsCount = data.shells.length;
                shells = [this.shell1, this.shell2, this.shell3];
                i = 0;
                while (i < SHELLS_COUNT)
                {
                    shell = shells[i] as net.wg.gui.components.advanced.ShellButton;
                    shell.onOut(null);
                    shell.clear();
                    shell.enabled = false;
                    if (shells.indexOf(shell) < shellsCount)
                    {
                        shell.enabled = !data.vehicleLocked;
                        shell.id = data.shells[i].id;
                        shell.shellType = data.shells[i].type;
                        shell.shellIcon = data.shells[i].icon;
                        shell.count = data.shells[i].count;
                        shell.inventoryCount = data.shells[i].inventoryCount;
                        shell.label = data.shells[i].label;
                        loaded = loaded + int(data.shells[i].count);
                    }
                    ++i;
                }
                isFlashBtn = (!(data.stateMsg == MENU.CURRENTVEHICLESTATUS_UNDAMAGED) && !(data.stateMsg == MENU.CURRENTVEHICLESTATUS_CREWNOTFULL) || loaded < data.maxAmmo * 0.2) && this.maitenanceBtn.enabled;
                this.maitenanceBtn.alertMC.visible = isFlashBtn;
            }
            catch (e:Error)
            {
                DebugUtils.LOG_ERROR("AmmunitionPanel.as_setAmmo error", e.getStackTrace());
            }
            return;
        }

        public function setVehicleStatus(arg1:String, arg2:String):void
        {
            arg1 = App.utils.locale.makeString(arg1);
            if (initialized && arg1.length > 0)
                this.__setVehicleStatus(arg1, this.__stateLevelToColor(arg2));
            return;
        }

        public function as_setVehicleHasTurret(arg1:Boolean):void
        {
            this._hasTurret = arg1;
            this.turret.enabled = arg1;
            return;
        }

        protected override function configUI():void
        {
            var loc1:*=null;
            var loc2:*=null;
            super.configUI();
            this.vehicleStateMsg.mouseEnabled = false;
            this.events.addEvent(this, net.wg.gui.events.ParamsEvent.HIGHLIGHT_PARAMS, this.onHighlightParams);
            this.events.addEvent(this.maitenanceBtn, scaleform.clik.events.ButtonEvent.CLICK, this.onMaintenanceClick);
            this.events.addEvent(this.maitenanceBtn, flash.events.MouseEvent.ROLL_OVER, this.showTooltip);
            this.events.addEvent(this.maitenanceBtn, flash.events.MouseEvent.ROLL_OUT, this.hideTooltip);
            this.events.addEvent(this.tuningBtn, scaleform.clik.events.ButtonEvent.CLICK, this.onCustomizationClick);
            this.events.addEvent(this.tuningBtn, flash.events.MouseEvent.ROLL_OVER, this.showTooltip);
            this.events.addEvent(this.tuningBtn, flash.events.MouseEvent.ROLL_OUT, this.hideTooltip);
            var loc3:*=[this.gun, this.turret, this.chassis, this.engine, this.radio];
            var loc4:*=0;
            var loc5:*=loc3;
            for each (loc1 in loc5)
            {
                this.subscribeSlot(loc1);
                loc1.type = net.wg.data.constants.FittingTypes.MANDATORY_SLOTS[loc3.indexOf(loc1)];
            }
            loc3 = [this.optionalDevice1, this.optionalDevice2, this.optionalDevice3];
            loc4 = 0;
            loc5 = loc3;
            for each (loc1 in loc5)
            {
                loc1.slotIndex = loc3.indexOf(loc1);
                loc1.type = net.wg.data.constants.FittingTypes.OPTIONAL_DEVICE;
                this.subscribeSlot(loc1);
            }
            loc3 = [this.equipment1, this.equipment2, this.equipment3];
            loc4 = 0;
            loc5 = loc3;
            for each (loc1 in loc5)
            {
                loc1.type = net.wg.data.constants.FittingTypes.EQUIPMENT;
                this.subscribeSlot(loc1);
            }
            loc3 = [this.shell1, this.shell2, this.shell3];
            loc4 = 0;
            loc5 = loc3;
            for each (loc2 in loc5)
                this.events.addEvent(loc2, flash.events.MouseEvent.CLICK, this.onModuleClick);
            this.events.addEvent(App.stage, net.wg.gui.events.ModuleInfoEvent.SHOW_INFO, this.onShowModuleInfo);
            this.events.addEvent(App.stage, net.wg.gui.events.DeviceEvent.DEVICE_REMOVE, this.onDeviceRemove);
            return;
        }

        internal function subscribeSlot(arg1:net.wg.gui.lobby.hangar.ammunitionPanel.DeviceSlot):void
        {
            this.events.addEvent(arg1, flash.events.MouseEvent.CLICK, this.onModuleClick);
            this.events.addEvent(arg1, net.wg.gui.events.DeviceEvent.DEVICE_CHANGE, this.onDeviceChange);
            return;
        }

        internal function unsubscribeSlot(arg1:net.wg.gui.lobby.hangar.ammunitionPanel.DeviceSlot):void
        {
            this.events.removeEvent(arg1, flash.events.MouseEvent.CLICK, this.onModuleClick);
            this.events.removeEvent(arg1, net.wg.gui.events.DeviceEvent.DEVICE_CHANGE, this.onDeviceChange);
            return;
        }

        internal function onDeviceChange(arg1:net.wg.gui.events.DeviceEvent):void
        {
            var loc1:*=arg1.oldDevice ? arg1.oldDevice.id : null;
            setVehicleModuleS(arg1.newDevice.id, (arg1.target as net.wg.gui.lobby.hangar.ammunitionPanel.DeviceSlot).slotIndex, loc1, false);
            return;
        }

        internal function onDeviceRemove(arg1:net.wg.gui.events.DeviceEvent):void
        {
            var loc1:*=arg1.useGold ? arg1.oldDevice.id : null;
            setVehicleModuleS(arg1.newDevice.id, arg1.newDevice.slotIndex, loc1, true);
            return;
        }

        public function onModuleClick(arg1:flash.events.MouseEvent):void
        {
            var loc1:*=null;
            App.toolTipMgr.hide();
            if (arg1 is scaleform.gfx.MouseEventEx)
            {
                loc1 = arg1 as scaleform.gfx.MouseEventEx;
                if (loc1.buttonIdx != scaleform.gfx.MouseEventEx.RIGHT_BUTTON)
                    if (loc1.buttonIdx == scaleform.gfx.MouseEventEx.LEFT_BUTTON && !([this.shell1, this.shell2, this.shell3, this.equipment1, this.equipment2, this.equipment3].indexOf(arg1.currentTarget) == -1))
                        showTechnicalMaintenanceS();
                else if (loc1.currentTarget.id)
                    showModuleInfoS(arg1.currentTarget.id);
            }
            return;
        }

        internal function onShowModuleInfo(arg1:net.wg.gui.events.ModuleInfoEvent):void
        {
            showModuleInfoS(arg1.id);
            return;
        }

        internal function onMaintenanceClick(arg1:scaleform.clik.events.ButtonEvent):void
        {
            showTechnicalMaintenanceS();
            return;
        }

        internal function onHighlightParams(arg1:net.wg.gui.events.ParamsEvent):void
        {
            if ([this.gun, this.turret, this.engine, this.chassis, this.radio].indexOf(arg1.target) > -1)
                highlightParamsS(arg1.paramsType);
            return;
        }

        internal function onCustomizationClick(arg1:scaleform.clik.events.ButtonEvent):void
        {
            showCustomizationS();
            return;
        }

        internal function showTooltip(arg1:flash.events.MouseEvent):void
        {
            var loc1:*=null;
            if (arg1.target != this.maitenanceBtn)
                if (arg1.target == this.tuningBtn)
                    loc1 = TOOLTIPS.HANGAR_TUNING;
            else
                loc1 = TOOLTIPS.HANGAR_MAINTENANCE;
            App.toolTipMgr.showComplex(loc1);
            return;
        }

        public function disableTuningButton(arg1:Boolean):void
        {
            this.tuningBtn.enabled = !arg1;
            return;
        }

        internal function __setVehicleStatus(arg1:String, arg2:uint):void
        {
            var loc1:*=null;
            if (this.vehicleStateMsg)
            {
                this.vehicleStateMsg.text = arg1;
                loc1 = this.vehicleStateMsg.getTextFormat();
                loc1.color = arg2;
                this.vehicleStateMsg.setTextFormat(loc1);
                this.vehicleStateMsg.width = this.vehicleStateMsg.textWidth;
                this.vehicleStateMsg.x = (width - this.vehicleStateMsg.width) / 2;
            }
            return;
        }

        internal function __stateLevelToColor(arg1:String):uint
        {
            var loc1:*=arg1;
            switch (loc1)
            {
                case "info":
                    return GREEN_COLOR;
                case "warning":
                    return YELLOW_COLOR;
                case "critical":
                    return RED_COLOR;
            }
            return GREEN_COLOR;
        }

        public function showHelpLayout():void
        {
            var loc1:*=App.utils.helpLayout;
            var loc2:*=this.radio.x + this.radio.width - this.gun.x;
            var loc3:*=loc1.getProps(loc2, this.gun.height, net.wg.data.constants.Directions.TOP, LOBBY_HELP.HANGAR_MODULES, this.gun.x, this.gun.y);
            this._modulesHL = loc1.create(root, loc3, this);
            loc2 = this.optionalDevice3.x + this.optionalDevice3.width - this.optionalDevice1.x;
            loc3 = loc1.getProps(loc2, this.optionalDevice1.height, net.wg.data.constants.Directions.BOTTOM, LOBBY_HELP.HANGAR_OPTIONAL_DEVICES, this.optionalDevice1.x, this.optionalDevice1.y);
            this._devicesHL = loc1.create(root, loc3, this);
            this.maitenanceBtn.showHelpLayout();
            this.tuningBtn.showHelpLayout();
            return;
        }

        public function closeHelpLayout():void
        {
            var loc1:*=App.utils.helpLayout;
            loc1.destroy(this._modulesHL);
            loc1.destroy(this._devicesHL);
            this.maitenanceBtn.closeHelpLayout();
            this.tuningBtn.closeHelpLayout();
            return;
        }

        public function disableAmmunitionPanel(arg1:Boolean):void
        {
            var loc1:*=null;
            this.maitenanceBtn.enabled = !arg1;
            var loc2:*=[this.gun, this.turret, this.engine, this.chassis, this.radio, this.optionalDevice1, this.optionalDevice2, this.optionalDevice3, this.equipment1, this.equipment2, this.equipment3];
            var loc3:*=0;
            var loc4:*=loc2;
            for each (loc1 in loc4)
            {
                if (loc1 != this.turret)
                {
                    loc1.enabled = !arg1;
                    continue;
                }
                loc1.enabled = !arg1 && this._hasTurret;
            }
            return;
        }

        internal static const SHELLS_COUNT:int=3;

        internal static const YELLOW_COLOR:uint=13814699;

        internal static const RED_COLOR:uint=10158594;

        internal static const GREEN_COLOR:uint=4813330;

        internal var events:net.wg.utils.IEventCollector;

        public var vehicleStateMsg:flash.text.TextField;

        public var maitenanceBtn:net.wg.gui.components.controls.IconTextButton;

        public var tuningBtn:net.wg.gui.components.controls.IconTextButton;

        public var gun:net.wg.gui.lobby.hangar.ammunitionPanel.ModuleSlot;

        public var engine:net.wg.gui.lobby.hangar.ammunitionPanel.ModuleSlot;

        public var chassis:net.wg.gui.lobby.hangar.ammunitionPanel.ModuleSlot;

        public var radio:net.wg.gui.lobby.hangar.ammunitionPanel.ModuleSlot;

        public var optionalDevice1:net.wg.gui.lobby.hangar.ammunitionPanel.EquipmentSlot;

        public var optionalDevice2:net.wg.gui.lobby.hangar.ammunitionPanel.EquipmentSlot;

        public var optionalDevice3:net.wg.gui.lobby.hangar.ammunitionPanel.EquipmentSlot;

        public var equipment1:net.wg.gui.lobby.hangar.ammunitionPanel.EquipmentSlot;

        public var equipment2:net.wg.gui.lobby.hangar.ammunitionPanel.EquipmentSlot;

        public var equipment3:net.wg.gui.lobby.hangar.ammunitionPanel.EquipmentSlot;

        public var shell1:net.wg.gui.components.advanced.ShellButton;

        public var shell2:net.wg.gui.components.advanced.ShellButton;

        public var shell3:net.wg.gui.components.advanced.ShellButton;

        internal var _devicesHL:flash.display.DisplayObject;

        internal var _hasTurret:Boolean;

        internal var _modulesHL:flash.display.DisplayObject;

        public var turret:net.wg.gui.lobby.hangar.ammunitionPanel.ModuleSlot;
    }
}
