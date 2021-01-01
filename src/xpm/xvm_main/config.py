"""
This file is part of the XVM project.

Copyright (c) 2013-2021 XVM Team.

XVM is free software: you can redistribute it and/or modify
it under the terms of the GNU Lesser General Public License as
published by the Free Software Foundation, version 3.

XVM is distributed in the hope that it will be useful, but
WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License
along with this program. If not, see <http://www.gnu.org/licenses/>.
"""

__all__ = ['load', 'get', 'config_data', 'lang_data']

#cpython
from copy import deepcopy
import logging
import os
import time
import traceback
import collections

#BigWorld
from gui.shared import g_eventBus, events

#xfw.loader
import xfw_loader.python as loader

#xfw.libraries
import JSONxLoader
from xfw import *
import xfw.constants as xfw_constants

#xvm.main
from consts import *
from logger import *
from default_xvm_xc import DEFAULT_XVM_XC
import default_config
import userprefs
import utils
import xvmapi

config_autoreload = False
config_data = None
lang_data = None

def get(path, default=None):
    if config_data is None or not path or path == '':
        return default
    try:
        path = path.replace('.', '/')
        if path[0] == '/':
            path = path[1:]
        c = config_data
        for x in path.split('/'):
            if not isinstance(c, collections.Mapping) or x not in c:
                return default
            c = c[x]
        return c
    except Exception:
        err(traceback.format_exc())
    return default

def load(e):
    global config_autoreload
    global config_data
    global lang_data

    try:
        # TODO: config selection
        filename = e.ctx.get('filename', XVM.CONFIG_FILE)

        config_data = None
        lang_data = None

        config_data = _load_xvm_xc(filename, config_autoreload)

        regionDetected = 'region' not in config_data or config_data['region'].lower() == XVM.REGION_AUTO_DETECTION
        if regionDetected:
            config_data['region'] = getRegion()

        languageDetected = 'language' not in config_data or config_data['language'] == XVM.LOCALE_AUTO_DETECTION
        if languageDetected:
            config_data['language'] = getLanguage()
        lang_data = _load_locale_file()

        log('Config loaded. Region: {} ({}), Language: {} ({})'.format(
            get('region'),
            'detected' if regionDetected else 'config',
            get('language'),
            'detected' if languageDetected else 'config'))

        if config_autoreload is not True:
            config_autoreload = get('autoReloadConfig', False)

        if config_autoreload:
            try:
                xfw_filewatcher = loader.get_mod_module('com.modxvm.xfw.filewatcher')
                if not xfw_filewatcher:
                    logging.error("[XVM/Main] [config/load]: failed to start filewatcher because XFW.Filewatcher is not loaded")
                else:
                    if not xfw_filewatcher.watcher_is_exists(XVM_EVENT.RELOAD_CONFIG):
                        xfw_filewatcher.watcher_add(XVM_EVENT.RELOAD_CONFIG, XVM.CONFIG_DIR, \
                            "import BigWorld;"\
                            "from gui.shared import g_eventBus, events;" \
                            "BigWorld.callback(0, lambda: g_eventBus.handleEvent(events.HasCtxEvent('%s', {'filename':'%s'})))" % (XVM_EVENT.RELOAD_CONFIG, XVM.CONFIG_FILE), \
                            True)
                    xfw_filewatcher.watcher_start(XVM_EVENT.RELOAD_CONFIG)
            except Exception:
                log('[WARNING] XFW Filewatcher is not available. Config reload was disabled.')

    except Exception:
        err(traceback.format_exc())


    g_eventBus.handleEvent(events.HasCtxEvent(XVM_EVENT.CONFIG_LOADED))


# PRIVATE

_xvm_xc_files_counter = 0

