"""
This file is part of the XVM project.

Copyright (c) 2013-2020 XVM Team.

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

#####################################################################
# imports

# Python
from datetime import datetime
from glob import glob
import os
import platform
import re
import traceback

#BigWorld
import BigWorld
from Avatar import PlayerAvatar
from BattleReplay import g_replayCtrl
from PlayerEvents import g_playerEvents
import game
from gui.shared import g_eventBus, events
from gui.Scaleform.framework.application import AppEntry
from gui.Scaleform.daapi.view.lobby.profile.ProfileTechniqueWindow import ProfileTechniqueWindow
from helpers import dependency
from notification.actions_handlers import NotificationsActionsHandlers
from notification.decorators import MessageDecorator
from notification.settings import NOTIFICATION_TYPE
from skeletons.gameplay import ReplayEventID
from skeletons.gui.app_loader import IAppLoader

#XFW
from xfw_loader.python import WOT_VERSION_FULL
from xfw import *

#XVM
from consts import *
from logger import *
import config
import filecache
import svcmsg
import utils
import mutex
from xvm import g_xvm


#####################################################################
# initialization/finalization

def start():
    debug('start')

    dependency.instance(IAppLoader).onGUISpaceEntered += g_xvm.onGUISpaceEntered

    g_eventBus.addListener(XFW_COMMAND.XFW_CMD, g_xvm.onXfwCommand)
    g_eventBus.addListener(XFW_EVENT.APP_INITIALIZED, g_xvm.onAppInitialized)
    g_eventBus.addListener(XFW_EVENT.APP_DESTROYED, g_xvm.onAppDestroyed)
    g_eventBus.addListener(XVM_EVENT.RELOAD_CONFIG, config.load)
    g_eventBus.addListener(XVM_EVENT.CONFIG_LOADED, g_xvm.onConfigLoaded)
    g_eventBus.addListener(XVM_EVENT.SYSTEM_MESSAGE, g_xvm.onSystemMessage)
    g_eventBus.addListener(XVM_EVENT.CHECK_ACTIVATION, g_xvm.onCheckActivation)

    # config already loaded, just send event to apply required code
    g_eventBus.handleEvent(events.HasCtxEvent(XVM_EVENT.CONFIG_LOADED, {'fromInitStage': True}))

@registerEvent(game, 'fini')
def fini():
    debug('fini')

    try:
        dependency.instance(IAppLoader).onGUISpaceEntered -= g_xvm.onGUISpaceEntered
    except(dependency.DependencyError):
        pass

    g_eventBus.removeListener(XFW_COMMAND.XFW_CMD, g_xvm.onXfwCommand)
    g_eventBus.removeListener(XFW_EVENT.APP_INITIALIZED, g_xvm.onAppInitialized)
    g_eventBus.removeListener(XFW_EVENT.APP_DESTROYED, g_xvm.onAppDestroyed)
    g_eventBus.removeListener(XVM_EVENT.RELOAD_CONFIG, config.load)
    g_eventBus.removeListener(XVM_EVENT.CONFIG_LOADED, g_xvm.onConfigLoaded)
    g_eventBus.removeListener(XVM_EVENT.SYSTEM_MESSAGE, g_xvm.onSystemMessage)
    g_eventBus.removeListener(XVM_EVENT.CHECK_ACTIVATION, g_xvm.onCheckActivation)


#####################################################################
# handlers

# GLOBAL

@registerEvent(game, 'handleKeyEvent')
def game_handleKeyEvent(event):
    g_xvm.onKeyEvent(event)

@registerEvent(AppEntry, 'as_updateStageS')
def AppEntry_as_updateStageS(*args, **kwargs):
    g_xvm.onUpdateStage()

@overrideMethod(MessageDecorator, 'getListVO')
def _MessageDecorator_getListVO(base, self, newId=None):
    return svcmsg.fixData(base(self, newId))

@overrideMethod(NotificationsActionsHandlers, 'handleAction')
def _NotificationsActionsHandlers_handleAction(base, self, model, typeID, entityID, actionName):
    if actionName == 'XVM_CHECK_ACTIVATION':
        g_eventBus.handleEvent(events.HasCtxEvent(XVM_EVENT.CHECK_ACTIVATION))
    elif typeID == NOTIFICATION_TYPE.MESSAGE and re.match('https?://', actionName, re.I):
        BigWorld.wg_openWebBrowser(actionName)
    else:
        base(self, model, typeID, entityID, actionName)


# LOGIN

def onClientVersionDiffers():
    if not (g_replayCtrl.scriptModalWindowsEnabled and not config.get('login/confirmOldReplays')):
        g_replayCtrl.acceptVersionDiffering()
        return
    g_replayCtrl.gameplay.postStateEvent(ReplayEventID.REPLAY_VERSION_CONFIRMATION)

g_replayCtrl._BattleReplay__replayCtrl.clientVersionDiffersCallback = onClientVersionDiffers


# LOBBY

@overrideMethod(ProfileTechniqueWindow, 'requestData')
def ProfileTechniqueWindow_RequestData(base, self, vehicleId):
    if vehicleId:
        base(self, vehicleId)


# PRE-BATTLE

def onArenaCreated():
    # debug('> onArenaCreated')
    g_xvm.onArenaCreated()

g_playerEvents.onArenaCreated += onArenaCreated

@overrideMethod(PlayerAvatar, 'onBecomePlayer')
def _PlayerAvatar_onBecomePlayer(base, self):
    # debug('> onBecomePlayer')
    base(self)
    g_xvm.onBecomePlayer()

@overrideMethod(PlayerAvatar, 'onBecomeNonPlayer')
def _PlayerAvatar_onBecomeNonPlayer(base, self):
    # debug('> onBecomeNonPlayer')
    g_xvm.onBecomeNonPlayer()
    base(self)


#####################################################################
# Log version info + warn about installed XVM fonts

def log_version():

    log("XVM: eXtended Visualization Mod ( https://modxvm.com/ )")

    try:
        from __version__ import __branch__, __revision__, __node__

        log("    XVM Version     : %s" % XVM.XVM_VERSION)
        log("    XVM Revision    : %s" % __revision__)
        log("    XVM Branch      : %s" % __branch__)
        log("    XVM Hash        : %s" % __node__)
        log("    WoT Version     : %s" % WOT_VERSION_FULL)
        log("    WoT Architecture: %s" % platform.architecture()[0])
        log("    Current Time    : %s %+05d" % (datetime.now().strftime('%Y-%m-%d %H:%M:%S'),
            round((round((datetime.now() - datetime.utcnow()).total_seconds()) / 1800) / 2) * 100))

        log("---------------------------")

        xvm_fonts_arr = glob(os.environ['WINDIR'] + '/Fonts/*xvm*')
        if len(xvm_fonts_arr):
            warn('Following XVM fonts installed: %s' % xvm_fonts_arr)

        log("---------------------------")
    except Exception:
        err(traceback.format_exc())

#####################################################################
# XFW Mod initialization

__xvm_main_loaded = False

def xfw_module_init():
    try:
        log_version()

        BigWorld.callback(0, start)

        # load config
        config.load(events.HasCtxEvent(XVM_EVENT.RELOAD_CONFIG, {'filename': XVM.CONFIG_FILE}))

        global __xvm_main_loaded
        __xvm_main_loaded = True
    except Exception:
        err(traceback.format_exc())

def xfw_is_module_loaded():
    return __xvm_main_loaded
