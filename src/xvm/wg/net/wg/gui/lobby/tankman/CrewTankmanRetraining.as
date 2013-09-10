package net.wg.gui.lobby.tankman 
{
    import flash.display.*;
    import flash.events.*;
    import net.wg.data.constants.*;
    import net.wg.gui.components.controls.*;
    import net.wg.gui.events.*;
    import net.wg.infrastructure.interfaces.*;
    import scaleform.clik.controls.*;
    import scaleform.clik.core.*;
    import scaleform.clik.data.*;
    import scaleform.clik.events.*;
    
    public class CrewTankmanRetraining extends scaleform.clik.core.UIComponent implements net.wg.infrastructure.interfaces.IViewStackContent
    {
        public function CrewTankmanRetraining()
        {
            this.retrainingButtons = [];
            this.vehicleButtons = [];
            this.toolTipBindHash = {};
            super();
            return;
        }

        internal function applyRetrainingButtonClick(arg1:scaleform.clik.events.ButtonEvent):void
        {
            var loc1:*=new net.wg.gui.events.PersonalCaseEvent(net.wg.gui.events.PersonalCaseEvent.APPLY_RETRAINING);
            var loc2:*={};
            loc2.innaitonID = this.currentSelectedInnationID;
            loc2.inventoryID = this.model.tankmanID;
            loc2.tankmanCostTypeIndex = this.currentSelectedCostIndex;
            loc1.retrainingTankmanData = loc2;
            dispatchEvent(loc1);
            return;
        }

        internal function retrainingTypeClick(arg1:scaleform.clik.events.ButtonEvent):void
        {
            this.currentSelectedCostIndex = this.retrainingButtonGroup.selectedIndex;
            return;
        }

        internal function checkEnabledResetBtn(arg1:int):void
        {
            if (this.model.currentVehicle) 
            {
                this.btnReset.enabled = !(arg1 == this.model.currentVehicle.innationID);
            }
            this.currentSelectedInnationID = arg1;
            this.updateRetrainingButtons();
            return;
        }

        internal function vehiclesDropdown_listIndexChangeHandler(arg1:scaleform.clik.events.ListEvent):void
        {
            this.checkEnabledResetBtn(arg1.itemData.innationID);
            return;
        }

        public function update(arg1:Object):void
        {
            if (arg1 == null) 
            {
                return;
            }
            this.model = arg1 as net.wg.gui.lobby.tankman.PersonalCaseRetrainingModel;
            this.btnReset.enabled = !(this.model.currentVehicle == null);
            this.needUpdateData = true;
            invalidate(this.UPDATE_DATA);
            return;
        }

        internal function btnReset_buttonClickHandler(arg1:scaleform.clik.events.ButtonEvent):void
        {
            this.currentSelectedVehicleType = this.model.currentVehicle.type;
            this.currentSelectedInnationID = this.model.currentVehicle.innationID;
            this.autoSelectVehicleType();
            this.autoSelectVehicle();
            return;
        }

        internal function autoSelectVehicle(arg1:Boolean=true):void
        {
            var loc1:*=null;
            var loc2:*=false;
            var loc3:*=0;
            var loc4:*=this.currentSelectedVehicleType;
            switch (loc4) 
            {
                case net.wg.data.constants.VehicleTypes.LIGHT_TANK:
                {
                    loc1 = new scaleform.clik.data.DataProvider(this.model.lightTanks);
                    break;
                }
                case net.wg.data.constants.VehicleTypes.MEDIUM_TANK:
                {
                    loc1 = new scaleform.clik.data.DataProvider(this.model.mediumTanks);
                    break;
                }
                case net.wg.data.constants.VehicleTypes.HEAVY_TANK:
                {
                    loc1 = new scaleform.clik.data.DataProvider(this.model.heavyTanks);
                    break;
                }
                case net.wg.data.constants.VehicleTypes.AT_SPG:
                {
                    loc1 = new scaleform.clik.data.DataProvider(this.model.AT_SPG);
                    break;
                }
                case net.wg.data.constants.VehicleTypes.SPG:
                {
                    loc1 = new scaleform.clik.data.DataProvider(this.model.SPG);
                    break;
                }
                default:
                {
                    DebugUtils.LOG_DEBUG("ERROR unknown tank type");
                    break;
                }
            }
            this.vehiclesDropdown.labelField = "userName";
            this.vehiclesDropdown.dataProvider = loc1;
            if (arg1) 
            {
                loc2 = false;
                loc3 = 0;
                while (loc3 < this.vehiclesDropdown.dataProvider.length) 
                {
                    if (this.vehiclesDropdown.dataProvider[loc3].innationID == this.currentSelectedInnationID) 
                    {
                        this.vehiclesDropdown.selectedIndex = loc3;
                        loc2 = true;
                        break;
                    }
                    ++loc3;
                }
                if (!loc2) 
                {
                    this.vehiclesDropdown.selectedIndex = 0;
                }
            }
            else 
            {
                this.vehiclesDropdown.selectedIndex = 0;
            }
            this.checkEnabledResetBtn(this.vehiclesDropdown.dataProvider[this.vehiclesDropdown.selectedIndex].innationID);
            this.currentSelectedCostIndex = -1;
            this.autoSelectRetrainingButtons();
            this.vehiclesDropdown.validateNow();
            return;
        }

        internal function autoSelectVehicleType():void
        {
            var loc1:*=0;
            while (loc1 < this.vehicleButtons.length) 
            {
                if (this.currentSelectedVehicleType == this.vehicleButtons[loc1].type) 
                {
                    this.vehicleButtons[loc1].selected = true;
                }
                ++loc1;
            }
            return;
        }

        internal function vehicleType_buttonPressHandler(arg1:scaleform.clik.events.ButtonEvent):void
        {
            var loc1:*=false;
            var loc2:*=false;
            if (this.currentSelectedVehicleType != net.wg.gui.lobby.tankman.VehicleTypeButton(arg1.currentTarget).type) 
            {
                this.currentSelectedVehicleType = net.wg.gui.lobby.tankman.VehicleTypeButton(arg1.currentTarget).type;
                loc1 = false;
                if (this.model.currentVehicle) 
                {
                    loc1 = this.currentSelectedVehicleType == this.model.currentVehicle.type;
                }
                loc2 = this.currentSelectedVehicleType == this.model.nativeVehicle.type;
                this.currentSelectedInnationID = loc1 ? this.model.currentVehicle.innationID : this.model.nativeVehicle.innationID;
                this.autoSelectVehicle(loc1 || loc2);
            }
            return;
        }

        internal function currnetItem_mouseOutHandler(arg1:flash.events.MouseEvent):void
        {
            App.toolTipMgr.hide();
            return;
        }

        internal function currentItem_mouseOverHandler(arg1:flash.events.MouseEvent):void
        {
            var loc1:*=null;
            if (this.toolTipBindHash[arg1.currentTarget.name] != null) 
            {
                loc1 = this.toolTipBindHash[arg1.currentTarget.name];
            }
            App.toolTipMgr.showComplex(loc1);
            return;
        }

        internal function initVehicleTypes():void
        {
            var loc2:*=null;
            this.vehicleGroup = scaleform.clik.controls.ButtonGroup.getGroup("vehicleGroup", this);
            var loc1:*=0;
            while (loc1 < this.vehicleButtons.length) 
            {
                loc2 = this.vehicleButtons[loc1] as net.wg.gui.lobby.tankman.VehicleTypeButton;
                loc2.addEventListener(scaleform.clik.events.ButtonEvent.PRESS, this.vehicleType_buttonPressHandler);
                this.setToolTipListeners(loc2);
                loc2.groupName = "vehicleGroup";
                loc2.allowDeselect = false;
                loc2.validateNow();
                ++loc1;
            }
            return;
        }

        internal function autoSelectRetrainingButtons():void
        {
            var loc2:*=null;
            var loc1:*=0;
            while (loc1 < this.retrainingButtons.length) 
            {
                loc2 = this.retrainingButtons[loc1] as net.wg.gui.components.controls.TankmanTrainingSmallButton;
                if (loc2.enabled == true) 
                {
                    loc2.selected = true;
                    this.currentSelectedCostIndex = loc1;
                    this.btnRetraining.enabled = true;
                    return;
                }
                ++loc1;
            }
            this.btnRetraining.enabled = false;
            return;
        }

        internal function updateRetrainingButtons():void
        {
            var loc1:*=this.currentSelectedInnationID == this.model.nativeVehicle.innationID;
            var loc2:*=this.currentSelectedVehicleType == this.model.nativeVehicle.type;
            var loc3:*=0;
            while (loc3 < this.retrainingButtons.length) 
            {
                net.wg.gui.components.controls.TankmanTrainingSmallButton(this.retrainingButtons[loc3]).setData(this.model.tankmanCost[loc3], this.model.gold, this.model.credits, this.model.specializationLevel, loc1, loc2, this.model.nationID);
                ++loc3;
            }
            this.autoSelectRetrainingButtons();
            return;
        }

        internal function initRetrainingButton():void
        {
            var loc2:*=null;
            this.retrainingButtonGroup = scaleform.clik.controls.ButtonGroup.getGroup("retrainingButtonGroup", this);
            var loc1:*=0;
            while (loc1 < this.retrainingButtons.length) 
            {
                loc2 = this.retrainingButtons[loc1] as net.wg.gui.components.controls.TankmanTrainingSmallButton;
                loc2.addEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.retrainingTypeClick);
                loc2.groupName = "retrainingButtonGroup";
                loc2.retraining = true;
                loc2.allowDeselect = false;
                ++loc1;
            }
            return;
        }

        internal function enableVehicleTypeButton():void
        {
            this.lightTankBtn.enabled = this.model.lightTanks.length > 0;
            this.mediumTankBtn.enabled = this.model.mediumTanks.length > 0;
            this.heavyTankBtn.enabled = this.model.heavyTanks.length > 0;
            this.at_spgBtn.enabled = this.model.AT_SPG.length > 0;
            this.spgBtn.enabled = this.model.SPG.length > 0;
            return;
        }

        internal function updateViewElements():void
        {
            this.enableVehicleTypeButton();
            if (this.currentSelectedVehicleType == null) 
            {
                this.currentSelectedVehicleType = this.model.nativeVehicle.type;
            }
            this.currentSelectedInnationID = this.model.nativeVehicle.innationID;
            this.autoSelectVehicleType();
            this.autoSelectVehicle();
            return;
        }

        internal function setToolTipListeners(arg1:flash.display.DisplayObject, arg2:Boolean=true):void
        {
            if (arg2) 
            {
                arg1.addEventListener(flash.events.MouseEvent.MOUSE_OVER, this.currentItem_mouseOverHandler);
                arg1.addEventListener(flash.events.MouseEvent.MOUSE_OUT, this.currnetItem_mouseOutHandler);
            }
            else 
            {
                arg1.removeEventListener(flash.events.MouseEvent.MOUSE_OVER, this.currentItem_mouseOverHandler);
                arg1.removeEventListener(flash.events.MouseEvent.MOUSE_OUT, this.currnetItem_mouseOutHandler);
            }
            return;
        }

        protected override function configUI():void
        {
            this.vehiclesDropdown.buttonMode = true;
            this.setToolTipListeners(this.vehiclesDropdown);
            this.setToolTipListeners(this.btnReset);
            super.configUI();
            this.btnReset.addEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.btnReset_buttonClickHandler);
            this.vehiclesDropdown.addEventListener(scaleform.clik.events.ListEvent.INDEX_CHANGE, this.vehiclesDropdown_listIndexChangeHandler);
            this.btnRetraining.addEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.applyRetrainingButtonClick);
            this.toolTipBindHash["lightTankBtn"] = "#tooltips:personal_case/training/light_tank_btn";
            this.toolTipBindHash["mediumTankBtn"] = "#tooltips:personal_case/training/medium_tank_btn";
            this.toolTipBindHash["heavyTankBtn"] = "#tooltips:personal_case/training/heavy_tank_btn";
            this.toolTipBindHash["at_spgBtn"] = "#tooltips:personal_case/training/at_spg_btn";
            this.toolTipBindHash["spgBtn"] = "#tooltips:personal_case/training/spg_btn";
            this.toolTipBindHash["vehiclesDropdown"] = "#tooltips:personal_case/training/tank";
            this.toolTipBindHash["btnReset"] = "#tooltips:personal_case/training/current_tank";
            this.vehicleButtons = [this.lightTankBtn, this.mediumTankBtn, this.heavyTankBtn, this.at_spgBtn, this.spgBtn];
            this.retrainingButtons = [this.btnCourses, this.btnScool, this.btnAcademy];
            this.initRetrainingButton();
            this.initVehicleTypes();
            return;
        }

        protected override function draw():void
        {
            super.draw();
            if (isInvalid(this.UPDATE_DATA) && this.needUpdateData) 
            {
                this.needUpdateData = false;
                this.updateViewElements();
            }
            return;
        }

        public override function dispose():void
        {
            var loc1:*=0;
            var loc2:*=null;
            var loc3:*=0;
            var loc4:*=null;
            super.dispose();
            this.model = null;
            if (this.vehicleButtons) 
            {
                loc1 = 0;
                while (loc1 < this.vehicleButtons.length) 
                {
                    loc2 = this.vehicleButtons[loc1] as net.wg.gui.lobby.tankman.VehicleTypeButton;
                    loc2.removeEventListener(scaleform.clik.events.ButtonEvent.PRESS, this.vehicleType_buttonPressHandler);
                    ++loc1;
                }
                this.vehicleButtons = null;
            }
            if (this.retrainingButtons) 
            {
                loc3 = 0;
                while (loc3 < this.retrainingButtons.length) 
                {
                    (loc4 = this.retrainingButtons[loc3] as net.wg.gui.components.controls.TankmanTrainingSmallButton).dispose();
                    loc4.removeEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.retrainingTypeClick);
                    ++loc3;
                }
                this.retrainingButtons = null;
            }
            this.btnReset.removeEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.btnReset_buttonClickHandler);
            this.vehiclesDropdown.removeEventListener(scaleform.clik.events.ListEvent.INDEX_CHANGE, this.vehiclesDropdown_listIndexChangeHandler);
            this.btnRetraining.removeEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.applyRetrainingButtonClick);
            this.setToolTipListeners(this.vehiclesDropdown, false);
            this.setToolTipListeners(this.btnReset, false);
            return;
        }

        internal const UPDATE_DATA:String="updateData";

        internal var needUpdateData:Boolean=false;

        internal var model:net.wg.gui.lobby.tankman.PersonalCaseRetrainingModel=null;

        internal var toolTipBindHash:Object;

        internal var vehicleButtons:Array;

        internal var retrainingButtons:Array;

        internal var currentSelectedCostIndex:int=-1;

        internal var currentSelectedInnationID:int=0;

        internal var currentSelectedVehicleType:String=null;

        public var btnReset:net.wg.gui.components.controls.SoundButtonEx=null;

        public var vehiclesDropdown:net.wg.gui.components.controls.DropdownMenu=null;

        public var btnCourses:net.wg.gui.components.controls.TankmanTrainingSmallButton=null;

        public var btnScool:net.wg.gui.components.controls.TankmanTrainingSmallButton=null;

        public var btnAcademy:net.wg.gui.components.controls.TankmanTrainingSmallButton=null;

        internal var retrainingButtonGroup:scaleform.clik.controls.ButtonGroup=null;

        public var spgBtn:net.wg.gui.lobby.tankman.VehicleTypeButton=null;

        public var heavyTankBtn:net.wg.gui.lobby.tankman.VehicleTypeButton=null;

        public var at_spgBtn:net.wg.gui.lobby.tankman.VehicleTypeButton=null;

        public var mediumTankBtn:net.wg.gui.lobby.tankman.VehicleTypeButton=null;

        public var lightTankBtn:net.wg.gui.lobby.tankman.VehicleTypeButton=null;

        internal var vehicleGroup:scaleform.clik.controls.ButtonGroup=null;

        public var btnRetraining:net.wg.gui.components.controls.SoundButtonEx;
    }
}
