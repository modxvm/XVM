package net.wg.gui.lobby.retrainCrewWindow
{
    import net.wg.data.daapi.base.DAAPIDataClass;
    
    public class RetrainCrewVehicleVO extends DAAPIDataClass
    {
        
        public function RetrainCrewVehicleVO(param1:Object) {
            super(param1);
        }
        
        public var vehicle:Object;
        
        private var _vehicleBlockVO:RetrainVehicleBlockVO;
        
        override protected function onDataWrite(param1:String, param2:Object) : Boolean {
            if(param1 == "vehicle")
            {
                this._vehicleBlockVO = new RetrainVehicleBlockVO(param2);
                return false;
            }
            return this.hasOwnProperty(param1);
        }
        
        public function get vehicleBlockVO() : RetrainVehicleBlockVO {
            return this._vehicleBlockVO;
        }
    }
}
