package net.wg.gui.events 
{
    import flash.events.*;
    
    public class VehicleSellDialogEvent extends flash.events.Event
    {
        public function VehicleSellDialogEvent(arg1:String, arg2:Number=0)
        {
            super(arg1, true, true);
            this.listVisibleHight = arg2;
            return;
        }

        public override function clone():flash.events.Event
        {
            return new net.wg.gui.events.VehicleSellDialogEvent(type, this.listVisibleHight);
        }

        public static const LIST_WAS_DRAWN:String="listWasDrawn";

        public static const UPDATE_RESULT:String="updateResult";

        public var listVisibleHight:Number;
    }
}
