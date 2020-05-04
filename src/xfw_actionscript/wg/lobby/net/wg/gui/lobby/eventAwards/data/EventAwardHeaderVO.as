package net.wg.gui.lobby.eventAwards.data
{
    import net.wg.data.daapi.base.DAAPIDataClass;

    public class EventAwardHeaderVO extends DAAPIDataClass
    {

        public var header:String = "";

        public var headerExtra:String = "";

        public function EventAwardHeaderVO(param1:Object = null)
        {
            super(param1);
        }
    }
}
