package net.wg.gui.components.advanced
{
    import net.wg.infrastructure.base.meta.impl.RecruitParametersMeta;
    import net.wg.infrastructure.base.meta.IRecruitParametersMeta;
    import net.wg.gui.components.controls.DropdownMenu;
    import net.wg.gui.components.advanced.vo.RecruitParametersVO;
    import scaleform.clik.data.DataProvider;
    import scaleform.clik.events.ListEvent;
    import flash.events.Event;
    
    public class RecruitParametersComponent extends RecruitParametersMeta implements IRecruitParametersMeta
    {
        
        public function RecruitParametersComponent()
        {
            super();
        }
        
        private static var NATIONS_INV:String = "nationsInv";
        
        private static var VEHICLE_CLASS_INV:String = "vClassInv";
        
        private static var VEHICLE_INV:String = "vehInv";
        
        private static var TANKMAN_ROLE_INV:String = "tManInv";
        
        private static function applyData(param1:DropdownMenu, param2:Object) : void
        {
            var _loc3_:RecruitParametersVO = new RecruitParametersVO(param2);
            param1.dataProvider = new DataProvider(_loc3_.data);
            param1.selectedIndex = _loc3_.selectedIndex;
            param1.enabled = _loc3_.enabled;
        }
        
        public var nationDropdown:DropdownMenu;
        
        public var vehicleClassDropdown:DropdownMenu;
        
        public var vehicleTypeDropdown:DropdownMenu;
        
        public var roleDropdown:DropdownMenu;
        
        private var nationsData:Object;
        
        private var vehicleClassData:Object;
        
        private var vehicleData:Object;
        
        private var tankmanRoleData:Object;
        
        public function as_setVehicleClassData(param1:Object) : void
        {
            this.vehicleClassData = param1;
            invalidate(VEHICLE_CLASS_INV);
        }
        
        public function as_setVehicleData(param1:Object) : void
        {
            this.vehicleData = param1;
            invalidate(VEHICLE_INV);
        }
        
        public function as_setTankmanRoleData(param1:Object) : void
        {
            this.tankmanRoleData = param1;
            invalidate(TANKMAN_ROLE_INV);
        }
        
        public function as_setNationsData(param1:Object) : void
        {
            this.nationsData = param1;
            invalidate(NATIONS_INV);
        }
        
        public function getSelectedNation() : int
        {
            return this.nationDropdown.dataProvider[this.nationDropdown.selectedIndex].id;
        }
        
        public function getSelectedVehicleClass() : String
        {
            return this.vehicleClassDropdown.dataProvider[this.vehicleClassDropdown.selectedIndex].id;
        }
        
        public function getSelectedVehicle() : Number
        {
            return this.vehicleTypeDropdown.dataProvider[this.vehicleTypeDropdown.selectedIndex].id;
        }
        
        public function getSelectedTankmanRole() : String
        {
            return this.roleDropdown.dataProvider[this.roleDropdown.selectedIndex].id;
        }
        
        override protected function configUI() : void
        {
            super.configUI();
            this.nationDropdown.addEventListener(ListEvent.INDEX_CHANGE,this.nationChangeHandler);
            this.vehicleClassDropdown.addEventListener(ListEvent.INDEX_CHANGE,this.vehClassChangeHandler);
            this.vehicleTypeDropdown.addEventListener(ListEvent.INDEX_CHANGE,this.vehicleChangeHandler);
            this.roleDropdown.addEventListener(ListEvent.INDEX_CHANGE,this.roleChangeHandler);
        }
        
        override protected function draw() : void
        {
            super.draw();
            if((isInvalid(NATIONS_INV)) && (this.nationsData))
            {
                applyData(this.nationDropdown,this.nationsData);
            }
            if((isInvalid(VEHICLE_CLASS_INV)) && (this.vehicleClassData))
            {
                applyData(this.vehicleClassDropdown,this.vehicleClassData);
            }
            if((isInvalid(VEHICLE_INV)) && (this.vehicleData))
            {
                applyData(this.vehicleTypeDropdown,this.vehicleData);
            }
            if((isInvalid(TANKMAN_ROLE_INV)) && (this.tankmanRoleData))
            {
                applyData(this.roleDropdown,this.tankmanRoleData);
            }
        }
        
        override protected function onDispose() : void
        {
            this.nationsData = null;
            this.vehicleClassData = null;
            this.vehicleData = null;
            this.tankmanRoleData = null;
            this.nationDropdown.removeEventListener(ListEvent.INDEX_CHANGE,this.nationChangeHandler);
            this.vehicleClassDropdown.removeEventListener(ListEvent.INDEX_CHANGE,this.vehClassChangeHandler);
            this.vehicleTypeDropdown.removeEventListener(ListEvent.INDEX_CHANGE,this.vehicleChangeHandler);
            this.roleDropdown.removeEventListener(ListEvent.INDEX_CHANGE,this.roleChangeHandler);
            super.onDispose();
        }
        
        private function nationChangeHandler(param1:ListEvent) : void
        {
            onNationChangedS(this.getSelectedNation());
            dispatchEvent(new Event(Event.CHANGE));
        }
        
        private function vehClassChangeHandler(param1:ListEvent) : void
        {
            onVehicleClassChangedS(this.getSelectedVehicleClass());
            dispatchEvent(new Event(Event.CHANGE));
        }
        
        private function vehicleChangeHandler(param1:ListEvent) : void
        {
            onVehicleChangedS(this.getSelectedVehicle());
            dispatchEvent(new Event(Event.CHANGE));
        }
        
        private function roleChangeHandler(param1:ListEvent) : void
        {
            onTankmanRoleChangedS(this.getSelectedTankmanRole());
            dispatchEvent(new Event(Event.CHANGE));
        }
    }
}
