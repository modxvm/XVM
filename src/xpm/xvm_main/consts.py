""" XVM (c) https://modxvm.com 2013-2021 """

from xfw_loader.python import XFWLOADER_PATH_TO_ROOT

from __version__ import __xvm_version__, __wot_version__, __revision__, __development__

class XVM(object):
    XVM_VERSION    = __xvm_version__ + ('-dev' if __development__ == 'True' else '')
    XVM_REVISION   = __revision__
    WOT_VERSION    = __wot_version__
    XVM_INTRO      = 'https://modxvm.com'

    API_VERSION = '4.0'
    SERVERS = ['https://stat.modxvm.com:443/{API}/{REQ}']
    TIMEOUT = 5.0

    XMQP_SERVER_TEMPLATE = 'xmqp{HASH}.modxvm.com'
    XMQP_SERVER_PORT_BASE = 5600
    XMQP_API_VERSION = '2v0'
    XMQP_LOBBY_EXCHANGE = 'com.xvm.xmqp.%s.lobby' % XMQP_API_VERSION
    XMQP_LOBBY_ROUTING_KEY = 'query.battle.channel'

    CONFIG_DIR = XFWLOADER_PATH_TO_ROOT + u'res_mods/configs/xvm'
    CONFIG_FILE = CONFIG_DIR + u'/xvm.xc'
    PY_MACRO_DIR = CONFIG_DIR + u'/py_macro'
    SHARED_RESOURCES_DIR = XFWLOADER_PATH_TO_ROOT + u'res_mods/mods/shared_resources/xvm'
    LOCALE_DIR = SHARED_RESOURCES_DIR + u'/l10n'
    CURRENT_CONFIG_DIR = CONFIG_DIR

    LOCALE_AUTO_DETECTION = 'auto'
    REGION_AUTO_DETECTION = 'auto'

class XVM_PATH(object):
    XVM_IMG_RES_ROOT = "../mods/shared_resources/xvm/"
    XVM_IMG_CFG_ROOT = "../configs/xvm/"

class XVM_EVENT(object):
    RELOAD_CONFIG = 'xvm.reload_config'
    CONFIG_LOADED = 'xvm.config_loaded'
    SYSTEM_MESSAGE = 'xvm.system_message'
    CHECK_ACTIVATION = 'xvm.check_activation'
    XVM_SERVICES_INITIALIZED = 'xvm.services_initialized'

# PY<->AS3 commands

class XVM_COMMAND(object):
    REQUEST_CONFIG = "xvm.request_config"
    GET_PLAYER_ID = "xvm.get_player_id"
    GET_PLAYER_NAME = "xvm.get_player_name"
    GET_PLAYER_CLAN_ID = "xvm.get_player_clan_id"
    GET_PLAYER_CLAN_NAME = "xvm.get_player_clan_name"
    GET_PLAYER_DOSSIER_VALUE = "xvm.get_player_dossier_value"
    GET_CURRENT_VEH_CD = "xvm.get_current_veh_cd"
    GET_CLAN_ICON = "xvm.get_clan_icon"
    GET_XTDB_DATA = "xvm.get_xtdb_data"
    REQUEST_DOSSIER = "xvm.request_dossier"
    GET_SVC_SETTINGS = "xvm.get_svc_settings"
    LOAD_SETTINGS = "xvm.load_settings"
    LOAD_STAT_BATTLE = "xvm.load_stat_battle"
    LOAD_STAT_BATTLE_RESULTS = "xvm.load_stat_battle_results"
    LOAD_STAT_USER = "xvm.load_stat_user"
    PYTHON_MACRO = "xvm.python_macro"
    SAVE_SETTINGS = "xvm.save_settings"
    IS_IN_BOOTCAMP = "xvm.is_in_bootcamp"
    MINIMAP_CLICK = "xvm.minimap_click"
    OPEN_WEB_BROWSER = "xvm.open_web_browser"
    AS_ON_KEY_EVENT = "xvm.as.on_key_event"
    AS_ON_UPDATE_STAGE = "xvm.as.on_update_stage"
    AS_DOSSIER = "xvm.as.dossier"
    AS_SET_CONFIG = "xvm.as.set_config"
    AS_UPDATE_RESERVE = "xvm.as.update_reserve"
    AS_STAT_BATTLE_DATA = "xvm.as.stat_battle_data"
    AS_STAT_BATTLE_RESULTS_DATA = "xvm.as.stat_battle_results_data"
    AS_STAT_USER_DATA = "xvm.as.stat_user_data"
    AS_UPDATE_CURRENT_VEHICLE = "xvm.as.update_current_vehicle"
    AS_ON_CLAN_ICON_LOADED = "xvm.as.on_clan_icon_loaded"

class XVM_PROFILER_COMMAND(object):
    BEGIN = "xvm.profiler.begin"
    END = "xvm.profiler.end"

# Teams

class TEAM(object):
    ALLY = 1
    ENEMY = 2


# Dynamic values types

class DYNAMIC_VALUE_TYPE(object):
    X              = 'x'
    HP             = 'hp'
    HP_RATIO       = 'hp_ratio'
    EFF            = 'eff'
    WN8            = 'wn8'
    WGR            = 'wgr'
    WTR            = 'wtr'
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
