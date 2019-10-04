package net.wg.gui.lobby.store
{
    import flash.events.Event;

    public class StoreViewsEvent extends Event
    {

        public static const POPULATE_MENU_FILTER:String = "populateMenuFilter";

        public static const VIEW_CHANGE:String = "onStoreViewChange";

        public var viewType:String = null;

        public function StoreViewsEvent(param1:String, param2:String)
        {
            super(param1,false,false);
            this.viewType = param2;
        }

        override public function clone() : Event
        {
            return new StoreViewsEvent(type,this.viewType);
        }
    }
}
