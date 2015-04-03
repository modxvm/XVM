""" XVM (c) www.modxvm.com 2013-2015 """

class XVM(object):
    API_VERSION = "3.0"
    SERVERS = ["https://stat.modxvm.com:443/{API}/{REQ}"]
    FINGERPRINTS = [ # fingerprints for SSL certificates
        "46169f8bd6f743733b23066f5cce2cd3d0392af8", # old
        "918154b8f25c74c2bcdeaf767cda7badf7f8a5e1"] # new
    TIMEOUT = 5000
    # WS_URL = "ws://echo.websocket.org/"
    WS_URL = "wss://echo.websocket.org/"

# DAAPI commands

class XVM_COMMAND(object):
    SET_CONFIG = "xvm.set_config"
    GET_VEHINFO = "xvm.get_vehinfo"
    GET_DOSSIER = "xvm.get_dossier"
    #GET_SVC_SETTINGS = "xvm.get_svc_settings"
    #GET_BATTLE_LEVEL = "xvm.get_battle_level"
    #GET_BATTLE_TYPE = "xvm.get_battle_type"
    #LOAD_SETTINGS = "xvm.load_settings"
    #SAVE_SETTINGS = "xvm.save_settings"

class XVM_AS_COMMAND(object):
    RELOAD_CONFIG = "xvm.as.reload_config"
    DOSSIER = "xvm.as.dossier"
    #SET_SVC_SETTINGS = "xvm.as.set_svc_settings"
    #L10N = "xvm.as.l10n"

# ExternalInterface commands

class AS2COMMAND(object):
    LOG = "log"
    GETSCREENSIZE = "getScreenSize"
    LOADBATTLESTAT = "loadBattleStat"
    LOADBATTLERESULTSSTAT = "loadBattleResultsStat"
    LOADUSERDATA = "loadUserData"
    OPEN_URL = "openUrl"
    LOAD_SETTINGS = "load_settings"
    SAVE_SETTINGS = "save_settings"
    CAPTUREBARGETBASENUM = "captureBarGetBaseNum"
    LOGSTAT = "logstat"
    TEST = "test"

class AS2RESPOND(object):
    CONFIG = "xvm.config"
    KEY_EVENT = "xvm.keyevent"
    BATTLESTATDATA = "xvm.battlestatdata"
    BATTLERESULTSDATA = "xvm.battleresultsdata"
    BATTLESTATE = "xvm.battleState"
    USERDATA = "xvm.userdata"
    UPDATECURRENTVEHICLE = "xvm.updatecurrentvehicle"

class TEAM(object):
    ALLY = 1
    ENEMY = 2

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
