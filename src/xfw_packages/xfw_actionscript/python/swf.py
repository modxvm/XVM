"""
This file is part of the XVM Framework project.

Copyright (c) 2018-2021 XVM Team.

XVM Framework is free software: you can redistribute it and/or modify
it under the terms of the GNU Lesser General Public License as
published by the Free Software Foundation, version 3.

XVM Framework is distributed in the hope that it will be useful, but
WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License
along with this program. If not, see <http://www.gnu.org/licenses/>.
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

from xfw.constants import *
from xfw.events import *
from xfw.logger import *
import xfw_vfs as vfs
from xfw import isInBootcamp

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

def _appInitialized(event):
    if isInBootcamp():
       return
    debug('[XFW] _appInitialized: {}'.format(event.ns))
    try:
        app_loader = dependency.instance(IAppLoader)
        app = app_loader.getApp(event.ns)
        if app is not None:
            global g_xfwview
            g_xfwview = None
            global xfwInitialized, appNS
            xfwInitialized = False
            appNS = event.ns
            swf_loaded_info.clear()
            if event.ns == APP_NAME_SPACE.SF_LOBBY:
                #BigWorld.callback(0, lambda: app.loadView(SFViewLoadParams(CONST.XFW_VIEW_ALIAS, None)))
                app.loadView(SFViewLoadParams(CONST.XFW_VIEW_ALIAS, None))
            elif event.ns == APP_NAME_SPACE.SF_BATTLE:
                if app_loader.getSpaceID() in [GuiGlobalSpaceID.BATTLE_LOADING, GuiGlobalSpaceID.BATTLE]:
                    app.loadView(SFViewLoadParams(CONST.XFW_VIEW_ALIAS, None))
                else:
                    BigWorld.callback(0, lambda: app.loadView(SFViewLoadParams(CONST.XFW_VIEW_ALIAS, None)))
    except:
        err(traceback.format_exc())
    g_eventBus.handleEvent(HasCtxEvent(XFW_EVENT.APP_INITIALIZED, event))

def _appDestroyed(event):
    if isInBootcamp():
       return
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
