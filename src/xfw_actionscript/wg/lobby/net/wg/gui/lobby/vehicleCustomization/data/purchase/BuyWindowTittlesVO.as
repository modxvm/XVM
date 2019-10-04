package net.wg.gui.lobby.vehicleCustomization.data.purchase
{
    import net.wg.data.daapi.base.DAAPIDataClass;

    public class BuyWindowTittlesVO extends DAAPIDataClass
    {

        public var summerTitle:String = "";

        public var winterTitle:String = "";

        public var desertTitle:String = "";

        public var summerSmallTitle:String = "";

        public var winterSmallTitle:String = "";

        public var desertSmallTitle:String = "";

        public function BuyWindowTittlesVO(param1:Object)
        {
            super(param1);
        }
    }
}
