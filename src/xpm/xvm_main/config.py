""" XVM (c) www.modxvm.com 2013-2015 """

__all__ = ['load', 'get', 'config_str', 'lang_str', 'lang_data']

from copy import deepcopy
import os
import traceback
import collections
import simplejson
import JSONxLoader

from xfw import *

from constants import *
from logger import *
import default_config
import configwatchdog
import utils

_config = None
config_str = None
lang_str = None
lang_data = None

def get(path, default=None):
    if _config is None or not path or path == '':
        return default
    try:
        path = path.replace('.', '/')
        if path[0] == '/':
            path = path[1:]
        c = _config
        for x in path.split('/'):
            if not isinstance(c, collections.Mapping) or x not in c:
                return default
            c = c[x]
        return c
    except Exception:
        err(traceback.format_exc())
    return default

def load(e):
    global _config
    global config_str
    global lang_str
    global lang_data

    try:
        # TODO: config selection
        filename = e.ctx.get('filename', XVM.CONFIG_FILE)

        configwatchdog.stopConfigWatchdog()

        config_str = None
        lang_str = None
        lang_data = None

        autoreload = get('autoReloadConfig', False)
        _config = _load_xvm_xc(filename, autoreload)

        regionDetected = 'region' not in _config or _config['region'].lower() == XVM.REGION_AUTO_DETECTION
        if regionDetected:
            _config['region'] = GAME_REGION

        languageDetected = 'language' not in _config or _config['language'] == XVM.LOCALE_AUTO_DETECTION
        if languageDetected:
            _config['language'] = GAME_LANGUAGE
        lang_data = _load_locale_file()

        log('Config loaded. Region: {} ({}), Language: {} ({})'.format(
            get('region'),
            'detected' if regionDetected else 'config',
            get('language'),
            'detected' if languageDetected else 'config'))

        config_str = simplejson.dumps(_config)
        lang_str = simplejson.dumps(lang_data)

    except Exception:
        err(traceback.format_exc())

    if get('autoReloadConfig', False) == True:
        configwatchdog.startConfigWatchdog()

    from gui.shared import g_eventBus, events
    g_eventBus.handleEvent(events.HasCtxEvent(XVM_EVENT.CONFIG_LOADED))


# PRIVATE


def _load_xvm_xc(filename, autoreload):
    # debug('_load_xvm_xc: "{}", {}'.format(filename, autoreload))
    try:
        config = deepcopy(default_config.DEFAULT_CONFIG)
        if os.path.isfile(filename):
            result = JSONxLoader.load(filename, _load_log)
            if result is not None:
                config = _merge_configs(config, result)
            config['__stateInfo'] = {}
        else:
            config['__stateInfo'] = {'warning':''}
    except Exception as ex:
        config['autoReloadConfig'] = autoreload
        config['__stateInfo'] = {'error':str(ex), 'stacktrace':traceback.format_exc()}
        err(traceback.format_exc())
    #log('config={}'.format(config))

    _tuneup_config(config)

    return config


def _load_locale_file():
    try:
        data = JSONxLoader.load('{}/{}.xc'.format(XVM.LOCALE_DIR, get('language')), _load_log)
    except Exception:
        data = default_config.LANG_RU if get('region').lower() == 'ru' else default_config.LANG_EN
        err(traceback.format_exc())

    return data


def _load_log(msg):
    log(msg
        .replace(XVM.CONFIG_DIR, '[cfg]')
        .replace(XVM.SHARED_RESOURCES_DIR, '[res]'))


def _merge_configs(orig_dict, new_dict):
    for key, val in new_dict.iteritems():
        if isinstance(val, collections.Mapping):
            tmp = _merge_configs(orig_dict.get(key, { }), val)
            orig_dict[key] = tmp
        elif isinstance(val, list):
            orig_dict[key] = val
        elif key in orig_dict and isinstance(orig_dict[key], bool):
            strval = str(val).lower()
            if strval == 'true':
                orig_dict[key] = True
            elif strval == 'false':
                orig_dict[key] = False
            else:
                orig_dict[key] = val
        else:
            orig_dict[key] = val
    return orig_dict


def _tuneup_config(config):
    config['__xvmVersion'] = XVM.XVM_VERSION
    config['__wotVersion'] = XVM.WOT_VERSION
    config['__xvmIntro'] = XVM.XVM_INTRO

    config['battle']['clanIconsFolder'] = utils.fixPath(config['battle']['clanIconsFolder'])

    config['iconset']['battleLoadingAlly']  = utils.fixPath(config['iconset']['battleLoadingAlly'])
    config['iconset']['battleLoadingEnemy'] = utils.fixPath(config['iconset']['battleLoadingEnemy'])
    config['iconset']['playersPanelAlly']   = utils.fixPath(config['iconset']['playersPanelAlly'])
    config['iconset']['playersPanelEnemy']  = utils.fixPath(config['iconset']['playersPanelEnemy'])
    config['iconset']['statisticFormAlly']  = utils.fixPath(config['iconset']['statisticFormAlly'])
    config['iconset']['statisticFormEnemy'] = utils.fixPath(config['iconset']['statisticFormEnemy'])
    config['iconset']['vehicleMarkerAlly']  = utils.fixPath(config['iconset']['vehicleMarkerAlly'])
    config['iconset']['vehicleMarkerEnemy'] = utils.fixPath(config['iconset']['vehicleMarkerEnemy'])

    if config['battleLoading']['clanIcon']['xr'] is None:
        config['battleLoading']['clanIcon']['xr'] = config['battleLoading']['clanIcon']['x']
    if config['battleLoading']['clanIcon']['yr'] is None:
        config['battleLoading']['clanIcon']['yr'] = config['battleLoading']['clanIcon']['y']
    if config['statisticForm']['clanIcon']['xr'] is None:
        config['statisticForm']['clanIcon']['xr'] = config['statisticForm']['clanIcon']['x']
    if config['statisticForm']['clanIcon']['yr'] is None:
        config['statisticForm']['clanIcon']['yr'] = config['statisticForm']['clanIcon']['y']
    if config['playersPanel']['clanIcon']['xr'] is None:
        config['playersPanel']['clanIcon']['xr'] = config['playersPanel']['clanIcon']['x']
    if config['playersPanel']['clanIcon']['yr'] is None:
        config['playersPanel']['clanIcon']['yr'] = config['playersPanel']['clanIcon']['y']
