package net.wg.gui.lobby.store.evnts
{
    import flash.events.Event;

    public class StoreViewStackEvent extends Event
    {

        public static const SWITCH_TO_VIEW:String = "onNeedSwitchToView";

        public var viewId:String = null;

        public function StoreViewStackEvent(param1:String, param2:String)
        {
            super(param1,false,false);
            this.viewId = param2;
        }
    }
}
