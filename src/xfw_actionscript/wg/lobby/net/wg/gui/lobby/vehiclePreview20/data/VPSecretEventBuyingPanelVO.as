package net.wg.gui.lobby.vehiclePreview20.data
{
    import net.wg.data.daapi.base.DAAPIDataClass;

    public class VPSecretEventBuyingPanelVO extends DAAPIDataClass
    {

        private static const VEHICLE_COST_FIELD:String = "vehicleCost";

        public var messageLabel:String = "";

        public var messageTooltip:String = "";

        public var buyButtonEnabled:Boolean = false;

        public var buyButtonLabel:String = "";

        public var vehicleCost:VPVehicleCostWithDiscountVO = null;

        public function VPSecretEventBuyingPanelVO(param1:Object)
        {
            super(param1);
        }

        override protected function onDataWrite(param1:String, param2:Object) : Boolean
        {
            if(param1 == VEHICLE_COST_FIELD && param2 != null)
            {
                this.vehicleCost = new VPVehicleCostWithDiscountVO(param2);
                return false;
            }
            return super.onDataWrite(param1,param2);
        }

        override protected function onDispose() : void
        {
            if(this.vehicleCost != null)
            {
                this.vehicleCost.dispose();
                this.vehicleCost = null;
            }
            super.onDispose();
        }
    }
}
