""" XVM (c) www.modxvm.com 2013-2015 """

XVM_API_VERSION = "3.0"
XVM_SERVERS = ["https://stat.modxvm.com:443/{API}/{REQ}"]
XVM_FINGERPRINTS = [ # fingerprints for SSL certificates
    "46169f8bd6f743733b23066f5cce2cd3d0392af8", # old 
    "918154b8f25c74c2bcdeaf767cda7badf7f8a5e1"] # new
XVM_TIMEOUT = 5000
# XVM_WS_URL = "ws://echo.websocket.org/"
XVM_WS_URL = "wss://echo.websocket.org/"

# DAAPI commands

XVM_COMMAND_SETCONFIG = "xvm.setconfig"

XVM_COMMAND_GET_SVC_SETTINGS = "xvm.get_svc_settings"
XVM_COMMAND_GET_BATTLE_LEVEL = "xvm.get_battle_level"
XVM_COMMAND_GET_BATTLE_TYPE = "xvm.get_battle_type"
XVM_COMMAND_LOAD_SETTINGS = "xvm.load_settings"
XVM_COMMAND_SAVE_SETTINGS = "xvm.save_settings"

XVM_AS_COMMAND_SET_SVC_SETTINGS = "xvm.as.set_svc_settings"
XVM_AS_COMMAND_L10N = "xvm.as.l10n"

# ExternalInterface commands

COMMAND_LOG = "log"
COMMAND_GETVEHICLEINFODATA = "getVehicleInfoData"
COMMAND_GETSCREENSIZE = "getScreenSize"
COMMAND_LOADBATTLESTAT = "loadBattleStat"
COMMAND_LOADBATTLERESULTSSTAT = "loadBattleResultsStat"
COMMAND_LOADUSERDATA = "loadUserData"
COMMAND_OPEN_URL = "openUrl"
COMMAND_LOAD_SETTINGS = "load_settings"
COMMAND_SAVE_SETTINGS = "save_settings"
COMMAND_CAPTUREBARGETBASENUM = "captureBarGetBaseNum"
COMMAND_LOGSTAT = "logstat"
COMMAND_TEST = "test"

RESPOND_CONFIG = "xvm.config"
RESPOND_KEY_EVENT = "xvm.keyevent"
RESPOND_BATTLESTATDATA = "xvm.battlestatdata"
RESPOND_BATTLERESULTSDATA = "xvm.battleresultsdata"
RESPOND_BATTLESTATE = "xvm.battleState"
RESPOND_USERDATA = "xvm.userdata"
RESPOND_UPDATECURRENTVEHICLE = "xvm.updatecurrentvehicle"

TEAM_ALLY = 1
TEAM_ENEMY = 2

# Invalidation targets
class INV(object):
    NONE              = 0x0000
    
    BATTLE_STATE      = 0x0001
    BATTLE_HP         = 0x0002
    BATTLE_SPOTTED    = 0x0004
    BATTLE_ALL        = 0x00FF

    MARKER_STATUS     = 0x0100
    MARKER_FRAGS      = 0x0200
    MARKER_ALL        = 0xFF00

    ALL               = 0xFFFF
