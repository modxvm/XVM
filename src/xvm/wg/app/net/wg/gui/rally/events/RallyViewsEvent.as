package net.wg.gui.rally.events
{
    import flash.events.Event;
    
    public class RallyViewsEvent extends Event
    {
        
        public function RallyViewsEvent(param1:String, param2:* = null)
        {
            super(param1,true,false);
            this.data = param2;
        }
        
        public static var CHOOSE_VEHICLE:String = "chooseVehicle";
        
        public static var LOAD_VIEW_REQUEST:String = "loadViewRequest";
        
        public static var BACK_NAVIGATION_REQUEST:String = "backNavigationRequest";
        
        public static var JOIN_RALLY_REQUEST:String = "joinRallyRequest";
        
        public static var ASSIGN_SLOT_REQUEST:String = "takePlaceRequest";
        
        public static var INVITE_FRIEND_REQUEST:String = "inviteFriendRequest";
        
        public static var IGNORE_USER_REQUEST:String = "ignoreUserRequest";
        
        public static var TOGGLE_READY_STATE_REQUEST:String = "toggleReadyStateRequest";
        
        public static var EDIT_RALLY_DESCRIPTION:String = "editRallyDescription";
        
        public static var SHOW_FAQ_WINDOW:String = "showFAQWindow";
        
        public static var LEAVE_SLOT_REQUEST:String = "leavePlaceRequest";
        
        public static var VEH_BTN_ROLL_OVER:String = "vehBtnRollOver";
        
        public static var VEH_BTN_ROLL_OUT:String = "vehBtnRollOut";
        
        public var data;
        
        override public function clone() : Event
        {
            return new RallyViewsEvent(type,this.data);
        }
    }
}
