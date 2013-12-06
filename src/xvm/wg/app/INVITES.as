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

      public static const INVITES_PREBATTLE_ACCEPTNOTALLOWED_SQUADALREADYJOINED:String = "#invites:invites/prebattle/acceptNotAllowed/squadAlreadyJoined";

      public static const INVITES_PREBATTLE_ACCEPTNOTALLOWED_COMPANYALREADYJOINED:String = "#invites:invites/prebattle/acceptNotAllowed/companyAlreadyJoined";

      public static const INVITES_PREBATTLE_ACCEPTNOTALLOWED_TRAININGALREADYJOINED:String = "#invites:invites/prebattle/acceptNotAllowed/trainingAlreadyJoined";

      public static const INVITES_PREBATTLE_ACCEPTNOTALLOWED_CLANALREADYJOINED:String = "#invites:invites/prebattle/acceptNotAllowed/clanAlreadyJoined";

      public static const INVITES_PREBATTLE_ACCEPTNOTALLOWED_TOURNAMENTALREADYJOINED:String = "#invites:invites/prebattle/acceptNotAllowed/tournamentAlreadyJoined";

      public static const INVITES_PREBATTLE_ACCEPTNOTALLOWED_UNITALREADYJOINED:String = "#invites:invites/prebattle/acceptNotAllowed/unitAlreadyJoined";

      public static const INVITES_SQUAD_INVITE:String = "#invites:invites/squad/invite";

      public static const INVITES_SQUAD_ACCEPT:String = "#invites:invites/squad/accept";

      public static const INVITES_SQUAD_REJECT:String = "#invites:invites/squad/reject";

      public static const INVITES_SQUAD_INVALIDINVITE_SENDER_SIDE:String = "#invites:invites/squad/invalidInvite/sender-side";

      public static const INVITES_SQUAD_INVALIDINVITE_RECEIVER_SIDE:String = "#invites:invites/squad/invalidInvite/receiver-side";

      public static const INVITES_COMPANY_INVITE:String = "#invites:invites/company/invite";

      public static const INVITES_COMPANY_ACCEPT:String = "#invites:invites/company/accept";

      public static const INVITES_COMPANY_REJECT:String = "#invites:invites/company/reject";

      public static const INVITES_COMPANY_INVALIDINVITE_SENDER_SIDE:String = "#invites:invites/company/invalidInvite/sender-side";

      public static const INVITES_COMPANY_INVALIDINVITE_RECEIVER_SIDE:String = "#invites:invites/company/invalidInvite/receiver-side";

      public static const INVITES_TRAINING_INVITE:String = "#invites:invites/training/invite";

      public static const INVITES_TRAINING_ACCEPT:String = "#invites:invites/training/accept";

      public static const INVITES_TRAINING_REJECT:String = "#invites:invites/training/reject";

      public static const INVITES_TRAINING_INVALIDINVITE_SENDER_SIDE:String = "#invites:invites/training/invalidInvite/sender-side";

      public static const INVITES_TRAINING_INVALIDINVITE_RECEIVER_SIDE:String = "#invites:invites/training/invalidInvite/receiver-side";

      public static const INVITES_UNIT_INVITE:String = "#invites:invites/unit/invite";

      public static const INVITES_UNIT_ACCEPT:String = "#invites:invites/unit/accept";

      public static const INVITES_UNIT_REJECT:String = "#invites:invites/unit/reject";

      public static const INVITES_UNIT_INVALIDINVITE_SENDER_SIDE:String = "#invites:invites/unit/invalidInvite/sender-side";

      public static const INVITES_UNIT_INVALIDINVITE_RECEIVER_SIDE:String = "#invites:invites/unit/invalidInvite/receiver-side";

      public static const INVITES_NOTE_SERVER_CHANGE:String = "#invites:invites/note/server_change";

      public static const INVITES_NOTE_COMPANY_LEAVE:String = "#invites:invites/note/company/leave";

      public static const INVITES_NOTE_COMPANY_LEAVE_AND_CHANGE:String = "#invites:invites/note/company/leave_and_change";

      public static const INVITES_NOTE_SQUAD_LEAVE:String = "#invites:invites/note/squad/leave";

      public static const INVITES_NOTE_SQUAD_LEAVE_AND_CHANGE:String = "#invites:invites/note/squad/leave_and_change";

      public static const INVITES_NOTE_TRAINING_LEAVE:String = "#invites:invites/note/training/leave";

      public static const INVITES_NOTE_TRAINING_LEAVE_AND_CHANGE:String = "#invites:invites/note/training/leave_and_change";

      public static const INVITES_NOTE_UNIT_LEAVE:String = "#invites:invites/note/unit/leave";

      public static const INVITES_NOTE_UNIT_LEAVE_AND_CHANGE:String = "#invites:invites/note/unit/leave_and_change";

      public static const INVITES_NOTE_CLAN_LEAVE:String = "#invites:invites/note/clan/leave";

      public static const INVITES_NOTE_CLAN_LEAVE_AND_CHANGE:String = "#invites:invites/note/clan/leave_and_change";

      public static const INVITES_NOTE_TOURNAMENT_LEAVE:String = "#invites:invites/note/tournament/leave";

      public static const INVITES_NOTE_TOURNAMENT_LEAVE_AND_CHANGE:String = "#invites:invites/note/tournament/leave_and_change";

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
   }

}