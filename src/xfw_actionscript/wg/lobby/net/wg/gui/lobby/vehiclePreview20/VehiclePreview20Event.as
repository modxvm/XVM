package net.wg.gui.lobby.vehiclePreview20
{
    import flash.events.Event;

    public class VehiclePreview20Event extends Event
    {

        public static const SELECT:String = "VehiclePreview20Event:select";

        public static const SHOW:String = "VehiclePreview20Event:show";

        public static const SHOW_TOOLTIP:String = "VehiclePreview20Event:showTooltip";

        private var _data:Object;

        public function VehiclePreview20Event(param1:String, param2:Object)
        {
            super(param1,true,false);
            this._data = param2;
        }

        override public function clone() : Event
        {
            return new VehiclePreview20Event(type,this.data);
        }

        override public function toString() : String
        {
            return formatToString("VehiclePreview20Event","type","data");
        }

        public function get data() : Object
        {
            return this._data;
        }
    }
}
