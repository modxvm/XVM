package net.wg.gui.lobby.eventItemsTradeCongratulation.data
{
    import net.wg.data.daapi.base.DAAPIDataClass;

    public class EventItemsTradeCongratulationVO extends DAAPIDataClass
    {

        public var header:String = "";

        public var title:String = "";

        public var description:String = "";

        public var btnLabel:String = "";

        public var multiplier:String = "";

        public var item:String = "";

        public var sign:String = "";

        public function EventItemsTradeCongratulationVO(param1:Object)
        {
            super(param1);
        }
    }
}
