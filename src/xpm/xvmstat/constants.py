""" xvm (c) sirmax 2013 """

XVM_STAT_API_VERSION = "2.0"
XVM_STAT_SERVERS = [ "http://proxy2.bulychev.net:80/{API}/{REQ}" ] # TODO - config
XVM_STAT_TIMEOUT = 30000 # TODO - config

COMMAND_LOG = "log"
COMMAND_PING = "ping"
COMMAND_GETMODS = "getMods"
COMMAND_GETVEHICLEINFODATA = "getVehicleInfoData"
COMMAND_GETSCREENSIZE = "getScreenSize"
COMMAND_GETGAMEREGION = "getGameRegion"
COMMAND_GETLANGUAGE = "getLanguage"
COMMAND_LOADBATTLESTAT = "loadBattleStat"
COMMAND_LOADUSERDATA = "loadUserData"
COMMAND_GETDOSSIER = "getDossier"
COMMAND_LOGSTAT = "logstat";
COMMAND_LOAD_SETTINGS = "load_settings"
COMMAND_SAVE_SETTINGS = "save_settings"

RESPOND_PINGDATA = "xvm.pingdata"
RESPOND_STATDATA = "xvm.statdata"
RESPOND_USERDATA = "xvm.userdata"
RESPOND_DOSSIER = "xvm.dossier"

#COMMAND_GETSTAT = "getstat"
#COMMAND_LOGSTAT = "logstat"

XVM_LOG_FILE_NAME = 'xvm.log'
XVM_STAT_LOG_FILE_NAME = 'xvm-stat.log'

TEAM_ALLY = 1
TEAM_ENEMY = 2
