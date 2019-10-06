package net.wg.gui.lobby.vehicleCompare
{
    import net.wg.infrastructure.base.meta.impl.VehicleCompareConfiguratorViewMeta;
    import net.wg.infrastructure.base.meta.IVehicleCompareConfiguratorViewMeta;
    import net.wg.infrastructure.interfaces.IViewStackContent;
    import net.wg.gui.lobby.vehicleCompare.configurator.VehConfCrew;
    import net.wg.gui.lobby.vehicleCompare.configurator.VehConfModules;
    import net.wg.gui.lobby.vehicleCompare.configurator.VehConfEquipment;
    import net.wg.gui.lobby.hangar.interfaces.IVehicleParameters;
    import flash.utils.Dictionary;
    import net.wg.gui.lobby.vehicleCompare.events.ClosableEquipmentSlotEvent;
    import net.wg.gui.lobby.vehicleCompare.events.VehConfShellSlotEvent;
    import net.wg.gui.lobby.vehicleCompare.events.VehConfEvent;
    import net.wg.gui.lobby.vehicleCompare.events.VehConfSkillEvent;
    import net.wg.gui.lobby.vehicleCompare.events.VehConfSkillDropDownEvent;
    import net.wg.gui.lobby.vehicleCompare.data.VehicleCompareConfiguratorInitDataVO;
    import net.wg.gui.lobby.vehicleCompare.data.VehicleCompareConfiguratorVO;
    import flash.display.DisplayObject;
    import net.wg.gui.lobby.components.data.DeviceSlotVO;
    import net.wg.gui.components.controls.VO.ShellButtonVO;
    import net.wg.data.constants.generated.VEHICLE_COMPARE_CONSTANTS;
    import net.wg.gui.lobby.vehicleCompare.data.VehConfSkillVO;
    import net.wg.gui.lobby.vehicleCompare.configurator.ClosableEquipmentSlot;

    public class VehicleCompareConfiguratorView extends VehicleCompareConfiguratorViewMeta implements IVehicleCompareConfiguratorViewMeta, IViewStackContent
    {

        private static const BORDER_OFFSET:int = 40;

        private static const MIN_SCREEN_WIDTH:int = 1024;

        private static const MIN_SCREEN_HEIGHT:int = 768;

        private static const MAX_SCREEN_WIDTH:int = 1920;

        private static const MAX_SCREEN_HEIGHT:int = 1080;

        private static const VEH_PARAMS_MAX_X_OFFSET:int = -4;

        private static const VEH_PARAMS_MIN_X_OFFSET:int = -50;

        private static const VEH_PARAMS_Y_OFFSET:int = -8;

        private static const VEH_PARAMS_BOTTOM_OFFSET:int = 13;

        public var crew:VehConfCrew;

        public var modules:VehConfModules;

        public var equipment:VehConfEquipment;

        public var vehParams:IVehicleParameters;

        private var _offsets:Dictionary;

        public function VehicleCompareConfiguratorView()
        {
            this._offsets = new Dictionary();
            super();
        }

        override protected function initialize() : void
        {
            super.initialize();
            this._offsets[titleTf] = new Offsets(55,115);
            this._offsets[this.crew] = new Offsets(15,55);
            this._offsets[this.modules] = new Offsets(20,50);
            this._offsets[this.equipment] = new Offsets(25,55);
            this._offsets[bottomPanel] = new Offsets(20,65);
        }

        override protected function configUI() : void
        {
            super.configUI();
            this.equipment.addEventListener(ClosableEquipmentSlotEvent.REMOVE_CLICK,this.onDeviceSlotRemoveClickHandler);
            this.equipment.addEventListener(VehConfShellSlotEvent.SHELL_SLOT_CLICK,this.onEquipmentShellSlotClickHandler);
            this.equipment.addEventListener(VehConfEvent.CAMO_CLICK,this.onEquipmentCamoClickHandler);
            this.modules.addEventListener(VehConfEvent.MODULES_CLICK,this.onModulesModulesClickHandler);
            this.modules.addEventListener(VehConfEvent.TOP_MODULES_ON,this.onModulesTopModulesOnHandler);
            this.modules.addEventListener(VehConfEvent.TOP_MODULES_OFF,this.onModulesTopModulesOffHandler);
            this.crew.addEventListener(VehConfSkillEvent.SKILL_SELECT,this.onCrewSkillSelectHandler);
            this.crew.addEventListener(VehConfSkillDropDownEvent.CREW_LEVEL_CHANGED,this.onCrewCrewLevelChangedHandler);
        }

        override protected function onDispose() : void
        {
            removeEventListener(ClosableEquipmentSlotEvent.REMOVE_CLICK,this.onDeviceSlotRemoveClickHandler);
            this.equipment.removeEventListener(VehConfEvent.CAMO_CLICK,this.onEquipmentCamoClickHandler);
            this.equipment.removeEventListener(ClosableEquipmentSlotEvent.REMOVE_CLICK,this.onDeviceSlotRemoveClickHandler);
            this.equipment.removeEventListener(VehConfShellSlotEvent.SHELL_SLOT_CLICK,this.onEquipmentShellSlotClickHandler);
            this.crew.removeEventListener(VehConfSkillEvent.SKILL_SELECT,this.onCrewSkillSelectHandler);
            this.crew.removeEventListener(VehConfSkillDropDownEvent.CREW_LEVEL_CHANGED,this.onCrewCrewLevelChangedHandler);
            this.modules.removeEventListener(VehConfEvent.MODULES_CLICK,this.onModulesModulesClickHandler);
            this.modules.removeEventListener(VehConfEvent.TOP_MODULES_ON,this.onModulesTopModulesOnHandler);
            this.modules.removeEventListener(VehConfEvent.TOP_MODULES_OFF,this.onModulesTopModulesOffHandler);
            this.modules.dispose();
            this.modules = null;
            this.equipment.dispose();
            this.equipment = null;
            this.crew.dispose();
            this.crew = null;
            this.vehParams = null;
            App.utils.data.cleanupDynamicObject(this._offsets);
            this._offsets = null;
            super.onDispose();
        }

        override protected function getVehicleCompareConfiguratorInitDataVOForData(param1:Object) : VehicleCompareConfiguratorInitDataVO
        {
            return new VehicleCompareConfiguratorVO(param1);
        }

        override protected function updateLayout() : void
        {
            var _loc5_:DisplayObject = null;
            var _loc6_:DisplayObject = null;
            var _loc7_:Offsets = null;
            var _loc8_:* = 0;
            super.updateLayout();
            var _loc1_:int = (width - MIN_SCREEN_WIDTH >> 1) + BORDER_OFFSET;
            this.modules.x = _loc1_;
            this.equipment.x = _loc1_;
            bottomPanel.x = _loc1_;
            this.crew.x = _loc1_;
            var _loc2_:Number = (App.appWidth - MIN_SCREEN_WIDTH) / (MAX_SCREEN_WIDTH - MIN_SCREEN_WIDTH);
            var _loc3_:Number = (App.appHeight - MIN_SCREEN_HEIGHT) / (MAX_SCREEN_HEIGHT - MIN_SCREEN_HEIGHT);
            var _loc4_:Vector.<DisplayObject> = new <DisplayObject>[titleTf,this.crew,this.modules,this.equipment,bottomPanel];
            for each(_loc6_ in _loc4_)
            {
                _loc7_ = this._offsets[_loc6_];
                _loc8_ = _loc5_?_loc5_.y + _loc5_.height:0;
                _loc6_.y = _loc8_ + _loc7_.min + (_loc7_.max - _loc7_.min) * _loc3_;
                _loc5_ = _loc6_;
            }
            _loc4_.splice(0,_loc4_.length);
            this.vehParams.x = this.modules.x + this.modules.width + VEH_PARAMS_MIN_X_OFFSET + (VEH_PARAMS_MAX_X_OFFSET - VEH_PARAMS_MIN_X_OFFSET) * _loc2_;
            this.vehParams.y = this.crew.y + VEH_PARAMS_Y_OFFSET;
            this.vehParams.height = bottomPanel.y + bottomPanel.height - this.vehParams.y + VEH_PARAMS_BOTTOM_OFFSET;
        }

        override protected function setInitData(param1:VehicleCompareConfiguratorInitDataVO) : void
        {
            super.setInitData(param1);
            var _loc2_:VehicleCompareConfiguratorVO = VehicleCompareConfiguratorVO(param1);
            this.crew.setStaticData(_loc2_);
            this.modules.setTopModulesEnabled(_loc2_.enableTopModules);
            this.equipment.setCamoEnabled(_loc2_.enableCamo);
        }

        override protected function setDevicesData(param1:Vector.<DeviceSlotVO>) : void
        {
            this.equipment.setData(param1);
            this.modules.setData(param1);
        }

        override protected function setAmmo(param1:Vector.<ShellButtonVO>) : void
        {
            this.equipment.setAmmo(param1);
        }

        override protected function onPopulate() : void
        {
            super.onPopulate();
            registerFlashComponentS(this.vehParams,VEHICLE_COMPARE_CONSTANTS.VEHICLE_COMPARE_PARAMS);
        }

        override protected function setSkills(param1:Vector.<VehConfSkillVO>) : void
        {
            this.crew.setSkills(param1);
        }

        public function as_disableCamo() : void
        {
            this.equipment.disableCamo();
        }

        public function as_setCamo(param1:Boolean) : void
        {
            this.equipment.camoSelected = param1;
        }

        public function as_setCrewAttentionIconVisible(param1:Boolean) : void
        {
            this.crew.setCrewAttentionIconVisible(param1);
        }

        public function as_setCrewLevelIndex(param1:int) : void
        {
            this.crew.crewLevelIndex = param1;
        }

        public function as_setSelectedAmmoIndex(param1:int) : void
        {
            this.equipment.setSelectedAmmoIndex(param1);
        }

        public function as_setSkillsBlocked(param1:Boolean) : void
        {
            this.crew.setSkillsFadeVisible(param1);
        }

        public function as_setTopModulesSelected(param1:Boolean) : void
        {
            this.modules.setTopModulesSelected(param1);
        }

        private function onCrewCrewLevelChangedHandler(param1:VehConfSkillDropDownEvent) : void
        {
            changeCrewLevelS(param1.crewLevel);
        }

        private function onCrewSkillSelectHandler(param1:VehConfSkillEvent) : void
        {
            skillSelectS(param1.skillType,param1.slotIndex,param1.selected);
        }

        private function onModulesTopModulesOffHandler(param1:VehConfEvent) : void
        {
            toggleTopModulesS(false);
        }

        private function onModulesTopModulesOnHandler(param1:VehConfEvent) : void
        {
            toggleTopModulesS(true);
        }

        private function onModulesModulesClickHandler(param1:VehConfEvent) : void
        {
            showModulesS();
        }

        private function onEquipmentCamoClickHandler(param1:VehConfEvent) : void
        {
            camoSelectedS(this.equipment.camoSelected);
        }

        private function onEquipmentShellSlotClickHandler(param1:VehConfShellSlotEvent) : void
        {
            selectShellS(param1.shellId,param1.slotIndex);
        }

        private function onDeviceSlotRemoveClickHandler(param1:ClosableEquipmentSlotEvent) : void
        {
            var _loc2_:ClosableEquipmentSlot = ClosableEquipmentSlot(param1.target);
            removeDeviceS(_loc2_.type,_loc2_.slotIndex);
        }
    }
}

class Offsets extends Object
{

    public var max:int;

    public var min:int;

    function Offsets(param1:int, param2:int)
    {
        super();
        this.max = param2;
        this.min = param1;
    }
}
