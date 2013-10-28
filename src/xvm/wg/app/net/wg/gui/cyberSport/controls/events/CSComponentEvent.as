package net.wg.gui.cyberSport.controls.events
{
   import flash.events.Event;


   public class CSComponentEvent extends Event
   {
          
      public function CSComponentEvent(param1:String, param2:*=null) {
         super(param1,true,true);
         this._data = param2;
      }

      public static const CHOOSE_VEHICLE:String = "chooseVehicle";

      public static const NEW_PAGE_REQUEST:String = "newPageRequest";

      public static const LOAD_PREVIOUS_REQUEST:String = "loadPreviousRequest";

      public static const LOAD_NEXT_REQUEST:String = "loadNextRequest";

      public static const ASSIGN_SLOT_REQUEST:String = "takePlaceRequest";

      public static const LEAVE_SLOT_REQUEST:String = "leavePlaceRequest";

      public static const TOGGLE_FREEZE_REQUEST:String = "toggleFreezeRequest";

      public static const TOGGLE_STATUS_REQUEST:String = "toggleStatusRequest";

      public static const TOGGLE_READY_STATE_REQUEST:String = "toggleReadyStateRequest";

      public static const INVITE_FRIEND_REQUEST:String = "inviteFriendRequest";

      public static const CLICK_CONFIGURE_BUTTON:String = "clickConfigureButton";

      public static const EDIT_UNIT_DESCRIPTION:String = "editUnitDescription";

      public static const APPLY_ROSTER_SETTINGS:String = "applyRosterSettings";

      public static const CANCEL_ROSTER_SETTINGS:String = "cancelRosterSettings";

      public static const JOIN_UNIT_REQUEST:String = "joinUnitRequest";

      public static const LOCK_SLOT_REQUEST:String = "lockSlotRequest";

      public static const IGNORE_USER_REQUEST:String = "ignoreUserRequest";

      public static const CLICK_SLOT_SETTINGS_BTN:String = "clickSlotSettingsBtn";

      public static const SHOW_SETTINGS_ROSTER_WND:String = "showSettingsRosterWnd";

      public static const SHOW_AUTO_SEARCH_VIEW:String = "showAutoSearchView";

      public static const AUTO_SEARCH_APPLY_BTN:String = "autoSearchApplyBtn";

      public static const AUTO_SEARCH_CANCEL_BTN:String = "autoSearchCancelBtn";

      public static const SHOW_FAQ_WINDOW:String = "showFAQWindow";

      private var _data = null;

      public function get data() : * {
         return this._data;
      }
   }

}