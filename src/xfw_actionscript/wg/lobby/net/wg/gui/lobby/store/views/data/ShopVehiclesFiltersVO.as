package net.wg.gui.lobby.store.views.data
{
    public class ShopVehiclesFiltersVO extends VehiclesFiltersVO
    {

        private static const OBTAINING_TYPE_FIELD_NAME:String = "obtainingType";

        public var obtainingType:String = "";

        public function ShopVehiclesFiltersVO(param1:Object)
        {
            super(param1);
        }

        override protected function onDataRead(param1:String, param2:Object) : Boolean
        {
            if(param1 == OBTAINING_TYPE_FIELD_NAME)
            {
                param2[param1] = this.obtainingType;
                return false;
            }
            return super.onDataRead(param1,param2);
        }
    }
}
