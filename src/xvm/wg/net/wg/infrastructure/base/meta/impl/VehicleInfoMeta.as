package net.wg.infrastructure.base.meta.impl 
{
    import net.wg.data.constants.*;
    import net.wg.infrastructure.base.*;
    
    public class VehicleInfoMeta extends net.wg.infrastructure.base.AbstractWindowView
    {
        public function VehicleInfoMeta()
        {
            super();
            return;
        }

        public function getVehicleInfoS():void
        {
            App.utils.asserter.assertNotNull(this.getVehicleInfo, "getVehicleInfo" + net.wg.data.constants.Errors.CANT_NULL);
            this.getVehicleInfo();
            return;
        }

        public function onCancelClickS():void
        {
            App.utils.asserter.assertNotNull(this.onCancelClick, "onCancelClick" + net.wg.data.constants.Errors.CANT_NULL);
            this.onCancelClick();
            return;
        }

        public var getVehicleInfo:Function=null;

        public var onCancelClick:Function=null;
    }
}
