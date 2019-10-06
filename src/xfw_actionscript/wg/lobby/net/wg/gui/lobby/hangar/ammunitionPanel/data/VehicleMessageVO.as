package net.wg.gui.lobby.hangar.ammunitionPanel.data
{
    import net.wg.data.daapi.base.DAAPIDataClass;

    public class VehicleMessageVO extends DAAPIDataClass
    {

        public var message:String = "";

        public var rentAvailable:Boolean = false;

        public var isBackground:Boolean = false;

        public function VehicleMessageVO(param1:Object)
        {
            super(param1);
        }
    }
}
