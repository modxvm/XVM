package net.wg.gui.events
{
    import flash.events.Event;

    public class VehicleSellDialogEvent extends Event
    {

        public static const LIST_WAS_DRAWN:String = "listWasDrawn";

        public static const SELL_DIALOG_LIST_ITEM_RENDERER_WAS_DRAWN:String = "sellDialogListItemRendererWasDrawn";

        public static const UPDATE_RESULT:String = "updateResult";

        public var listVisibleHight:Number;

        public function VehicleSellDialogEvent(param1:String, param2:Number = 0)
        {
            super(param1,true,true);
            this.listVisibleHight = param2;
        }

        override public function clone() : Event
        {
            return new VehicleSellDialogEvent(type,this.listVisibleHight);
        }
    }
}
