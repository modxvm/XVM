package net.wg.gui.lobby.store 
{
    import flash.events.*;
    
    public class StoreViewsEvent extends flash.events.Event
    {
        public function StoreViewsEvent(arg1:String, arg2:String)
        {
            super(arg1, false, false);
            this.viewType = arg2;
            return;
        }

        public static const POPULATE_MENU_FILTER:String="populateMenuFilter";

        public static const VIEW_CHANGE:String="onStoreViewChange";

        public var viewType:String=null;
    }
}
