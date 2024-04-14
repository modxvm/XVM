"""
SPDX-License-Identifier: LGPL-3.0-or-later
Copyright (c) 2013-2024 XVM Contributors
"""

import os
import BigWorld
import game

from gui.app_loader.settings import APP_NAME_SPACE
from gui.shared import events, g_eventBus
from gui.shared.events import HasCtxEvent
from gui.Scaleform.framework.application import AppEntry
from gui.Scaleform.framework.managers.loaders import SFViewLoadParams
from helpers import dependency
from skeletons.gui.app_loader import IAppLoader, GuiGlobalSpaceID
from skeletons.gui.impl import IGuiLoader

from xfw.constants import *
from xfw.events import *
from xfw.logger import *
import openwg_vfs as vfs

from .swfloadedinfo import swf_loaded_info

g_xvmlogger = None
g_xfwview = None

def as_xfw_cmd(cmd, *args):
    global g_xfwview
    view = g_xfwview() if g_xfwview else None
    return view.as_xfw_cmdS(cmd, *args) if view else None

def as_event(*args):
    return as_xfw_cmd('xfw.as.py_event', *args)

_events = {}

def as_callback(event_name, handler):
    global _events
    if not event_name in _events:
        _events[event_name] = EventHook()
    _events[event_name] += handler


#####################################################################
# SWF mods initializer

_curdir = os.path.dirname(os.path.realpath(__file__))

# Load xfw.swf
xfwInitialized = False
appNS = None
debug('[XFW] _start')

# TODO: disabled, because of the strange behavior on WoT 1.1
#@overrideMethod(AppEntry, '__init__')
#def _AppEntry__init__(base, self, userWndFlags, swfName, appNS, daapiBridge=None):
#    if swfName.lower() in ['battle.swf', 'lobby.swf'] and vfs.file_exists('gui/flash/xfw_' + swfName):
#        swfName = 'xfw_' + swfName
#    base(self, userWndFlags, swfName, appNS, daapiBridge)

#if vfs.file_exists('gui/flash/xfw_battleVehicleMarkersApp.swf'):
#    from gui.Scaleform.daapi.view.battle.shared.markers2d import settings as markers_settings
#    markers_settings.MARKERS_MANAGER_SWF = 'xfw_battleVehicleMarkersApp.swf'

def _getParentWindow():
    guiLoader = dependency.instance(IGuiLoader)
    parentWindow = None
    if guiLoader and guiLoader.windowsManager:
        parentWindow = guiLoader.windowsManager.getMainWindow()
    return parentWindow

def _loadXFWView():
    global appNS
    appLoader = dependency.instance(IAppLoader)
    app = appLoader.getApp(appNS)
    parent = _getParentWindow()
    app.loadView(SFViewLoadParams(CONST.XFW_VIEW_ALIAS, parent=parent))

def _appInitialized(event):
    debug('[XFW] _appInitialized: {}'.format(event.ns))
    try:
        appLoader = dependency.instance(IAppLoader)
        app = appLoader.getApp(event.ns)
        if app is not None:
            global g_xfwview
            g_xfwview = None
            global xfwInitialized, appNS
            xfwInitialized = False
            appNS = event.ns
            swf_loaded_info.clear()
            if event.ns == APP_NAME_SPACE.SF_LOBBY:
                _loadXFWView()
            elif event.ns == APP_NAME_SPACE.SF_BATTLE:
                if appLoader.getSpaceID() in [GuiGlobalSpaceID.BATTLE_LOADING, GuiGlobalSpaceID.BATTLE]:
                    _loadXFWView()
                else:
                    BigWorld.callback(0, _loadXFWView)
    except:
        err(traceback.format_exc())
    g_eventBus.handleEvent(HasCtxEvent(XFW_EVENT.APP_INITIALIZED, event))

def _appDestroyed(event):
    g_eventBus.handleEvent(HasCtxEvent(XFW_EVENT.APP_DESTROYED, event))

g_eventBus.addListener(events.AppLifeCycleEvent.INITIALIZED, _appInitialized)
g_eventBus.addListener(events.AppLifeCycleEvent.DESTROYED, _appDestroyed)

@registerEvent(game, 'fini')
def _fini():
    debug('[XFW] _fini')
    g_eventBus.removeListener(events.AppLifeCycleEvent.INITIALIZED, _appInitialized)
    g_eventBus.removeListener(events.AppLifeCycleEvent.DESTROYED, _appDestroyed)

@overrideMethod(AppEntry, 'onAsInitializationCompleted')
def _AppEntry_onAsInitializationCompleted(base, self):
    if self.initialized:
        #g_eventBus.removeListener(events.AppLifeCycleEvent.INITIALIZED, _appInitialized)
        #base(self)
        #g_eventBus.addListener(events.AppLifeCycleEvent.INITIALIZED, _appInitialized)
        pass
    else:
        base(self)

@overrideMethod(AppEntry, 'loadView')
def _AppEntry_loadView(base, self, loadParams, *args, **kwargs):
    onLoadView(base, self, loadParams, *args, **kwargs)

def onLoadView(base, self, loadParams, *args, **kwargs):
    #debug('[XFW] _AppEntry_loadView: ' + loadParams.viewKey)
    if hasattr(loadParams, 'viewKey'):
        if loadParams.viewKey == 'hangar':
            global xfwInitialized
            if not xfwInitialized:
                BigWorld.callback(0, lambda: onLoadView(base, self, loadParams, *args, **kwargs))
                return
    base(self, loadParams, *args, **kwargs)