def _load_xvm_xc(filename, autoreload):
    # debug('_load_xvm_xc: "{}", {}'.format(filename, autoreload))
    try:
        global _xvm_xc_files_counter
        _xvm_xc_files_counter = 0

        config = deepcopy(default_config.DEFAULT_CONFIG)
        if not os.path.isfile(filename):
            log('[WARNING] xvm.xc was not found, building new')
            with open(filename, 'w') as f:
                f.write(DEFAULT_XVM_XC)
        if os.path.isfile(filename):
            result = JSONxLoader.load(filename, _load_log_xvm_xc)
            if result is not None:
                config = _merge_configs(config, result)
            config['__stateInfo'] = {}
        else:
            log('[WARNING] xvm.xc was not found, using the built-in config')
            config['__stateInfo'] = {'warning':''}
    except Exception as ex:
        config['autoReloadConfig'] = autoreload
        config['__stateInfo'] = {'error': str(ex), 'stacktrace': traceback.format_exc()}
        err(traceback.format_exc())
    #log('config={}'.format(config))

    _tuneup_config(config)

    config = unicode_to_ascii(config)

    return config


def _load_locale_file():
    try:
        data = JSONxLoader.load(u'{}/{}.xc'.format(XVM.LOCALE_DIR, get('language')), _load_log)
    except Exception:
        data = default_config.LANG_RU if get('region').lower() == 'ru' else default_config.LANG_EN
        err(traceback.format_exc())
    try:
        folderLanguage = get('userLanguageFolder', 'lang').strip(' /')
        if folderLanguage:
            filename = u'{}/{}/{}.xc'.format(XVM.CURRENT_CONFIG_DIR, folderLanguage, get('language'))
            if os.path.isfile(filename):
                user_data = JSONxLoader.load(filename, _load_log)
                data = _merge_configs(data, user_data)
    except Exception:
        err(traceback.format_exc())
    data = unicode_to_ascii(data)
    return data

def _load_log_xvm_xc(msg):
    _load_log(msg)
    if msg.startswith(u'[JSONxLoader] load: '):
        global _xvm_xc_files_counter
        _xvm_xc_files_counter += 1
        if _xvm_xc_files_counter < 3:
            XVM.CURRENT_CONFIG_DIR = os.path.dirname(
                msg.replace(u'[JSONxLoader] load: ', '').replace('\\', '/'))

def _load_log(msg):
    log(msg
        .replace('\\', '/')
        .replace(XVM.CONFIG_DIR, '[cfg]')
        .replace(XVM.SHARED_RESOURCES_DIR, '[res]'))


def _merge_configs(original, result, path=[]):
    def to_bool(user_data):
        lower = str(user_data).lower()
        if lower == 'true':
            return True
        elif lower == 'false':
            return False
        else:
            return user_data
    if type(result) != type(original):
        log('[JSONxLoader] merge: /{} expected {}, got {}. Default value loaded'
            .format('/'.join(path), type(original).__name__, type(result).__name__))
        return original
    for key, value in original.iteritems():
        path.append(key)
        if key not in result:
            result[key] = value
        elif isinstance(value, dict):
            result[key] = _merge_configs(value, result[key], path)
        elif isinstance(value, bool):
            result[key] = to_bool(result[key])
        elif isinstance(value, list):
            result_list = result[key] or []
            is_list = isinstance(result_list, list)
            result[key] = result_list if is_list else value
        path.pop()
    return result


def _tuneup_config(config):
    config['__xvmVersion'] = XVM.XVM_VERSION
    config['__wotVersion'] = XVM.WOT_VERSION
    config['__xvmIntro'] = XVM.XVM_INTRO
    config['__wgApiAvailable'] = getRegion() in xfw_constants.URLS.WG_API_SERVERS
    try:
        from __version__ import __revision__
        config['__xvmRevision'] = __revision__
    except Exception as ex:
        pass

    # Cleanup empty vehicle names
    config['vehicleNames'] = {k:v for k,v in config['vehicleNames'].iteritems() \
        if v and (v['short'] is not None or v['name'] is not None)}


