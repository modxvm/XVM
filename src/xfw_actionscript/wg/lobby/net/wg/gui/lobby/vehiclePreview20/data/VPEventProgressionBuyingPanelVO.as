package net.wg.gui.lobby.vehiclePreview20.data
{
    import net.wg.data.daapi.base.DAAPIDataClass;

    public class VPEventProgressionBuyingPanelVO extends DAAPIDataClass
    {

        public var title:String = "";

        public var money:String = "";

        public var price:String = "";

        public var buyButtonEnabled:Boolean = false;

        public var buyButtonLabel:String = "";

        public var buyButtonTooltip:String = "";

        public function VPEventProgressionBuyingPanelVO(param1:Object)
        {
            super(param1);
        }
    }
}
