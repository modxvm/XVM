package net.wg.infrastructure.base.meta.impl 
{
    import net.wg.data.constants.*;
    import net.wg.infrastructure.base.*;
    
    public class RecruitWindowMeta extends net.wg.infrastructure.base.AbstractWindowView
    {
        public function RecruitWindowMeta()
        {
            super();
            return;
        }

        public function updateVehicleClassDropdownS(arg1:Number):void
        {
            App.utils.asserter.assertNotNull(this.updateVehicleClassDropdown, "updateVehicleClassDropdown" + net.wg.data.constants.Errors.CANT_NULL);
            this.updateVehicleClassDropdown(arg1);
            return;
        }

        public function updateVehicleTypeDropdownS(arg1:Number, arg2:String):void
        {
            App.utils.asserter.assertNotNull(this.updateVehicleTypeDropdown, "updateVehicleTypeDropdown" + net.wg.data.constants.Errors.CANT_NULL);
            this.updateVehicleTypeDropdown(arg1, arg2);
            return;
        }

        public function updateRoleDropdownS(arg1:Number, arg2:String, arg3:Number):void
        {
            App.utils.asserter.assertNotNull(this.updateRoleDropdown, "updateRoleDropdown" + net.wg.data.constants.Errors.CANT_NULL);
            this.updateRoleDropdown(arg1, arg2, arg3);
            return;
        }

        public function updateNationDropdownS():void
        {
            App.utils.asserter.assertNotNull(this.updateNationDropdown, "updateNationDropdown" + net.wg.data.constants.Errors.CANT_NULL);
            this.updateNationDropdown();
            return;
        }

        public function buyTankmanS(arg1:Number, arg2:Number, arg3:String, arg4:Number, arg5:Number):void
        {
            App.utils.asserter.assertNotNull(this.buyTankman, "buyTankman" + net.wg.data.constants.Errors.CANT_NULL);
            this.buyTankman(arg1, arg2, arg3, arg4, arg5);
            return;
        }

        public function updateAllDropdownsS(arg1:Number, arg2:String, arg3:Number, arg4:String):void
        {
            App.utils.asserter.assertNotNull(this.updateAllDropdowns, "updateAllDropdowns" + net.wg.data.constants.Errors.CANT_NULL);
            this.updateAllDropdowns(arg1, arg2, arg3, arg4);
            return;
        }

        public var updateVehicleClassDropdown:Function=null;

        public var updateVehicleTypeDropdown:Function=null;

        public var updateRoleDropdown:Function=null;

        public var updateNationDropdown:Function=null;

        public var buyTankman:Function=null;

        public var updateAllDropdowns:Function=null;
    }
}
