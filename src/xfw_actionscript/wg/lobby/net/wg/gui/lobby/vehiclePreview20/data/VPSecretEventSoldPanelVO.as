package net.wg.gui.lobby.vehiclePreview20.data
{
    import net.wg.data.daapi.base.DAAPIDataClass;

    public class VPSecretEventSoldPanelVO extends DAAPIDataClass
    {

        public var restoreButtonEnabled:Boolean = false;

        public var restoreButtonLabel:String = "";

        public var restoreButtonHeader:String = "";

        public var restoreCostLabel:String = "";

        public var buttonTooltip:String = "";

        public var isShowSpecialTooltip:Boolean = false;

        public function VPSecretEventSoldPanelVO(param1:Object)
        {
            super(param1);
        }
    }
}
