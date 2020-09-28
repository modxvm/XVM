package net.wg.gui.lobby.battlequeue
{
    import net.wg.data.daapi.base.DAAPIDataClass;

    public class WTEventChangeVehicleWidgetVO extends DAAPIDataClass
    {

        public var vehicleName:String = "";

        public var changeTitle:String = "";

        public var btnLabel:String = "";

        public var calculatedText:String = "";

        public var waitingTime:String = "";

        public var ticketText:String = "";

        public var needTicket:Boolean = false;

        public var isBoss:Boolean = false;

        public function WTEventChangeVehicleWidgetVO(param1:Object)
        {
            super(param1);
        }
    }
}
