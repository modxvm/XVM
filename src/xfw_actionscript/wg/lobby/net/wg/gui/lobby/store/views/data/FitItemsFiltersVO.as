package net.wg.gui.lobby.store.views.data
{
    public class FitItemsFiltersVO extends FiltersVO
    {

        private static const VEHICLE_CD_FIELD_NAME:String = "vehicleCD";

        private static const FITS_TYPE_FIELD_NAME:String = "fitsType";

        public var vehicleCD:Number = 0;

        public var fitsType:String = "";

        public function FitItemsFiltersVO(param1:Object)
        {
            super(param1);
        }

        override protected function onDataRead(param1:String, param2:Object) : Boolean
        {
            if(param1 == VEHICLE_CD_FIELD_NAME)
            {
                param2[param1] = this.vehicleCD;
                return false;
            }
            if(param1 == FITS_TYPE_FIELD_NAME)
            {
                param2[param1] = this.fitsType;
                return false;
            }
            return super.onDataRead(param1,param2);
        }
    }
}
