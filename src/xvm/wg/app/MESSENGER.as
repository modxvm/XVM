package 
{


   public class MESSENGER extends Object
   {
          
      public function MESSENGER() {
         super();
      }

      public static const STATUS_ONLINE:String = "#messenger:status/online";

      public static const STATUS_OFFLINE:String = "#messenger:status/offline";

      public static const LOBBY_BUTTONS_CHANNELS:String = "#messenger:lobby/buttons/channels";

      public static const LOBBY_BUTTONS_CONTACTS:String = "#messenger:lobby/buttons/contacts";

      public static const LOBBY_BUTTONS_SEND:String = "#messenger:lobby/buttons/send";

      public static const LOBBY_BSCHANNELS_TITLE_STARTTIME:String = "#messenger:lobby/bsChannels/title/startTime";

      public static const LOBBY_CHANNELS_ACTIONS_REMOVE:String = "#messenger:lobby/channels/actions/remove";

      public static const LOBBY_CHANNELS_ACTIONS_SETTIME:String = "#messenger:lobby/channels/actions/setTime";

      public static const LOBBY_CHANNELS_ACTIONS_SETDAY:String = "#messenger:lobby/channels/actions/setDay";

      public static const LOBBY_USERS_ACTIONS_SHOWINFO:String = "#messenger:lobby/users/actions/showInfo";

      public static const LOBBY_USERS_ACTIONS_CREATEPRIVATECHANNEL:String = "#messenger:lobby/users/actions/createPrivateChannel";

      public static const LOBBY_USERS_ACTIONS_ADDTOFRIENDS:String = "#messenger:lobby/users/actions/addToFriends";

      public static const LOBBY_USERS_ACTIONS_ADDTOIGNORE:String = "#messenger:lobby/users/actions/addToIgnore";

      public static const LOBBY_USERS_ACTIONS_COPYNAMETOCLIPBOARD:String = "#messenger:lobby/users/actions/copyNameToClipboard";

      public static const LOBBY_FAQ_TITLE:String = "#messenger:lobby/faq/title";

      public static const LOBBY_FAQ_CLOSE:String = "#messenger:lobby/faq/close";

      public static const BATTLE_HINTS_CHANGERECEIVER:String = "#messenger:battle/hints/changeReceiver";

      public static const BATTLE_TOOLTIPS_USINGCHAT:String = "#messenger:battle/toolTips/usingChat";

      public static const BATTLE_TOOLTIPS_STARTCHAT:String = "#messenger:battle/toolTips/startChat";

      public static const BATTLE_TOOLTIPS_DEFAULT:String = "#messenger:battle/toolTips/default";

      public static const BATTLE_TOOLTIPS_WITHALL:String = "#messenger:battle/toolTips/withAll";

      public static const BATTLE_TOOLTIPS_WITHSQUAD:String = "#messenger:battle/toolTips/withSquad";

      public static const BATTLE_TOOLTIPS_DURINGCHAT:String = "#messenger:battle/toolTips/duringChat";

      public static const BATTLE_TOOLTIPS_CHANGERECEIVER:String = "#messenger:battle/toolTips/changeReceiver";

      public static const BATTLE_TOOLTIPS_SEND:String = "#messenger:battle/toolTips/send";

      public static const BATTLE_TOOLTIPS_CANCEL:String = "#messenger:battle/toolTips/cancel";

      public static const BATTLE_RECEIVERS_TEAM:String = "#messenger:battle/receivers/team";

      public static const BATTLE_RECEIVERS_COMMON:String = "#messenger:battle/receivers/common";

      public static const BATTLE_RECEIVERS_SQUAD:String = "#messenger:battle/receivers/squad";

      public static const BATTLE_UNKNOWN_ALLY:String = "#messenger:battle/unknown/ally";

      public static const BATTLE_UNKNOWN_ENEMY:String = "#messenger:battle/unknown/enemy";

      public static const DIALOGS_USERINFO_TITLE:String = "#messenger:dialogs/userInfo/title";

      public static const DIALOGS_USERINFO_LABELS_STATUS:String = "#messenger:dialogs/userInfo/labels/status";

      public static const DIALOGS_USERINFO_LABELS_COMMON:String = "#messenger:dialogs/userInfo/labels/common";

      public static const DIALOGS_USERINFO_LABELS_CREATIONTIME:String = "#messenger:dialogs/userInfo/labels/creationTime";

      public static const DIALOGS_USERINFO_LABELS_LASTBATTLETIME:String = "#messenger:dialogs/userInfo/labels/lastBattleTime";

      public static const DIALOGS_USERINFO_BUTTONS_CREATEPRIVATECHANNEL:String = "#messenger:dialogs/userInfo/buttons/createPrivateChannel";

      public static const DIALOGS_USERINFO_BUTTONS_ADDTOFRIENDS:String = "#messenger:dialogs/userInfo/buttons/addToFriends";

      public static const DIALOGS_USERINFO_BUTTONS_ADDTOIGNORED:String = "#messenger:dialogs/userInfo/buttons/addToIgnored";

      public static const DIALOGS_USERINFO_BUTTONS_ADDMUTED:String = "#messenger:dialogs/userInfo/buttons/addMuted";

      public static const DIALOGS_USERINFO_BUTTONS_REMOVEMUTED:String = "#messenger:dialogs/userInfo/buttons/removeMuted";

      public static const DIALOGS_USERINFO_BUTTONS_CLOSE:String = "#messenger:dialogs/userInfo/buttons/close";

      public static const DIALOGS_USERINFO_BAN_REASON_TITLE:String = "#messenger:dialogs/userInfo/ban_reason/title";

      public static const DIALOGS_USERINFO_BAN_REASON_SUSPICION:String = "#messenger:dialogs/userInfo/ban_reason/suspicion";

      public static const DIALOGS_USERINFO_BAN_REASON_GUILTY:String = "#messenger:dialogs/userInfo/ban_reason/guilty";

      public static const DIALOGS_CHANNELS_TITLE:String = "#messenger:dialogs/channels/title";

      public static const DIALOGS_CHANNELS_BUTTONS_CREATE:String = "#messenger:dialogs/channels/buttons/create";

      public static const DIALOGS_CHANNELS_BUTTONS_SEARCHANDJOIN:String = "#messenger:dialogs/channels/buttons/searchAndJoin";

      public static const DIALOGS_CHANNELS_BUTTONS_CLOSE:String = "#messenger:dialogs/channels/buttons/close";

      public static const DIALOGS_CREATECHANNEL_TITLE:String = "#messenger:dialogs/createChannel/title";

      public static const DIALOGS_CREATECHANNEL_LABELS_NAME:String = "#messenger:dialogs/createChannel/labels/name";

      public static const DIALOGS_CREATECHANNEL_LABELS_PASSWORD:String = "#messenger:dialogs/createChannel/labels/password";

      public static const DIALOGS_CREATECHANNEL_LABELS_USEPASSWORD:String = "#messenger:dialogs/createChannel/labels/usePassword";

      public static const DIALOGS_CREATECHANNEL_LABELS_FILLPASSWORD:String = "#messenger:dialogs/createChannel/labels/fillPassword";

      public static const DIALOGS_CREATECHANNEL_LABELS_RETYPEPASSWORD:String = "#messenger:dialogs/createChannel/labels/retypePassword";

      public static const DIALOGS_CREATECHANNEL_BUTTONS_CREATE:String = "#messenger:dialogs/createChannel/buttons/create";

      public static const DIALOGS_CREATECHANNEL_BUTTONS_CLOSE:String = "#messenger:dialogs/createChannel/buttons/close";

      public static const DIALOGS_CREATECHANNEL_ERRORS_INVALIDNAME_TITLE:String = "#messenger:dialogs/createChannel/errors/invalidName/title";

      public static const DIALOGS_CREATECHANNEL_ERRORS_INVALIDNAME_MESSAGE:String = "#messenger:dialogs/createChannel/errors/invalidName/message";

      public static const DIALOGS_CREATECHANNEL_ERRORS_INVALIDPASSWORD_TITLE:String = "#messenger:dialogs/createChannel/errors/invalidPassword/title";

      public static const DIALOGS_CREATECHANNEL_ERRORS_INVALIDPASSWORD_MESSAGE:String = "#messenger:dialogs/createChannel/errors/invalidPassword/message";

      public static const DIALOGS_CREATECHANNEL_ERRORS_INVALIDRETYPEPASSWORD_TITLE:String = "#messenger:dialogs/createChannel/errors/invalidRetypePassword/title";

      public static const DIALOGS_CREATECHANNEL_ERRORS_INVALIDRETYPEPASSWORD_MESSAGE:String = "#messenger:dialogs/createChannel/errors/invalidRetypePassword/message";

      public static const DIALOGS_CREATECHANNEL_ERRORS_NOTEQUALSPASSWORDS_TITLE:String = "#messenger:dialogs/createChannel/errors/notEqualsPasswords/title";

      public static const DIALOGS_CREATECHANNEL_ERRORS_NOTEQUALSPASSWORDS_MESSAGE:String = "#messenger:dialogs/createChannel/errors/notEqualsPasswords/message";

      public static const DIALOGS_CREATECHANNEL_ERRORS_ACTIVECHANNELLIMITREACHED_TITLE:String = "#messenger:dialogs/createChannel/errors/activeChannelLimitReached/title";

      public static const DIALOGS_CREATECHANNEL_ERRORS_ACTIVECHANNELLIMITREACHED_MESSAGE:String = "#messenger:dialogs/createChannel/errors/activeChannelLimitReached/message";

      public static const DIALOGS_SEARCHCHANNEL_TITLE:String = "#messenger:dialogs/searchChannel/title";

      public static const DIALOGS_SEARCHCHANNEL_LABELS_SEARCH:String = "#messenger:dialogs/searchChannel/labels/search";

      public static const DIALOGS_SEARCHCHANNEL_LABELS_RESULT:String = "#messenger:dialogs/searchChannel/labels/result";

      public static const DIALOGS_SEARCHCHANNEL_BUTTONS_SEARCH:String = "#messenger:dialogs/searchChannel/buttons/search";

      public static const DIALOGS_SEARCHCHANNEL_BUTTONS_JOIN:String = "#messenger:dialogs/searchChannel/buttons/join";

      public static const DIALOGS_SEARCHCHANNEL_BUTTONS_CLOSE:String = "#messenger:dialogs/searchChannel/buttons/close";

      public static const DIALOGS_CONTACTS_TITLE:String = "#messenger:dialogs/contacts/title";

      public static const DIALOGS_CONTACTS_TREE_FRIENDS:String = "#messenger:dialogs/contacts/tree/friends";

      public static const DIALOGS_CONTACTS_TREE_CLAN:String = "#messenger:dialogs/contacts/tree/clan";

      public static const DIALOGS_CONTACTS_TREE_IGNORED:String = "#messenger:dialogs/contacts/tree/ignored";

      public static const DIALOGS_CONTACTS_TREE_MUTED:String = "#messenger:dialogs/contacts/tree/muted";

      public static const DIALOGS_CONTACTS_CONTACT_USERINFO:String = "#messenger:dialogs/contacts/contact/userInfo";

      public static const DIALOGS_CONTACTS_CONTACT_MONEYTRANSFER:String = "#messenger:dialogs/contacts/contact/moneyTransfer";

      public static const DIALOGS_CONTACTS_CONTACT_CREATEPRIVATECHANNEL:String = "#messenger:dialogs/contacts/contact/createPrivateChannel";

      public static const DIALOGS_CONTACTS_CONTACT_ADDTOFRIENDS:String = "#messenger:dialogs/contacts/contact/addToFriends";

      public static const DIALOGS_CONTACTS_CONTACT_REMOVEFROMFRIENDS:String = "#messenger:dialogs/contacts/contact/removeFromFriends";

      public static const DIALOGS_CONTACTS_CONTACT_ADDTOIGNORED:String = "#messenger:dialogs/contacts/contact/addToIgnored";

      public static const DIALOGS_CONTACTS_CONTACT_REMOVEFROMIGNORED:String = "#messenger:dialogs/contacts/contact/removeFromIgnored";

      public static const DIALOGS_CONTACTS_CONTACT_COPYTOCLIPBORAD:String = "#messenger:dialogs/contacts/contact/copyToClipBorad";

      public static const DIALOGS_CONTACTS_GROUP_SORTBYNAME:String = "#messenger:dialogs/contacts/group/sortByName";

      public static const DIALOGS_CONTACTS_GROUP_SORTBYSTATUS:String = "#messenger:dialogs/contacts/group/sortByStatus";

      public static const DIALOGS_CONTACTS_BUTTONS_CLOSE:String = "#messenger:dialogs/contacts/buttons/close";

      public static const DIALOGS_SEARCHCONTACT_TITLE:String = "#messenger:dialogs/searchContact/title";

      public static const DIALOGS_SEARCHCONTACT_LABELS_SEARCH:String = "#messenger:dialogs/searchContact/labels/search";

      public static const DIALOGS_SEARCHCONTACT_LABELS_RESULT:String = "#messenger:dialogs/searchContact/labels/result";

      public static const DIALOGS_SEARCHCONTACT_BUTTONS_SEARCH:String = "#messenger:dialogs/searchContact/buttons/search";

      public static const DIALOGS_SEARCHCONTACT_BUTTONS_ADDTOFRIENDS:String = "#messenger:dialogs/searchContact/buttons/addToFriends";

      public static const DIALOGS_SEARCHCONTACT_BUTTONS_ADDTOIGNORED:String = "#messenger:dialogs/searchContact/buttons/addToIgnored";

      public static const DIALOGS_SEARCHCONTACT_BUTTONS_USERINFO:String = "#messenger:dialogs/searchContact/buttons/userInfo";

      public static const DIALOGS_SEARCHCONTACT_BUTTONS_CLOSE:String = "#messenger:dialogs/searchContact/buttons/close";

      public static const DIALOGS_CONNECTINGTOSECURECHANNEL_TITLE:String = "#messenger:dialogs/connectingToSecureChannel/title";

      public static const DIALOGS_CONNECTINGTOSECURECHANNEL_LABELS_WARRNING:String = "#messenger:dialogs/connectingToSecureChannel/labels/warrning";

      public static const DIALOGS_CONNECTINGTOSECURECHANNEL_LABELS_INFO:String = "#messenger:dialogs/connectingToSecureChannel/labels/info";

      public static const DIALOGS_CONNECTINGTOSECURECHANNEL_LABELS_PASSWORD:String = "#messenger:dialogs/connectingToSecureChannel/labels/password";

      public static const DIALOGS_CONNECTINGTOSECURECHANNEL_BUTTONS_CONNECT:String = "#messenger:dialogs/connectingToSecureChannel/buttons/connect";

      public static const DIALOGS_CONNECTINGTOSECURECHANNEL_BUTTONS_CLOSE:String = "#messenger:dialogs/connectingToSecureChannel/buttons/close";

      public static const DIALOGS_CONNECTINGTOSECURECHANNEL_ERRORS_INVALIDPASSWORD_TITLE:String = "#messenger:dialogs/connectingToSecureChannel/errors/invalidPassword/title";

      public static const DIALOGS_CONNECTINGTOSECURECHANNEL_ERRORS_INVALIDPASSWORD_MESSAGE:String = "#messenger:dialogs/connectingToSecureChannel/errors/invalidPassword/message";

      public static const DIALOGS_SERVICECHANNEL_TITLE:String = "#messenger:dialogs/serviceChannel/title";

      public static const DIALOGS_SQUADCHANNEL_BUTTONS_READY:String = "#messenger:dialogs/squadChannel/buttons/ready";

      public static const DIALOGS_SQUADCHANNEL_BUTTONS_NOTREADY:String = "#messenger:dialogs/squadChannel/buttons/notReady";

      public static const DIALOGS_SQUADCHANNEL_BUTTONS_LEAVE:String = "#messenger:dialogs/squadChannel/buttons/leave";

      public static const DIALOGS_SQUADCHANNEL_BUTTONS_DISMISS:String = "#messenger:dialogs/squadChannel/buttons/dismiss";

      public static const DIALOGS_SQUADCHANNEL_BUTTONS_AFK:String = "#messenger:dialogs/squadChannel/buttons/afk";

      public static const DIALOGS_SQUADCHANNEL_BUTTONS_INVITE:String = "#messenger:dialogs/squadChannel/buttons/invite";

      public static const DIALOGS_SQUADCHANNEL_MESSEGE_NOPREMIUM:String = "#messenger:dialogs/squadChannel/messege/noPremium";

      public static const DIALOGS_SQUADCHANNEL_CONTEXT_KICKPLAYER:String = "#messenger:dialogs/squadChannel/context/kickPlayer";

      public static const DIALOGS_TEAMCHANNEL_CONTEXT_KICKPLAYER:String = "#messenger:dialogs/teamChannel/context/kickPlayer";

      public static const DIALOGS_BSCHANNEL_CONTEXT_KICKPLAYER:String = "#messenger:dialogs/bsChannel/context/kickPlayer";

      public static const DIALOGS_TEAMCHANNEL_BUTTONS_LEAVE:String = "#messenger:dialogs/teamChannel/buttons/leave";

      public static const DIALOGS_TEAMCHANNEL_BUTTONS_DISMISS:String = "#messenger:dialogs/teamChannel/buttons/dismiss";

      public static const DIALOGS_TEAMCHANNEL_BUTTONS_INVITE:String = "#messenger:dialogs/teamChannel/buttons/invite";

      public static const DIALOGS_SQUADCHANNEL_TOOLTIPS_STATUS_OFFLINE:String = "#messenger:dialogs/squadChannel/tooltips/status/offline";

      public static const DIALOGS_SQUADCHANNEL_TOOLTIPS_STATUS_NOTREADY:String = "#messenger:dialogs/squadChannel/tooltips/status/notReady";

      public static const DIALOGS_SQUADCHANNEL_TOOLTIPS_STATUS_READY:String = "#messenger:dialogs/squadChannel/tooltips/status/ready";

      public static const DIALOGS_SQUADCHANNEL_TOOLTIPS_STATUS_INBATTLE:String = "#messenger:dialogs/squadChannel/tooltips/status/inBattle";

      public static const DIALOGS_SQUADCHANNEL_TOOLTIPS_STATUS_AFK:String = "#messenger:dialogs/squadChannel/tooltips/status/afk";

      public static const SERVER_ERRORS_INTERNALERROR_TITLE:String = "#messenger:server/errors/internalError/title";

      public static const SERVER_ERRORS_INTERNALERROR_MESSAGE:String = "#messenger:server/errors/internalError/message";

      public static const SERVER_ERRORS_CHANNELALREADYEXISTS_TITLE:String = "#messenger:server/errors/channelAlreadyExists/title";

      public static const SERVER_ERRORS_CHANNELALREADYEXISTS_MESSAGE:String = "#messenger:server/errors/channelAlreadyExists/message";

      public static const SERVER_ERRORS_CHANNELDESTROYED_TITLE:String = "#messenger:server/errors/channelDestroyed/title";

      public static const SERVER_ERRORS_CHANNELDESTROYED_MESSAGE:String = "#messenger:server/errors/channelDestroyed/message";

      public static const SERVER_ERRORS_PASSWORDREQUIRED_TITLE:String = "#messenger:server/errors/passwordRequired/title";

      public static const SERVER_ERRORS_PASSWORDREQUIRED_MESSAGE:String = "#messenger:server/errors/passwordRequired/message";

      public static const SERVER_ERRORS_INCORRECTPASSWORD_TITLE:String = "#messenger:server/errors/incorrectPassword/title";

      public static const SERVER_ERRORS_INCORRECTPASSWORD_MESSAGE:String = "#messenger:server/errors/incorrectPassword/message";

      public static const SERVER_ERRORS_MEMBERBANNED_TITLE:String = "#messenger:server/errors/memberBanned/title";

      public static const SERVER_ERRORS_MEMBERBANNED_MESSAGE:String = "#messenger:server/errors/memberBanned/message";

      public static const SERVER_ERRORS_CHATBANNED_TITLE:String = "#messenger:server/errors/chatBanned/title";

      public static const SERVER_ERRORS_CHATBANNED_MESSAGE:String = "#messenger:server/errors/chatBanned/message";

      public static const SERVER_ERRORS_MEMBERDISCONNECTING_TITLE:String = "#messenger:server/errors/memberDisconnecting/title";

      public static const SERVER_ERRORS_MEMBERDISCONNECTING_MESSAGE:String = "#messenger:server/errors/memberDisconnecting/message";

      public static const SERVER_ERRORS_NOTALLOWED_TITLE:String = "#messenger:server/errors/notAllowed/title";

      public static const SERVER_ERRORS_NOTALLOWED_MESSAGE:String = "#messenger:server/errors/notAllowed/message";

      public static const SERVER_ERRORS_CONNECTTIMEOUT_TITLE:String = "#messenger:server/errors/connectTimeout/title";

      public static const SERVER_ERRORS_CONNECTTIMEOUT_MESSAGE:String = "#messenger:server/errors/connectTimeout/message";

      public static const SERVER_ERRORS_INITIALIZATIONFAILURE_TITLE:String = "#messenger:server/errors/initializationFailure/title";

      public static const SERVER_ERRORS_INITIALIZATIONFAILURE_MESSAGE:String = "#messenger:server/errors/initializationFailure/message";

      public static const SERVER_ERRORS_USERNOTEXISTS_TITLE:String = "#messenger:server/errors/userNotExists/title";

      public static const SERVER_ERRORS_USERNOTEXISTS_MESSAGE:String = "#messenger:server/errors/userNotExists/message";

      public static const SERVER_ERRORS_USERSROSTERLIMITREACHED_TITLE:String = "#messenger:server/errors/usersRosterLimitReached/title";

      public static const SERVER_ERRORS_USERSROSTERLIMITREACHED_MESSAGE:String = "#messenger:server/errors/usersRosterLimitReached/message";

      public static const SERVER_ERRORS_ACTIVECHANNELSLIMITREACHED_TITLE:String = "#messenger:server/errors/activeChannelsLimitReached/title";

      public static const SERVER_ERRORS_ACTIVECHANNELSLIMITREACHED_MESSAGE:String = "#messenger:server/errors/activeChannelsLimitReached/message";

      public static const SERVER_ERRORS_SQLERROR_TITLE:String = "#messenger:server/errors/sqlError/title";

      public static const SERVER_ERRORS_SQLERROR_MESSAGE:String = "#messenger:server/errors/sqlError/message";

      public static const SERVER_ERRORS_INCORRECTCHARACTER_TITLE:String = "#messenger:server/errors/incorrectCharacter/title";

      public static const SERVER_ERRORS_INCORRECTCHARACTER_MESSAGE:String = "#messenger:server/errors/incorrectCharacter/message";

      public static const SERVER_ERRORS_ADDFRIENDERROR_TITLE:String = "#messenger:server/errors/addFriendError/title";

      public static const SERVER_ERRORS_ADDFRIENDERROR_MESSAGE:String = "#messenger:server/errors/addFriendError/message";

      public static const SERVER_ERRORS_ADDIGNOREDERROR_TITLE:String = "#messenger:server/errors/addIgnoredError/title";

      public static const SERVER_ERRORS_ADDIGNOREDERROR_MESSAGE:String = "#messenger:server/errors/addIgnoredError/message";

      public static const SERVER_ERRORS_USERIGNOREDERROR_TITLE:String = "#messenger:server/errors/userIgnoredError/title";

      public static const SERVER_ERRORS_USERIGNOREDERROR_MESSAGE:String = "#messenger:server/errors/userIgnoredError/message";

      public static const SERVER_ERRORS_CHATCOMMANDERROR_TITLE:String = "#messenger:server/errors/chatCommandError/title";

      public static const SERVER_ERRORS_CHATCOMMANDERROR_MESSAGE:String = "#messenger:server/errors/chatCommandError/message";

      public static const SERVER_ERRORS_MEMBERALREADYBANNED_TITLE:String = "#messenger:server/errors/memberAlreadyBanned/title";

      public static const SERVER_ERRORS_MEMBERALREADYBANNED_MESSAGE:String = "#messenger:server/errors/memberAlreadyBanned/message";

      public static const SERVER_ERRORS_MEMBERALREADYMODERATOR_TITLE:String = "#messenger:server/errors/memberAlreadyModerator/title";

      public static const SERVER_ERRORS_MEMBERALREADYMODERATOR_MESSAGE:String = "#messenger:server/errors/memberAlreadyModerator/message";

      public static const SERVER_ERRORS_MEMBERNOTMODERATOR_TITLE:String = "#messenger:server/errors/memberNotModerator/title";

      public static const SERVER_ERRORS_MEMBERNOTMODERATOR_MESSAGE:String = "#messenger:server/errors/memberNotModerator/message";

      public static const SERVER_ERRORS_COMMANDINCOOLDOWN_TITLE:String = "#messenger:server/errors/commandInCooldown/title";

      public static const SERVER_ERRORS_COMMANDINCOOLDOWN_MESSAGE:String = "#messenger:server/errors/commandInCooldown/message";

      public static const SERVER_ERRORS_CREATEPRIVATEERROR_TITLE:String = "#messenger:server/errors/createPrivateError/title";

      public static const SERVER_ERRORS_CREATEPRIVATEERROR_MESSAGE:String = "#messenger:server/errors/createPrivateError/message";

      public static const SERVER_ERRORS_ACTIONINCOOLDOWN_TITLE:String = "#messenger:server/errors/actionInCooldown/title";

      public static const SERVER_ERRORS_ACTIONINCOOLDOWN_MESSAGE:String = "#messenger:server/errors/actionInCooldown/message";

      public static const SERVER_ERRORS_INVITECOMMANDERROR_TITLE:String = "#messenger:server/errors/inviteCommandError/title";

      public static const SERVER_ERRORS_INVITECOMMANDERROR_MESSAGE:String = "#messenger:server/errors/inviteCommandError/message";

      public static const SERVER_ERRORS_MEMBERSLIMITREACHED_TITLE:String = "#messenger:server/errors/membersLimitReached/title";

      public static const SERVER_ERRORS_MEMBERSLIMITREACHED_MESSAGE:String = "#messenger:server/errors/membersLimitReached/message";

      public static const SERVER_ERRORS_INCORRECTCOMMANDARGUMENT_TITLE:String = "#messenger:server/errors/incorrectCommandArgument/title";

      public static const SERVER_ERRORS_INCORRECTCOMMANDARGUMENT_MESSAGE:String = "#messenger:server/errors/incorrectCommandArgument/message";

      public static const SERVER_ERRORS_INVALIDCHANNELNAME_TITLE:String = "#messenger:server/errors/invalidChannelName/title";

      public static const SERVER_ERRORS_INVALIDCHANNELNAME_MESSAGE:String = "#messenger:server/errors/invalidChannelName/message";

      public static const CLIENT_INFORMATION_ADDTOFRIENDS_MESSAGE:String = "#messenger:client/information/addToFriends/message";

      public static const CLIENT_INFORMATION_ADDTOIGNORED_MESSAGE:String = "#messenger:client/information/addToIgnored/message";

      public static const CLIENT_INFORMATION_SETMUTED_MESSAGE:String = "#messenger:client/information/setMuted/message";

      public static const CLIENT_INFORMATION_UNSETMUTED_MESSAGE:String = "#messenger:client/information/unsetMuted/message";

      public static const CLIENT_INFORMATION_REMOVEFROMFRIENDS_MESSAGE:String = "#messenger:client/information/removeFromFriends/message";

      public static const CLIENT_INFORMATION_REMOVEFROMIGNORED_MESSAGE:String = "#messenger:client/information/removeFromIgnored/message";

      public static const CLIENT_INFORMATION_EMPTYSEARCHRESULT_MESSAGE:String = "#messenger:client/information/emptySearchResult/message";

      public static const CLIENT_WARNING_EMPTYUSERSEARCHTOKEN_TITLE:String = "#messenger:client/warning/emptyUserSearchToken/title";

      public static const CLIENT_WARNING_EMPTYUSERSEARCHTOKEN_MESSAGE:String = "#messenger:client/warning/emptyUserSearchToken/message";

      public static const CLIENT_WARNING_INVALIDUSERSEARCHTOKEN_TITLE:String = "#messenger:client/warning/invalidUserSearchToken/title";

      public static const CLIENT_WARNING_INVALIDUSERSEARCHTOKEN_MESSAGE:String = "#messenger:client/warning/invalidUserSearchToken/message";

      public static const CLIENT_ERROR_BROADCASTINCOOLDOWN:String = "#messenger:client/error/broadcastInCooldown";

      public static const CLIENT_ERROR_COMMANDINCOOLDOWN_LIMITED:String = "#messenger:client/error/commandInCooldown/limited";

      public static const CLIENT_ERROR_COMMANDINCOOLDOWN_UNLIMITED:String = "#messenger:client/error/commandInCooldown/unlimited";

      public static const COMMAND_FINDUSER:String = "#messenger:command/findUser";

      public static const COMMAND_FINDCHATCHANNELS:String = "#messenger:command/findChatChannels";

      public static const COMMAND_ADDFRIEND:String = "#messenger:command/addFriend";

      public static const COMMAND_ADDIGNORED:String = "#messenger:command/addIgnored";

      public static const COMMAND_REMOVEFRIEND:String = "#messenger:command/removeFriend";

      public static const COMMAND_REMOVEIGNORED:String = "#messenger:command/removeIgnored";

      public static const COMMAND_SETMUTED:String = "#messenger:command/setMuted";

      public static const COMMAND_UNSETMUTED:String = "#messenger:command/unsetMuted";

      public static const COMMAND_CREATEPRIVATE:String = "#messenger:command/createPrivate";

      public static const COMMAND_ACCEPTINVITE:String = "#messenger:command/acceptInvite";

      public static const COMMAND_REJECTINVITE:String = "#messenger:command/rejectInvite";

      public static const COMMAND_GETACTIVEINVITES:String = "#messenger:command/getActiveInvites";

      public static const COMMAND_GETARCHIVEINVITES:String = "#messenger:command/getArchiveInvites";

      public static const COMMAND_GETMEMBERSCOUNT:String = "#messenger:command/getMembersCount";

      public static const COMMAND_REQUESTSYSTEMCHATCHANNELS:String = "#messenger:command/requestSystemChatChannels";

      public static const COMMAND_CREATECHATCHANNEL:String = "#messenger:command/createChatChannel";

      public static const COMMAND_BROADCAST:String = "#messenger:command/broadcast";

      public static const COMMAND_CREATEINVITE:String = "#messenger:command/createInvite";

      public static const COMMAND_LEAVECHATCHANNEL:String = "#messenger:command/leaveChatChannel";

      public static const COMMAND_REQUESTCHATCHANNELMEMBERS:String = "#messenger:command/requestChatChannelMembers";

      public static const COMMAND_ATTENTIONTOCELL_ARG0:String = "#messenger:command/ATTENTIONTOCELL/arg0";

      public static const COMMAND_ATTACKENEMY_ARG0:String = "#messenger:command/ATTACKENEMY/arg0";

      public static const COMMAND_TURNBACK_ARG0:String = "#messenger:command/TURNBACK/arg0";

      public static const COMMAND_HELPMEEX_ARG0:String = "#messenger:command/HELPMEEX/arg0";

      public static const COMMAND_SUPPORTMEWITHFIRE_ARG0:String = "#messenger:command/SUPPORTMEWITHFIRE/arg0";

      public static const COMMAND_STOP_ARG0:String = "#messenger:command/STOP/arg0";

      public static const COMMAND_FOLLOWME_ARG0:String = "#messenger:command/FOLLOWME/arg0";

      public static const EVENTS_ENTERCHANNEL:String = "#messenger:events/enterChannel";

      public static const EVENTS_LEAVECHANNEL:String = "#messenger:events/leaveChannel";

      public static const SERVICECHANNELMESSAGES_PRIORITYMESSAGETITLE:String = "#messenger:serviceChannelMessages/priorityMessageTitle";

      public static const SERVICECHANNELMESSAGES_BUTTONS_CLOSE:String = "#messenger:serviceChannelMessages/buttons/close";

      public static const SERVICECHANNELMESSAGES_SERVERREBOOT:String = "#messenger:serviceChannelMessages/serverReboot";

      public static const SERVICECHANNELMESSAGES_SERVERREBOOTCANCELLED:String = "#messenger:serviceChannelMessages/serverRebootCancelled";

      public static const SERVICECHANNELMESSAGES_BATTLERESULTS_BUTTON:String = "#messenger:serviceChannelMessages/battleResults/button";

      public static const SERVICECHANNELMESSAGES_BATTLERESULTS_VICTORY:String = "#messenger:serviceChannelMessages/battleResults/victory";

      public static const SERVICECHANNELMESSAGES_BATTLERESULTS_DRAWGAME:String = "#messenger:serviceChannelMessages/battleResults/drawGame";

      public static const SERVICECHANNELMESSAGES_BATTLERESULTS_DEFEAT:String = "#messenger:serviceChannelMessages/battleResults/defeat";

      public static const SERVICECHANNELMESSAGES_BATTLERESULTS_BATTLE:String = "#messenger:serviceChannelMessages/battleResults/battle";

      public static const SERVICECHANNELMESSAGES_BATTLERESULTS_TRAINING_BATTLE:String = "#messenger:serviceChannelMessages/battleResults/training_battle";

      public static const SERVICECHANNELMESSAGES_BATTLERESULTS_TANK:String = "#messenger:serviceChannelMessages/battleResults/tank";

      public static const SERVICECHANNELMESSAGES_BATTLERESULTS_EXPERIENCE:String = "#messenger:serviceChannelMessages/battleResults/experience";

      public static const SERVICECHANNELMESSAGES_BATTLERESULTS_FREEXP:String = "#messenger:serviceChannelMessages/battleResults/freeXP";

      public static const SERVICECHANNELMESSAGES_BATTLERESULTS_CREDITS:String = "#messenger:serviceChannelMessages/battleResults/credits";

      public static const SERVICECHANNELMESSAGES_BATTLERESULTS_GOLD:String = "#messenger:serviceChannelMessages/battleResults/gold";

      public static const SERVICECHANNELMESSAGES_BATTLERESULTS_DOUBLEXPFACTOR:String = "#messenger:serviceChannelMessages/battleResults/doubleXpFactor";

      public static const SERVICECHANNELMESSAGES_BATTLERESULTS_PENALTYFORDAMAGEALLIES:String = "#messenger:serviceChannelMessages/battleResults/penaltyForDamageAllies";

      public static const SERVICECHANNELMESSAGES_BATTLERESULTS_CONTRIBUTIONFORDAMAGEALLIES:String = "#messenger:serviceChannelMessages/battleResults/contributionForDamageAllies";

      public static const SERVICECHANNELMESSAGES_BATTLERESULTS_ACTION:String = "#messenger:serviceChannelMessages/battleResults/action";

      public static const SERVICECHANNELMESSAGES_BATTLERESULTS_ACTIONS:String = "#messenger:serviceChannelMessages/battleResults/actions";

      public static const SERVICECHANNELMESSAGES_BATTLERESULTS_ACTIONSRESULTSGOLD:String = "#messenger:serviceChannelMessages/battleResults/actionsResultsGold";

      public static const SERVICECHANNELMESSAGES_BATTLERESULTS_ACTIONSRESULTSCREDITS:String = "#messenger:serviceChannelMessages/battleResults/actionsResultsCredits";

      public static const SERVICECHANNELMESSAGES_BATTLERESULTS_ACTIONSRESULTSFREEXP:String = "#messenger:serviceChannelMessages/battleResults/actionsResultsFreeXP";

      public static const SERVICECHANNELMESSAGES_BATTLERESULTS_ACHIEVES:String = "#messenger:serviceChannelMessages/battleResults/achieves";

      public static const SERVICECHANNELMESSAGES_BATTLERESULTS_QUESTS:String = "#messenger:serviceChannelMessages/battleResults/quests";

      public static const SERVICECHANNELMESSAGES_BATTLERESULTS_QUESTS_VEHICLESLOTS:String = "#messenger:serviceChannelMessages/battleResults/quests/vehicleSlots";

      public static const SERVICECHANNELMESSAGES_BATTLERESULTS_QUESTS_BERTHS:String = "#messenger:serviceChannelMessages/battleResults/quests/berths";

      public static const SERVICECHANNELMESSAGES_BATTLERESULTS_QUESTS_PREMIUM:String = "#messenger:serviceChannelMessages/battleResults/quests/premium";

      public static const SERVICECHANNELMESSAGES_BATTLERESULTS_QUESTS_ITEMS:String = "#messenger:serviceChannelMessages/battleResults/quests/items";

      public static const SERVICECHANNELMESSAGES_BATTLERESULTS_QUESTS_ITEMS_NAME:String = "#messenger:serviceChannelMessages/battleResults/quests/items/name";

      public static const SERVICECHANNELMESSAGES_BATTLETUTORIAL_RESULTS_FINISHED:String = "#messenger:serviceChannelMessages/battleTutorial/results/finished";

      public static const SERVICECHANNELMESSAGES_BATTLETUTORIAL_RESULTS_FAILED:String = "#messenger:serviceChannelMessages/battleTutorial/results/failed";

      public static const SERVICECHANNELMESSAGES_BATTLETUTORIAL_REASONS_FINISHED:String = "#messenger:serviceChannelMessages/battleTutorial/reasons/finished";

      public static const SERVICECHANNELMESSAGES_BATTLETUTORIAL_REASONS_FAILED:String = "#messenger:serviceChannelMessages/battleTutorial/reasons/failed";

      public static const SERVICECHANNELMESSAGES_BATTLETUTORIAL_REASONS_TIMEOUT:String = "#messenger:serviceChannelMessages/battleTutorial/reasons/timeout";

      public static const SERVICECHANNELMESSAGES_BATTLETUTORIAL_REASONS_EXTERMINATION:String = "#messenger:serviceChannelMessages/battleTutorial/reasons/extermination";

      public static const SERVICECHANNELMESSAGES_GOLDRECEIVED_FINANCIAL_TRANSACTION:String = "#messenger:serviceChannelMessages/goldReceived/financial_transaction";

      public static const SERVICECHANNELMESSAGES_GOLDRECEIVED_DATE:String = "#messenger:serviceChannelMessages/goldReceived/date";

      public static const SERVICECHANNELMESSAGES_GOLDRECEIVED_RECEIVED:String = "#messenger:serviceChannelMessages/goldReceived/received";

      public static const SERVICECHANNELMESSAGES_INVOICERECEIVED_GOLDACCRUED:String = "#messenger:serviceChannelMessages/invoiceReceived/goldAccrued";

      public static const SERVICECHANNELMESSAGES_INVOICERECEIVED_GOLDDEBITED:String = "#messenger:serviceChannelMessages/invoiceReceived/goldDebited";

      public static const SERVICECHANNELMESSAGES_INVOICERECEIVED_CREDITSACCRUED:String = "#messenger:serviceChannelMessages/invoiceReceived/creditsAccrued";

      public static const SERVICECHANNELMESSAGES_INVOICERECEIVED_CREDITSDEBITED:String = "#messenger:serviceChannelMessages/invoiceReceived/creditsDebited";

      public static const SERVICECHANNELMESSAGES_INVOICERECEIVED_PREMIUM_ACCOUNT:String = "#messenger:serviceChannelMessages/invoiceReceived/premium_account";

      public static const SERVICECHANNELMESSAGES_INVOICERECEIVED_PREMIUMACCRUED:String = "#messenger:serviceChannelMessages/invoiceReceived/premiumAccrued";

      public static const SERVICECHANNELMESSAGES_INVOICERECEIVED_PREMIUMDEBITED:String = "#messenger:serviceChannelMessages/invoiceReceived/premiumDebited";

      public static const SERVICECHANNELMESSAGES_INVOICERECEIVED_FREEXP:String = "#messenger:serviceChannelMessages/invoiceReceived/freeXp";

      public static const SERVICECHANNELMESSAGES_INVOICERECEIVED_FREEXPACCRUED:String = "#messenger:serviceChannelMessages/invoiceReceived/freeXpAccrued";

      public static const SERVICECHANNELMESSAGES_INVOICERECEIVED_FREEXPDEBITED:String = "#messenger:serviceChannelMessages/invoiceReceived/freeXpDebited";

      public static const SERVICECHANNELMESSAGES_ACHIEVEMENTRECEIVED_MESSAGE:String = "#messenger:serviceChannelMessages/achievementReceived/message";

      public static const SERVICECHANNELMESSAGES_INVOICERECEIVED_INVOICE:String = "#messenger:serviceChannelMessages/invoiceReceived/invoice";

      public static const SERVICECHANNELMESSAGES_INVOICERECEIVED_ITEMSACCRUED:String = "#messenger:serviceChannelMessages/invoiceReceived/itemsAccrued";

      public static const SERVICECHANNELMESSAGES_INVOICERECEIVED_ITEMSDEBITED:String = "#messenger:serviceChannelMessages/invoiceReceived/itemsDebited";

      public static const SERVICECHANNELMESSAGES_INVOICERECEIVED_VEHICLESACCRUED:String = "#messenger:serviceChannelMessages/invoiceReceived/vehiclesAccrued";

      public static const SERVICECHANNELMESSAGES_INVOICERECEIVED_VEHICLESDEBITED:String = "#messenger:serviceChannelMessages/invoiceReceived/vehiclesDebited";

      public static const SERVICECHANNELMESSAGES_INVOICERECEIVED_SLOTSACCRUED:String = "#messenger:serviceChannelMessages/invoiceReceived/slotsAccrued";

      public static const SERVICECHANNELMESSAGES_INVOICERECEIVED_SLOTSDEBITED:String = "#messenger:serviceChannelMessages/invoiceReceived/slotsDebited";

      public static const SERVICECHANNELMESSAGES_INVOICERECEIVED_COMPENSATION:String = "#messenger:serviceChannelMessages/invoiceReceived/compensation";

      public static const SERVICECHANNELMESSAGES_INVOICERECEIVED_COMPENSATION_GOLD:String = "#messenger:serviceChannelMessages/invoiceReceived/compensation/gold";

      public static const SERVICECHANNELMESSAGES_INVOICERECEIVED_COMPENSATION_CREDITS:String = "#messenger:serviceChannelMessages/invoiceReceived/compensation/credits";

      public static const SERVICECHANNELMESSAGES_INVOICERECEIVED_TANKMEN:String = "#messenger:serviceChannelMessages/invoiceReceived/tankmen";

      public static const SERVICECHANNELMESSAGES_INVOICERECEIVED_PIECES:String = "#messenger:serviceChannelMessages/invoiceReceived/pieces";

      public static const SERVICECHANNELMESSAGES_INVOICERECEIVED_CREWLVL:String = "#messenger:serviceChannelMessages/invoiceReceived/crewLvl";

      public static const SERVICECHANNELMESSAGES_DURATIONOFPREMIUMACCOUNEXPIRES:String = "#messenger:serviceChannelMessages/durationOfPremiumAccounExpires";

      public static const SERVICECHANNELMESSAGES_PREMIUMBOUGHT:String = "#messenger:serviceChannelMessages/premiumBought";

      public static const SERVICECHANNELMESSAGES_PREMIUMEXTENDED:String = "#messenger:serviceChannelMessages/premiumExtended";

      public static const SERVICECHANNELMESSAGES_PREMIUMEXPIRED:String = "#messenger:serviceChannelMessages/premiumExpired";

      public static const SERVICECHANNELMESSAGES_CREDITSANDGOLDRECEIVEDASGIFT:String = "#messenger:serviceChannelMessages/creditsAndGoldReceivedAsGift";

      public static const SERVICECHANNELMESSAGES_CREDITSRECEIVEDASGIFT:String = "#messenger:serviceChannelMessages/creditsReceivedAsGift";

      public static const SERVICECHANNELMESSAGES_GOLDRECEIVEDASGIFT:String = "#messenger:serviceChannelMessages/goldReceivedAsGift";

      public static const SERVICECHANNELMESSAGES_XPRECEIVEDASGIFT:String = "#messenger:serviceChannelMessages/xpReceivedAsGift";

      public static const SERVICECHANNELMESSAGES_PREMIUMRECEIVEDASGIFT:String = "#messenger:serviceChannelMessages/premiumReceivedAsGift";

      public static const SERVICECHANNELMESSAGES_ITEMRECEIVEDASGIFT:String = "#messenger:serviceChannelMessages/itemReceivedAsGift";

      public static const SERVICECHANNELMESSAGES_VEHICLERECEIVEDASGIFT:String = "#messenger:serviceChannelMessages/vehicleReceivedAsGift";

      public static const SERVICECHANNELMESSAGES_WARESBOUGHTASGOLD:String = "#messenger:serviceChannelMessages/waresBoughtAsGold";

      public static const SERVICECHANNELMESSAGES_WARESSOLDASGOLD:String = "#messenger:serviceChannelMessages/waresSoldAsGold";

      public static const SERVICECHANNELMESSAGES_VEHICLELOCKEXPIRED:String = "#messenger:serviceChannelMessages/vehicleLockExpired";

      public static const SERVICECHANNELMESSAGES_VEHICLELOCK:String = "#messenger:serviceChannelMessages/vehicleLock";

      public static const SERVICECHANNELMESSAGES_VEHICLESALLLOCKEXPIRED:String = "#messenger:serviceChannelMessages/vehiclesAllLockExpired";

      public static const SERVICECHANNELMESSAGES_AUTOREPAIRERROR:String = "#messenger:serviceChannelMessages/autoRepairError";

      public static const SERVICECHANNELMESSAGES_AUTOLOADERROR:String = "#messenger:serviceChannelMessages/autoLoadError";

      public static const SERVICECHANNELMESSAGES_AUTOEQUIPERROR:String = "#messenger:serviceChannelMessages/autoEquipError";

      public static const SERVICECHANNELMESSAGES_AUTOREPAIRERRORNOWALLET:String = "#messenger:serviceChannelMessages/autoRepairErrorNoWallet";

      public static const SERVICECHANNELMESSAGES_AUTOLOADERRORNOWALLET:String = "#messenger:serviceChannelMessages/autoLoadErrorNoWallet";

      public static const SERVICECHANNELMESSAGES_AUTOEQUIPERRORNOWALLET:String = "#messenger:serviceChannelMessages/autoEquipErrorNoWallet";

      public static const SERVICECHANNELMESSAGES_AUTOREPAIRSUCCESS:String = "#messenger:serviceChannelMessages/autoRepairSuccess";

      public static const SERVICECHANNELMESSAGES_AUTOLOADSUCCESS:String = "#messenger:serviceChannelMessages/autoLoadSuccess";

      public static const SERVICECHANNELMESSAGES_AUTOEQUIPSUCCESS:String = "#messenger:serviceChannelMessages/autoEquipSuccess";

      public static const SERVICECHANNELMESSAGES_AUTOREPAIRSKIPPED:String = "#messenger:serviceChannelMessages/autoRepairSkipped";

      public static const SERVICECHANNELMESSAGES_AUTOLOADSKIPPED:String = "#messenger:serviceChannelMessages/autoLoadSkipped";

      public static const SERVICECHANNELMESSAGES_AUTOEQUIPSKIPPED:String = "#messenger:serviceChannelMessages/autoEquipSkipped";

      public static const SERVICECHANNELMESSAGES_AUTOREPAIRDISABLEDOPTION:String = "#messenger:serviceChannelMessages/autoRepairDisabledOption";

      public static const SERVICECHANNELMESSAGES_AUTOLOADDISABLEDOPTION:String = "#messenger:serviceChannelMessages/autoLoadDisabledOption";

      public static const SERVICECHANNELMESSAGES_AUTOEQUIPDISABLEDOPTION:String = "#messenger:serviceChannelMessages/autoEquipDisabledOption";

      public static const SERVICECHANNELMESSAGES_VEHCAMOUFLAGETIMEDOUT:String = "#messenger:serviceChannelMessages/vehCamouflageTimedOut";

      public static const SERVICECHANNELMESSAGES_VEHEMBLEMTIMEDOUT:String = "#messenger:serviceChannelMessages/vehEmblemTimedOut";

      public static const SERVICECHANNELMESSAGES_VEHINSCRIPTIONTIMEDOUT:String = "#messenger:serviceChannelMessages/vehInscriptionTimedOut";

      public static const SERVICECHANNELMESSAGES_SYSMSG_TITLES_ERROR:String = "#messenger:serviceChannelMessages/sysMsg/titles/error";

      public static const SERVICECHANNELMESSAGES_SYSMSG_TITLES_POWERLEVEL:String = "#messenger:serviceChannelMessages/sysMsg/titles/powerlevel";

      public static const SERVICECHANNELMESSAGES_SYSMSG_TITLES_FINANCIALTRANSACTION:String = "#messenger:serviceChannelMessages/sysMsg/titles/financialTransaction";

      public static const SERVICECHANNELMESSAGES_SYSMSG_TITLES_PURCHASE:String = "#messenger:serviceChannelMessages/sysMsg/titles/purchase";

      public static const SERVICECHANNELMESSAGES_SYSMSG_TITLES_DISMANTLING:String = "#messenger:serviceChannelMessages/sysMsg/titles/dismantling";

      public static const SERVICECHANNELMESSAGES_SYSMSG_TITLES_SELLING:String = "#messenger:serviceChannelMessages/sysMsg/titles/selling";

      public static const SERVICECHANNELMESSAGES_SYSMSG_TITLES_REPAIR:String = "#messenger:serviceChannelMessages/sysMsg/titles/repair";

      public static const SERVICECHANNELMESSAGES_SYSMSG_TITLES_CUSTOMIZATION:String = "#messenger:serviceChannelMessages/sysMsg/titles/customization";

      public static const SERVICECHANNELMESSAGES_PREBATTLE_BATTLETYPE_TOURNAMENT:String = "#messenger:serviceChannelMessages/prebattle/battleType/tournament";

      public static const SERVICECHANNELMESSAGES_PREBATTLE_BATTLETYPE_CLAN:String = "#messenger:serviceChannelMessages/prebattle/battleType/clan";

      public static const SERVICECHANNELMESSAGES_PREBATTLE_BATTLETYPE_PREBATTLE:String = "#messenger:serviceChannelMessages/prebattle/battleType/prebattle";

      public static const SERVICECHANNELMESSAGES_PREBATTLE_FINISH_BASE_DRAFTGAME:String = "#messenger:serviceChannelMessages/prebattle/finish/base/draftGame";

      public static const SERVICECHANNELMESSAGES_PREBATTLE_FINISH_BASE_DEFEAT:String = "#messenger:serviceChannelMessages/prebattle/finish/base/defeat";

      public static const SERVICECHANNELMESSAGES_PREBATTLE_FINISH_BASE_UNDEFINED:String = "#messenger:serviceChannelMessages/prebattle/finish/base/undefined";

      public static const SERVICECHANNELMESSAGES_PREBATTLE_FINISH_BASE_WIN:String = "#messenger:serviceChannelMessages/prebattle/finish/base/win";

      public static const SERVICECHANNELMESSAGES_PREBATTLE_FINISH_TECHNICAL_DRAFTGAME:String = "#messenger:serviceChannelMessages/prebattle/finish/technical/draftGame";

      public static const SERVICECHANNELMESSAGES_PREBATTLE_FINISH_TECHNICAL_DEFEAT:String = "#messenger:serviceChannelMessages/prebattle/finish/technical/defeat";

      public static const SERVICECHANNELMESSAGES_PREBATTLE_FINISH_TECHNICAL_WIN:String = "#messenger:serviceChannelMessages/prebattle/finish/technical/win";

      public static const SERVICECHANNELMESSAGES_PREBATTLE_FINISH_TECHNICAL_UNDEFINED:String = "#messenger:serviceChannelMessages/prebattle/finish/technical/undefined";

      public static const SERVICECHANNELMESSAGES_PREBATTLE_FINISH_FAILURE:String = "#messenger:serviceChannelMessages/prebattle/finish/failure";

      public static const SERVICECHANNELMESSAGES_PREBATTLE_FINISH_CREATORLEFT:String = "#messenger:serviceChannelMessages/prebattle/finish/creatorLeft";

      public static const SERVICECHANNELMESSAGES_PREBATTLE_FINISH_PLAYERKICK:String = "#messenger:serviceChannelMessages/prebattle/finish/playerKick";

      public static const SERVICECHANNELMESSAGES_PREBATTLE_FINISH_TIMEOUT:String = "#messenger:serviceChannelMessages/prebattle/finish/timeout";

      public static const SERVICECHANNELMESSAGES_PREBATTLE_NUMBEROFBATTLE:String = "#messenger:serviceChannelMessages/prebattle/numberOfBattle";

      public static const SERVICECHANNELMESSAGES_PREBATTLE_SUBTOTAL:String = "#messenger:serviceChannelMessages/prebattle/subtotal";

      public static const SERVICECHANNELMESSAGES_PREBATTLE_TOTAL:String = "#messenger:serviceChannelMessages/prebattle/total";

      public static const SERVICECHANNELMESSAGES_PREBATTLE_FINISHEDTIME:String = "#messenger:serviceChannelMessages/prebattle/finishedTime";

      public static const SERVICECHANNELMESSAGES_SERVERDOWNTIMECOMPENSATION:String = "#messenger:serviceChannelMessages/serverDowntimeCompensation";

      public static const SERVICECHANNELMESSAGES_SERVERDOWNTIMECOMPENSATION_PREMIUM:String = "#messenger:serviceChannelMessages/serverDowntimeCompensation/premium";

      public static const SERVICECHANNELMESSAGES_SERVERDOWNTIMECOMPENSATION_CAMOUFLAGES:String = "#messenger:serviceChannelMessages/serverDowntimeCompensation/camouflages";

      public static const SERVICECHANNELMESSAGES_SERVERDOWNTIMECOMPENSATION_PLAYEREMBLEMS:String = "#messenger:serviceChannelMessages/serverDowntimeCompensation/playerEmblems";

      public static const SERVICECHANNELMESSAGES_SERVERDOWNTIMECOMPENSATION_PLAYERINSCRIPTIONS:String = "#messenger:serviceChannelMessages/serverDowntimeCompensation/playerInscriptions";

      public static const SERVICECHANNELMESSAGES_ACTIONBEGIN:String = "#messenger:serviceChannelMessages/actionBegin";

      public static const SERVICECHANNELMESSAGES_ACTIONEND:String = "#messenger:serviceChannelMessages/actionEnd";

      public static const SERVICECHANNELMESSAGES_SYSMSG_CONVERTER_TITLE:String = "#messenger:serviceChannelMessages/sysMsg/converter/title";

      public static const SERVICECHANNELMESSAGES_SYSMSG_CONVERTER_EMBLEMS:String = "#messenger:serviceChannelMessages/sysMsg/converter/emblems";

      public static const SERVICECHANNELMESSAGES_SYSMSG_CONVERTER_INSCRIPTIONS:String = "#messenger:serviceChannelMessages/sysMsg/converter/inscriptions";

      public static const SERVICECHANNELMESSAGES_SYSMSG_CONVERTER_CAMOUFLAGES:String = "#messenger:serviceChannelMessages/sysMsg/converter/camouflages";

      public static const SERVICECHANNELMESSAGES_SYSMSG_CONVERTER_GOLDRECEIVED:String = "#messenger:serviceChannelMessages/sysMsg/converter/goldReceived";

      public static const SERVICECHANNELMESSAGES_SYSMSG_CONVERTER_GOLDWITHDRAWN:String = "#messenger:serviceChannelMessages/sysMsg/converter/goldWithdrawn";

      public static const SERVICECHANNELMESSAGES_SYSMSG_CONVERTER_CREDITSRECEIVED:String = "#messenger:serviceChannelMessages/sysMsg/converter/creditsReceived";

      public static const SERVICECHANNELMESSAGES_SYSMSG_CONVERTER_CREDITSWITHDRAWN:String = "#messenger:serviceChannelMessages/sysMsg/converter/creditsWithdrawn";

      public static const SERVICECHANNELMESSAGES_SYSMSG_CONVERTER_FREEXPRECEIVED:String = "#messenger:serviceChannelMessages/sysMsg/converter/freeXPReceived";

      public static const SERVICECHANNELMESSAGES_SYSMSG_CONVERTER_FREEXPWITHDRAWN:String = "#messenger:serviceChannelMessages/sysMsg/converter/freeXPWithdrawn";

      public static const SERVICECHANNELMESSAGES_SYSMSG_CONVERTER_SLOTSRECEIVED:String = "#messenger:serviceChannelMessages/sysMsg/converter/slotsReceived";

      public static const SERVICECHANNELMESSAGES_SYSMSG_CONVERTER_SLOTSWITHDRAWN:String = "#messenger:serviceChannelMessages/sysMsg/converter/slotsWithdrawn";

      public static const SERVICECHANNELMESSAGES_SYSMSG_CONVERTER_VEHICLESRECEIVED:String = "#messenger:serviceChannelMessages/sysMsg/converter/vehiclesReceived";

      public static const SERVICECHANNELMESSAGES_SYSMSG_CONVERTER_VEHICLESWITHDRAWN:String = "#messenger:serviceChannelMessages/sysMsg/converter/vehiclesWithdrawn";

      public static const KEYBOARDCHAT:String = "#messenger:keyboardChat";
   }

}