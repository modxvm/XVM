package net.wg.gui.lobby.vehicleCustomization.data.purchase
{
    import net.wg.data.daapi.base.DAAPIDataClass;

    public class InitBuyWindowVO extends DAAPIDataClass
    {

        public var windowTitle:String = "";

        public var titleText:String = "";

        public var titleTextSmall:String = "";

        public var isStyle:Boolean = false;

        public var haveAutoprolongation:Boolean = false;

        public var autoprolongationSelected:Boolean = false;

        public var prolongStyleRent:Boolean = false;

        public function InitBuyWindowVO(param1:Object)
        {
            super(param1);
        }
    }
}
