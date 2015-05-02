""" XVM (c) www.modxvm.com 2013-2015 """

import os
import traceback
import BigWorld

from constants import *
from logger import *
import config

_xvm_config_dir_name = os.path.join(os.path.dirname(os.path.realpath(__file__)), '../../../../configs/xvm')
_configWatchdogTimerId = None
_lastConfigDirState = None

def startConfigWatchdog():
    #debug('startConfigWatchdog')
    _stopConfigWatchdog()
    if _isConfigReloadingEnabled():
        _configWatchdog()

def _configWatchdog():
    global _xvm_config_dir_name
    global _lastConfigDirState
    global _configWatchdogTimerId

    #debug('_configWatchdog(): {0}'.format(_xvm_config_dir_name))

    try:
        x = [(nm, os.path.getmtime(nm)) for nm in [os.path.join(p, f)
                                                   for p, n, fn in os.walk(_xvm_config_dir_name)
                                                   for f in fn]]
        if _lastConfigDirState is None:
            _lastConfigDirState = x
        elif _lastConfigDirState != x:
            _lastConfigDirState = x
            if not _onConfigChanged():
                return

    except Exception, ex:
        err(traceback.format_exc())

    if _isConfigReloadingEnabled():
        _configWatchdogTimerId = BigWorld.callback(1, _configWatchdog)
    else:
        _stopConfigWatchdog()

def _stopConfigWatchdog():
    #debug('_stopConfigWatchdog')
    global _configWatchdogTimerId
    if _configWatchdogTimerId:
        BigWorld.cancelCallback(_configWatchdogTimerId)
        _configWatchdogTimerId = None

def _isConfigReloadingEnabled():
    try:
        if config.config is None:
            return False
        enabled = config.config.get('autoReloadConfig', False) is True
        #debug('_isConfigReloadingEnabled: {}'.format(enabled))
        return enabled
    except:
        err(traceback.format_exc())
        return False

def _onConfigChanged():
    try:
        #debug('_onConfigChanged')
        _stopConfigWatchdog()
        as_xfw_cmd(XVM_COMMAND.AS_RELOAD_CONFIG)

        # reload hangar to apply changes
        from gui.WindowsManager import g_windowsManager
        from gui.Scaleform.framework import ViewTypes
        from gui.Scaleform.daapi.settings.views import VIEW_ALIAS
        from gui.prb_control.events_dispatcher import g_eventDispatcher
        app = g_windowsManager.window
        if app:
            container = app.containerManager.getContainer(ViewTypes.LOBBY_SUB)
            if container:
                view = container.getView()
                if view and view.alias == VIEW_ALIAS.LOBBY_HANGAR:
                    container.remove(view)
                g_eventDispatcher.loadHangar()
        return True
    except:
        err(traceback.format_exc())
        return False
