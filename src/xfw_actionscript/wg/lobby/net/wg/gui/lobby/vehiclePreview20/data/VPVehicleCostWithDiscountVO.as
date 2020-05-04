package net.wg.gui.lobby.vehiclePreview20.data
{
    import net.wg.data.daapi.base.DAAPIDataClass;

    public class VPVehicleCostWithDiscountVO extends DAAPIDataClass
    {

        public var buyValueLabel:String = "";

        public var buyValueOldLabel:String = "";

        public var discount:int;

        public function VPVehicleCostWithDiscountVO(param1:Object)
        {
            super(param1);
        }
    }
}
