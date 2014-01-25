package 
{


   public class MENU extends Object
   {
          
      public function MENU() {
         super();
      }

      public static const TRAINING_INFO_STATES_STATE:String = "#menu:training/info/states/state";

      public static const COPY:String = "#menu:copy";

      public static const LOGIN_LOGIN:String = "#menu:login/login";

      public static const LOGIN_VERSION:String = "#menu:login/version";

      public static const LOGIN_PASSWORD:String = "#menu:login/password";

      public static const LOGIN_REGISTRATIONLINK:String = "#menu:login/registrationLink";

      public static const LOGIN_RECOVERYLINK:String = "#menu:login/recoveryLink";

      public static const LOGIN_REMEMBERPASSWORD:String = "#menu:login/rememberPassword";

      public static const LOGIN_REMEMBERPASSWORDIGR:String = "#menu:login/rememberPasswordIgr";

      public static const LOGIN_REMEMBERPASSWORDIGRWARNING:String = "#menu:login/rememberPasswordIgrWarning";

      public static const LOGIN_OK:String = "#menu:login/ok";

      public static const LOGIN_AUTO:String = "#menu:login/auto";

      public static const LOGIN_CAPS:String = "#menu:login/caps";

      public static const LOGIN_QUITFROMAUTOLOGIN:String = "#menu:login/quitFromAutoLogin";

      public static const LOGIN_STATUS_EMPTY_LOGIN:String = "#menu:login/status/empty_login";

      public static const LOGIN_STATUS_INVALID_LOGIN_LENGTH:String = "#menu:login/status/invalid_login_length";

      public static const LOGIN_STATUS_INVALID_NICKNAME:String = "#menu:login/status/invalid_nickname";

      public static const LOGIN_STATUS_INVALID_LOGIN:String = "#menu:login/status/invalid_login";

      public static const LOGIN_STATUS_EMPTY_PASSWORD:String = "#menu:login/status/empty_password";

      public static const LOGIN_STATUS_INVALID_PASSWORD:String = "#menu:login/status/invalid_password";

      public static const LOGIN_STATUS_EMPTY_SERVER:String = "#menu:login/status/empty_server";

      public static const LOGIN_STATUS_CONNECTING:String = "#menu:login/status/connecting";

      public static const LOGIN_STATUS_DISCONNECTED:String = "#menu:login/status/disconnected";

      public static const LOGIN_STATUS_UNAVAILABLE:String = "#menu:login/status/unavailable";

      public static const LOGIN_STATUS_LOGIN_REJECTED_ALREADY_LOGGED_IN:String = "#menu:login/status/LOGIN_REJECTED_ALREADY_LOGGED_IN";

      public static const LOGIN_STATUS_CONNECTION_FAILED:String = "#menu:login/status/CONNECTION_FAILED";

      public static const LOGIN_STATUS_DNS_LOOKUP_FAILED:String = "#menu:login/status/DNS_LOOKUP_FAILED";

      public static const LOGIN_STATUS_UNKNOWN_ERROR:String = "#menu:login/status/UNKNOWN_ERROR";

      public static const LOGIN_STATUS_CANCELLED:String = "#menu:login/status/CANCELLED";

      public static const LOGIN_STATUS_LOGIN_REJECTED_NO_SUCH_USER:String = "#menu:login/status/LOGIN_REJECTED_NO_SUCH_USER";

      public static const LOGIN_STATUS_LOGIN_REJECTED_ACTIVATING:String = "#menu:login/status/LOGIN_REJECTED_ACTIVATING";

      public static const LOGIN_STATUS_LOGIN_REJECTED_INVALID_PASSWORD:String = "#menu:login/status/LOGIN_REJECTED_INVALID_PASSWORD";

      public static const LOGIN_STATUS_LOGIN_REJECTED_NO_BASEAPP_RESPONSE:String = "#menu:login/status/LOGIN_REJECTED_NO_BASEAPP_RESPONSE";

      public static const LOGIN_STATUS_LOGIN_REJECTED_ILLEGAL_CHARACTERS:String = "#menu:login/status/LOGIN_REJECTED_ILLEGAL_CHARACTERS";

      public static const LOGIN_STATUS_LOGIN_BAD_PROTOCOL_VERSION:String = "#menu:login/status/LOGIN_BAD_PROTOCOL_VERSION";

      public static const LOGIN_STATUS_LOGIN_REJECTED_BAD_DIGEST:String = "#menu:login/status/LOGIN_REJECTED_BAD_DIGEST";

      public static const LOGIN_STATUS_LOGIN_REJECTED_SERVER_NOT_READY:String = "#menu:login/status/LOGIN_REJECTED_SERVER_NOT_READY";

      public static const LOGIN_STATUS_LOGIN_REJECTED_BASEAPP_OVERLOAD:String = "#menu:login/status/LOGIN_REJECTED_BASEAPP_OVERLOAD";

      public static const LOGIN_STATUS_LOGIN_REJECTED_CELLAPP_OVERLOAD:String = "#menu:login/status/LOGIN_REJECTED_CELLAPP_OVERLOAD";

      public static const LOGIN_STATUS_LOGIN_REJECTED_DBMGR_OVERLOAD:String = "#menu:login/status/LOGIN_REJECTED_DBMGR_OVERLOAD";

      public static const LOGIN_STATUS_LOGIN_REJECTED_LOGINS_NOT_ALLOWED:String = "#menu:login/status/LOGIN_REJECTED_LOGINS_NOT_ALLOWED";

      public static const LOGIN_STATUS_LOGIN_REJECTED_REGISTRATION_NOT_CONFIRMED:String = "#menu:login/status/LOGIN_REJECTED_REGISTRATION_NOT_CONFIRMED";

      public static const HANGAR_CREW_TOOLTIP_NEW_SKILL:String = "#menu:hangar/crew/tooltip/new_skill";

      public static const HANGAR_CREW_TOOLTIP_DROP_SKILL:String = "#menu:hangar/crew/tooltip/drop_skill";

      public static const HANGAR_XPTOTMENCHECKBOX_TOOLTIP:String = "#menu:hangar/xpToTmenCheckbox/tooltip";

      public static const LOGIN_STATUS_LOGIN_REJECTED_RATE_LIMITED:String = "#menu:login/status/LOGIN_REJECTED_RATE_LIMITED";

      public static const LOGIN_STATUS_LOGIN_REJECTED_USERS_LIMIT:String = "#menu:login/status/LOGIN_REJECTED_USERS_LIMIT";

      public static const LOGIN_STATUS_LOGIN_REJECTED_DB_GENERAL_FAILURE:String = "#menu:login/status/LOGIN_REJECTED_DB_GENERAL_FAILURE";

      public static const LOGIN_STATUS_LOGIN_REJECTED_DB_NOT_READY:String = "#menu:login/status/LOGIN_REJECTED_DB_NOT_READY";

      public static const LOGIN_STATUS_LOGIN_REJECTED_NO_BASEAPPS:String = "#menu:login/status/LOGIN_REJECTED_NO_BASEAPPS";

      public static const LOGIN_STATUS_LOGIN_REJECTED_NO_LOGINAPP_RESPONSE:String = "#menu:login/status/LOGIN_REJECTED_NO_LOGINAPP_RESPONSE";

      public static const LOGIN_STATUS_LOGIN_REJECTED_BASEAPP_TIMEOUT:String = "#menu:login/status/LOGIN_REJECTED_BASEAPP_TIMEOUT";

      public static const LOGIN_STATUS_LOGIN_REJECTED_BASEAPPMGR_TIMEOUT:String = "#menu:login/status/LOGIN_REJECTED_BASEAPPMGR_TIMEOUT";

      public static const LOGIN_STATUS_LOGIN_MALFORMED_REQUEST:String = "#menu:login/status/LOGIN_MALFORMED_REQUEST";

      public static const LOGIN_STATUS_PUBLIC_KEY_LOOKUP_FAILED:String = "#menu:login/status/PUBLIC_KEY_LOOKUP_FAILED";

      public static const LOGIN_STATUS_ALREADY_ONLINE_LOCALLY:String = "#menu:login/status/ALREADY_ONLINE_LOCALLY";

      public static const LOGIN_STATUS_LOGIN_REJECTED_BAN:String = "#menu:login/status/LOGIN_REJECTED_BAN";

      public static const LOGIN_STATUS_LOGIN_REJECTED_BAN_UNLIMITED:String = "#menu:login/status/LOGIN_REJECTED_BAN_UNLIMITED";

      public static const LOGIN_STATUS_LOGIN_CUSTOM_DEFINED_ERROR:String = "#menu:login/status/LOGIN_CUSTOM_DEFINED_ERROR";

      public static const LOGIN_STATUS_LOGIN_REJECTED_LOGIN_QUEUE:String = "#menu:login/status/LOGIN_REJECTED_LOGIN_QUEUE";

      public static const LOGIN_STATUS_LOGIN_REJECTED_NICKNAME_ALREADY_EXIST:String = "#menu:login/status/LOGIN_REJECTED_NICKNAME_ALREADY_EXIST";

      public static const LOGIN_STATUS_LOGIN_REJECTED_UNABLE_TO_PARSE_JSON:String = "#menu:login/status/LOGIN_REJECTED_UNABLE_TO_PARSE_JSON";

      public static const LOGIN_STATUS_LOGIN_REJECTED_REGISTRATION_NOT_ALLOWED:String = "#menu:login/status/LOGIN_REJECTED_REGISTRATION_NOT_ALLOWED";

      public static const LOGIN_STATUS_LOGIN_REJECTED_INACCESSIBLE_REALM:String = "#menu:login/status/LOGIN_REJECTED_INACCESSIBLE_REALM";

      public static const LOGIN_UPDATEURLAVAIALBLEAT:String = "#menu:login/updateURLAvaialbleAt";

      public static const LOGIN_STATUS_LAUNCHERNOTFOUND:String = "#menu:login/status/launchernotfound";

      public static const LOGIN_STATUS_SESSION_END:String = "#menu:login/status/SESSION_END";

      public static const LOGIN_STATUS_ACCOUNTNOTREADY:String = "#menu:login/status/accountNotReady";

      public static const LOGIN_STATUS_VERSIONMISMATCH:String = "#menu:login/status/versionMismatch";

      public static const LOGIN_STATUS_CENTERRESTART:String = "#menu:login/status/centerRestart";

      public static const LOGIN_STATUS_CLIENT_SERVER_VERSIONS_ARE_DIFFERENT:String = "#menu:login/status/CLIENT_SERVER_VERSIONS_ARE_DIFFERENT";

      public static const LOADING_GAME:String = "#menu:loading/game";

      public static const LOADING_GAMEINFO:String = "#menu:loading/gameInfo";

      public static const LOADING_BATTLETYPES_0:String = "#menu:loading/battleTypes/0";

      public static const LOADING_BATTLETYPES_DESC_0:String = "#menu:loading/battleTypes/desc/0";

      public static const LOADING_BATTLETYPES_1:String = "#menu:loading/battleTypes/1";

      public static const LOADING_BATTLETYPES_DESC_1:String = "#menu:loading/battleTypes/desc/1";

      public static const LOADING_BATTLETYPES_2:String = "#menu:loading/battleTypes/2";

      public static const LOADING_BATTLETYPES_DESC_2:String = "#menu:loading/battleTypes/desc/2";

      public static const LOADING_BATTLETYPES_3:String = "#menu:loading/battleTypes/3";

      public static const LOADING_BATTLETYPES_DESC_3:String = "#menu:loading/battleTypes/desc/3";

      public static const LOADING_BATTLETYPES_4:String = "#menu:loading/battleTypes/4";

      public static const LOADING_BATTLETYPES_DESC_4:String = "#menu:loading/battleTypes/desc/4";

      public static const LOADING_BATTLETYPES_5:String = "#menu:loading/battleTypes/5";

      public static const LOADING_BATTLETYPES_DESC_5:String = "#menu:loading/battleTypes/desc/5";

      public static const LOADING_TEAM1:String = "#menu:loading/team1";

      public static const LOADING_TEAM2:String = "#menu:loading/team2";

      public static const LOADING_HELPTIP:String = "#menu:loading/helpTip";

      public static const HANGAR_VEHICLE_LOCKED:String = "#menu:hangar/vehicle_locked";

      public static const LOBBY_MENU_TITLE:String = "#menu:lobby_menu/title";

      public static const LOBBY_MENU_BUTTONS_SETTINGS:String = "#menu:lobby_menu/buttons/settings";

      public static const LOBBY_MENU_BUTTONS_LOGOFF:String = "#menu:lobby_menu/buttons/logoff";

      public static const LOBBY_MENU_BUTTONS_EXIT:String = "#menu:lobby_menu/buttons/exit";

      public static const LOBBY_MENU_BUTTONS_BACK:String = "#menu:lobby_menu/buttons/back";

      public static const LOBBY_MENU_BUTTONS_REFUSE_TRAINING:String = "#menu:lobby_menu/buttons/refuse-training";

      public static const LOBBY_MENU_BUTTONS_RESTART_TRAINING:String = "#menu:lobby_menu/buttons/restart-training";

      public static const INGAME_MENU_TITLE:String = "#menu:ingame_menu/title";

      public static const INGAME_MENU_BUTTONS_SETTINGS:String = "#menu:ingame_menu/buttons/settings";

      public static const INGAME_MENU_BUTTONS_LOGOFF:String = "#menu:ingame_menu/buttons/logoff";

      public static const INGAME_MENU_BUTTONS_HELP:String = "#menu:ingame_menu/buttons/help";

      public static const INGAME_MENU_BUTTONS_BACK:String = "#menu:ingame_menu/buttons/back";

      public static const TANKMEN_LIGHTTANK:String = "#menu:tankmen/lightTank";

      public static const TANKMEN_MEDIUMTANK:String = "#menu:tankmen/mediumTank";

      public static const TANKMEN_HEAVYTANK:String = "#menu:tankmen/heavyTank";

      public static const TANKMEN_AT_SPG:String = "#menu:tankmen/AT-SPG";

      public static const TANKMEN_SPG:String = "#menu:tankmen/SPG";

      public static const TANKMANPERSONALCASE_TITLE:String = "#menu:tankmanPersonalCase/title";

      public static const TANKMANPERSONALCASE_RANK:String = "#menu:tankmanPersonalCase/rank";

      public static const TANKMANPERSONALCASE_NAME:String = "#menu:tankmanPersonalCase/name";

      public static const TANKMANPERSONALCASE_CREW:String = "#menu:tankmanPersonalCase/crew";

      public static const TANKMANPERSONALCASE_MAINSPECIALIZATION:String = "#menu:tankmanPersonalCase/mainSpecialization";

      public static const TANKMANPERSONALCASE_DOCS_INFO:String = "#menu:tankmanPersonalCase/docs/info";

      public static const TANKMANPERSONALCASE_PERSONALDOCS:String = "#menu:tankmanPersonalCase/personalDocs";

      public static const TANKMANPERSONALCASE_CHANGEDOCSBTN:String = "#menu:tankmanPersonalCase/changeDocsBtn";

      public static const TANKMANPERSONALCASE_USINGLEVEL:String = "#menu:tankmanPersonalCase/usingLevel";

      public static const TANKMANPERSONALCASE_MODIFIERS_FROMCOMMANDER:String = "#menu:tankmanPersonalCase/modifiers/fromCommander";

      public static const TANKMANPERSONALCASE_MODIFIERS_FROMEQUIPMENT:String = "#menu:tankmanPersonalCase/modifiers/fromEquipment";

      public static const TANKMANPERSONALCASE_MODIFIERS_FROMSKILLS:String = "#menu:tankmanPersonalCase/modifiers/fromSkills";

      public static const TANKMANPERSONALCASE_MODIFIERS_PENALTY:String = "#menu:tankmanPersonalCase/modifiers/penalty";

      public static const TANKMANPERSONALCASE_MODIFIERSHEADER:String = "#menu:tankmanPersonalCase/modifiersHeader";

      public static const TANKMANPERSONALCASE_MODIFIERSRESULT:String = "#menu:tankmanPersonalCase/modifiersResult";

      public static const TANKMANPERSONALCASE_SPECIALIZATION:String = "#menu:tankmanPersonalCase/specialization";

      public static const TANKMANPERSONALCASE_TRAININGBTN:String = "#menu:tankmanPersonalCase/trainingBtn";

      public static const TANKMANPERSONALCASE_BTNRESET:String = "#menu:tankmanPersonalCase/btnReset";

      public static const TANKMANPERSONALCASE_RETRAININGBTN:String = "#menu:tankmanPersonalCase/retrainingBtn";

      public static const TANKMANPERSONALCASE_VEHICLETYPE:String = "#menu:tankmanPersonalCase/vehicleType";

      public static const TANKMANPERSONALCASE_VEHICLE:String = "#menu:tankmanPersonalCase/vehicle";

      public static const TANKMANPERSONALCASE_CLOSEBTN:String = "#menu:tankmanPersonalCase/closeBtn";

      public static const TANKMANPERSONALCASE_TABBATTLEINFO:String = "#menu:tankmanPersonalCase/tabBattleInfo";

      public static const TANKMANPERSONALCASE_TABTRAINING:String = "#menu:tankmanPersonalCase/tabTraining";

      public static const TANKMANPERSONALCASE_BTNTRAINING:String = "#menu:tankmanPersonalCase/btnTraining";

      public static const TANKMANPERSONALCASE_BTNRETRAINING:String = "#menu:tankmanPersonalCase/btnRetraining";

      public static const TANKMANPERSONALCASE_VEHICLETYPEID:String = "#menu:tankmanPersonalCase/vehicleTypeID";

      public static const TANKMANPERSONALCASE_SKILLSBUTTON_MAINTEXT:String = "#menu:tankmanPersonalCase/skillsButton/mainText";

      public static const TANKMANPERSONALCASE_SKILLSBUTTON_ADDITIONTEXT:String = "#menu:tankmanPersonalCase/skillsButton/additionText";

      public static const TANKMANPERSONALCASE_RETRAININGWARNING:String = "#menu:tankmanPersonalCase/retrainingWarning";

      public static const TANKMANPERSONALCASE_RETRAININGWARNING2:String = "#menu:tankmanPersonalCase/retrainingWarning2";

      public static const TANKMANPERSONALCASE_NOMODIFIERS:String = "#menu:tankmanPersonalCase/noModifiers";

      public static const TANKMSNPERSONALCASE_LACKOFSKILLSFORLEARN:String = "#menu:tankmsnPersonalCase/lackOfSkillsForLearn";

      public static const TANKMANPERSONALCASE_NOACHIVS:String = "#menu:tankmanPersonalCase/noAchivs";

      public static const TANKMANPERSONALCASE_ACHIVS:String = "#menu:tankmanPersonalCase/achivs";

      public static const TANKMANPERSONALCASE_TABDOCS:String = "#menu:tankmanPersonalCase/tabDocs";

      public static const TANKMANPERSONALCASE_TABSKILLS:String = "#menu:tankmanPersonalCase/tabSkills";

      public static const TANKMANPERSONALCASE_SKILLSDESC:String = "#menu:tankmanPersonalCase/skillsDesc";

      public static const TANKMANPERSONALCASE_DROPSKILLSBUTTONLABEL:String = "#menu:tankmanPersonalCase/dropSkillsButtonLabel";

      public static const TANKMANPERSONALCASE_ACCELERATETEACHINGOFSKILL:String = "#menu:tankmanPersonalCase/accelerateTeachingOfSkill";

      public static const TANKMANTRAININGWINDOW_TITLE:String = "#menu:tankmanTrainingWindow/title";

      public static const TANKMANTRAININGWINDOW_ACADEMY:String = "#menu:tankmanTrainingWindow/academy";

      public static const TANKMANTRAININGWINDOW_SCOOL:String = "#menu:tankmanTrainingWindow/scool";

      public static const TANKMANTRAININGWINDOW_FREE:String = "#menu:tankmanTrainingWindow/free";

      public static const TANKMANTRAININGWINDOW_TRAININGTO:String = "#menu:tankmanTrainingWindow/trainingTo";

      public static const TANKMANTRAININGBUTTON2_TRAININGTO:String = "#menu:tankmanTrainingButton2/trainingTo";

      public static const TANKMANTRAININGBUTTON2_RETRAININGTO:String = "#menu:tankmanTrainingButton2/retrainingTo";

      public static const TANKMANTRAININGWINDOW_CLOSEBTN:String = "#menu:tankmanTrainingWindow/closeBtn";

      public static const TANKMANRECRUITRENDERER_PERSONALCASE:String = "#menu:tankmanRecruitRenderer/personalCase";

      public static const TANKMANRECRUITRENDERER_COMMANDER:String = "#menu:tankmanRecruitRenderer/commander";

      public static const TANKMANRECRUITRENDERER_GUNNER:String = "#menu:tankmanRecruitRenderer/gunner";

      public static const TANKMANRECRUITRENDERER_LOADER:String = "#menu:tankmanRecruitRenderer/loader";

      public static const TANKMANRECRUITRENDERER_DRIVER:String = "#menu:tankmanRecruitRenderer/driver";

      public static const TANKMANRECRUITRENDERER_RADIOMAN:String = "#menu:tankmanRecruitRenderer/radioman";

      public static const TANKMANRECRUITRENDERER_DESCR:String = "#menu:tankmanRecruitRenderer/descr";

      public static const TANKMANRECRUITRENDERER_UNLOAD:String = "#menu:tankmanRecruitRenderer/unload";

      public static const TANKCAROUSEL_VEHICLESTATES_BATTLE:String = "#menu:tankCarousel/vehicleStates/battle";

      public static const TANKCAROUSEL_VEHICLESTATES_LOCKED:String = "#menu:tankCarousel/vehicleStates/locked";

      public static const TANKCAROUSEL_VEHICLESTATES_CLANLOCKED:String = "#menu:tankCarousel/vehicleStates/clanLocked";

      public static const TANKCAROUSEL_VEHICLESTATES_INPREBATTLE:String = "#menu:tankCarousel/vehicleStates/inPrebattle";

      public static const TANKCAROUSEL_VEHICLESTATES_AMMONOTFULL:String = "#menu:tankCarousel/vehicleStates/ammoNotFull";

      public static const TANKCAROUSEL_VEHICLESTATES_DAMAGED:String = "#menu:tankCarousel/vehicleStates/damaged";

      public static const TANKCAROUSEL_VEHICLESTATES_DESTROYED:String = "#menu:tankCarousel/vehicleStates/destroyed";

      public static const TANKCAROUSEL_VEHICLESTATES_EXPLODED:String = "#menu:tankCarousel/vehicleStates/exploded";

      public static const TANKCAROUSEL_VEHICLESTATES_NOTPRESENT:String = "#menu:tankCarousel/vehicleStates/notpresent";

      public static const TANKCAROUSEL_VEHICLESTATES_UNDAMAGED:String = "#menu:tankCarousel/vehicleStates/undamaged";

      public static const TANKCAROUSEL_VEHICLESTATES_SERVERRESTRICTION:String = "#menu:tankCarousel/vehicleStates/serverRestriction";

      public static const TANKCAROUSEL_VEHICLESTATES_CREWNOTFULL:String = "#menu:tankCarousel/vehicleStates/crewNotFull";

      public static const TANKCAROUSEL_VEHICLESTATES_BUYTANK:String = "#menu:tankCarousel/vehicleStates/buyTank";

      public static const TANKCAROUSEL_VEHICLESTATES_BUYTANKEMPTYCOUNT:String = "#menu:tankCarousel/vehicleStates/buyTankEmptyCount";

      public static const TANKCAROUSEL_VEHICLESTATES_BUYSLOT:String = "#menu:tankCarousel/vehicleStates/buySlot";

      public static const STORE_VEHICLESTATES_BATTLE:String = "#menu:store/vehicleStates/battle";

      public static const STORE_VEHICLESTATES_LOCKED:String = "#menu:store/vehicleStates/locked";

      public static const STORE_VEHICLESTATES_CLANLOCKED:String = "#menu:store/vehicleStates/clanLocked";

      public static const STORE_VEHICLESTATES_INPREBATTLE:String = "#menu:store/vehicleStates/inPrebattle";

      public static const STORE_VEHICLESTATES_AMMONOTFULL:String = "#menu:store/vehicleStates/ammoNotFull";

      public static const STORE_VEHICLESTATES_DAMAGED:String = "#menu:store/vehicleStates/damaged";

      public static const STORE_VEHICLESTATES_DESTROYED:String = "#menu:store/vehicleStates/destroyed";

      public static const STORE_VEHICLESTATES_EXPLODED:String = "#menu:store/vehicleStates/exploded";

      public static const STORE_VEHICLESTATES_NOTPRESENT:String = "#menu:store/vehicleStates/notpresent";

      public static const STORE_VEHICLESTATES_UNDAMAGED:String = "#menu:store/vehicleStates/undamaged";

      public static const STORE_VEHICLESTATES_SERVERRESTRICTION:String = "#menu:store/vehicleStates/serverRestriction";

      public static const STORE_VEHICLESTATES_CREWNOTFULL:String = "#menu:store/vehicleStates/crewNotFull";

      public static const STORE_VEHICLESTATES_BUYTANK:String = "#menu:store/vehicleStates/buyTank";

      public static const STORE_VEHICLESTATES_BUYTANKEMPTYCOUNT:String = "#menu:store/vehicleStates/buyTankEmptyCount";

      public static const STORE_VEHICLESTATES_BUYSLOT:String = "#menu:store/vehicleStates/buySlot";

      public static const CURRENTVEHICLESTATUS_BATTLE:String = "#menu:currentVehicleStatus/battle";

      public static const CURRENTVEHICLESTATUS_INPREBATTLE:String = "#menu:currentVehicleStatus/inPrebattle";

      public static const CURRENTVEHICLESTATUS_SERVERRESTRICTION:String = "#menu:currentVehicleStatus/serverRestriction";

      public static const CURRENTVEHICLESTATUS_LOCKED:String = "#menu:currentVehicleStatus/locked";

      public static const CURRENTVEHICLESTATUS_CLANLOCKED:String = "#menu:currentVehicleStatus/clanLocked";

      public static const CURRENTVEHICLESTATUS_AMMONOTFULL:String = "#menu:currentVehicleStatus/ammoNotFull";

      public static const CURRENTVEHICLESTATUS_DAMAGED:String = "#menu:currentVehicleStatus/damaged";

      public static const CURRENTVEHICLESTATUS_DESTROYED:String = "#menu:currentVehicleStatus/destroyed";

      public static const CURRENTVEHICLESTATUS_EXPLODED:String = "#menu:currentVehicleStatus/exploded";

      public static const CURRENTVEHICLESTATUS_NOTPRESENT:String = "#menu:currentVehicleStatus/notpresent";

      public static const CURRENTVEHICLESTATUS_UNDAMAGED:String = "#menu:currentVehicleStatus/undamaged";

      public static const CURRENTVEHICLESTATUS_CREWNOTFULL:String = "#menu:currentVehicleStatus/crewNotFull";

      public static const REPAIR_REPAIRSTATUS:String = "#menu:repair/repairstatus";

      public static const REPAIR_CURIENCY:String = "#menu:repair/curiency";

      public static const REPAIR_BUTTON:String = "#menu:repair/button";

      public static const PRICE_CREDITS:String = "#menu:price/credits";

      public static const PRICE_GOLD:String = "#menu:price/gold";

      public static const PRICE_SPENT:String = "#menu:price/spent";

      public static const PRICE_RECEIVED:String = "#menu:price/received";

      public static const AMMORELOAD_TITLE:String = "#menu:ammoReload/title";

      public static const AMMORELOAD_RELOADTITLE:String = "#menu:ammoReload/reloadTitle";

      public static const AMMORELOAD_ONINVENTORY:String = "#menu:ammoReload/onInventory";

      public static const AMMORELOAD_ADDITIONBUY:String = "#menu:ammoReload/additionBuy";

      public static const AMMORELOAD_INTANK:String = "#menu:ammoReload/inTank";

      public static const AMMORELOAD_PIERCINGPOWER_TITLE:String = "#menu:ammoReload/piercingPower/title";

      public static const AMMORELOAD_PIERCINGPOWER_UNITS:String = "#menu:ammoReload/piercingPower/units";

      public static const AMMORELOAD_DAMAGE_TITLE:String = "#menu:ammoReload/damage/title";

      public static const AMMORELOAD_DAMAGE_UNITS:String = "#menu:ammoReload/damage/units";

      public static const AMMORELOAD_AUTOFILL:String = "#menu:ammoReload/autoFill";

      public static const AMMORELOAD_CLEARAMMUNITION:String = "#menu:ammoReload/clearAmmunition";

      public static const AMMORELOAD_CANCEL:String = "#menu:ammoReload/cancel";

      public static const AMMORELOAD_FILL:String = "#menu:ammoReload/fill";

      public static const AMMORELOAD_AMMUNITION:String = "#menu:ammoReload/ammunition";

      public static const AMMORELOAD_TOTALCOST:String = "#menu:ammoReload/totalcost";

      public static const RATING_TITLE:String = "#menu:rating/title";

      public static const PREBATTLE_PLAYERSLABEL:String = "#menu:prebattle/playersLabel";

      public static const PREBATTLE_GROUPSLABEL:String = "#menu:prebattle/groupsLabel";

      public static const PREBATTLE_TIMERLABEL:String = "#menu:prebattle/timerLabel";

      public static const PREBATTLE_EXITBUTTON:String = "#menu:prebattle/exitButton";

      public static const PREBATTLE_STARTBUTTON:String = "#menu:prebattle/startButton";

      public static const PREBATTLE_ALREADY_IN_AWAITING_BATTLE:String = "#menu:prebattle/already_in_awaiting_battle";

      public static const PREBATTLE_TITLE:String = "#menu:prebattle/title";

      public static const PREBATTLE_DESCRIPTION:String = "#menu:prebattle/description";

      public static const PREBATTLE_LEVELSTITLE:String = "#menu:prebattle/levelsTitle";

      public static const PREBATTLE_TYPESTITLE:String = "#menu:prebattle/typesTitle";

      public static const PREBATTLE_TYPESCOMPANIESTITLE:String = "#menu:prebattle/typesCompaniesTitle";

      public static const PREBATTLE_COMPANIESTITLE_JUNIOR:String = "#menu:prebattle/CompaniesTitle/JUNIOR";

      public static const PREBATTLE_COMPANIESTITLE_MIDDLE:String = "#menu:prebattle/CompaniesTitle/MIDDLE";

      public static const PREBATTLE_COMPANIESTITLE_CHAMPION:String = "#menu:prebattle/CompaniesTitle/CHAMPION";

      public static const PREBATTLE_COMPANIESTITLE_ABSOLUTE:String = "#menu:prebattle/CompaniesTitle/ABSOLUTE";

      public static const PREBATTLE_INVITATIONS_LABELS_MAILINGLIST:String = "#menu:prebattle/invitations/labels/mailingList";

      public static const PREBATTLE_INVITATIONS_LABELS_ISONLINE:String = "#menu:prebattle/invitations/labels/isOnline";

      public static const PREBATTLE_INVITATIONS_LABELS_DEFAULTINVITETEXT:String = "#menu:prebattle/invitations/labels/defaultInviteText";

      public static const PREBATTLE_INVITATIONS_BUTTONS_SEARCH:String = "#menu:prebattle/invitations/buttons/search";

      public static const PREBATTLE_INVITATIONS_BUTTONS_SEND:String = "#menu:prebattle/invitations/buttons/send";

      public static const PREBATTLE_INVITATIONS_BUTTONS_CANCEL:String = "#menu:prebattle/invitations/buttons/cancel";

      public static const PREBATTLE_INVITATIONS_ERRORS_USEROFFLINE:String = "#menu:prebattle/invitations/errors/userOffline";

      public static const PREBATTLE_INVITATIONS_ERRORS_EXISTSINRECEIVELIST:String = "#menu:prebattle/invitations/errors/existsInReceiveList";

      public static const PREBATTLE_INVITATIONS_ERRORS_SELECTUSERTOADD:String = "#menu:prebattle/invitations/errors/selectUserToAdd";

      public static const PREBATTLE_INVITATIONS_ERRORS_SELECTUSERTOREMOVE:String = "#menu:prebattle/invitations/errors/selectUserToRemove";

      public static const PREBATTLE_INVITATIONS_ERRORS_USERLISTEMPTY:String = "#menu:prebattle/invitations/errors/userListEmpty";

      public static const PREBATTLE_INVITATIONS_ERRORS_RECEIVERLISTEMPTY:String = "#menu:prebattle/invitations/errors/receiverListEmpty";

      public static const PREBATTLE_INVITATIONS_ERRORS_ADDIGNOREDUSER:String = "#menu:prebattle/invitations/errors/addIgnoredUser";

      public static const PREBATTLE_INVITATIONS_ERRORS_NOTFOUNDUSERS:String = "#menu:prebattle/invitations/errors/notFoundUsers";

      public static const NATIONS_TITLE:String = "#menu:nations/title";

      public static const NATIONS_USSR:String = "#menu:nations/ussr";

      public static const NATIONS_GERMANY:String = "#menu:nations/germany";

      public static const NATIONS_USA:String = "#menu:nations/usa";

      public static const NATIONS_FRANCE:String = "#menu:nations/france";

      public static const NATIONS_CHINA:String = "#menu:nations/china";

      public static const NATIONS_JAPAN:String = "#menu:nations/japan";

      public static const NATIONS_UK:String = "#menu:nations/uk";

      public static const NATIONS_ALL:String = "#menu:nations/all";

      public static const LEVELS_1:String = "#menu:levels/1";

      public static const LEVELS_2:String = "#menu:levels/2";

      public static const LEVELS_3:String = "#menu:levels/3";

      public static const LEVELS_4:String = "#menu:levels/4";

      public static const LEVELS_5:String = "#menu:levels/5";

      public static const LEVELS_6:String = "#menu:levels/6";

      public static const LEVELS_7:String = "#menu:levels/7";

      public static const LEVELS_8:String = "#menu:levels/8";

      public static const LEVELS_9:String = "#menu:levels/9";

      public static const LEVELS_10:String = "#menu:levels/10";

      public static const LEVELS_ALL:String = "#menu:levels/all";

      public static const NATION_TREE_TITLE_USSR:String = "#menu:nation_tree/title/ussr";

      public static const NATION_TREE_TITLE_GERMANY:String = "#menu:nation_tree/title/germany";

      public static const NATION_TREE_TITLE_USA:String = "#menu:nation_tree/title/usa";

      public static const NATION_TREE_TITLE_FRANCE:String = "#menu:nation_tree/title/france";

      public static const NATION_TREE_TITLE_UK:String = "#menu:nation_tree/title/uk";

      public static const NATION_TREE_TITLE_CHINA:String = "#menu:nation_tree/title/china";

      public static const NATION_TREE_TITLE_JAPAN:String = "#menu:nation_tree/title/japan";

      public static const SERVERSTATS_PLAYERSCOUNT:String = "#menu:serverStats/playersCount";

      public static const SERVERSTATS_ARENASCOUNT:String = "#menu:serverStats/arenasCount";

      public static const SERVERSTATS_PLAYERSINARENACOUNT:String = "#menu:serverStats/playersInArenaCount";

      public static const ACCOUNTINFO_EXPERIENCE:String = "#menu:accountInfo/experience";

      public static const ACCOUNTINFO_CREDITS:String = "#menu:accountInfo/credits";

      public static const ACCOUNTINFO_GOLD:String = "#menu:accountInfo/gold";

      public static const TANK_PARAMS_MAXHEALTH:String = "#menu:tank_params/maxHealth";

      public static const TANK_PARAMS_WEIGHT:String = "#menu:tank_params/weight";

      public static const TANK_PARAMS_ENGINEPOWER:String = "#menu:tank_params/enginePower";

      public static const TANK_PARAMS_ENGINEPOWERPERTON:String = "#menu:tank_params/enginePowerPerTon";

      public static const TANK_PARAMS_SPEEDLIMITS:String = "#menu:tank_params/speedLimits";

      public static const TANK_PARAMS_CHASSISROTATIONSPEED:String = "#menu:tank_params/chassisRotationSpeed";

      public static const TANK_PARAMS_HULLARMOR:String = "#menu:tank_params/hullArmor";

      public static const TANK_PARAMS_TURRETARMOR:String = "#menu:tank_params/turretArmor";

      public static const TANK_PARAMS_RELOADTIME:String = "#menu:tank_params/reloadTime";

      public static const TANK_PARAMS_RELOADTIMESECS:String = "#menu:tank_params/reloadTimeSecs";

      public static const TANK_PARAMS_PIERCINGPOWER:String = "#menu:tank_params/piercingPower";

      public static const TANK_PARAMS_DAMAGE:String = "#menu:tank_params/damage";

      public static const TANK_PARAMS_DAMAGEAVG:String = "#menu:tank_params/damageAvg";

      public static const TANK_PARAMS_DAMAGEAVGPERMINUTE:String = "#menu:tank_params/damageAvgPerMinute";

      public static const TANK_PARAMS_TURRETROTATIONSPEED:String = "#menu:tank_params/turretRotationSpeed";

      public static const TANK_PARAMS_GUNROTATIONSPEED:String = "#menu:tank_params/gunRotationSpeed";

      public static const TANK_PARAMS_CIRCULARVISIONRADIUS:String = "#menu:tank_params/circularVisionRadius";

      public static const TANK_PARAMS_RADIODISTANCE:String = "#menu:tank_params/radioDistance";

      public static const TANK_PARAMS_PARAM12:String = "#menu:tank_params/param12";

      public static const TANK_PARAMS_SHOTDISPERSIONANGLE:String = "#menu:tank_params/shotDispersionAngle";

      public static const TANK_PARAMS_AIMINGTIME:String = "#menu:tank_params/aimingTime";

      public static const TANK_PARAMS_MAXAMMO:String = "#menu:tank_params/maxAmmo";

      public static const TANK_PARAMS_VALUES_PARAM12_VALUE0:String = "#menu:tank_params/values/param12/value0";

      public static const TANK_PARAMS_VALUES_PARAM12_VALUE1:String = "#menu:tank_params/values/param12/value1";

      public static const TANK_PARAMS_VALUES_PARAM12_VALUE2:String = "#menu:tank_params/values/param12/value2";

      public static const TANK_PARAMS_VALUES_PARAM12_VALUE3:String = "#menu:tank_params/values/param12/value3";

      public static const TANK_PARAMS_VALUES_PARAM10_VALUE0:String = "#menu:tank_params/values/param10/value0";

      public static const TANK_PARAMS_VALUES_PARAM10_VALUE1:String = "#menu:tank_params/values/param10/value1";

      public static const TANK_PARAMS_VALUES_PARAM10_VALUE2:String = "#menu:tank_params/values/param10/value2";

      public static const TANK_PARAMS_VALUES_PARAM10_VALUE3:String = "#menu:tank_params/values/param10/value3";

      public static const TANK_PARAMS_VALUES_PARAM11_VALUE0:String = "#menu:tank_params/values/param11/value0";

      public static const TANK_PARAMS_VALUES_PARAM11_VALUE1:String = "#menu:tank_params/values/param11/value1";

      public static const TANK_PARAMS_VALUES_PARAM11_VALUE2:String = "#menu:tank_params/values/param11/value2";

      public static const TANK_PARAMS_VALUES_PARAM11_VALUE3:String = "#menu:tank_params/values/param11/value3";

      public static const TANK_PARAMS_EXPLOSIONRADIUS:String = "#menu:tank_params/explosionRadius";

      public static const DESCRIPTIONS_VEHICLE:String = "#menu:descriptions/vehicle";

      public static const DESCRIPTIONS_VEHICLEGUN:String = "#menu:descriptions/vehicleGun";

      public static const DESCRIPTIONS_VEHICLETURRET:String = "#menu:descriptions/vehicleTurret";

      public static const DESCRIPTIONS_VEHICLEENGINE:String = "#menu:descriptions/vehicleEngine";

      public static const DESCRIPTIONS_VEHICLECHASSIS:String = "#menu:descriptions/vehicleChassis";

      public static const DESCRIPTIONS_VEHICLERADIO:String = "#menu:descriptions/vehicleRadio";

      public static const DESCRIPTIONS_SHELL:String = "#menu:descriptions/shell";

      public static const DESCRIPTIONS_SHELLFULL:String = "#menu:descriptions/shellFull";

      public static const HEADERBUTTONS_BATTLE_TYPES_STANDART:String = "#menu:headerButtons/battle/types/standart";

      public static const HEADERBUTTONS_BATTLE_TYPES_STANDART_DESCR:String = "#menu:headerButtons/battle/types/standart/descr";

      public static const HEADERBUTTONS_BATTLE_TYPES_STANDARTLEAVE_DESCR:String = "#menu:headerButtons/battle/types/standartLeave/descr";

      public static const HEADERBUTTONS_BATTLE_TYPES_SQUAD:String = "#menu:headerButtons/battle/types/squad";

      public static const HEADERBUTTONS_BATTLE_TYPES_SQUADLEAVEOWNER:String = "#menu:headerButtons/battle/types/squadLeaveOwner";

      public static const HEADERBUTTONS_BATTLE_TYPES_SQUADLEAVE:String = "#menu:headerButtons/battle/types/squadLeave";

      public static const HEADERBUTTONS_BATTLE_TYPES_SQUAD_DESCR:String = "#menu:headerButtons/battle/types/squad/descr";

      public static const HEADERBUTTONS_BATTLE_TYPES_SQUADLEAVE_DESCR:String = "#menu:headerButtons/battle/types/squadLeave/descr";

      public static const HEADERBUTTONS_BATTLE_TYPES_SQUADBATTLE:String = "#menu:headerButtons/battle/types/squadBattle";

      public static const HEADERBUTTONS_BATTLE_TYPES_TRAINING:String = "#menu:headerButtons/battle/types/training";

      public static const HEADERBUTTONS_BATTLE_TYPES_TRAINING_DESCR:String = "#menu:headerButtons/battle/types/training/descr";

      public static const HEADERBUTTONS_BATTLE_TYPES_LEAVETRAINING_DESCR:String = "#menu:headerButtons/battle/types/leaveTraining/descr";

      public static const HEADERBUTTONS_BATTLE_TYPES_TRAININGLEAVEOWNER:String = "#menu:headerButtons/battle/types/trainingLeaveOwner";

      public static const HEADERBUTTONS_BATTLE_TYPES_TRAININGLEAVE:String = "#menu:headerButtons/battle/types/trainingLeave";

      public static const HEADERBUTTONS_BATTLE_TYPES_SPEC:String = "#menu:headerButtons/battle/types/spec";

      public static const HEADERBUTTONS_BATTLE_TYPES_SPEC_DESCR:String = "#menu:headerButtons/battle/types/spec/descr";

      public static const HEADERBUTTONS_BATTLE_TYPES_LEAVESPEC_DESCR:String = "#menu:headerButtons/battle/types/leaveSpec/descr";

      public static const HEADERBUTTONS_BATTLE_TYPES_SPECLEAVE:String = "#menu:headerButtons/battle/types/specLeave";

      public static const HEADERBUTTONS_BATTLE_TYPES_COMPANY:String = "#menu:headerButtons/battle/types/company";

      public static const HEADERBUTTONS_BATTLE_TYPES_COMPANY_DESCR:String = "#menu:headerButtons/battle/types/company/descr";

      public static const HEADERBUTTONS_BATTLE_TYPES_LEAVECOMPANY_DESCR:String = "#menu:headerButtons/battle/types/leaveCompany/descr";

      public static const HEADERBUTTONS_BATTLE_TYPES_COMPANYLEAVEOWNER:String = "#menu:headerButtons/battle/types/companyLeaveOwner";

      public static const HEADERBUTTONS_BATTLE_TYPES_COMPANYLEAVE:String = "#menu:headerButtons/battle/types/companyLeave";

      public static const HEADERBUTTONS_BATTLE_TYPES_UNIT:String = "#menu:headerButtons/battle/types/unit";

      public static const HEADERBUTTONS_BATTLE_TYPES_UNIT_DESCR:String = "#menu:headerButtons/battle/types/unit/descr";

      public static const HEADERBUTTONS_BATTLE_TYPES_LEAVEUNIT_DESCR:String = "#menu:headerButtons/battle/types/leaveUnit/descr";

      public static const HEADERBUTTONS_BATTLE_TYPES_UNITLEAVE:String = "#menu:headerButtons/battle/types/unitLeave";

      public static const HEADERBUTTONS_BATTLE_MENU_STANDART:String = "#menu:headerButtons/battle/menu/standart";

      public static const HEADERBUTTONS_BATTLE_MENU_SQUAD:String = "#menu:headerButtons/battle/menu/squad";

      public static const HEADERBUTTONS_BATTLE_MENU_TRAINING:String = "#menu:headerButtons/battle/menu/training";

      public static const HEADERBUTTONS_BATTLE_MENU_TEAM:String = "#menu:headerButtons/battle/menu/team";

      public static const HEADERBUTTONS_BATTLE_MENU_BATTLE_SESSION:String = "#menu:headerButtons/battle/menu/battle_session";

      public static const HEADERBUTTONS_BATTLE_MENU_UNIT:String = "#menu:headerButtons/battle/menu/unit";

      public static const HEADERBUTTONS_HANGAR:String = "#menu:headerButtons/hangar";

      public static const HEADERBUTTONS_SHOP:String = "#menu:headerButtons/shop";

      public static const HEADERBUTTONS_BATTLE:String = "#menu:headerButtons/battle";

      public static const HEADERBUTTONS_READY:String = "#menu:headerButtons/ready";

      public static const HEADERBUTTONS_NOTREADY:String = "#menu:headerButtons/notReady";

      public static const HEADERBUTTONS_RATING:String = "#menu:headerButtons/rating";

      public static const HEADERBUTTONS_PROFILE:String = "#menu:headerButtons/profile";

      public static const HEADERBUTTONS_INVENTORY:String = "#menu:headerButtons/inventory";

      public static const HEADERBUTTONS_TECHTREE:String = "#menu:headerButtons/techtree";

      public static const HEADERBUTTONS_BARRACKS:String = "#menu:headerButtons/barracks";

      public static const HEADERBUTTONS_BROWSER:String = "#menu:headerButtons/browser";

      public static const HEADERBUTTONS_MENU:String = "#menu:headerButtons/menu";

      public static const HEADERBUTTONS_ACCOUNT_PREMIUM:String = "#menu:headerButtons/account/premium";

      public static const HEADERBUTTONS_ACCOUNT_ACCOUNTREFILL:String = "#menu:headerButtons/account/accountRefill";

      public static const HEADERBUTTONS_ACCOUNT_GOLDEXCHANGE:String = "#menu:headerButtons/account/goldExchange";

      public static const HEADERBUTTONS_ACCOUNT_EXPGATHERING:String = "#menu:headerButtons/account/expGathering";

      public static const HEADER_ACCOUNT_PREMIUM_DAYS:String = "#menu:header/account/premium/days";

      public static const HEADER_ACCOUNT_PREMIUM_HOURS:String = "#menu:header/account/premium/hours";

      public static const HEADER_SERVERINFO:String = "#menu:header/serverInfo";

      public static const COMMON_PREMIUMBUY:String = "#menu:common/premiumBuy";

      public static const COMMON_PREMIUMCONTINUE:String = "#menu:common/premiumContinue";

      public static const MODULEFITS_CREDIT_ERROR:String = "#menu:moduleFits/credit_error";

      public static const MODULEFITS_GOLD_ERROR:String = "#menu:moduleFits/gold_error";

      public static const MODULEFITS_NEED_TURRET:String = "#menu:moduleFits/need_turret";

      public static const MODULEFITS_NOT_FOR_THIS_VEHICLE_TYPE:String = "#menu:moduleFits/not_for_this_vehicle_type";

      public static const MODULEFITS_NOT_FOR_CURRENT_VEHICLE:String = "#menu:moduleFits/not_for_current_vehicle";

      public static const MODULEFITS_TOO_HEAVY:String = "#menu:moduleFits/too_heavy";

      public static const MODULEFITS_TOO_HEAVY_CHASSIS:String = "#menu:moduleFits/too_heavy_chassis";

      public static const MODULEFITS_REMOVE_TOO_HEAVY:String = "#menu:moduleFits/remove_too_heavy";

      public static const MODULEFITS_UNLOCK_ERROR:String = "#menu:moduleFits/unlock_error";

      public static const MODULEFITS_WRONG_SLOT:String = "#menu:moduleFits/wrong_slot";

      public static const MODULEFITS_ALREADY_INSTALLED:String = "#menu:moduleFits/already_installed";

      public static const MODULEFITS_NOT_WITH_INSTALLED_EQUIPMENT:String = "#menu:moduleFits/not_with_installed_equipment";

      public static const MODULEFITS_DESTROYNAME:String = "#menu:moduleFits/destroyName";

      public static const MODULEFITS_DESTROYDESCR:String = "#menu:moduleFits/destroyDescr";

      public static const MODULEFITS_DESTROYTOOLTIP:String = "#menu:moduleFits/destroyToolTip";

      public static const MODULEFITS_REMOVENAME:String = "#menu:moduleFits/removeName";

      public static const MODULEFITS_REMOVEDESCR:String = "#menu:moduleFits/removeDescr";

      public static const MODULEFITS_REMOVETOOLTIP:String = "#menu:moduleFits/removeToolTip";

      public static const EXCHANGE_TITLE:String = "#menu:exchange/title";

      public static const EXCHANGE_RATE:String = "#menu:exchange/rate";

      public static const EXCHANGE_ONHAND:String = "#menu:exchange/onhand";

      public static const EXCHANGE_TOEXCHANGE:String = "#menu:exchange/toexchange";

      public static const EXCHANGE_RESULT:String = "#menu:exchange/result";

      public static const EXCHANGE_SUBMIT:String = "#menu:exchange/submit";

      public static const EXCHANGE_CANCEL:String = "#menu:exchange/cancel";

      public static const EXCHANGE_NO_GOLD:String = "#menu:exchange/no_gold";

      public static const EXCHANGEVCOIN_TITLE:String = "#menu:exchangeVcoin/title";

      public static const EXCHANGEVCOIN_VCOINISTIGHT:String = "#menu:exchangeVcoin/vcoinIsTight";

      public static const EXCHANGEVCOIN_BUYVCOINBTNNAME:String = "#menu:exchangeVcoin/buyVcoinBtnName";

      public static const EXCHANGEXP_TITLE:String = "#menu:exchangeXP/title";

      public static const EXCHANGEXP_AVAILABLE:String = "#menu:exchangeXP/available";

      public static const EXCHANGEXP_CHANGE:String = "#menu:exchangeXP/change";

      public static const EXCHANGEXP_PAY:String = "#menu:exchangeXP/pay";

      public static const EXCHANGEXP_SUBMIT:String = "#menu:exchangeXP/submit";

      public static const EXCHANGEXP_CANCEL:String = "#menu:exchangeXP/cancel";

      public static const TEACHINGSKILL_TITLE:String = "#menu:teachingSkill/title";

      public static const TEACHINGSKILL_BEFORE:String = "#menu:teachingSkill/before";

      public static const TEACHINGSKILL_COST:String = "#menu:teachingSkill/cost";

      public static const TEACHINGSKILL_AFTER:String = "#menu:teachingSkill/after";

      public static const TEACHINGSKILL_SUBMIT:String = "#menu:teachingSkill/submit";

      public static const TEACHINGSKILL_CANCEL:String = "#menu:teachingSkill/cancel";

      public static const TEACHINGSKILL_TEACHTOLEVEL:String = "#menu:teachingSkill/teachToLevel";

      public static const TEACHINGSKILL_TOTALPAY:String = "#menu:teachingSkill/totalPay";

      public static const TEACHINGSKILL_FREEXPISTIGHT:String = "#menu:teachingSkill/freeXpIsTight";

      public static const PROFILE_HEADER_REGISTRATIONDATETITLE:String = "#menu:profile/header/registrationDateTitle";

      public static const PROFILE_HEADER_LASTBATTLEDATETITLE:String = "#menu:profile/header/lastBattleDateTitle";

      public static const PROFILE_CLAN_LABEL:String = "#menu:profile/clan/label";

      public static const PROFILE_HEADER_CLAN_POSITION:String = "#menu:profile/header/clan/position";

      public static const PROFILE_HEADER_CLAN_JOINDATE:String = "#menu:profile/header/clan/joinDate";

      public static const PROFILE_HEADER_CLAN_POSITION_LEADER:String = "#menu:profile/header/clan/position/leader";

      public static const PROFILE_HEADER_CLAN_POSITION_VICE_LEADER:String = "#menu:profile/header/clan/position/vice_leader";

      public static const PROFILE_HEADER_CLAN_POSITION_RECRUITER:String = "#menu:profile/header/clan/position/recruiter";

      public static const PROFILE_HEADER_CLAN_POSITION_TREASURER:String = "#menu:profile/header/clan/position/treasurer";

      public static const PROFILE_HEADER_CLAN_POSITION_DIPLOMAT:String = "#menu:profile/header/clan/position/diplomat";

      public static const PROFILE_HEADER_CLAN_POSITION_COMMANDER:String = "#menu:profile/header/clan/position/commander";

      public static const PROFILE_HEADER_CLAN_POSITION_PRIVATE:String = "#menu:profile/header/clan/position/private";

      public static const PROFILE_HEADER_CLAN_POSITION_RECRUIT:String = "#menu:profile/header/clan/position/recruit";

      public static const PROFILE_HEADER_FIGHTS:String = "#menu:profile/header/fights";

      public static const PROFILE_HEADER_WINS:String = "#menu:profile/header/wins";

      public static const PROFILE_CREDITS:String = "#menu:profile/credits";

      public static const PROFILE_GOLD:String = "#menu:profile/gold";

      public static const PROFILE_CREATIONTIME:String = "#menu:profile/creationTime";

      public static const PROFILE_LIST_TOTALNAME:String = "#menu:profile/list/totalName";

      public static const PROFILE_LIST_DESCR:String = "#menu:profile/list/descr";

      public static const PROFILE_STATS_BLOCKS_COMMON:String = "#menu:profile/stats/blocks/common";

      public static const PROFILE_STATS_BLOCKS_BATTLEEFFECT:String = "#menu:profile/stats/blocks/battleeffect";

      public static const PROFILE_STATS_BLOCKS_CREDITS:String = "#menu:profile/stats/blocks/credits";

      public static const PROFILE_STATS_BLOCKS_STUDYING:String = "#menu:profile/stats/blocks/studying";

      public static const PROFILE_STATS_ITEMS_READYTOLEARN:String = "#menu:profile/stats/items/readyToLearn";

      public static const PROFILE_STATS_ITEMS_NEXTSKILLXPLEFT:String = "#menu:profile/stats/items/nextSkillXPLeft";

      public static const PROFILE_STATS_ITEMS_NEXTSKILLBATTLESLEFT:String = "#menu:profile/stats/items/nextSkillBattlesLeft";

      public static const PROFILE_STATS_ITEMS_XP:String = "#menu:profile/stats/items/xp";

      public static const PROFILE_STATS_ITEMS_FRAGS:String = "#menu:profile/stats/items/frags";

      public static const PROFILE_STATS_ITEMS_UNKNOWN:String = "#menu:profile/stats/items/unknown";

      public static const PROFILE_STATS_ITEMS_READY:String = "#menu:profile/stats/items/ready";

      public static const PROFILE_STATS_ITEMS_FRAGSBEAST:String = "#menu:profile/stats/items/fragsBeast";

      public static const PROFILE_STATS_ITEMS_AVGEXPERIENCE:String = "#menu:profile/stats/items/avgExperience";

      public static const PROFILE_STATS_ITEMS_MAXXP:String = "#menu:profile/stats/items/maxXP";

      public static const PROFILE_STATS_ITEMS_MAXFRAGS:String = "#menu:profile/stats/items/maxFrags";

      public static const PROFILE_STATS_ITEMS_BATTLESCOUNT:String = "#menu:profile/stats/items/battlesCount";

      public static const PROFILE_STATS_ITEMS_WINS:String = "#menu:profile/stats/items/wins";

      public static const PROFILE_STATS_ITEMS_LOSSES:String = "#menu:profile/stats/items/losses";

      public static const PROFILE_STATS_ITEMS_SURVIVEDBATTLES:String = "#menu:profile/stats/items/survivedBattles";

      public static const PROFILE_STATS_ITEMS_LASTBATTLETIME:String = "#menu:profile/stats/items/lastBattleTime";

      public static const PROFILE_STATS_ITEMS_EFFECTIVESHOTS:String = "#menu:profile/stats/items/effectiveShots";

      public static const PROFILE_STATS_ITEMS_DAMAGEDEALT:String = "#menu:profile/stats/items/damageDealt";

      public static const PROFILE_STATS_ITEMS_HEROES:String = "#menu:profile/stats/items/heroes";

      public static const PROFILE_STATS_ITEMS_WARRIOR:String = "#menu:profile/stats/items/warrior";

      public static const PROFILE_STATS_ITEMS_INVADER:String = "#menu:profile/stats/items/invader";

      public static const PROFILE_STATS_ITEMS_SNIPER:String = "#menu:profile/stats/items/sniper";

      public static const PROFILE_STATS_ITEMS_DEFENDER:String = "#menu:profile/stats/items/defender";

      public static const PROFILE_STATS_ITEMS_STEELWALL:String = "#menu:profile/stats/items/steelwall";

      public static const PROFILE_STATS_ITEMS_SUPPORTER:String = "#menu:profile/stats/items/supporter";

      public static const PROFILE_STATS_ITEMS_SCOUT:String = "#menu:profile/stats/items/scout";

      public static const PROFILE_STATS_ITEMS_MEDALKAY:String = "#menu:profile/stats/items/medalKay";

      public static const PROFILE_EXCHANGE:String = "#menu:profile/exchange";

      public static const PROFILE_PREMIUMBUY:String = "#menu:profile/premiumBuy";

      public static const PROFILE_PREMIUMCONTINUE:String = "#menu:profile/premiumContinue";

      public static const PROFILE_PREMIUNEXPIRATIONDATE:String = "#menu:profile/premiunExpirationDate";

      public static const ACCOUNTTYPES_GUEST:String = "#menu:accountTypes/guest";

      public static const ACCOUNTTYPES_FREE:String = "#menu:accountTypes/free";

      public static const ACCOUNTTYPES_BASE:String = "#menu:accountTypes/base";

      public static const ACCOUNTTYPES_PREMIUM:String = "#menu:accountTypes/premium";

      public static const ACCOUNTTYPES_DEMO:String = "#menu:accountTypes/demo";

      public static const PREMIUM_BUYTITLE:String = "#menu:premium/buyTitle";

      public static const PREMIUM_CONTINUETITLE:String = "#menu:premium/continueTitle";

      public static const PREMIUM_PROMOMESSAGE:String = "#menu:premium/promoMessage";

      public static const PREMIUM_BUYMESSAGE:String = "#menu:premium/buyMessage";

      public static const PREMIUM_CONTINUEMESSAGE:String = "#menu:premium/continueMessage";

      public static const PREMIUM_OFCREDITSANDEXPERIENCE:String = "#menu:premium/ofCreditsAndExperience";

      public static const PREMIUM_PEREVERBUTTLE:String = "#menu:premium/perEverButtle";

      public static const PREMIUM_PERIODS_DAYS1:String = "#menu:premium/periods/days1";

      public static const PREMIUM_PERIODS_DAYS3:String = "#menu:premium/periods/days3";

      public static const PREMIUM_PERIODS_DAYS7:String = "#menu:premium/periods/days7";

      public static const PREMIUM_PERIODS_DAYS30:String = "#menu:premium/periods/days30";

      public static const PREMIUM_PERIODS_DAYS180:String = "#menu:premium/periods/days180";

      public static const PREMIUM_PERIODS_DAYS360:String = "#menu:premium/periods/days360";

      public static const PREMIUM_GOLD:String = "#menu:premium/gold";

      public static const PREMIUM_SUBMITBUY:String = "#menu:premium/submitBuy";

      public static const PREMIUM_SUBMITCONTINUE:String = "#menu:premium/submitContinue";

      public static const PREMIUM_CANCEL:String = "#menu:premium/cancel";

      public static const MODULEINFO_TITLE:String = "#menu:moduleInfo/title";

      public static const MODULEINFO_PARAMETERSLABEL:String = "#menu:moduleInfo/parametersLabel";

      public static const MODULEINFO_PARAMETERSCLIPGUNLABEL:String = "#menu:moduleInfo/parametersClipGunLabel";

      public static const MODULEINFO_CLIPGUNLABEL:String = "#menu:moduleInfo/clipGunLabel";

      public static const MODULEINFO_PARAMS_MAXLOAD:String = "#menu:moduleInfo/params/maxLoad";

      public static const MODULEINFO_PARAMS_ENGINEPOWER:String = "#menu:moduleInfo/params/enginePower";

      public static const MODULEINFO_PARAMS_CALIBER:String = "#menu:moduleInfo/params/caliber";

      public static const MODULEINFO_PARAMS_SHELLSCOUNT:String = "#menu:moduleInfo/params/shellsCount";

      public static const MODULEINFO_PARAMS_SHELLRELOADINGTIME:String = "#menu:moduleInfo/params/shellReloadingTime";

      public static const MODULEINFO_PARAMS_RELOADMAGAZINETIME:String = "#menu:moduleInfo/params/reloadMagazineTime";

      public static const MODULEINFO_PARAMS_RELOADTIME:String = "#menu:moduleInfo/params/reloadTime";

      public static const MODULEINFO_PARAMS_PIERCINGPOWER:String = "#menu:moduleInfo/params/piercingPower";

      public static const MODULEINFO_ADDITIONALINFO:String = "#menu:moduleInfo/additionalInfo";

      public static const MODULEINFO_PARAMS_DAMAGE:String = "#menu:moduleInfo/params/damage";

      public static const MODULEINFO_PARAMS_AVGPIERCINGPOWER:String = "#menu:moduleInfo/params/avgPiercingPower";

      public static const MODULEINFO_PARAMS_AVGDAMAGE:String = "#menu:moduleInfo/params/avgDamage";

      public static const MODULEINFO_PARAMS_ARMOR:String = "#menu:moduleInfo/params/armor";

      public static const MODULEINFO_PARAMS_ROTATIONSPEED:String = "#menu:moduleInfo/params/rotationSpeed";

      public static const MODULEINFO_PARAMS_DISPERTIONRADIUS:String = "#menu:moduleInfo/params/dispertionRadius";

      public static const MODULEINFO_PARAMS_AIMINGTIME:String = "#menu:moduleInfo/params/aimingTime";

      public static const MODULEINFO_PARAMS_FIRESTARTINGCHANCE:String = "#menu:moduleInfo/params/fireStartingChance";

      public static const MODULEINFO_PARAMS_RADIODISTANCE:String = "#menu:moduleInfo/params/radioDistance";

      public static const MODULEINFO_PARAMS_CIRCULARVISIONRADIUS:String = "#menu:moduleInfo/params/circularVisionRadius";

      public static const MODULEINFO_PARAMS_WEIGHT:String = "#menu:moduleInfo/params/weight";

      public static const MODULEINFO_PARAMS_EXPLOSIONRADIUS:String = "#menu:moduleInfo/params/explosionRadius";

      public static const MODULEINFO_COMPATIBLE_TURRETS:String = "#menu:moduleInfo/compatible/turrets";

      public static const MODULEINFO_COMPATIBLE_SHELLS:String = "#menu:moduleInfo/compatible/shells";

      public static const MODULEINFO_COMPATIBLE_GUNS:String = "#menu:moduleInfo/compatible/guns";

      public static const MODULEINFO_COMPATIBLE_SHELLGUNS:String = "#menu:moduleInfo/compatible/shellGuns";

      public static const MODULEINFO_COMPATIBLE_VEHICLES:String = "#menu:moduleInfo/compatible/vehicles";

      public static const MODULEINFO_COMPATIBLE_UNICHARGEDVEHICLES:String = "#menu:moduleInfo/compatible/uniChargedVehicles";

      public static const MODULEINFO_COMPATIBLE_CLIPVEHICLES:String = "#menu:moduleInfo/compatible/clipVehicles";

      public static const MODULEINFO_CLOSEBTN:String = "#menu:moduleInfo/closeBtn";

      public static const VEHICLEINFO_TITLE:String = "#menu:vehicleInfo/title";

      public static const VEHICLEINFO_PARAMS_MAXHEALTH:String = "#menu:vehicleInfo/params/maxHealth";

      public static const VEHICLEINFO_PARAMS_WEIGHT:String = "#menu:vehicleInfo/params/weight";

      public static const VEHICLEINFO_PARAMS_ENGINEPOWER:String = "#menu:vehicleInfo/params/enginePower";

      public static const VEHICLEINFO_PARAMS_SPEEDLIMITS:String = "#menu:vehicleInfo/params/speedLimits";

      public static const VEHICLEINFO_PARAMS_CHASSISROTATIONSPEED:String = "#menu:vehicleInfo/params/chassisRotationSpeed";

      public static const VEHICLEINFO_PARAMS_HULLARMOR:String = "#menu:vehicleInfo/params/hullArmor";

      public static const VEHICLEINFO_PARAMS_TURRETARMOR:String = "#menu:vehicleInfo/params/turretArmor";

      public static const VEHICLEINFO_PARAMS_RELOADTIME:String = "#menu:vehicleInfo/params/reloadTime";

      public static const VEHICLEINFO_PARAMS_PIERCINGPOWER:String = "#menu:vehicleInfo/params/piercingPower";

      public static const VEHICLEINFO_PARAMS_DAMAGE:String = "#menu:vehicleInfo/params/damage";

      public static const VEHICLEINFO_PARAMS_TURRETROTATIONSPEED:String = "#menu:vehicleInfo/params/turretRotationSpeed";

      public static const VEHICLEINFO_PARAMS_GUNROTATIONSPEED:String = "#menu:vehicleInfo/params/gunRotationSpeed";

      public static const VEHICLEINFO_PARAMS_CIRCULARVISIONRADIUS:String = "#menu:vehicleInfo/params/circularVisionRadius";

      public static const VEHICLEINFO_PARAMS_RADIODISTANCE:String = "#menu:vehicleInfo/params/radioDistance";

      public static const VEHICLEINFO_TABS_PROPERTIES:String = "#menu:vehicleInfo/tabs/properties";

      public static const VEHICLEINFO_TABS_BASE:String = "#menu:vehicleInfo/tabs/base";

      public static const VEHICLEINFO_TABS_STATISTIC:String = "#menu:vehicleInfo/tabs/statistic";

      public static const VEHICLEINFO_TABS_CREW:String = "#menu:vehicleInfo/tabs/crew";

      public static const VEHICLEINFO_CLOSEBTN:String = "#menu:vehicleInfo/closeBtn";

      public static const UNLOCKS_UNLOCKBUTTON:String = "#menu:unlocks/unlockButton";

      public static const UNLOCKS_EXCHANGEBUTTON:String = "#menu:unlocks/exchangeButton";

      public static const UNLOCKS_XPTOTMENCHECKBOX:String = "#menu:unlocks/xpToTmenCheckbox";

      public static const RESEARCH_PREMIUM_BENEFITS_HEAD:String = "#menu:research/premium/benefits/head";

      public static const RESEARCH_SPECIAL_BENEFITS_HEAD:String = "#menu:research/special/benefits/head";

      public static const RESEARCH_PREMIUM_BENEFITS_FIRST:String = "#menu:research/premium/benefits/first";

      public static const RESEARCH_PREMIUM_BENEFITS_SECOND:String = "#menu:research/premium/benefits/second";

      public static const RESEARCH_PREMIUM_BENEFITS_THIRD:String = "#menu:research/premium/benefits/third";

      public static const RESEARCH_PREMIUM_BENEFITS_FOURTH:String = "#menu:research/premium/benefits/fourth";

      public static const RESEARCH_PREMIUM_BENEFITS_FIFTH:String = "#menu:research/premium/benefits/fifth";

      public static const RESEARCH_PREMIUM_DESCRIPTION_TITTE:String = "#menu:research/premium/description/titte";

      public static const RESEARCH_LABELS_BUTTON_SHOWINHANGAR:String = "#menu:research/labels/button/showInHangar";

      public static const RESEARCH_LABELS_VEHXP:String = "#menu:research/labels/vehXP";

      public static const RESEARCH_LABELS_FREEXP:String = "#menu:research/labels/freeXP";

      public static const RESEARCH_LABELS_TOTALXP:String = "#menu:research/labels/totalXP";

      public static const BARRACKS_MENU_ROLEFILTER_TEXTFIELD:String = "#menu:barracks/menu/roleFilter/textfield";

      public static const BARRACKS_BTNBUYTANKMAN:String = "#menu:barracks/btnBuyTankman";

      public static const BARRACKS_BTNBUYBERTH:String = "#menu:barracks/btnBuyBerth";

      public static const BARRACKS_BTNBUYBERTHDECS:String = "#menu:barracks/btnBuyBerthDecs";

      public static const BARRACKS_MENU_ROLEFILTER_ALL:String = "#menu:barracks/menu/roleFilter/all";

      public static const BARRACKS_MENU_ROLEFILTER_COMMANDER:String = "#menu:barracks/menu/roleFilter/commander";

      public static const BARRACKS_MENU_ROLEFILTER_RADIOMAN:String = "#menu:barracks/menu/roleFilter/radioman";

      public static const BARRACKS_MENU_ROLEFILTER_GUNNER:String = "#menu:barracks/menu/roleFilter/gunner";

      public static const BARRACKS_MENU_ROLEFILTER_LOADER:String = "#menu:barracks/menu/roleFilter/loader";

      public static const BARRACKS_MENU_ROLEFILTER_DRIVER:String = "#menu:barracks/menu/roleFilter/driver";

      public static const BARRACKS_MENU_TANKTYPEFILTER_TEXTFIELD:String = "#menu:barracks/menu/tankTypeFilter/textfield";

      public static const BARRACKS_MENU_LOCATIONFILTER_TEXTFIELD:String = "#menu:barracks/menu/locationFilter/textfield";

      public static const BARRACKS_MENU_LOCATIONFILTER_TANKS:String = "#menu:barracks/menu/locationFilter/tanks";

      public static const BARRACKS_MENU_LOCATIONFILTER_BARRACKS:String = "#menu:barracks/menu/locationFilter/barracks";

      public static const BARRACKS_MENU_LOCATIONFILTER_ALL:String = "#menu:barracks/menu/locationFilter/all";

      public static const BARRACKS_TANKMENCOUNT:String = "#menu:barracks/tankmenCount";

      public static const BARRACKS_BTNRECRUIT:String = "#menu:barracks/btnRecruit";

      public static const BARRACKS_PLACESCOUNT:String = "#menu:barracks/placesCount";

      public static const BARRACKS_BARRACKSRENDERER_PLACESCOUNT:String = "#menu:barracks/barracksRenderer/placesCount";

      public static const BARRACKS_BTNNEWPLACE:String = "#menu:barracks/btnNewPlace";

      public static const BARRACKS_BTNUNLOAD:String = "#menu:barracks/btnUnload";

      public static const BARRACKS_BTNDISSMISS:String = "#menu:barracks/btnDissmiss";

      public static const INVENTORY_MENU_VEHICLE_NAME:String = "#menu:inventory/menu/vehicle/name";

      public static const INVENTORY_MENU_VEHICLE_TAGS_NAME:String = "#menu:inventory/menu/vehicle/tags/name";

      public static const INVENTORY_MENU_VEHICLE_TAGS_ALL_NAME:String = "#menu:inventory/menu/vehicle/tags/all/name";

      public static const INVENTORY_MENU_VEHICLE_TAGS_LIGHTTANK_NAME:String = "#menu:inventory/menu/vehicle/tags/lightTank/name";

      public static const INVENTORY_MENU_VEHICLE_TAGS_MEDIUMTANK_NAME:String = "#menu:inventory/menu/vehicle/tags/mediumTank/name";

      public static const INVENTORY_MENU_VEHICLE_TAGS_HEAVYTANK_NAME:String = "#menu:inventory/menu/vehicle/tags/heavyTank/name";

      public static const INVENTORY_MENU_VEHICLE_TAGS_AT_SPG_NAME:String = "#menu:inventory/menu/vehicle/tags/at-spg/name";

      public static const INVENTORY_MENU_VEHICLE_TAGS_SPG_NAME:String = "#menu:inventory/menu/vehicle/tags/spg/name";

      public static const INVENTORY_MENU_VEHICLE_EXTRA_NAME:String = "#menu:inventory/menu/vehicle/extra/name";

      public static const INVENTORY_MENU_VEHICLE_EXTRA_BROCKEN_NAME:String = "#menu:inventory/menu/vehicle/extra/brocken/name";

      public static const INVENTORY_MENU_VEHICLE_EXTRA_LOCKED_NAME:String = "#menu:inventory/menu/vehicle/extra/locked/name";

      public static const INVENTORY_MENU_MODULE_NAME:String = "#menu:inventory/menu/module/name";

      public static const INVENTORY_MENU_MODULE_TYPES_NAME:String = "#menu:inventory/menu/module/types/name";

      public static const INVENTORY_MENU_MODULE_TYPES_VEHICLECHASSIS_NAME:String = "#menu:inventory/menu/module/types/vehicleChassis/name";

      public static const INVENTORY_MENU_MODULE_TYPES_VEHICLETURRET_NAME:String = "#menu:inventory/menu/module/types/vehicleTurret/name";

      public static const INVENTORY_MENU_MODULE_TYPES_VEHICLEGUN_NAME:String = "#menu:inventory/menu/module/types/vehicleGun/name";

      public static const INVENTORY_MENU_MODULE_TYPES_VEHICLEENGINE_NAME:String = "#menu:inventory/menu/module/types/vehicleEngine/name";

      public static const INVENTORY_MENU_MODULE_TYPES_VEHICLERADIO_NAME:String = "#menu:inventory/menu/module/types/vehicleRadio/name";

      public static const INVENTORY_MENU_MODULE_FITS_NAME:String = "#menu:inventory/menu/module/fits/name";

      public static const INVENTORY_MENU_MODULE_FITS_MYVEHICLE_NAME:String = "#menu:inventory/menu/module/fits/myVehicle/name";

      public static const INVENTORY_MENU_MODULE_FITS_MYVEHICLES_NAME:String = "#menu:inventory/menu/module/fits/myVehicles/name";

      public static const INVENTORY_MENU_MODULE_FITS_OTHERVEHICLES_NAME:String = "#menu:inventory/menu/module/fits/otherVehicles/name";

      public static const INVENTORY_MENU_MODULE_EXTRA_NAME:String = "#menu:inventory/menu/module/extra/name";

      public static const INVENTORY_MENU_MODULE_EXTRA_ONVEHICLE_NAME:String = "#menu:inventory/menu/module/extra/onVehicle/name";

      public static const INVENTORY_MENU_SHELL_NAME:String = "#menu:inventory/menu/shell/name";

      public static const INVENTORY_MENU_SHELL_KINDS_NAME:String = "#menu:inventory/menu/shell/kinds/name";

      public static const INVENTORY_MENU_SHELL_KINDS_ARMOR_PIERCING_NAME:String = "#menu:inventory/menu/shell/kinds/ARMOR_PIERCING/name";

      public static const INVENTORY_MENU_SHELL_KINDS_ARMOR_PIERCING_CR_NAME:String = "#menu:inventory/menu/shell/kinds/ARMOR_PIERCING_CR/name";

      public static const INVENTORY_MENU_SHELL_KINDS_ARMOR_PIERCING_HE_NAME:String = "#menu:inventory/menu/shell/kinds/ARMOR_PIERCING_HE/name";

      public static const INVENTORY_MENU_SHELL_KINDS_HOLLOW_CHARGE_NAME:String = "#menu:inventory/menu/shell/kinds/HOLLOW_CHARGE/name";

      public static const INVENTORY_MENU_SHELL_KINDS_HIGH_EXPLOSIVE_NAME:String = "#menu:inventory/menu/shell/kinds/HIGH_EXPLOSIVE/name";

      public static const INVENTORY_MENU_SHELL_FITS_NAME:String = "#menu:inventory/menu/shell/fits/name";

      public static const INVENTORY_MENU_SHELL_FITS_MYVEHICLEGUN_NAME:String = "#menu:inventory/menu/shell/fits/myVehicleGun/name";

      public static const INVENTORY_MENU_SHELL_FITS_MYINVENTORYGUNS_NAME:String = "#menu:inventory/menu/shell/fits/myInventoryGuns/name";

      public static const INVENTORY_MENU_SHELL_FITS_MYVEHICLESINVENTORYGUNS_NAME:String = "#menu:inventory/menu/shell/fits/myVehiclesInventoryGuns/name";

      public static const INVENTORY_MENU_SHELL_FITS_OTHERGUNS_NAME:String = "#menu:inventory/menu/shell/fits/otherGuns/name";

      public static const INVENTORY_MENU_OPTIONALDEVICE_NAME:String = "#menu:inventory/menu/optionalDevice/name";

      public static const INVENTORY_MENU_OPTIONALDEVICE_FITS_NAME:String = "#menu:inventory/menu/optionalDevice/fits/name";

      public static const INVENTORY_MENU_OPTIONALDEVICE_FITS_MYVEHICLE_NAME:String = "#menu:inventory/menu/optionalDevice/fits/myVehicle/name";

      public static const INVENTORY_MENU_OPTIONALDEVICE_FITS_MYVEHICLES_NAME:String = "#menu:inventory/menu/optionalDevice/fits/myVehicles/name";

      public static const INVENTORY_MENU_OPTIONALDEVICE_FITS_OTHERVEHICLES_NAME:String = "#menu:inventory/menu/optionalDevice/fits/otherVehicles/name";

      public static const INVENTORY_MENU_OPTIONALDEVICE_EXTRA_NAME:String = "#menu:inventory/menu/optionalDevice/extra/name";

      public static const INVENTORY_MENU_OPTIONALDEVICE_EXTRA_ONVEHICLE_NAME:String = "#menu:inventory/menu/optionalDevice/extra/onVehicle/name";

      public static const INVENTORY_MENU_EQUIPMENT_NAME:String = "#menu:inventory/menu/equipment/name";

      public static const INVENTORY_MENU_EQUIPMENT_FITS_NAME:String = "#menu:inventory/menu/equipment/fits/name";

      public static const INVENTORY_MENU_EQUIPMENT_FITS_MYVEHICLE_NAME:String = "#menu:inventory/menu/equipment/fits/myVehicle/name";

      public static const INVENTORY_MENU_EQUIPMENT_FITS_MYVEHICLES_NAME:String = "#menu:inventory/menu/equipment/fits/myVehicles/name";

      public static const INVENTORY_MENU_EQUIPMENT_FITS_OTHERVEHICLES_NAME:String = "#menu:inventory/menu/equipment/fits/otherVehicles/name";

      public static const INVENTORY_ERRORS_RESERVED:String = "#menu:inventory/errors/reserved";

      public static const INVENTORY_DEVICE_ERRORS_NOT_REMOVABLE:String = "#menu:inventory/device/errors/not_removable";

      public static const INVENTORY_DEVICE_ERRORS_RESERVED:String = "#menu:inventory/device/errors/reserved";

      public static const INVENTORY_TABLE_HEADER_COUNT:String = "#menu:inventory/table/header/count";

      public static const INVENTORY_TABLE_HEADER_PRICE:String = "#menu:inventory/table/header/price";

      public static const INVENTORY_TABLE_BUTTONSELL:String = "#menu:inventory/table/buttonSell";

      public static const SHOP_MENU_VEHICLE_NAME:String = "#menu:shop/menu/vehicle/name";

      public static const SHOP_MENU_VEHICLE_TAGS_NAME:String = "#menu:shop/menu/vehicle/tags/name";

      public static const SHOP_MENU_VEHICLE_TAGS_ALL_NAME:String = "#menu:shop/menu/vehicle/tags/all/name";

      public static const SHOP_MENU_VEHICLE_TAGS_LIGHTTANK_NAME:String = "#menu:shop/menu/vehicle/tags/lightTank/name";

      public static const SHOP_MENU_VEHICLE_TAGS_MEDIUMTANK_NAME:String = "#menu:shop/menu/vehicle/tags/mediumTank/name";

      public static const SHOP_MENU_VEHICLE_TAGS_HEAVYTANK_NAME:String = "#menu:shop/menu/vehicle/tags/heavyTank/name";

      public static const SHOP_MENU_VEHICLE_TAGS_AT_SPG_NAME:String = "#menu:shop/menu/vehicle/tags/at-spg/name";

      public static const SHOP_MENU_VEHICLE_TAGS_SPG_NAME:String = "#menu:shop/menu/vehicle/tags/spg/name";

      public static const SHOP_MENU_VEHICLE_EXTRA_NAME:String = "#menu:shop/menu/vehicle/extra/name";

      public static const SHOP_MENU_VEHICLE_EXTRA_LOCKED_NAME:String = "#menu:shop/menu/vehicle/extra/locked/name";

      public static const SHOP_MENU_VEHICLE_EXTRA_INHANGAR_NAME:String = "#menu:shop/menu/vehicle/extra/inHangar/name";

      public static const SHOP_MENU_MODULE_NAME:String = "#menu:shop/menu/module/name";

      public static const SHOP_MENU_MODULE_TYPES_NAME:String = "#menu:shop/menu/module/types/name";

      public static const SHOP_MENU_MODULE_TYPES_VEHICLECHASSIS_NAME:String = "#menu:shop/menu/module/types/vehicleChassis/name";

      public static const SHOP_MENU_MODULE_TYPES_VEHICLETURRET_NAME:String = "#menu:shop/menu/module/types/vehicleTurret/name";

      public static const SHOP_MENU_MODULE_TYPES_VEHICLEGUN_NAME:String = "#menu:shop/menu/module/types/vehicleGun/name";

      public static const SHOP_MENU_MODULE_TYPES_VEHICLEENGINE_NAME:String = "#menu:shop/menu/module/types/vehicleEngine/name";

      public static const SHOP_MENU_MODULE_TYPES_VEHICLERADIO_NAME:String = "#menu:shop/menu/module/types/vehicleRadio/name";

      public static const SHOP_MENU_MODULE_FITS_NAME:String = "#menu:shop/menu/module/fits/name";

      public static const SHOP_MENU_MODULE_FITS_MYVEHICLE_NAME:String = "#menu:shop/menu/module/fits/myVehicle/name";

      public static const SHOP_MENU_MODULE_FITS_MYVEHICLES_NAME:String = "#menu:shop/menu/module/fits/myVehicles/name";

      public static const SHOP_MENU_MODULE_FITS_OTHERVEHICLES_NAME:String = "#menu:shop/menu/module/fits/otherVehicles/name";

      public static const SHOP_MENU_MODULE_EXTRA_NAME:String = "#menu:shop/menu/module/extra/name";

      public static const SHOP_MENU_MODULE_EXTRA_LOCKED_NAME:String = "#menu:shop/menu/module/extra/locked/name";

      public static const SHOP_MENU_MODULE_EXTRA_ONVEHICLE_NAME:String = "#menu:shop/menu/module/extra/onVehicle/name";

      public static const SHOP_MENU_MODULE_EXTRA_INHANGAR_NAME:String = "#menu:shop/menu/module/extra/inHangar/name";

      public static const SHOP_MENU_SHELL_NAME:String = "#menu:shop/menu/shell/name";

      public static const SHOP_MENU_SHELL_KINDS_NAME:String = "#menu:shop/menu/shell/kinds/name";

      public static const SHOP_MENU_SHELL_KINDS_ARMOR_PIERCING_NAME:String = "#menu:shop/menu/shell/kinds/ARMOR_PIERCING/name";

      public static const SHOP_MENU_SHELL_KINDS_ARMOR_PIERCING_CR_NAME:String = "#menu:shop/menu/shell/kinds/ARMOR_PIERCING_CR/name";

      public static const SHOP_MENU_SHELL_KINDS_ARMOR_PIERCING_HE_NAME:String = "#menu:shop/menu/shell/kinds/ARMOR_PIERCING_HE/name";

      public static const SHOP_MENU_SHELL_KINDS_HOLLOW_CHARGE_NAME:String = "#menu:shop/menu/shell/kinds/HOLLOW_CHARGE/name";

      public static const SHOP_MENU_SHELL_KINDS_HIGH_EXPLOSIVE_NAME:String = "#menu:shop/menu/shell/kinds/HIGH_EXPLOSIVE/name";

      public static const SHOP_MENU_SHELL_FITS_NAME:String = "#menu:shop/menu/shell/fits/name";

      public static const SHOP_MENU_SHELL_FITS_MYVEHICLEGUN_NAME:String = "#menu:shop/menu/shell/fits/myVehicleGun/name";

      public static const SHOP_MENU_SHELL_FITS_MYINVENTORYGUNS_NAME:String = "#menu:shop/menu/shell/fits/myInventoryGuns/name";

      public static const SHOP_MENU_SHELL_FITS_MYVEHICLESINVENTORYGUNS_NAME:String = "#menu:shop/menu/shell/fits/myVehiclesInventoryGuns/name";

      public static const SHOP_MENU_SHELL_FITS_OTHERGUNS_NAME:String = "#menu:shop/menu/shell/fits/otherGuns/name";

      public static const SHOP_MENU_OPTIONALDEVICE_NAME:String = "#menu:shop/menu/optionalDevice/name";

      public static const SHOP_MENU_OPTIONALDEVICE_FITS_NAME:String = "#menu:shop/menu/optionalDevice/fits/name";

      public static const SHOP_MENU_OPTIONALDEVICE_FITS_MYVEHICLE_NAME:String = "#menu:shop/menu/optionalDevice/fits/myVehicle/name";

      public static const SHOP_MENU_OPTIONALDEVICE_FITS_MYVEHICLES_NAME:String = "#menu:shop/menu/optionalDevice/fits/myVehicles/name";

      public static const SHOP_MENU_OPTIONALDEVICE_FITS_OTHERVEHICLES_NAME:String = "#menu:shop/menu/optionalDevice/fits/otherVehicles/name";

      public static const SHOP_MENU_OPTIONALDEVICE_EXTRA_NAME:String = "#menu:shop/menu/optionalDevice/extra/name";

      public static const SHOP_MENU_OPTIONALDEVICE_EXTRA_ONVEHICLE_NAME:String = "#menu:shop/menu/optionalDevice/extra/onVehicle/name";

      public static const SHOP_MENU_EQUIPMENT_NAME:String = "#menu:shop/menu/equipment/name";

      public static const SHOP_MENU_EQUIPMENT_FITS_NAME:String = "#menu:shop/menu/equipment/fits/name";

      public static const SHOP_MENU_EQUIPMENT_FITS_MYVEHICLE_NAME:String = "#menu:shop/menu/equipment/fits/myVehicle/name";

      public static const SHOP_MENU_EQUIPMENT_FITS_MYVEHICLES_NAME:String = "#menu:shop/menu/equipment/fits/myVehicles/name";

      public static const SHOP_MENU_EQUIPMENT_FITS_OTHERVEHICLES_NAME:String = "#menu:shop/menu/equipment/fits/otherVehicles/name";

      public static const SHOP_ERRORS_UNLOCKNEEDED:String = "#menu:shop/errors/unlockNeeded";

      public static const SHOP_ERRORS_INHANGAR:String = "#menu:shop/errors/inHangar";

      public static const SHOP_ERRORS_CENTERISDOWN:String = "#menu:shop/errors/centerIsDown";

      public static const SHOP_TABLE_FIND:String = "#menu:shop/table/find";

      public static const SHOP_TABLE_HEADER_COUNT_VEHICLE:String = "#menu:shop/table/header/count/vehicle";

      public static const SHOP_TABLE_HEADER_COUNT_MODULE:String = "#menu:shop/table/header/count/module";

      public static const SHOP_TABLE_HEADER_COUNT_SHELL:String = "#menu:shop/table/header/count/shell";

      public static const SHOP_TABLE_HEADER_COUNT_OPTIONALDEVICE:String = "#menu:shop/table/header/count/optionalDevice";

      public static const SHOP_TABLE_HEADER_COUNT_EQUIPMENT:String = "#menu:shop/table/header/count/equipment";

      public static const SHOP_TABLE_HEADER_PRICE:String = "#menu:shop/table/header/price";

      public static const SHOP_TABLE_BUTTONBUY:String = "#menu:shop/table/buttonBuy";

      public static const SHOP_TABLE_BUYACTIONOR:String = "#menu:shop/table/buyActionOr";

      public static const SPECPREBETLES_TITLE:String = "#menu:specPrebetles/title";

      public static const SPECPREBETLES_LISTTITLE:String = "#menu:specPrebetles/listTitle";

      public static const SPECPREBETLES_OWNERTITLE:String = "#menu:specPrebetles/ownerTitle";

      public static const SPECPREBETLES_PLAYERSTITLE:String = "#menu:specPrebetles/playersTitle";

      public static const TRAINING_TITLE:String = "#menu:training/title";

      public static const TRAINING_DESCRIPTION:String = "#menu:training/description";

      public static const TRAINING_CREATEBUTTON:String = "#menu:training/createButton";

      public static const TRAINING_JOINBUTTON:String = "#menu:training/joinButton";

      public static const TRAINING_LISTTITLE:String = "#menu:training/listTitle";

      public static const TRAINING_PLAYERSLABEL:String = "#menu:training/playersLabel";

      public static const TRAINING_ROOMSLABEL:String = "#menu:training/roomsLabel";

      public static const TRAINING_OWNERTITLE:String = "#menu:training/ownerTitle";

      public static const TRAINING_PLAYERSTITLE:String = "#menu:training/playersTitle";

      public static const TRAINING_CREATE_TITLE:String = "#menu:training/create/title";

      public static const TRAINING_CREATE_CREATEBUTTON:String = "#menu:training/create/createButton";

      public static const TRAINING_CREATE_CLOSEBUTTON:String = "#menu:training/create/closeButton";

      public static const TRAINING_CREATE_MAPSELECT:String = "#menu:training/create/mapSelect";

      public static const TRAINING_CREATE_MAXPLAYERS:String = "#menu:training/create/maxPlayers";

      public static const TRAINING_CREATE_BATTLETIME:String = "#menu:training/create/battleTime";

      public static const TRAINING_CREATE_PRIVACY:String = "#menu:training/create/privacy";

      public static const TRAINING_CREATE_DESCRIPTION:String = "#menu:training/create/description";

      public static const TRAINING_INFO_TITLE:String = "#menu:training/info/title";

      public static const TRAINING_INFO_STARTBUTTON:String = "#menu:training/info/startButton";

      public static const TRAINING_INFO_SETTINGSBUTTON:String = "#menu:training/info/settingsButton";

      public static const TRAINING_INFO_INVITEBUTTON:String = "#menu:training/info/inviteButton";

      public static const TRAINING_INFO_EXITBUTTON:String = "#menu:training/info/exitButton";

      public static const TRAINING_INFO_DELETEBUTTON:String = "#menu:training/info/deleteButton";

      public static const TRAINING_INFO_TEAM1LABEL:String = "#menu:training/info/team1Label";

      public static const TRAINING_INFO_TEAM2LABEL:String = "#menu:training/info/team2Label";

      public static const TRAINING_INFO_OTHERLABEL:String = "#menu:training/info/otherLabel";

      public static const TRAINING_INFO_SETTINGS_TITLE:String = "#menu:training/info/settings/title";

      public static const TRAINING_INFO_SETTINGS_OKBUTTON:String = "#menu:training/info/settings/okButton";

      public static const TRAINING_INFO_MAP:String = "#menu:training/info/map";

      public static const TRAINING_INFO_TIMEOUT_LABEL:String = "#menu:training/info/timeout/label";

      public static const TRAINING_INFO_TIMEOUT_VALUE:String = "#menu:training/info/timeout/value";

      public static const TRAINING_INFO_MAXPLAYERS:String = "#menu:training/info/maxPlayers";

      public static const TRAINING_INFO_OWNER:String = "#menu:training/info/owner";

      public static const TRAINING_INFO_VOICECHAT:String = "#menu:training/info/voiceChat";

      public static const TRAINING_INFO_STATES_STATE0:String = TRAINING_INFO_STATES_STATE + "0";

      public static const TRAINING_INFO_STATES_STATE1:String = TRAINING_INFO_STATES_STATE + "1";

      public static const TRAINING_INFO_STATES_STATE2:String = TRAINING_INFO_STATES_STATE + "2";

      public static const TRAINING_INFO_STATES_STATE4:String = TRAINING_INFO_STATES_STATE + "4";

      public static const TRAINING_INFO_STATES_STATE8:String = TRAINING_INFO_STATES_STATE + "8";

      public static const TRAINING_INFO_STATES_STATE17:String = TRAINING_INFO_STATES_STATE + "17";

      public static const TRAINING_INFO_STATES_STATE20:String = TRAINING_INFO_STATES_STATE + "20";

      public static const TRAINING_INFO_STATES_STATE24:String = TRAINING_INFO_STATES_STATE + "24";

      public static const TRAINING_INFO_USECOMMONVOICECHAT:String = "#menu:training/info/useCommonVoiceChat";

      public static const TRAINING_INFO_USESEPARATEVOIPCHAT:String = "#menu:training/info/useSeparateVoipChat";

      public static const TRAINING_INFO_NOTUSECHAT:String = "#menu:training/info/notUseChat";

      public static const TRAINING_INVITATIONS_TITLE:String = "#menu:training/invitations/title";

      public static const TANKMANRETRAININGBTN_FREE:String = "#menu:tankmanRetrainingBtn/free";

      public static const VEHICLESCAROUSEL_CONTEXTMENU_VEHICLEINFO:String = "#menu:vehiclesCarousel/contextMenu/vehicleInfo";

      public static const VEHICLESCAROUSEL_CONTEXTMENU_VEHICLESELL:String = "#menu:vehiclesCarousel/contextMenu/vehicleSell";

      public static const VEHICLESCAROUSEL_CONTEXTMENU_VEHICLERESEARCH:String = "#menu:vehiclesCarousel/contextMenu/vehicleResearch";

      public static const VEHICLESCAROUSEL_CONTEXTMENU_VEHICLECHECK:String = "#menu:vehiclesCarousel/contextMenu/vehicleCheck";

      public static const VEHICLESCAROUSEL_CONTEXTMENU_VEHICLEUNCHECK:String = "#menu:vehiclesCarousel/contextMenu/vehicleUncheck";

      public static const TANKMEN_LOCKREASON_INBATTLE:String = "#menu:tankmen/lockReason/inbattle";

      public static const TANKMEN_LOCKREASON_PREBATTLE:String = "#menu:tankmen/lockReason/prebattle";

      public static const TANKMEN_LOCKREASON_BROKEN:String = "#menu:tankmen/lockReason/broken";

      public static const HANGAR_AMMUNITIONPANEL_MAITENANCEBTN:String = "#menu:hangar/ammunitionPanel/maitenanceBtn";

      public static const HANGAR_AMMUNITIONPANEL_TUNINGBTN:String = "#menu:hangar/ammunitionPanel/tuningBtn";

      public static const HANGAR_AMMUNITIONPANEL_TECHNICALMAITENANCE_TITLE:String = "#menu:hangar/ammunitionPanel/technicalMaitenance/title";

      public static const HANGAR_AMMUNITIONPANEL_TECHNICALMAITENANCE_REPAIR_LABEL:String = "#menu:hangar/ammunitionPanel/technicalMaitenance/repair/label";

      public static const HANGAR_AMMUNITIONPANEL_TECHNICALMAITENANCE_REPAIR_CHECKBOXAUTO:String = "#menu:hangar/ammunitionPanel/technicalMaitenance/repair/checkboxAuto";

      public static const HANGAR_AMMUNITIONPANEL_TECHNICALMAITENANCE_AMMO_LABEL:String = "#menu:hangar/ammunitionPanel/technicalMaitenance/ammo/label";

      public static const HANGAR_AMMUNITIONPANEL_TECHNICALMAITENANCE_AMMO_CHECKBOXAUTO:String = "#menu:hangar/ammunitionPanel/technicalMaitenance/ammo/checkboxAuto";

      public static const HANGAR_AMMUNITIONPANEL_TECHNICALMAITENANCE_AMMO_LIST_BUY:String = "#menu:hangar/ammunitionPanel/technicalMaitenance/ammo/list/buy";

      public static const HANGAR_AMMUNITIONPANEL_TECHNICALMAITENANCE_AMMO_LIST_INVENTORY:String = "#menu:hangar/ammunitionPanel/technicalMaitenance/ammo/list/inventory";

      public static const HANGAR_AMMUNITIONPANEL_TECHNICALMAITENANCE_AMMO_LIST_PRICE:String = "#menu:hangar/ammunitionPanel/technicalMaitenance/ammo/list/price";

      public static const HANGAR_AMMUNITIONPANEL_TECHNICALMAITENANCE_EQUIPMENT_LABEL:String = "#menu:hangar/ammunitionPanel/technicalMaitenance/equipment/label";

      public static const HANGAR_AMMUNITIONPANEL_TECHNICALMAITENANCE_EQUIPMENT_CHECKBOXAUTO:String = "#menu:hangar/ammunitionPanel/technicalMaitenance/equipment/checkboxAuto";

      public static const HANGAR_AMMUNITIONPANEL_TECHNICALMAITENANCE_EQUIPMENT_LIST_INVENTORY:String = "#menu:hangar/ammunitionPanel/technicalMaitenance/equipment/list/inventory";

      public static const HANGAR_AMMUNITIONPANEL_TECHNICALMAITENANCE_EQUIPMENT_LIST_BUY:String = "#menu:hangar/ammunitionPanel/technicalMaitenance/equipment/list/buy";

      public static const HANGAR_AMMUNITIONPANEL_TECHNICALMAITENANCE_EQUIPMENT_LIST_PRICE:String = "#menu:hangar/ammunitionPanel/technicalMaitenance/equipment/list/price";

      public static const HANGAR_AMMUNITIONPANEL_TECHNICALMAITENANCE_BUTTONS_REPAIR:String = "#menu:hangar/ammunitionPanel/technicalMaitenance/buttons/repair";

      public static const HANGAR_AMMUNITIONPANEL_TECHNICALMAITENANCE_BUTTONS_AMMO:String = "#menu:hangar/ammunitionPanel/technicalMaitenance/buttons/ammo";

      public static const HANGAR_AMMUNITIONPANEL_TECHNICALMAITENANCE_BUTTONS_EQUIPMENT:String = "#menu:hangar/ammunitionPanel/technicalMaitenance/buttons/equipment";

      public static const HANGAR_AMMUNITIONPANEL_TECHNICALMAITENANCE_BUTTONS_APPLY:String = "#menu:hangar/ammunitionPanel/technicalMaitenance/buttons/apply";

      public static const HANGAR_AMMUNITIONPANEL_TECHNICALMAITENANCE_BUTTONS_CLOSE:String = "#menu:hangar/ammunitionPanel/technicalMaitenance/buttons/close";

      public static const HANGAR_AMMUNITIONPANEL_TECHNICALMAITENANCE_BUTTONS_LABELTOTAL:String = "#menu:hangar/ammunitionPanel/technicalMaitenance/buttons/labelTotal";

      public static const FITTINGLISTITEMRENDERER_UNLOAD:String = "#menu:fittingListItemRenderer/unload";

      public static const FITTINGLISTITEMRENDERER_REPLACE:String = "#menu:fittingListItemRenderer/replace";

      public static const SHELLLISTITEMRENDERER_REPLACE:String = "#menu:shellListItemRenderer/replace";

      public static const CUSTOMIZATION_TITLE:String = "#menu:customization/title";

      public static const CUSTOMIZATION_ITEMS_CAMOUFLAGE:String = "#menu:customization/items/camouflage";

      public static const CUSTOMIZATION_ITEMS_EMBLEMLEFT:String = "#menu:customization/items/emblemLeft";

      public static const CUSTOMIZATION_ITEMS_EMBLEMRIGHT:String = "#menu:customization/items/emblemRight";

      public static const CUSTOMIZATION_ITEMS_INSCRIPTIONLEFT:String = "#menu:customization/items/inscriptionLeft";

      public static const CUSTOMIZATION_ITEMS_INSCRIPTIONRIGHT:String = "#menu:customization/items/inscriptionRight";

      public static const CUSTOMIZATION_ITEMS_HORN:String = "#menu:customization/items/horn";

      public static const CUSTOMIZATION_CHANGE_CAMOUFLAGE:String = "#menu:customization/change/camouflage";

      public static const CUSTOMIZATION_CHANGE_EMBLEMLEFT:String = "#menu:customization/change/emblemLeft";

      public static const CUSTOMIZATION_CHANGE_EMBLEMRIGHT:String = "#menu:customization/change/emblemRight";

      public static const CUSTOMIZATION_CHANGE_INSCRIPTIONLEFT:String = "#menu:customization/change/inscriptionLeft";

      public static const CUSTOMIZATION_CHANGE_INSCRIPTIONRIGHT:String = "#menu:customization/change/inscriptionRight";

      public static const CUSTOMIZATION_CHANGE_HORN:String = "#menu:customization/change/horn";

      public static const CUSTOMIZATION_REMOVE_CAMOUFLAGE_SIDE_01:String = "#menu:customization/remove/camouflage/side-01";

      public static const CUSTOMIZATION_REMOVE_CAMOUFLAGE0_SIDE_01:String = "#menu:customization/remove/camouflage0/side-01";

      public static const CUSTOMIZATION_REMOVE_CAMOUFLAGE1_SIDE_01:String = "#menu:customization/remove/camouflage1/side-01";

      public static const CUSTOMIZATION_REMOVE_CAMOUFLAGE2_SIDE_01:String = "#menu:customization/remove/camouflage2/side-01";

      public static const CUSTOMIZATION_REMOVE_CAMOUFLAGE_SIDE_02:String = "#menu:customization/remove/camouflage/side-02";

      public static const CUSTOMIZATION_STORE_CAMOUFLAGE_SIDE_02:String = "#menu:customization/store/camouflage/side-02";

      public static const CUSTOMIZATION_REMOVE_EMBLEMLEFT_SIDE_01:String = "#menu:customization/remove/emblemLeft/side-01";

      public static const CUSTOMIZATION_REMOVE_EMBLEMLEFT_SIDE_02:String = "#menu:customization/remove/emblemLeft/side-02";

      public static const CUSTOMIZATION_STORE_EMBLEMLEFT_SIDE_02:String = "#menu:customization/store/emblemLeft/side-02";

      public static const CUSTOMIZATION_REMOVE_EMBLEMRIGHT_SIDE_01:String = "#menu:customization/remove/emblemRight/side-01";

      public static const CUSTOMIZATION_REMOVE_EMBLEMRIGHT_SIDE_02:String = "#menu:customization/remove/emblemRight/side-02";

      public static const CUSTOMIZATION_STORE_EMBLEMRIGHT_SIDE_02:String = "#menu:customization/store/emblemRight/side-02";

      public static const CUSTOMIZATION_REMOVE_INSCRIPTIONLEFT_SIDE_01:String = "#menu:customization/remove/inscriptionLeft/side-01";

      public static const CUSTOMIZATION_REMOVE_INSCRIPTIONLEFT_SIDE_02:String = "#menu:customization/remove/inscriptionLeft/side-02";

      public static const CUSTOMIZATION_STORE_INSCRIPTIONLEFT_SIDE_02:String = "#menu:customization/store/inscriptionLeft/side-02";

      public static const CUSTOMIZATION_REMOVE_INSCRIPTIONRIGHT_SIDE_01:String = "#menu:customization/remove/inscriptionRight/side-01";

      public static const CUSTOMIZATION_REMOVE_INSCRIPTIONRIGHT_SIDE_02:String = "#menu:customization/remove/inscriptionRight/side-02";

      public static const CUSTOMIZATION_STORE_INSCRIPTIONRIGHT_SIDE_02:String = "#menu:customization/store/inscriptionRight/side-02";

      public static const CUSTOMIZATION_REMOVE_HORN_SIDE_01:String = "#menu:customization/remove/horn/side-01";

      public static const CUSTOMIZATION_REMOVE_HORN_SIDE_02:String = "#menu:customization/remove/horn/side-02";

      public static const CUSTOMIZATION_LABELS_CAMOUFLAGE_SECTION:String = "#menu:customization/labels/camouflage/section";

      public static const CUSTOMIZATION_LABELS_CAMOUFLAGE_PRICE:String = "#menu:customization/labels/camouflage/price";

      public static const CUSTOMIZATION_LABELS_CAMOUFLAGE_CURRENT:String = "#menu:customization/labels/camouflage/current";

      public static const CUSTOMIZATION_LABELS_CAMOUFLAGE_NEW:String = "#menu:customization/labels/camouflage/new";

      public static const CUSTOMIZATION_MARKER_CAMOUFLAGE_NEW:String = "#menu:customization/marker/camouflage/new";

      public static const CUSTOMIZATION_MARKER_CAMOUFLAGE_DEFAULTHINT:String = "#menu:customization/marker/camouflage/defaultHint";

      public static const CUSTOMIZATION_MARKER_CAMOUFLAGE_WINTERHINT:String = "#menu:customization/marker/camouflage/winterHint";

      public static const CUSTOMIZATION_MARKER_CAMOUFLAGE_SUMMERHINT:String = "#menu:customization/marker/camouflage/summerHint";

      public static const CUSTOMIZATION_MARKER_CAMOUFLAGE_DESERTHINT:String = "#menu:customization/marker/camouflage/desertHint";

      public static const CUSTOMIZATION_LABELS_HORN_SECTION:String = "#menu:customization/labels/horn/section";

      public static const CUSTOMIZATION_LABELS_HORN_PRICE:String = "#menu:customization/labels/horn/price";

      public static const CUSTOMIZATION_LABELS_HORN_CURRENT:String = "#menu:customization/labels/horn/current";

      public static const CUSTOMIZATION_LABELS_HORN_NEW:String = "#menu:customization/labels/horn/new";

      public static const CUSTOMIZATION_LABELS_EMBLEMLEFT_SECTION:String = "#menu:customization/labels/emblemLeft/section";

      public static const CUSTOMIZATION_LABELS_EMBLEMLEFT_PRICE:String = "#menu:customization/labels/emblemLeft/price";

      public static const CUSTOMIZATION_LABELS_EMBLEMRIGHT_SECTION:String = "#menu:customization/labels/emblemRight/section";

      public static const CUSTOMIZATION_LABELS_EMBLEMRIGHT_PRICE:String = "#menu:customization/labels/emblemRight/price";

      public static const CUSTOMIZATION_LABELS_INSCRIPTIONLEFT_SECTION:String = "#menu:customization/labels/inscriptionLeft/section";

      public static const CUSTOMIZATION_LABELS_INSCRIPTIONLEFT_PRICE:String = "#menu:customization/labels/inscriptionLeft/price";

      public static const CUSTOMIZATION_LABELS_INSCRIPTIONRIGHT_SECTION:String = "#menu:customization/labels/inscriptionRight/section";

      public static const CUSTOMIZATION_LABELS_INSCRIPTIONRIGHT_PRICE:String = "#menu:customization/labels/inscriptionRight/price";

      public static const CUSTOMIZATION_LABELS_EMBLEM_CURRENT:String = "#menu:customization/labels/emblem/current";

      public static const CUSTOMIZATION_LABELS_EMBLEM_NEW:String = "#menu:customization/labels/emblem/new";

      public static const CUSTOMIZATION_LABELS_TOTALPRICE:String = "#menu:customization/labels/totalPrice";

      public static const CUSTOMIZATION_LABELS_CAMOUFLAGE_PERIOD:String = "#menu:customization/labels/camouflage/period";

      public static const CUSTOMIZATION_LABELS_EMBLEM_PERIOD:String = "#menu:customization/labels/emblem/period";

      public static const CUSTOMIZATION_LABELS_INSCRIPTION_PERIOD:String = "#menu:customization/labels/inscription/period";

      public static const CUSTOMIZATION_LABELS_TIMELEFT_DAYS:String = "#menu:customization/labels/timeLeft/days";

      public static const CUSTOMIZATION_LABELS_TIMELEFT_HOURS:String = "#menu:customization/labels/timeLeft/hours";

      public static const CUSTOMIZATION_LABELS_TIMELEFT_TITLE:String = "#menu:customization/labels/timeLeft/title";

      public static const CUSTOMIZATION_LABELS_CAMOUFLAGE_TIMELEFT_DAYS:String = "#menu:customization/labels/camouflage/timeLeft/days";

      public static const CUSTOMIZATION_LABELS_CAMOUFLAGE_TIMELEFT_HOURS:String = "#menu:customization/labels/camouflage/timeLeft/hours";

      public static const CUSTOMIZATION_BUTTONS_APPLY:String = "#menu:customization/buttons/apply";

      public static const CUSTOMIZATION_BUTTONS_CLOSE:String = "#menu:customization/buttons/close";

      public static const CUSTOMIZATION_PERIOD_INFINITY:String = "#menu:customization/period/infinity";

      public static const CUSTOMIZATION_PERIOD_DAY:String = "#menu:customization/period/day";

      public static const CUSTOMIZATION_PERIOD_DAYS:String = "#menu:customization/period/days";

      public static const CUSTOMIZATION_PERIOD_IGR:String = "#menu:customization/period/igr";

      public static const CUSTOMIZATION_GROUP_IGR:String = "#menu:customization/group/igr";

      public static const SCREENSHOT_SAVE:String = "#menu:screenshot/save";

      public static const TECHNICALMAINTENANCE_AMMOTITLEEX:String = "#menu:technicalMaintenance/ammoTitleEx";

      public static const CONTEXTMENU_VEHICLEINFO:String = "#menu:contextMenu/vehicleInfo";

      public static const CONTEXTMENU_VEHICLEINFOEX:String = "#menu:contextMenu/vehicleInfoEx";

      public static const CONTEXTMENU_GOTONATIONTREE:String = "#menu:contextMenu/goToNationTree";

      public static const CONTEXTMENU_GOTONEXTVEHICLE:String = "#menu:contextMenu/goToNextVehicle";

      public static const CONTEXTMENU_VEHICLESELL:String = "#menu:contextMenu/vehicleSell";

      public static const CONTEXTMENU_VEHICLERESEARCH:String = "#menu:contextMenu/vehicleResearch";

      public static const CONTEXTMENU_VEHICLECHECK:String = "#menu:contextMenu/vehicleCheck";

      public static const CONTEXTMENU_VEHICLEUNCHECK:String = "#menu:contextMenu/vehicleUncheck";

      public static const CONTEXTMENU_USERINFO:String = "#menu:contextMenu/userInfo";

      public static const CONTEXTMENU_MONEYTRANSFER:String = "#menu:contextMenu/moneyTransfer";

      public static const CONTEXTMENU_CREATEPRIVATECHANNEL:String = "#menu:contextMenu/createPrivateChannel";

      public static const CONTEXTMENU_ADDTOFRIENDS:String = "#menu:contextMenu/addToFriends";

      public static const CONTEXTMENU_REMOVEFROMFRIENDS:String = "#menu:contextMenu/removeFromFriends";

      public static const CONTEXTMENU_ADDTOIGNORED:String = "#menu:contextMenu/addToIgnored";

      public static const CONTEXTMENU_REMOVEFROMIGNORED:String = "#menu:contextMenu/removeFromIgnored";

      public static const CONTEXTMENU_COPYTOCLIPBOARD:String = "#menu:contextMenu/copyToClipBoard";

      public static const CONTEXTMENU_SETMUTED:String = "#menu:contextMenu/setMuted";

      public static const CONTEXTMENU_UNSETMUTED:String = "#menu:contextMenu/unsetMuted";

      public static const CONTEXTMENU_MODULEINFO:String = "#menu:contextMenu/moduleInfo";

      public static const CONTEXTMENU_SELL:String = "#menu:contextMenu/sell";

      public static const CONTEXTMENU_SELLFROMINVENTORY:String = "#menu:contextMenu/sellFromInventory";

      public static const CONTEXTMENU_SELECTVEHICLEINHANGAR:String = "#menu:contextMenu/selectVehicleInHangar";

      public static const CONTEXTMENU_SHOWVEHICLESTATISTICS:String = "#menu:contextMenu/showVehicleStatistics";

      public static const CONTEXTMENU_BUY:String = "#menu:contextMenu/buy";

      public static const CONTEXTMENU_UNLOAD:String = "#menu:contextMenu/unload";

      public static const CONTEXTMENU_CANCELBUY:String = "#menu:contextMenu/cancelBuy";

      public static const CONTEXTMENU_BUYANDEQUIP:String = "#menu:contextMenu/buyAndEquip";

      public static const CONTEXTMENU_EQUIP:String = "#menu:contextMenu/equip";

      public static const CONTEXTMENU_UNLOCK:String = "#menu:contextMenu/unlock";

      public static const CONTEXTMENU_KICKPLAYER:String = "#menu:contextMenu/kickPlayer";

      public static const CONTEXTMENU_APPEAL:String = "#menu:contextMenu/appeal";

      public static const CONTEXTMENU_OFFEND:String = "#menu:contextMenu/offend";

      public static const CONTEXTMENU_FLOOD:String = "#menu:contextMenu/flood";

      public static const CONTEXTMENU_OPENINGOFALLYPOS:String = "#menu:contextMenu/openingOfAllyPos";

      public static const CONTEXTMENU_ALLYEJECTION:String = "#menu:contextMenu/allyEjection";

      public static const CONTEXTMENU_NOTFAIRPLAY:String = "#menu:contextMenu/notFairPlay";

      public static const CONTEXTMENU_TEAMKILL:String = "#menu:contextMenu/teamKill";

      public static const CONTEXTMENU_BOT:String = "#menu:contextMenu/bot";

      public static const CONTEXTMENU_PERSONALCASE:String = "#menu:contextMenu/personalCase";

      public static const CONTEXTMENU_TANKMANUNLOAD:String = "#menu:contextMenu/tankmanUnload";

      public static const CONTEXTMENU_TANKMANUNLOADALL:String = "#menu:contextMenu/tankmanUnloadAll";

      public static const CONTEXTMENU_DISMISS:String = "#menu:contextMenu/dismiss";

      public static const CONTEXTMENU_LOCKSLOT:String = "#menu:contextMenu/lockSlot";

      public static const CONTEXTMENU_UNLOCKSLOT:String = "#menu:contextMenu/unlockSlot";

      public static const DENUNCIATION_0:String = "#menu:denunciation/0";

      public static const DENUNCIATION_1:String = "#menu:denunciation/1";

      public static const DENUNCIATION_2:String = "#menu:denunciation/2";

      public static const DENUNCIATION_3:String = "#menu:denunciation/3";

      public static const DENUNCIATION_4:String = "#menu:denunciation/4";

      public static const DENUNCIATION_5:String = "#menu:denunciation/5";

      public static const DENUNCIATION_6:String = "#menu:denunciation/6";

      public static const STEAM_TITLE:String = "#menu:steam/title";

      public static const STEAM_GOLDPACKETSELECT:String = "#menu:steam/goldPacketSelect";

      public static const STEAM_OTHERMETHODS:String = "#menu:steam/otherMethods";

      public static const STEAM_SUBMIT:String = "#menu:steam/submit";

      public static const STEAM_CANCEL:String = "#menu:steam/cancel";

      public static const SKILLDROPWINDOW_TITLE:String = "#menu:skillDropWindow/title";

      public static const SKILLDROPWINDOW_BEFORE:String = "#menu:skillDropWindow/before";

      public static const SKILLDROPWINDOW_MULTIPLIER:String = "#menu:skillDropWindow/multiplier";

      public static const SKILLDROPWINDOW_AFTER:String = "#menu:skillDropWindow/after";

      public static const SKILLDROPWINDOW_STUDY_GOLDLABEL:String = "#menu:skillDropWindow/study/goldLabel";

      public static const SKILLDROPWINDOW_STUDY_CREDITSLABEL:String = "#menu:skillDropWindow/study/creditsLabel";

      public static const SKILLDROPWINDOW_STUDY_FREELABEL:String = "#menu:skillDropWindow/study/freeLabel";

      public static const SKILLDROPWINDOW_APPLYBTN:String = "#menu:skillDropWindow/applyBtn";

      public static const SKILLDROPWINDOW_CANCELBTN:String = "#menu:skillDropWindow/cancelBtn";

      public static const CENTERISAVAILABLE:String = "#menu:centerIsAvailable";

      public static const CENTERISUNAVAILABLE:String = "#menu:centerIsUnAvailable";

      public static const ACCOUNT_PROFILE_EMPTYBATTLELIST:String = "#menu:account/profile/emptyBattleList";

      public static const FINALSTATISTIC_WINDOW_TITLE:String = "#menu:finalStatistic/window/title";

      public static const FINALSTATISTIC_TABS_COMMONSTATS:String = "#menu:finalStatistic/tabs/commonStats";

      public static const FINALSTATISTIC_TABS_TEAMSTATS:String = "#menu:finalStatistic/tabs/teamStats";

      public static const FINALSTATISTIC_TABS_DETAILSSTATS:String = "#menu:finalStatistic/tabs/detailsStats";

      public static const FINALSTATISTIC_COMMONSTATS_RESULTLABEL_WIN:String = "#menu:finalStatistic/commonStats/resultlabel/win";

      public static const FINALSTATISTIC_COMMONSTATS_RESULTLABEL_LOSE:String = "#menu:finalStatistic/commonStats/resultlabel/lose";

      public static const FINALSTATISTIC_COMMONSTATS_RESULTLABEL_TIE:String = "#menu:finalStatistic/commonStats/resultlabel/tie";

      public static const BROWSER_WINDOW_TITLE:String = "#menu:browser/window/title";

      public static const CLASSES_LIGHTTANK:String = "#menu:classes/lightTank";

      public static const CLASSES_MEDIUMTANK:String = "#menu:classes/mediumTank";

      public static const CLASSES_HEAVYTANK:String = "#menu:classes/heavyTank";

      public static const CLASSES_SPG:String = "#menu:classes/SPG";

      public static const CLASSES_AT_SPG:String = "#menu:classes/AT-SPG";

      public static const CLASSES_ANYTYPE:String = "#menu:classes/anyType";

      public static const OPPONENTS:String = "#menu:opponents";

      public static const DEMONSTRATOR_WINDOW_TITLE:String = "#menu:demonstrator/window/title";

      public static const DEMONSTRATOR_WINDOW_INFO:String = "#menu:demonstrator/window/info";

      public static const IGR_INFO:String = "#menu:igr/info";

      public static const BONUSTYPE_0:String = "#menu:bonusType/0";

      public static const BONUSTYPE_1:String = "#menu:bonusType/1";

      public static const BONUSTYPE_2:String = "#menu:bonusType/2";

      public static const BONUSTYPE_3:String = "#menu:bonusType/3";

      public static const BONUSTYPE_4:String = "#menu:bonusType/4";

      public static const BONUSTYPE_5:String = "#menu:bonusType/5";

      public static const BONUSTYPE_6:String = "#menu:bonusType/6";

      public static const BONUSTYPE_7:String = "#menu:bonusType/7";

      public static const DAY_1:String = "#menu:day/1";

      public static const DAY_2:String = "#menu:day/2";

      public static const DAY_3:String = "#menu:day/3";

      public static const DAY_4:String = "#menu:day/4";

      public static const DAY_5:String = "#menu:day/5";

      public static const DAY_6:String = "#menu:day/6";

      public static const DAY_7:String = "#menu:day/7";

      public static const NATION_TREE_TITLE_ENUM:Array = [NATION_TREE_TITLE_USSR,NATION_TREE_TITLE_GERMANY,NATION_TREE_TITLE_USA,NATION_TREE_TITLE_FRANCE,NATION_TREE_TITLE_UK,NATION_TREE_TITLE_CHINA,NATION_TREE_TITLE_JAPAN];

      public static const TANKMANPERSONALCASE_MODIFIERS_ENUM:Array = [TANKMANPERSONALCASE_MODIFIERS_FROMCOMMANDER,TANKMANPERSONALCASE_MODIFIERS_FROMEQUIPMENT,TANKMANPERSONALCASE_MODIFIERS_FROMSKILLS,TANKMANPERSONALCASE_MODIFIERS_PENALTY,TANKMANPERSONALCASE_MODIFIERSHEADER,TANKMANPERSONALCASE_MODIFIERSRESULT];

      public static const TANKMANTRAININGWINDOW_ENUM:Array = [TANKMANTRAININGWINDOW_TITLE,TANKMANTRAININGWINDOW_ACADEMY,TANKMANTRAININGWINDOW_SCOOL,TANKMANTRAININGWINDOW_FREE,TANKMANTRAININGWINDOW_TRAININGTO,TANKMANTRAININGWINDOW_CLOSEBTN];

      public static const SHOP_MENU_ENUM:Array = [SHOP_MENU_VEHICLE_NAME,SHOP_MENU_VEHICLE_TAGS_NAME,SHOP_MENU_VEHICLE_TAGS_ALL_NAME,SHOP_MENU_VEHICLE_TAGS_LIGHTTANK_NAME,SHOP_MENU_VEHICLE_TAGS_MEDIUMTANK_NAME,SHOP_MENU_VEHICLE_TAGS_HEAVYTANK_NAME,SHOP_MENU_VEHICLE_TAGS_AT_SPG_NAME,SHOP_MENU_VEHICLE_TAGS_SPG_NAME,SHOP_MENU_VEHICLE_EXTRA_NAME,SHOP_MENU_VEHICLE_EXTRA_LOCKED_NAME,SHOP_MENU_VEHICLE_EXTRA_INHANGAR_NAME,SHOP_MENU_MODULE_NAME,SHOP_MENU_MODULE_TYPES_NAME,SHOP_MENU_MODULE_TYPES_VEHICLECHASSIS_NAME,SHOP_MENU_MODULE_TYPES_VEHICLETURRET_NAME,SHOP_MENU_MODULE_TYPES_VEHICLEGUN_NAME,SHOP_MENU_MODULE_TYPES_VEHICLEENGINE_NAME,SHOP_MENU_MODULE_TYPES_VEHICLERADIO_NAME,SHOP_MENU_MODULE_FITS_NAME,SHOP_MENU_MODULE_FITS_MYVEHICLE_NAME,SHOP_MENU_MODULE_FITS_MYVEHICLES_NAME,SHOP_MENU_MODULE_FITS_OTHERVEHICLES_NAME,SHOP_MENU_MODULE_EXTRA_NAME,SHOP_MENU_MODULE_EXTRA_LOCKED_NAME,SHOP_MENU_MODULE_EXTRA_ONVEHICLE_NAME,SHOP_MENU_MODULE_EXTRA_INHANGAR_NAME,SHOP_MENU_SHELL_NAME,SHOP_MENU_SHELL_KINDS_NAME,SHOP_MENU_SHELL_KINDS_ARMOR_PIERCING_NAME,SHOP_MENU_SHELL_KINDS_ARMOR_PIERCING_CR_NAME,SHOP_MENU_SHELL_KINDS_ARMOR_PIERCING_HE_NAME,SHOP_MENU_SHELL_KINDS_HOLLOW_CHARGE_NAME,SHOP_MENU_SHELL_KINDS_HIGH_EXPLOSIVE_NAME,SHOP_MENU_SHELL_FITS_NAME,SHOP_MENU_SHELL_FITS_MYVEHICLEGUN_NAME,SHOP_MENU_SHELL_FITS_MYINVENTORYGUNS_NAME,SHOP_MENU_SHELL_FITS_MYVEHICLESINVENTORYGUNS_NAME,SHOP_MENU_SHELL_FITS_OTHERGUNS_NAME,SHOP_MENU_OPTIONALDEVICE_NAME,SHOP_MENU_OPTIONALDEVICE_FITS_NAME,SHOP_MENU_OPTIONALDEVICE_FITS_MYVEHICLE_NAME,SHOP_MENU_OPTIONALDEVICE_FITS_MYVEHICLES_NAME,SHOP_MENU_OPTIONALDEVICE_FITS_OTHERVEHICLES_NAME,SHOP_MENU_OPTIONALDEVICE_EXTRA_NAME,SHOP_MENU_OPTIONALDEVICE_EXTRA_ONVEHICLE_NAME,SHOP_MENU_EQUIPMENT_NAME,SHOP_MENU_EQUIPMENT_FITS_NAME,SHOP_MENU_EQUIPMENT_FITS_MYVEHICLE_NAME,SHOP_MENU_EQUIPMENT_FITS_MYVEHICLES_NAME,SHOP_MENU_EQUIPMENT_FITS_OTHERVEHICLES_NAME];

      public static const MODULEINFO_PARAMS_ENUM:Array = [MODULEINFO_PARAMS_MAXLOAD,MODULEINFO_PARAMS_ENGINEPOWER,MODULEINFO_PARAMS_CALIBER,MODULEINFO_PARAMS_SHELLSCOUNT,MODULEINFO_PARAMS_SHELLRELOADINGTIME,MODULEINFO_PARAMS_RELOADMAGAZINETIME,MODULEINFO_PARAMS_RELOADTIME,MODULEINFO_PARAMS_PIERCINGPOWER,MODULEINFO_PARAMS_DAMAGE,MODULEINFO_PARAMS_AVGPIERCINGPOWER,MODULEINFO_PARAMS_AVGDAMAGE,MODULEINFO_PARAMS_ARMOR,MODULEINFO_PARAMS_ROTATIONSPEED,MODULEINFO_PARAMS_DISPERTIONRADIUS,MODULEINFO_PARAMS_AIMINGTIME,MODULEINFO_PARAMS_FIRESTARTINGCHANCE,MODULEINFO_PARAMS_RADIODISTANCE,MODULEINFO_PARAMS_CIRCULARVISIONRADIUS,MODULEINFO_PARAMS_WEIGHT,MODULEINFO_PARAMS_EXPLOSIONRADIUS];

      public static const SKILLDROPWINDOW_STUDY_ENUM:Array = [SKILLDROPWINDOW_STUDY_GOLDLABEL,SKILLDROPWINDOW_STUDY_CREDITSLABEL,SKILLDROPWINDOW_STUDY_FREELABEL];

      public static const INVENTORY_MENU_ENUM:Array = [INVENTORY_MENU_VEHICLE_NAME,INVENTORY_MENU_VEHICLE_TAGS_NAME,INVENTORY_MENU_VEHICLE_TAGS_ALL_NAME,INVENTORY_MENU_VEHICLE_TAGS_LIGHTTANK_NAME,INVENTORY_MENU_VEHICLE_TAGS_MEDIUMTANK_NAME,INVENTORY_MENU_VEHICLE_TAGS_HEAVYTANK_NAME,INVENTORY_MENU_VEHICLE_TAGS_AT_SPG_NAME,INVENTORY_MENU_VEHICLE_TAGS_SPG_NAME,INVENTORY_MENU_VEHICLE_EXTRA_NAME,INVENTORY_MENU_VEHICLE_EXTRA_BROCKEN_NAME,INVENTORY_MENU_VEHICLE_EXTRA_LOCKED_NAME,INVENTORY_MENU_MODULE_NAME,INVENTORY_MENU_MODULE_TYPES_NAME,INVENTORY_MENU_MODULE_TYPES_VEHICLECHASSIS_NAME,INVENTORY_MENU_MODULE_TYPES_VEHICLETURRET_NAME,INVENTORY_MENU_MODULE_TYPES_VEHICLEGUN_NAME,INVENTORY_MENU_MODULE_TYPES_VEHICLEENGINE_NAME,INVENTORY_MENU_MODULE_TYPES_VEHICLERADIO_NAME,INVENTORY_MENU_MODULE_FITS_NAME,INVENTORY_MENU_MODULE_FITS_MYVEHICLE_NAME,INVENTORY_MENU_MODULE_FITS_MYVEHICLES_NAME,INVENTORY_MENU_MODULE_FITS_OTHERVEHICLES_NAME,INVENTORY_MENU_MODULE_EXTRA_NAME,INVENTORY_MENU_MODULE_EXTRA_ONVEHICLE_NAME,INVENTORY_MENU_SHELL_NAME,INVENTORY_MENU_SHELL_KINDS_NAME,INVENTORY_MENU_SHELL_KINDS_ARMOR_PIERCING_NAME,INVENTORY_MENU_SHELL_KINDS_ARMOR_PIERCING_CR_NAME,INVENTORY_MENU_SHELL_KINDS_ARMOR_PIERCING_HE_NAME,INVENTORY_MENU_SHELL_KINDS_HOLLOW_CHARGE_NAME,INVENTORY_MENU_SHELL_KINDS_HIGH_EXPLOSIVE_NAME,INVENTORY_MENU_SHELL_FITS_NAME,INVENTORY_MENU_SHELL_FITS_MYVEHICLEGUN_NAME,INVENTORY_MENU_SHELL_FITS_MYINVENTORYGUNS_NAME,INVENTORY_MENU_SHELL_FITS_MYVEHICLESINVENTORYGUNS_NAME,INVENTORY_MENU_SHELL_FITS_OTHERGUNS_NAME,INVENTORY_MENU_OPTIONALDEVICE_NAME,INVENTORY_MENU_OPTIONALDEVICE_FITS_NAME,INVENTORY_MENU_OPTIONALDEVICE_FITS_MYVEHICLE_NAME,INVENTORY_MENU_OPTIONALDEVICE_FITS_MYVEHICLES_NAME,INVENTORY_MENU_OPTIONALDEVICE_FITS_OTHERVEHICLES_NAME,INVENTORY_MENU_OPTIONALDEVICE_EXTRA_NAME,INVENTORY_MENU_OPTIONALDEVICE_EXTRA_ONVEHICLE_NAME,INVENTORY_MENU_EQUIPMENT_NAME,INVENTORY_MENU_EQUIPMENT_FITS_NAME,INVENTORY_MENU_EQUIPMENT_FITS_MYVEHICLE_NAME,INVENTORY_MENU_EQUIPMENT_FITS_MYVEHICLES_NAME,INVENTORY_MENU_EQUIPMENT_FITS_OTHERVEHICLES_NAME];

      public static const TANK_PARAMS_ENUM:Array = [TANK_PARAMS_MAXHEALTH,TANK_PARAMS_WEIGHT,TANK_PARAMS_ENGINEPOWER,TANK_PARAMS_ENGINEPOWERPERTON,TANK_PARAMS_SPEEDLIMITS,TANK_PARAMS_CHASSISROTATIONSPEED,TANK_PARAMS_HULLARMOR,TANK_PARAMS_TURRETARMOR,TANK_PARAMS_RELOADTIME,TANK_PARAMS_RELOADTIMESECS,TANK_PARAMS_PIERCINGPOWER,TANK_PARAMS_DAMAGE,TANK_PARAMS_DAMAGEAVG,TANK_PARAMS_DAMAGEAVGPERMINUTE,TANK_PARAMS_TURRETROTATIONSPEED,TANK_PARAMS_GUNROTATIONSPEED,TANK_PARAMS_CIRCULARVISIONRADIUS,TANK_PARAMS_RADIODISTANCE,TANK_PARAMS_PARAM12,TANK_PARAMS_SHOTDISPERSIONANGLE,TANK_PARAMS_AIMINGTIME,TANK_PARAMS_MAXAMMO,TANK_PARAMS_VALUES_PARAM12_VALUE0,TANK_PARAMS_VALUES_PARAM12_VALUE1,TANK_PARAMS_VALUES_PARAM12_VALUE2,TANK_PARAMS_VALUES_PARAM12_VALUE3,TANK_PARAMS_VALUES_PARAM10_VALUE0,TANK_PARAMS_VALUES_PARAM10_VALUE1,TANK_PARAMS_VALUES_PARAM10_VALUE2,TANK_PARAMS_VALUES_PARAM10_VALUE3,TANK_PARAMS_VALUES_PARAM11_VALUE0,TANK_PARAMS_VALUES_PARAM11_VALUE1,TANK_PARAMS_VALUES_PARAM11_VALUE2,TANK_PARAMS_VALUES_PARAM11_VALUE3,TANK_PARAMS_EXPLOSIONRADIUS];

      public static const LOADING_BATTLETYPES_ENUM:Array = [LOADING_BATTLETYPES_0,LOADING_BATTLETYPES_1,LOADING_BATTLETYPES_2,LOADING_BATTLETYPES_3,LOADING_BATTLETYPES_4,LOADING_BATTLETYPES_5];

      public static const TANKCAROUSEL_VEHICLESTATES_ENUM:Array = [TANKCAROUSEL_VEHICLESTATES_BATTLE,TANKCAROUSEL_VEHICLESTATES_LOCKED,TANKCAROUSEL_VEHICLESTATES_CLANLOCKED,TANKCAROUSEL_VEHICLESTATES_INPREBATTLE,TANKCAROUSEL_VEHICLESTATES_AMMONOTFULL,TANKCAROUSEL_VEHICLESTATES_DAMAGED,TANKCAROUSEL_VEHICLESTATES_DESTROYED,TANKCAROUSEL_VEHICLESTATES_EXPLODED,TANKCAROUSEL_VEHICLESTATES_NOTPRESENT,TANKCAROUSEL_VEHICLESTATES_UNDAMAGED,TANKCAROUSEL_VEHICLESTATES_SERVERRESTRICTION,TANKCAROUSEL_VEHICLESTATES_CREWNOTFULL,TANKCAROUSEL_VEHICLESTATES_BUYTANK,TANKCAROUSEL_VEHICLESTATES_BUYTANKEMPTYCOUNT,TANKCAROUSEL_VEHICLESTATES_BUYSLOT];

      public static const SHOP_TABLE_HEADER_COUNT_ENUM:Array = [SHOP_TABLE_HEADER_COUNT_VEHICLE,SHOP_TABLE_HEADER_COUNT_MODULE,SHOP_TABLE_HEADER_COUNT_SHELL,SHOP_TABLE_HEADER_COUNT_OPTIONALDEVICE,SHOP_TABLE_HEADER_COUNT_EQUIPMENT];

      public static const TANKMEN_ENUM:Array = [TANKMEN_LIGHTTANK,TANKMEN_MEDIUMTANK,TANKMEN_HEAVYTANK,TANKMEN_AT_SPG,TANKMEN_SPG,TANKMEN_LOCKREASON_INBATTLE,TANKMEN_LOCKREASON_PREBATTLE,TANKMEN_LOCKREASON_BROKEN];

      public static const DENUNCIATION_ENUM:Array = [DENUNCIATION_0,DENUNCIATION_1,DENUNCIATION_2,DENUNCIATION_3,DENUNCIATION_4,DENUNCIATION_5,DENUNCIATION_6];

      public static const VEHICLEINFO_PARAMS_ENUM:Array = [VEHICLEINFO_PARAMS_MAXHEALTH,VEHICLEINFO_PARAMS_WEIGHT,VEHICLEINFO_PARAMS_ENGINEPOWER,VEHICLEINFO_PARAMS_SPEEDLIMITS,VEHICLEINFO_PARAMS_CHASSISROTATIONSPEED,VEHICLEINFO_PARAMS_HULLARMOR,VEHICLEINFO_PARAMS_TURRETARMOR,VEHICLEINFO_PARAMS_RELOADTIME,VEHICLEINFO_PARAMS_PIERCINGPOWER,VEHICLEINFO_PARAMS_DAMAGE,VEHICLEINFO_PARAMS_TURRETROTATIONSPEED,VEHICLEINFO_PARAMS_GUNROTATIONSPEED,VEHICLEINFO_PARAMS_CIRCULARVISIONRADIUS,VEHICLEINFO_PARAMS_RADIODISTANCE];

      public static const LOADING_BATTLETYPES_DESC_ENUM:Array = [LOADING_BATTLETYPES_DESC_0,LOADING_BATTLETYPES_DESC_1,LOADING_BATTLETYPES_DESC_2,LOADING_BATTLETYPES_DESC_3,LOADING_BATTLETYPES_DESC_4,LOADING_BATTLETYPES_DESC_5];

      public static const PROFILE_STATS_BLOCKS_ENUM:Array = [PROFILE_STATS_BLOCKS_COMMON,PROFILE_STATS_BLOCKS_BATTLEEFFECT,PROFILE_STATS_BLOCKS_CREDITS,PROFILE_STATS_BLOCKS_STUDYING];

      public static const PROFILE_STATS_ITEMS_ENUM:Array = [PROFILE_STATS_ITEMS_READYTOLEARN,PROFILE_STATS_ITEMS_NEXTSKILLXPLEFT,PROFILE_STATS_ITEMS_NEXTSKILLBATTLESLEFT,PROFILE_STATS_ITEMS_XP,PROFILE_STATS_ITEMS_FRAGS,PROFILE_STATS_ITEMS_UNKNOWN,PROFILE_STATS_ITEMS_READY,PROFILE_STATS_ITEMS_FRAGSBEAST,PROFILE_STATS_ITEMS_AVGEXPERIENCE,PROFILE_STATS_ITEMS_MAXXP,PROFILE_STATS_ITEMS_MAXFRAGS,PROFILE_STATS_ITEMS_BATTLESCOUNT,PROFILE_STATS_ITEMS_WINS,PROFILE_STATS_ITEMS_LOSSES,PROFILE_STATS_ITEMS_SURVIVEDBATTLES,PROFILE_STATS_ITEMS_LASTBATTLETIME,PROFILE_STATS_ITEMS_EFFECTIVESHOTS,PROFILE_STATS_ITEMS_DAMAGEDEALT,PROFILE_STATS_ITEMS_HEROES,PROFILE_STATS_ITEMS_WARRIOR,PROFILE_STATS_ITEMS_INVADER,PROFILE_STATS_ITEMS_SNIPER,PROFILE_STATS_ITEMS_DEFENDER,PROFILE_STATS_ITEMS_STEELWALL,PROFILE_STATS_ITEMS_SUPPORTER,PROFILE_STATS_ITEMS_SCOUT,PROFILE_STATS_ITEMS_MEDALKAY];

      public static const LOGIN_STATUS_ENUM:Array = [LOGIN_STATUS_EMPTY_LOGIN,LOGIN_STATUS_INVALID_LOGIN_LENGTH,LOGIN_STATUS_INVALID_NICKNAME,LOGIN_STATUS_INVALID_LOGIN,LOGIN_STATUS_EMPTY_PASSWORD,LOGIN_STATUS_INVALID_PASSWORD,LOGIN_STATUS_EMPTY_SERVER,LOGIN_STATUS_CONNECTING,LOGIN_STATUS_DISCONNECTED,LOGIN_STATUS_UNAVAILABLE,LOGIN_STATUS_LOGIN_REJECTED_ALREADY_LOGGED_IN,LOGIN_STATUS_CONNECTION_FAILED,LOGIN_STATUS_DNS_LOOKUP_FAILED,LOGIN_STATUS_UNKNOWN_ERROR,LOGIN_STATUS_CANCELLED,LOGIN_STATUS_LOGIN_REJECTED_NO_SUCH_USER,LOGIN_STATUS_LOGIN_REJECTED_ACTIVATING,LOGIN_STATUS_LOGIN_REJECTED_INVALID_PASSWORD,LOGIN_STATUS_LOGIN_REJECTED_NO_BASEAPP_RESPONSE,LOGIN_STATUS_LOGIN_REJECTED_ILLEGAL_CHARACTERS,LOGIN_STATUS_LOGIN_BAD_PROTOCOL_VERSION,LOGIN_STATUS_LOGIN_REJECTED_BAD_DIGEST,LOGIN_STATUS_LOGIN_REJECTED_SERVER_NOT_READY,LOGIN_STATUS_LOGIN_REJECTED_BASEAPP_OVERLOAD,LOGIN_STATUS_LOGIN_REJECTED_CELLAPP_OVERLOAD,LOGIN_STATUS_LOGIN_REJECTED_DBMGR_OVERLOAD,LOGIN_STATUS_LOGIN_REJECTED_LOGINS_NOT_ALLOWED,LOGIN_STATUS_LOGIN_REJECTED_REGISTRATION_NOT_CONFIRMED,LOGIN_STATUS_LOGIN_REJECTED_RATE_LIMITED,LOGIN_STATUS_LOGIN_REJECTED_USERS_LIMIT,LOGIN_STATUS_LOGIN_REJECTED_DB_GENERAL_FAILURE,LOGIN_STATUS_LOGIN_REJECTED_DB_NOT_READY,LOGIN_STATUS_LOGIN_REJECTED_NO_BASEAPPS,LOGIN_STATUS_LOGIN_REJECTED_NO_LOGINAPP_RESPONSE,LOGIN_STATUS_LOGIN_REJECTED_BASEAPP_TIMEOUT,LOGIN_STATUS_LOGIN_REJECTED_BASEAPPMGR_TIMEOUT,LOGIN_STATUS_LOGIN_MALFORMED_REQUEST,LOGIN_STATUS_PUBLIC_KEY_LOOKUP_FAILED,LOGIN_STATUS_ALREADY_ONLINE_LOCALLY,LOGIN_STATUS_LOGIN_REJECTED_BAN,LOGIN_STATUS_LOGIN_REJECTED_BAN_UNLIMITED,LOGIN_STATUS_LOGIN_CUSTOM_DEFINED_ERROR,LOGIN_STATUS_LOGIN_REJECTED_LOGIN_QUEUE,LOGIN_STATUS_LOGIN_REJECTED_NICKNAME_ALREADY_EXIST,LOGIN_STATUS_LOGIN_REJECTED_UNABLE_TO_PARSE_JSON,LOGIN_STATUS_LOGIN_REJECTED_REGISTRATION_NOT_ALLOWED,LOGIN_STATUS_LOGIN_REJECTED_INACCESSIBLE_REALM,LOGIN_STATUS_LAUNCHERNOTFOUND,LOGIN_STATUS_SESSION_END,LOGIN_STATUS_ACCOUNTNOTREADY,LOGIN_STATUS_VERSIONMISMATCH,LOGIN_STATUS_CENTERRESTART,LOGIN_STATUS_CLIENT_SERVER_VERSIONS_ARE_DIFFERENT];

      public static const TRAINING_INFO_ENUM:Array = [TRAINING_INFO_TITLE,TRAINING_INFO_STARTBUTTON,TRAINING_INFO_SETTINGSBUTTON,TRAINING_INFO_INVITEBUTTON,TRAINING_INFO_EXITBUTTON,TRAINING_INFO_DELETEBUTTON,TRAINING_INFO_TEAM1LABEL,TRAINING_INFO_TEAM2LABEL,TRAINING_INFO_OTHERLABEL,TRAINING_INFO_SETTINGS_TITLE,TRAINING_INFO_SETTINGS_OKBUTTON,TRAINING_INFO_MAP,TRAINING_INFO_TIMEOUT_LABEL,TRAINING_INFO_TIMEOUT_VALUE,TRAINING_INFO_MAXPLAYERS,TRAINING_INFO_OWNER,TRAINING_INFO_VOICECHAT,TRAINING_INFO_STATES_STATE0,TRAINING_INFO_STATES_STATE1,TRAINING_INFO_STATES_STATE2,TRAINING_INFO_STATES_STATE4,TRAINING_INFO_STATES_STATE8,TRAINING_INFO_STATES_STATE17,TRAINING_INFO_STATES_STATE20,TRAINING_INFO_STATES_STATE24,TRAINING_INFO_USECOMMONVOICECHAT,TRAINING_INFO_USESEPARATEVOIPCHAT,TRAINING_INFO_NOTUSECHAT];

      public static const PREMIUM_PERIODS_ENUM:Array = [PREMIUM_PERIODS_DAYS1,PREMIUM_PERIODS_DAYS3,PREMIUM_PERIODS_DAYS7,PREMIUM_PERIODS_DAYS30,PREMIUM_PERIODS_DAYS180,PREMIUM_PERIODS_DAYS360];

      public static const CONTEXTMENU_ENUM:Array = [CONTEXTMENU_VEHICLEINFO,CONTEXTMENU_VEHICLEINFOEX,CONTEXTMENU_GOTONATIONTREE,CONTEXTMENU_GOTONEXTVEHICLE,CONTEXTMENU_VEHICLESELL,CONTEXTMENU_VEHICLERESEARCH,CONTEXTMENU_VEHICLECHECK,CONTEXTMENU_VEHICLEUNCHECK,CONTEXTMENU_USERINFO,CONTEXTMENU_MONEYTRANSFER,CONTEXTMENU_CREATEPRIVATECHANNEL,CONTEXTMENU_ADDTOFRIENDS,CONTEXTMENU_REMOVEFROMFRIENDS,CONTEXTMENU_ADDTOIGNORED,CONTEXTMENU_REMOVEFROMIGNORED,CONTEXTMENU_COPYTOCLIPBOARD,CONTEXTMENU_SETMUTED,CONTEXTMENU_UNSETMUTED,CONTEXTMENU_MODULEINFO,CONTEXTMENU_SELL,CONTEXTMENU_SELLFROMINVENTORY,CONTEXTMENU_SELECTVEHICLEINHANGAR,CONTEXTMENU_SHOWVEHICLESTATISTICS,CONTEXTMENU_BUY,CONTEXTMENU_UNLOAD,CONTEXTMENU_CANCELBUY,CONTEXTMENU_BUYANDEQUIP,CONTEXTMENU_EQUIP,CONTEXTMENU_UNLOCK,CONTEXTMENU_KICKPLAYER,CONTEXTMENU_APPEAL,CONTEXTMENU_OFFEND,CONTEXTMENU_FLOOD,CONTEXTMENU_OPENINGOFALLYPOS,CONTEXTMENU_ALLYEJECTION,CONTEXTMENU_NOTFAIRPLAY,CONTEXTMENU_TEAMKILL,CONTEXTMENU_BOT,CONTEXTMENU_PERSONALCASE,CONTEXTMENU_TANKMANUNLOAD,CONTEXTMENU_TANKMANUNLOADALL,CONTEXTMENU_DISMISS,CONTEXTMENU_LOCKSLOT,CONTEXTMENU_UNLOCKSLOT];

      public static const NATIONS_ENUM:Array = [NATIONS_TITLE,NATIONS_USSR,NATIONS_GERMANY,NATIONS_USA,NATIONS_FRANCE,NATIONS_CHINA,NATIONS_JAPAN,NATIONS_UK,NATIONS_ALL];

      public static const TANKMANRECRUITRENDERER_ENUM:Array = [TANKMANRECRUITRENDERER_PERSONALCASE,TANKMANRECRUITRENDERER_COMMANDER,TANKMANRECRUITRENDERER_GUNNER,TANKMANRECRUITRENDERER_LOADER,TANKMANRECRUITRENDERER_DRIVER,TANKMANRECRUITRENDERER_RADIOMAN,TANKMANRECRUITRENDERER_DESCR,TANKMANRECRUITRENDERER_UNLOAD];

      public static const MODULEINFO_COMPATIBLE_ENUM:Array = [MODULEINFO_COMPATIBLE_TURRETS,MODULEINFO_COMPATIBLE_SHELLS,MODULEINFO_COMPATIBLE_GUNS,MODULEINFO_COMPATIBLE_SHELLGUNS,MODULEINFO_COMPATIBLE_VEHICLES,MODULEINFO_COMPATIBLE_UNICHARGEDVEHICLES,MODULEINFO_COMPATIBLE_CLIPVEHICLES];

      public static function nation_tree_title(param1:String) : String {
         var _loc2_:String = "#menu:nation_tree/title/" + param1;
         if(NATION_TREE_TITLE_ENUM.indexOf(_loc2_) == -1)
         {
            DebugUtils.LOG_WARNING("[nation_tree_title]:locale key \"" + _loc2_ + "\" was not found");
            return null;
         }
         return _loc2_;
      }

      public static function tankmanpersonalcase_modifiers(param1:String) : String {
         var _loc2_:String = "#menu:tankmanPersonalCase/modifiers/" + param1;
         App.utils.asserter.assert(!(TANKMANPERSONALCASE_MODIFIERS_ENUM.indexOf(_loc2_) == -1),"locale key \"" + _loc2_ + "\" was not found");
         return _loc2_;
      }

      public static function tankmantrainingwindow(param1:String) : String {
         var _loc2_:String = "#menu:tankmanTrainingWindow/" + param1;
         App.utils.asserter.assert(!(TANKMANTRAININGWINDOW_ENUM.indexOf(_loc2_) == -1),"locale key \"" + _loc2_ + "\" was not found");
         return _loc2_;
      }

      public static function shop_menu(param1:String) : String {
         var _loc2_:String = "#menu:shop/menu/" + param1;
         App.utils.asserter.assert(!(SHOP_MENU_ENUM.indexOf(_loc2_) == -1),"locale key \"" + _loc2_ + "\" was not found");
         return _loc2_;
      }

      public static function moduleinfo_params(param1:String) : String {
         var _loc2_:String = null;
         _loc2_ = "#menu:moduleInfo/params/" + param1;
         App.utils.asserter.assert(!(MODULEINFO_PARAMS_ENUM.indexOf(_loc2_) == -1),"locale key \"" + _loc2_ + "\" was not found");
         return _loc2_;
      }

      public static function skilldropwindow_study(param1:String) : String {
         var _loc2_:String = null;
         _loc2_ = "#menu:skillDropWindow/study/" + param1;
         App.utils.asserter.assert(!(SKILLDROPWINDOW_STUDY_ENUM.indexOf(_loc2_) == -1),"locale key \"" + _loc2_ + "\" was not found");
         return _loc2_;
      }

      public static function inventory_menu(param1:String) : String {
         var _loc2_:String = null;
         _loc2_ = "#menu:inventory/menu/" + param1;
         App.utils.asserter.assert(!(INVENTORY_MENU_ENUM.indexOf(_loc2_) == -1),"locale key \"" + _loc2_ + "\" was not found");
         return _loc2_;
      }

      public static function tank_params(param1:String) : String {
         var _loc2_:String = null;
         _loc2_ = "#menu:tank_params/" + param1;
         App.utils.asserter.assert(!(TANK_PARAMS_ENUM.indexOf(_loc2_) == -1),"locale key \"" + _loc2_ + "\" was not found");
         return _loc2_;
      }

      public static function loading_battletypes(param1:String) : String {
         var _loc2_:String = null;
         _loc2_ = "#menu:loading/battleTypes/" + param1;
         App.utils.asserter.assert(!(LOADING_BATTLETYPES_ENUM.indexOf(_loc2_) == -1),"locale key \"" + _loc2_ + "\" was not found");
         return _loc2_;
      }

      public static function tankcarousel_vehiclestates(param1:String) : String {
         var _loc2_:String = null;
         _loc2_ = "#menu:tankCarousel/vehicleStates/" + param1;
         App.utils.asserter.assert(!(TANKCAROUSEL_VEHICLESTATES_ENUM.indexOf(_loc2_) == -1),"locale key \"" + _loc2_ + "\" was not found");
         return _loc2_;
      }

      public static function shop_table_header_count(param1:String) : String {
         var _loc2_:String = null;
         _loc2_ = "#menu:shop/table/header/count/" + param1;
         App.utils.asserter.assert(!(SHOP_TABLE_HEADER_COUNT_ENUM.indexOf(_loc2_) == -1),"locale key \"" + _loc2_ + "\" was not found");
         return _loc2_;
      }

      public static function tankmen(param1:String) : String {
         var _loc2_:String = null;
         _loc2_ = "#menu:tankmen/" + param1;
         App.utils.asserter.assert(!(TANKMEN_ENUM.indexOf(_loc2_) == -1),"locale key \"" + _loc2_ + "\" was not found");
         return _loc2_;
      }

      public static function denunciation(param1:String) : String {
         var _loc2_:String = null;
         _loc2_ = "#menu:denunciation/" + param1;
         App.utils.asserter.assert(!(DENUNCIATION_ENUM.indexOf(_loc2_) == -1),"locale key \"" + _loc2_ + "\" was not found");
         return _loc2_;
      }

      public static function vehicleinfo_params(param1:String) : String {
         var _loc2_:String = null;
         _loc2_ = "#menu:vehicleInfo/params/" + param1;
         App.utils.asserter.assert(!(VEHICLEINFO_PARAMS_ENUM.indexOf(_loc2_) == -1),"locale key \"" + _loc2_ + "\" was not found");
         return _loc2_;
      }

      public static function loading_battletypes_desc(param1:String) : String {
         var _loc2_:String = null;
         _loc2_ = "#menu:loading/battleTypes/desc/" + param1;
         App.utils.asserter.assert(!(LOADING_BATTLETYPES_DESC_ENUM.indexOf(_loc2_) == -1),"locale key \"" + _loc2_ + "\" was not found");
         return _loc2_;
      }

      public static function profile_stats_blocks(param1:String) : String {
         var _loc2_:String = null;
         _loc2_ = "#menu:profile/stats/blocks/" + param1;
         App.utils.asserter.assert(!(PROFILE_STATS_BLOCKS_ENUM.indexOf(_loc2_) == -1),"locale key \"" + _loc2_ + "\" was not found");
         return _loc2_;
      }

      public static function profile_stats_items(param1:String) : String {
         var _loc2_:String = null;
         _loc2_ = "#menu:profile/stats/items/" + param1;
         App.utils.asserter.assert(!(PROFILE_STATS_ITEMS_ENUM.indexOf(_loc2_) == -1),"locale key \"" + _loc2_ + "\" was not found");
         return _loc2_;
      }

      public static function login_status(param1:String) : String {
         var _loc2_:String = null;
         _loc2_ = "#menu:login/status/" + param1;
         App.utils.asserter.assert(!(LOGIN_STATUS_ENUM.indexOf(_loc2_) == -1),"locale key \"" + _loc2_ + "\" was not found");
         return _loc2_;
      }

      public static function training_info(param1:String) : String {
         var _loc2_:String = null;
         _loc2_ = "#menu:training/info/" + param1;
         App.utils.asserter.assert(!(TRAINING_INFO_ENUM.indexOf(_loc2_) == -1),"locale key \"" + _loc2_ + "\" was not found");
         return _loc2_;
      }

      public static function premium_periods(param1:String) : String {
         var _loc2_:String = null;
         _loc2_ = "#menu:premium/periods/" + param1;
         App.utils.asserter.assert(!(PREMIUM_PERIODS_ENUM.indexOf(_loc2_) == -1),"locale key \"" + _loc2_ + "\" was not found");
         return _loc2_;
      }

      public static function contextmenu(param1:String) : String {
         var _loc2_:String = null;
         _loc2_ = "#menu:contextMenu/" + param1;
         App.utils.asserter.assert(!(CONTEXTMENU_ENUM.indexOf(_loc2_) == -1),"locale key \"" + _loc2_ + "\" was not found");
         return _loc2_;
      }

      public static function nations(param1:String) : String {
         var _loc2_:String = null;
         _loc2_ = "#menu:nations/" + param1;
         App.utils.asserter.assert(!(NATIONS_ENUM.indexOf(_loc2_) == -1),"locale key \"" + _loc2_ + "\" was not found");
         return _loc2_;
      }

      public static function tankmanrecruitrenderer(param1:String) : String {
         var _loc2_:String = null;
         _loc2_ = "#menu:tankmanRecruitRenderer/" + param1;
         App.utils.asserter.assert(!(TANKMANRECRUITRENDERER_ENUM.indexOf(_loc2_) == -1),"locale key \"" + _loc2_ + "\" was not found");
         return _loc2_;
      }

      public static function moduleinfo_compatible(param1:String) : String {
         var _loc2_:String = null;
         _loc2_ = "#menu:moduleInfo/compatible/" + param1;
         App.utils.asserter.assert(!(MODULEINFO_COMPATIBLE_ENUM.indexOf(_loc2_) == -1),"locale key \"" + _loc2_ + "\" was not found");
         return _loc2_;
      }
   }

}