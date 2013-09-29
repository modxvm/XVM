package net.wg.infrastructure.base.meta.impl 
{
    import net.wg.data.constants.*;
    import net.wg.infrastructure.base.*;
    
    public class TechnicalMaintenanceMeta extends net.wg.infrastructure.base.AbstractWindowView
    {
        public function TechnicalMaintenanceMeta()
        {
            super();
            return;
        }

        public function getEquipmentS(arg1:String, arg2:String, arg3:String, arg4:String, arg5:String, arg6:String, arg7:int):void
        {
            App.utils.asserter.assertNotNull(this.getEquipment, "getEquipment" + net.wg.data.constants.Errors.CANT_NULL);
            this.getEquipment(arg1, arg2, arg3, arg4, arg5, arg6, arg7);
            return;
        }

        public function repairS():void
        {
            App.utils.asserter.assertNotNull(this.repair, "repair" + net.wg.data.constants.Errors.CANT_NULL);
            this.repair();
            return;
        }

        public function setRefillSettingsS(arg1:String, arg2:Boolean, arg3:Boolean, arg4:Boolean):void
        {
            App.utils.asserter.assertNotNull(this.setRefillSettings, "setRefillSettings" + net.wg.data.constants.Errors.CANT_NULL);
            this.setRefillSettings(arg1, arg2, arg3, arg4);
            return;
        }

        public function showModuleInfoS(arg1:String):void
        {
            App.utils.asserter.assertNotNull(this.showModuleInfo, "showModuleInfo" + net.wg.data.constants.Errors.CANT_NULL);
            this.showModuleInfo(arg1);
            return;
        }

        public function fillVehicleS(arg1:Boolean, arg2:Boolean, arg3:Boolean, arg4:Boolean, arg5:Boolean, arg6:Boolean, arg7:Array, arg8:Array):void
        {
            App.utils.asserter.assertNotNull(this.fillVehicle, "fillVehicle" + net.wg.data.constants.Errors.CANT_NULL);
            this.fillVehicle(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
            return;
        }

        public var getEquipment:Function=null;

        public var repair:Function=null;

        public var setRefillSettings:Function=null;

        public var showModuleInfo:Function=null;

        public var fillVehicle:Function=null;
    }
}
