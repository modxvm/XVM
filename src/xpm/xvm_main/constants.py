""" XVM (c) www.modxvm.com 2013-2015 """

class XVM(object):
    XVM_VERSION    = '6.1.5-dev'
    WOT_VERSION    = '0.9.10'
    CONFIG_VERSION = '6.0.0'
    XVM_INTRO      = 'www.modxvm.com'

    API_VERSION = '3.0'
    SERVERS = ['https://stat.modxvm.com:443/{API}/{REQ}']
    FINGERPRINTS = [ # fingerprints for SSL certificates
        '46169f8bd6f743733b23066f5cce2cd3d0392af8', # old
        '918154b8f25c74c2bcdeaf767cda7badf7f8a5e1'] # new
    TIMEOUT = 5000
    # WS_URL = 'ws://echo.websocket.org/'
    WS_URL = 'wss://echo.websocket.org/'

    CONFIG_DIR = 'res_mods/configs/xvm'
    CONFIG_FILE = CONFIG_DIR + '/xvm.xc'
    SHARED_RESOURCES_DIR = 'res_mods/mods/shared_resources/xvm'
    LOCALE_DIR = SHARED_RESOURCES_DIR + '/l10n'

    LOCALE_AUTO_DETECTION = 'auto'
    REGION_AUTO_DETECTION = 'auto'

class XVM_EVENT(object):
    CONFIG_LOADED = 'xvm.config_loaded'
    RELOAD_CONFIG = 'xvm.reload_config'
    SYSTEM_MESSAGE = 'xvm.system_message'

# DAAPI commands

class XVM_COMMAND(object):
    REQUEST_CONFIG = "xvm.request_config"
    GET_BATTLE_LEVEL = "xvm.get_battle_level"
    GET_BATTLE_TYPE = "xvm.get_battle_type"
    REQUEST_DOSSIER = "xvm.request_dossier"
    GET_SVC_SETTINGS = "xvm.get_svc_settings"
    LOAD_SETTINGS = "xvm.load_settings"
    LOAD_STAT_BATTLE = "xvm.load_stat_battle"
    LOAD_STAT_BATTLE_RESULTS = "xvm.load_stat_battle_results"
    LOAD_STAT_USER = "xvm.load_stat_user"
    OPEN_URL = "xvm.open_url"
    SAVE_SETTINGS = "xvm.save_settings"
    AS_DOSSIER = "xvm.as.dossier"
    AS_L10N = "xvm.as.l10n"
    AS_SET_SVC_SETTINGS = "xvm.as.set_svc_settings"
    AS_SET_CONFIG = "xvm.as.set_config"
    AS_UPDATE_RESERVE = "xvm.as.update_reserve"
    AS_STAT_BATTLE_DATA = "xvm.as.stat_battle_data"
    AS_STAT_BATTLE_RESULTS_DATA = "xvm.as.stat_battle_results_data"
    AS_STAT_USER_DATA = "xvm.as.stat_user_data"
    AS_UPDATE_CURRENT_VEHICLE = "xvm.as.update_current_vehicle"

# ExternalInterface commands

class AS2COMMAND(object):
    CAPTURE_BAR_GET_BASE_NUM = "capture_bar_get_base_num"
    GET_SCREEN_SIZE = "get_screen_size"
    LOG = "log"
    LOGSTAT = "logstat"
    LOAD_BATTLE_STAT = "load_battle_stat"
    LOAD_SETTINGS = "load_settings"
    SAVE_SETTINGS = "save_settings"

class AS2RESPOND(object):
    BATTLE_STATE = "xvm.battle_state"
    BATTLE_STAT_DATA = "xvm.battle_stat_data"
    CONFIG = "xvm.config"
    KEY_EVENT = "xvm.keyevent"

class TEAM(object):
    ALLY = 1
    ENEMY = 2

# Invalidation targets
class INV(object):
    NONE                = 0x00000000

    BATTLE_STATE        = 0x00000001
    BATTLE_HP           = 0x00000002
    BATTLE_SPOTTED      = 0x00000004
    BATTLE_ALL          = 0x000000FF

    MARKER_STATUS       = 0x00000100
    MARKER_FRAGS        = 0x00000200
    MARKER_SQUAD        = 0x00000400
    MARKER_ALL          = 0x0000FF00

    MINIMAP_SQUAD       = 0x00010000
    MINIMAP_ALL         = 0x000F0000

    ALL                 = 0xFFFFFFFF

class DYNAMIC_VALUE_TYPE(object):
    X              = 'x'
    HP             = 'hp'
    HP_RATIO       = 'hp_ratio'
    EFF            = 'eff'
    WN6            = 'wn6'
    WN8            = 'wn8'
    WGR            = 'wgr'
    WINRATE        = 'winrate'
    KB             = 'kb'
    AVGLVL         = 'avglvl'
    TBATTLES       = 't_battles'
    TDB            = 'tdb'
    TDV            = 'tdv'
    TFB            = 'tfb'
    TSB            = 'tsb'
    WN8EFFD        = 'wn8effd'
    DAMAGERATING   = 'damageRating'
    HITSRATIO      = 'hitsRatio'
    WINCHANCE      = 'winChance'
