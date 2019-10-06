package net.wg.gui.lobby.vehiclePreview.events
{
    import flash.events.Event;

    public class VehPreviewEvent extends Event
    {

        public static const BUY_CLICK:String = "buyClick";

        public static const CLOSE_CLICK:String = "closeClick";

        public static const BACK_CLICK:String = "backClick";

        public static const COMPARE_CLICK:String = "compareClick";

        public function VehPreviewEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
        {
            super(param1,param2,param3);
        }
    }
}
