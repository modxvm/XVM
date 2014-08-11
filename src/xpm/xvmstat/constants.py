""" XVM (c) www.modxvm.com 2013-2014 """

XVM_STAT_API_VERSION = "3.0"
XVM_STAT_SERVERS = [ "https://stat.modxvm.com:443/{API}/{REQ}" ] # TODO - config
XVM_WS_URL = "ws://echo.websocket.org/"
#XVM_WS_URL = "wss://echo.websocket.org/"
XVM_STAT_FINGERPRINT = "46169f8bd6f743733b23066f5cce2cd3d0392af8" # fingerprint for SSL certificate
XVM_STAT_TIMEOUT = 5000 # TODO - config

COMMAND_LOG = "log"
COMMAND_LOAD_FILE = "loadFile"
COMMAND_SET_CONFIG = "setConfig"
COMMAND_PING = "ping"
COMMAND_GETMODS = "getMods"
COMMAND_GETVEHICLEINFODATA = "getVehicleInfoData"
COMMAND_GETWN8EXPECTEDDATA = "getWN8ExpectedData"
COMMAND_GETXVMSTATTOKENDATA = "getXvmStatTokenData"
COMMAND_GETSCREENSIZE = "getScreenSize"
COMMAND_GETGAMEREGION = "getGameRegion"
COMMAND_GETLANGUAGE = "getLanguage"
COMMAND_LOADBATTLESTAT = "loadBattleStat"
COMMAND_LOADBATTLERESULTSSTAT = "loadBattleResultsStat"
COMMAND_LOADUSERDATA = "loadUserData"
COMMAND_GETDOSSIER = "getDossier"
COMMAND_OPEN_URL = "openUrl"
COMMAND_RETURN_CREW = "returnCrew"
COMMAND_LOGSTAT = "logstat"
COMMAND_LOAD_SETTINGS = "load_settings"
COMMAND_SAVE_SETTINGS = "save_settings"
COMMAND_TEST = "test"

RESPOND_CONFIG = "xvm.config"
RESPOND_KEY_EVENT = "xvm.keyevent"
RESPOND_DOSSIER = "xvm.dossier"
RESPOND_BATTLEDATA = "xvm.battledata"
RESPOND_BATTLERESULTSDATA = "xvm.battleresultsdata"
RESPOND_BATTLESTATE = "xvm.battleState"
RESPOND_MARKSONGUN = "xvm.marksOnGun"
RESPOND_PINGDATA = "xvm.pingdata"
RESPOND_USERDATA = "xvm.userdata"
RESPOND_UPDATECURRENTVEHICLE = "xvm.updatecurrentvehicle"

#COMMAND_GETSTAT = "getstat"
#COMMAND_LOGSTAT = "logstat"

XVM_LOG_FILE_NAME = 'xvm.log'
XVM_STAT_LOG_FILE_NAME = 'xvm-stat.log'

TEAM_ALLY = 1
TEAM_ENEMY = 2

XVM_DIR = "res_mods/xvm"
XVM_DB_DIR = XVM_DIR + "/db"
XVM_MODS_DIR = XVM_DIR + "/mods"
