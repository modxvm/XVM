package net.wg.gui.lobby.vehicleCustomization.data
{
    import net.wg.data.daapi.base.DAAPIDataClass;

    public class CustomizationItemPopoverHeaderVO extends DAAPIDataClass
    {

        public var title:String = "";

        public var counterText:String = "";

        public var checkBoxText:String = "";

        public var currentSeasonImage:String = "";

        public function CustomizationItemPopoverHeaderVO(param1:Object)
        {
            super(param1);
        }
    }
}
