package 
{
   public class INVITES extends Object
   {
      
      public function INVITES() {
         super();
      }
      
      public static const ERRORS_UNKNOWNUSER:String = "#invites:errors/unknownuser";
      
      public static const ERRORS_USEROFFLINE:String = "#invites:errors/useroffline";
      
      public static const ERRORS_SELFINVITE:String = "#invites:errors/selfinvite";
      
      public static const ERRORS_INVITENOTSUPPORTED:String = "#invites:errors/inviteNotSupported";
      
      public static const ERRORS_CREATIONNOTALLOWED:String = "#invites:errors/creationNotAllowed";
      
      public static const ERRORS_RECEIVERIGNORESENDER:String = "#invites:errors/receiverIgnoreSender";
      
      public static const ERRORS_VEHICLEBROKENORLOCKED:String = "#invites:errors/vehicleBrokenOrLocked";
      
      public static const ERRORS_INVALID:String = "#invites:errors/invalid";
      
      public static const INVITES_PREBATTLE_ACCEPTNOTALLOWED_UNDEFINEDPERIPHERY:String = "#invites:invites/prebattle/acceptNotAllowed/undefinedPeriphery";
      
      public static const INVITES_PREBATTLE_ACCEPTNOTALLOWED_OTHERPERIPHERY:String = "#invites:invites/prebattle/acceptNotAllowed/otherPeriphery";
      
      public static const INVITES_PREBATTLE_ALREADYJOINED_SQUAD:String = "#invites:invites/prebattle/alreadyJoined/SQUAD";
      
      public static const INVITES_PREBATTLE_ALREADYJOINED_COMPANY:String = "#invites:invites/prebattle/alreadyJoined/COMPANY";
      
      public static const INVITES_PREBATTLE_ALREADYJOINED_TRAINING:String = "#invites:invites/prebattle/alreadyJoined/TRAINING";
      
      public static const INVITES_PREBATTLE_ALREADYJOINED_CLAN:String = "#invites:invites/prebattle/alreadyJoined/CLAN";
      
      public static const INVITES_PREBATTLE_ALREADYJOINED_TOURNAMENT:String = "#invites:invites/prebattle/alreadyJoined/TOURNAMENT";
      
      public static const INVITES_PREBATTLE_ALREADYJOINED_UNIT:String = "#invites:invites/prebattle/alreadyJoined/UNIT";
      
      public static const INVITES_PREBATTLE_ALREADYJOINED_SORTIE:String = "#invites:invites/prebattle/alreadyJoined/SORTIE";
      
      public static const INVITES_TEXT_SQUAD:String = "#invites:invites/text/SQUAD";
      
      public static const INVITES_TEXT_COMPANY:String = "#invites:invites/text/COMPANY";
      
      public static const INVITES_TEXT_TRAINING:String = "#invites:invites/text/TRAINING";
      
      public static const INVITES_TEXT_UNIT:String = "#invites:invites/text/UNIT";
      
      public static const INVITES_TEXT_SORTIE:String = "#invites:invites/text/SORTIE";
      
      public static const INVITES_COMMENT:String = "#invites:invites/comment";
      
      public static const INVITES_STATE_ACTIVE:String = "#invites:invites/state/ACTIVE";
      
      public static const INVITES_STATE_ACCEPTED:String = "#invites:invites/state/ACCEPTED";
      
      public static const INVITES_STATE_DECLINED:String = "#invites:invites/state/DECLINED";
      
      public static const INVITES_STATE_EXPIRED:String = "#invites:invites/state/EXPIRED";
      
      public static const INVITES_NOTE_SERVER_CHANGE:String = "#invites:invites/note/server_change";
      
      public static const INVITES_NOTE_LEAVE_COMPANY:String = "#invites:invites/note/leave/COMPANY";
      
      public static const INVITES_NOTE_CHANGE_AND_LEAVE_COMPANY:String = "#invites:invites/note/change_and_leave/COMPANY";
      
      public static const INVITES_NOTE_LEAVE_SQUAD:String = "#invites:invites/note/leave/SQUAD";
      
      public static const INVITES_NOTE_CHANGE_AND_LEAVE_SQUAD:String = "#invites:invites/note/change_and_leave/SQUAD";
      
      public static const INVITES_NOTE_LEAVE_TRAINING:String = "#invites:invites/note/leave/TRAINING";
      
      public static const INVITES_NOTE_CHANGE_AND_LEAVE_TRAINING:String = "#invites:invites/note/change_and_leave/TRAINING";
      
      public static const INVITES_NOTE_LEAVE_UNIT:String = "#invites:invites/note/leave/UNIT";
      
      public static const INVITES_NOTE_CHANGE_AND_LEAVE_UNIT:String = "#invites:invites/note/change_and_leave/UNIT";
      
      public static const INVITES_NOTE_LEAVE_CLAN:String = "#invites:invites/note/leave/CLAN";
      
      public static const INVITES_NOTE_CHANGE_AND_LEAVE_CLAN:String = "#invites:invites/note/change_and_leave/CLAN";
      
      public static const INVITES_NOTE_LEAVE_TOURNAMENT:String = "#invites:invites/note/leave/TOURNAMENT";
      
      public static const INVITES_NOTE_CHANGE_AND_LEAVE_TOURNAMENT:String = "#invites:invites/note/change_and_leave/TOURNAMENT";
      
      public static const INVITES_NOTE_LEAVE_HISTORICAL:String = "#invites:invites/note/leave/HISTORICAL";
      
      public static const INVITES_NOTE_CHANGE_AND_LEAVE_HISTORICAL:String = "#invites:invites/note/change_and_leave/HISTORICAL";
      
      public static const INVITES_NOTE_LEAVE_SORTIE:String = "#invites:invites/note/leave/SORTIE";
      
      public static const INVITES_NOTE_CHANGE_AND_LEAVE_SORTIE:String = "#invites:invites/note/change_and_leave/SORTIE";
      
      public static const GUI_TITLES_RECEIVEDINVITES:String = "#invites:gui/titles/receivedInvites";
      
      public static const GUI_TITLES_INVITE:String = "#invites:gui/titles/invite";
      
      public static const GUI_TITLES_BARTER:String = "#invites:gui/titles/barter";
      
      public static const GUI_TITLES_CLAN:String = "#invites:gui/titles/clan";
      
      public static const GUI_LABELS_RECEIVER:String = "#invites:gui/labels/receiver";
      
      public static const GUI_LABELS_INVITETEXT:String = "#invites:gui/labels/inviteText";
      
      public static const GUI_LABELS_ADDITIONALTEXT:String = "#invites:gui/labels/additionalText";
      
      public static const GUI_BUTTONS_SEND:String = "#invites:gui/buttons/send";
      
      public static const GUI_BUTTONS_ACCEPT:String = "#invites:gui/buttons/accept";
      
      public static const GUI_BUTTONS_REJECT:String = "#invites:gui/buttons/reject";
      
      public static const GUI_BUTTONS_CANCEL:String = "#invites:gui/buttons/cancel";
      
      public static const INVITES_STATE_ENUM:Array;
      
      public static const INVITES_PREBATTLE_ALREADYJOINED_ENUM:Array;
      
      public static const INVITES_PREBATTLE_ACCEPTNOTALLOWED_ENUM:Array;
      
      public static const INVITES_TEXT_ENUM:Array;
      
      public static const INVITES_NOTE_CHANGE_AND_LEAVE_ENUM:Array;
      
      public static const INVITES_NOTE_LEAVE_ENUM:Array;
      
      public static function invites_state(param1:String) : String {
         var _loc2_:String = "#invites:invites/state/" + param1;
         if(INVITES_STATE_ENUM.indexOf(_loc2_) == -1)
         {
            DebugUtils.LOG_WARNING("[invites_state]:locale key \"" + _loc2_ + "\" was not found");
            return null;
         }
         return _loc2_;
      }
      
      public static function invites_prebattle_alreadyjoined(param1:String) : String {
         var _loc2_:String = "#invites:invites/prebattle/alreadyJoined/" + param1;
         if(INVITES_PREBATTLE_ALREADYJOINED_ENUM.indexOf(_loc2_) == -1)
         {
            DebugUtils.LOG_WARNING("[invites_prebattle_alreadyjoined]:locale key \"" + _loc2_ + "\" was not found");
            return null;
         }
         return _loc2_;
      }
      
      public static function invites_prebattle_acceptnotallowed(param1:String) : String {
         var _loc2_:String = "#invites:invites/prebattle/acceptNotAllowed/" + param1;
         if(INVITES_PREBATTLE_ACCEPTNOTALLOWED_ENUM.indexOf(_loc2_) == -1)
         {
            DebugUtils.LOG_WARNING("[invites_prebattle_acceptnotallowed]:locale key \"" + _loc2_ + "\" was not found");
            return null;
         }
         return _loc2_;
      }
      
      public static function invites_text(param1:String) : String {
         var _loc2_:String = "#invites:invites/text/" + param1;
         if(INVITES_TEXT_ENUM.indexOf(_loc2_) == -1)
         {
            DebugUtils.LOG_WARNING("[invites_text]:locale key \"" + _loc2_ + "\" was not found");
            return null;
         }
         return _loc2_;
      }
      
      public static function invites_note_change_and_leave(param1:String) : String {
         var _loc2_:String = "#invites:invites/note/change_and_leave/" + param1;
         if(INVITES_NOTE_CHANGE_AND_LEAVE_ENUM.indexOf(_loc2_) == -1)
         {
            DebugUtils.LOG_WARNING("[invites_note_change_and_leave]:locale key \"" + _loc2_ + "\" was not found");
            return null;
         }
         return _loc2_;
      }
      
      public static function invites_note_leave(param1:String) : String {
         var _loc2_:String = "#invites:invites/note/leave/" + param1;
         if(INVITES_NOTE_LEAVE_ENUM.indexOf(_loc2_) == -1)
         {
            DebugUtils.LOG_WARNING("[invites_note_leave]:locale key \"" + _loc2_ + "\" was not found");
            return null;
         }
         return _loc2_;
      }
   }
}
