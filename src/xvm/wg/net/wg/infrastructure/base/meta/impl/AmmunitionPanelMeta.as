package net.wg.infrastructure.base.meta.impl 
{
    import net.wg.data.constants.*;
    import net.wg.infrastructure.base.*;
    
    public class AmmunitionPanelMeta extends net.wg.infrastructure.base.BaseDAAPIComponent
    {
        public function AmmunitionPanelMeta()
        {
            super();
            return;
        }

        public function setVehicleModuleS(arg1:String, arg2:int, arg3:String, arg4:Boolean):void
        {
            App.utils.asserter.assertNotNull(this.setVehicleModule, "setVehicleModule" + net.wg.data.constants.Errors.CANT_NULL);
            this.setVehicleModule(arg1, arg2, arg3, arg4);
            return;
        }

        public function showModuleInfoS(arg1:String):void
        {
            App.utils.asserter.assertNotNull(this.showModuleInfo, "showModuleInfo" + net.wg.data.constants.Errors.CANT_NULL);
            this.showModuleInfo(arg1);
            return;
        }

        public function showTechnicalMaintenanceS():void
        {
            App.utils.asserter.assertNotNull(this.showTechnicalMaintenance, "showTechnicalMaintenance" + net.wg.data.constants.Errors.CANT_NULL);
            this.showTechnicalMaintenance();
            return;
        }

        public function showCustomizationS():void
        {
            App.utils.asserter.assertNotNull(this.showCustomization, "showCustomization" + net.wg.data.constants.Errors.CANT_NULL);
            this.showCustomization();
            return;
        }

        public function highlightParamsS(arg1:String):void
        {
            App.utils.asserter.assertNotNull(this.highlightParams, "highlightParams" + net.wg.data.constants.Errors.CANT_NULL);
            this.highlightParams(arg1);
            return;
        }

        public var setVehicleModule:Function=null;

        public var showModuleInfo:Function=null;

        public var showTechnicalMaintenance:Function=null;

        public var showCustomization:Function=null;

        public var highlightParams:Function=null;
    }
}