# config.networkServicesSettings

class NetworkServicesSettings(object):

    def __init__(self, data={}, active=False):
        self.servicesActive = active
        self.statBattle = data.get('statBattle', True) if active else False
        self.statAwards = data.get('statAwards', True) if active else False
        self.comments = data.get('comments', True) if active else False
        self.scale = data.get('scale', 'xvm')
        self.rating = data.get('rating', 'wgr')
        self.topClansCountWgm = int(data.get('topClansCount', 50))
        self.topClansCountWsh = int(data.get('topClansCountWsh', 50))
        self.flag = data.get('flag', None)
        self.xmqp = data.get('xmqp', True) if active else False
        # TODO: configure color in the personal cabinet
        self.x_minimap_clicks_color = int(str(data.get('minimap_click_color', 0x00FF00)), 0)

networkServicesSettings = NetworkServicesSettings()


# config.token

class XvmServicesToken(object):

    def __init__(self, data={}):
        #trace('config.token.__init__')
        #log(data)
        self._apply(data)
        self.errStr = None
        self.online = False

    @staticmethod
    def restore():
        #trace('config.token.restore')
        try:
            accountDBID = utils.getAccountDBID()
            if accountDBID is None:
                return XvmServicesToken()
            new_token = XvmServicesToken(userprefs.get('tokens/{0}'.format(accountDBID)))
            global token
            if token:
                new_token.online = token.online
            return new_token
        except Exception:
            err(traceback.format_exc())

    def saveToken(self):
        #trace('config.token.saveToken')
        if self.accountDBID:
            userprefs.set('tokens/{0}'.format(self.accountDBID), self.__dict__)

    def saveLastAccountDBID(self):
        #trace('config.token.saveLastAccountDBID')
        if self.accountDBID:
            userprefs.set('tokens/lastAccountDBID', self.accountDBID)

    def updateTokenFromApi(self):
        #trace('config.token.updateTokenFromApi')
        try:
            (data, errStr) = xvmapi.getToken()
            #log(utils.hide_guid(data))
            self.update(data, errStr)
        except Exception, ex:
            err(traceback.format_exc())

    def update(self, data={}, errStr=None):
        #trace('config.token._update')
        #log(data)

        if data is None:
            data = {}

        status = data.get('status', None)
        if not status:
            self.status = None
            self.errStr = errStr
            self.online = False
            return

        self.online = True
        if status == 'active':
            if 'token' not in data:
                data['token'] = self.token
            self._apply(data)
        else:
            self.token = None
            self.status = status
            self.services = {}
            global networkServicesSettings
            networkServicesSettings = NetworkServicesSettings()

        self.saveToken()
        self.saveLastAccountDBID()

    def _apply(self, data):
        #trace('config.token._apply')
        if data is None:
            data = {}
        self.accountDBID = data.get('accountDBID', None)
        if self.accountDBID is None:
            self.accountDBID = data.get('_id', None) # returned from XVM API
        self.token = data.get('token', '')
        if self.token is not None:
            if self.token == '':
                self.token = None
            else:
                self.token = self.token.encode('ascii')
        self.expires_at = data.get('expires_at', None)
        if self.expires_at is None or time.time() > self.expires_at / 1000:
            self.status = 'inactive'
            self.token = None
        else:
            self.status = data.get('status', 'inactive')
        self.services = data.get('services', {});

        active = self.token is not None
        global networkServicesSettings
        networkServicesSettings = NetworkServicesSettings(self.services, active)

token = XvmServicesToken()


# config.verinfo

class XvmVersionInfo(object):
    def __init__(self, data={}):
        #trace('config.verinfo.__init__')
        if data is None:
            data = {}
        info = data.get('info', None)
        if info is None:
            info = {}
        self.message = info.get('message', None)
        self.wot = info.get('wot', None)
        self.ver = info.get('ver', None)

verinfo = XvmVersionInfo()
