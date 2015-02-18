""" XVM (c) www.modxvm.com 2013-2015 """

XVM_API_VERSION = "3.0"
XVM_SERVERS = ["https://stat.modxvm.com:443/{API}/{REQ}"]
XVM_FINGERPRINT = "46169f8bd6f743733b23066f5cce2cd3d0392af8"  # fingerprints for SSL certificate
#XVM_SERVERS = ["https://stat2.modxvm.com:443/{API}/{REQ}"]
#XVM_FINGERPRINT = "918154b8f25c74c2bcdeaf767cda7badf7f8a5e1"  # fingerprints for SSL certificate
XVM_TIMEOUT = 5000
# XVM_WS_URL = "ws://echo.websocket.org/"
XVM_WS_URL = "wss://echo.websocket.org/"

# DAAPI commands

XVM_COMMAND_GET_SVC_SETTINGS = "xvm.get_svc_settings"
XVM_COMMAND_GET_BATTLE_LEVEL = "xvm.get_battle_level"
XVM_COMMAND_GET_BATTLE_TYPE = "xvm.get_battle_type"

XVM_AS_COMMAND_SET_SVC_SETTINGS = "xvm.as.set_svc_settings"

# ExternalInterface commands

COMMAND_LOG = "log"
COMMAND_SET_CONFIG = "setConfig"
COMMAND_GETVEHICLEINFODATA = "getVehicleInfoData"
COMMAND_GETSCREENSIZE = "getScreenSize"
COMMAND_LOADBATTLESTAT = "loadBattleStat"
COMMAND_LOADBATTLERESULTSSTAT = "loadBattleResultsStat"
COMMAND_LOADUSERDATA = "loadUserData"
COMMAND_GETDOSSIER = "getDossier"
COMMAND_OPEN_URL = "openUrl"
COMMAND_LOAD_SETTINGS = "load_settings"
COMMAND_SAVE_SETTINGS = "save_settings"
COMMAND_CAPTUREBARGETBASENUM = "captureBarGetBaseNum"
COMMAND_LOGSTAT = "logstat"
COMMAND_TEST = "test"

RESPOND_CONFIG = "xvm.config"
RESPOND_KEY_EVENT = "xvm.keyevent"
RESPOND_DOSSIER = "xvm.dossier"
RESPOND_BATTLEDATA = "xvm.battledata"
RESPOND_BATTLERESULTSDATA = "xvm.battleresultsdata"
RESPOND_BATTLESTATE = "xvm.battleState"
RESPOND_MARKSONGUN = "xvm.marksOnGun"
RESPOND_USERDATA = "xvm.userdata"
RESPOND_UPDATECURRENTVEHICLE = "xvm.updatecurrentvehicle"

XVM_DIR = "res_mods/xvm"

XVM_LOG_FILE_NAME = 'xvm.log'
XVM_STAT_LOG_FILE_NAME = 'xvm-stat.log'

TEAM_ALLY = 1
TEAM_ENEMY = 2
