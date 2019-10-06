package net.wg.gui.lobby.modulesPanel.data
{
    public class OptionalDeviceVO extends DeviceVO
    {

        public var removable:Boolean = false;

        public var desc:String = "";

        public var notAffectedTTCTooltip:String = "";

        public var notAffectedTTC:Boolean = false;

        public function OptionalDeviceVO(param1:Object)
        {
            super(param1);
        }
    }
}
