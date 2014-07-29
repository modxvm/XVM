package net.wg.gui.cyberSport.controls.events
{
    import flash.events.Event;
    
    public class CSComponentEvent extends Event
    {
        
        public function CSComponentEvent(param1:String, param2:* = null)
        {
            super(param1,true,true);
            this._data = param2;
        }
        
        public static var LOAD_PREVIOUS_REQUEST:String = "loadPreviousRequest";
        
        public static var LOAD_NEXT_REQUEST:String = "loadNextRequest";
        
        public static var TOGGLE_FREEZE_REQUEST:String = "toggleFreezeRequest";
        
        public static var TOGGLE_STATUS_REQUEST:String = "toggleStatusRequest";
        
        public static var CLICK_CONFIGURE_BUTTON:String = "clickConfigureButton";
        
        public static var LOCK_SLOT_REQUEST:String = "lockSlotRequest";
        
        public static var APPLY_ROSTER_SETTINGS:String = "applyRosterSettings";
        
        public static var CANCEL_ROSTER_SETTINGS:String = "cancelRosterSettings";
        
        public static var CLICK_SLOT_SETTINGS_BTN:String = "clickSlotSettingsBtn";
        
        public static var SHOW_SETTINGS_ROSTER_WND:String = "showSettingsRosterWnd";
        
        public static var SHOW_AUTO_SEARCH_VIEW:String = "showAutoSearchView";
        
        public static var AUTO_SEARCH_APPLY_BTN:String = "autoSearchApplyBtn";
        
        public static var AUTO_SEARCH_CANCEL_BTN:String = "autoSearchCancelBtn";
        
        private var _data = null;
        
        public function get data() : *
        {
            return this._data;
        }
    }
}
