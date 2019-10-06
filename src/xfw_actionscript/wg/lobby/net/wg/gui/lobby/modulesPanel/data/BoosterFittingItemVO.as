package net.wg.gui.lobby.modulesPanel.data
{
    public class BoosterFittingItemVO extends DeviceVO
    {

        public var desc:String = "";

        public var notAffectedTTC:Boolean = false;

        public var count:int = -1;

        public var removable:Boolean = true;

        public var buyButtonLabel:String = "";

        public var buyButtonTooltip:String = "";

        public var buyButtonVisible:Boolean = false;

        public function BoosterFittingItemVO(param1:Object)
        {
            super(param1);
        }
    }
}
