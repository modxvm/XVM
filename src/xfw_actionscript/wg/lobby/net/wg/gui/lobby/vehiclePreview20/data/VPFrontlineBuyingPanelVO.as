package net.wg.gui.lobby.vehiclePreview20.data
{
    import net.wg.data.daapi.base.DAAPIDataClass;

    public class VPFrontlineBuyingPanelVO extends DAAPIDataClass
    {

        public var title:String = "";

        public var price:String = "";

        public var buyButtonEnabled:Boolean = false;

        public var buyButtonLabel:String = "";

        public var buyButtonTooltip:String = "";

        public function VPFrontlineBuyingPanelVO(param1:Object)
        {
            super(param1);
        }
    }
}
