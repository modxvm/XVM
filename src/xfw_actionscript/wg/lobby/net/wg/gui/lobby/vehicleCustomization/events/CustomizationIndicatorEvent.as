package net.wg.gui.lobby.vehicleCustomization.events
{
    import flash.events.Event;

    public class CustomizationIndicatorEvent extends Event
    {

        public static const REMOVAL:String = "ItemAssignedToTankRemovalEvent";

        private var _id:Number;

        private var _itemsList:Object;

        public function CustomizationIndicatorEvent(param1:String, param2:Number, param3:Object)
        {
            super(param1,true,false);
            this._id = param2;
            this._itemsList = param3;
        }

        override public function clone() : Event
        {
            return new CustomizationIndicatorEvent(type,this._id,this._itemsList);
        }

        override public function toString() : String
        {
            return formatToString("CustomizationIndicatorEvent","type","id","itemsList");
        }

        public function get id() : Number
        {
            return this._id;
        }

        public function get itemsList() : Object
        {
            return this._itemsList;
        }
    }
}
