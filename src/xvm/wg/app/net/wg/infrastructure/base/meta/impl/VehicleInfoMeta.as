package net.wg.infrastructure.base.meta.impl
{
    import net.wg.infrastructure.base.AbstractWindowView;
    import net.wg.data.constants.Errors;
    
    public class VehicleInfoMeta extends AbstractWindowView
    {
        
        public function VehicleInfoMeta()
        {
            super();
        }
        
        public var getVehicleInfo:Function = null;
        
        public var onCancelClick:Function = null;
        
        public function getVehicleInfoS() : void
        {
            App.utils.asserter.assertNotNull(this.getVehicleInfo,"getVehicleInfo" + Errors.CANT_NULL);
            this.getVehicleInfo();
        }
        
        public function onCancelClickS() : void
        {
            App.utils.asserter.assertNotNull(this.onCancelClick,"onCancelClick" + Errors.CANT_NULL);
            this.onCancelClick();
        }
    }
}
