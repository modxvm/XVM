""" XVM (c) www.modxvm.com 2013-2016 """

#####################################################################
# MOD INFO

XFW_MOD_INFO = {
    # mandatory
    'VERSION':       '0.9.16',
    'URL':           'http://www.modxvm.com/',
    'UPDATE_URL':    'http://www.modxvm.com/en/download-xvm/',
    'GAME_VERSIONS': ['0.9.16'],
    # optional
}


#####################################################################
# imports

from pprint import pprint
from glob import glob
import os
import re
import time
import traceback

import BigWorld
import game
from account_helpers.settings_core import settings_constants
from account_helpers.settings_core.options import SettingsContainer
from account_helpers.settings_core.SettingsCore import g_settingsCore
from Avatar import PlayerAvatar
from BattleReplay import g_replayCtrl
from PlayerEvents import g_playerEvents
from notification.actions_handlers import NotificationsActionsHandlers
from notification.decorators import MessageDecorator
from notification.settings import NOTIFICATION_TYPE
from gui.app_loader import g_appLoader
from gui.app_loader.settings import GUI_GLOBAL_SPACE_ID
from gui.battle_control.arena_info.settings import INVALIDATE_OP
from gui.shared import g_eventBus, events
from gui.Scaleform.framework.application import SFApplication
from gui.Scaleform.daapi.view.lobby.profile.ProfileTechniqueWindow import ProfileTechniqueWindow
from gui.Scaleform.daapi.view.lobby.hangar.AmmunitionPanel import AmmunitionPanel
from gui.Scaleform.Minimap import Minimap

from xfw import *

from consts import *
from logger import *
import config
import filecache
import svcmsg
import utils
from xvm import g_xvm
import xmqp_events


#####################################################################
# initialization/finalization

def start():
    debug('start')

    g_appLoader.onGUISpaceEntered += g_xvm.onGUISpaceEntered

    g_eventBus.addListener(XFWCOMMAND.XFW_CMD, g_xvm.onXfwCommand)
    g_eventBus.addListener(XVM_EVENT.RELOAD_CONFIG, config.load)
    g_eventBus.addListener(XVM_EVENT.CONFIG_LOADED, g_xvm.onConfigLoaded)
    g_eventBus.addListener(XVM_EVENT.SYSTEM_MESSAGE, g_xvm.onSystemMessage)
    g_eventBus.addListener(events.AppLifeCycleEvent.INITIALIZED, g_xvm.onAppInitialized)
    g_eventBus.addListener(events.AppLifeCycleEvent.DESTROYED, g_xvm.onAppDestroyed)
    g_eventBus.addListener(XVM_EVENT.XMQP_CONNECTED, xmqp_events.onXmqpConnected)
    g_eventBus.addListener(XVM_EVENT.XMQP_MESSAGE, xmqp_events.onXmqpMessage)

    # config already loaded, just send event to apply required code
    g_eventBus.handleEvent(events.HasCtxEvent(XVM_EVENT.CONFIG_LOADED, {'fromInitStage':True}))

BigWorld.callback(0, start)

@registerEvent(game, 'fini')
def fini():
    debug('fini')

    g_appLoader.onGUISpaceEntered -= g_xvm.onGUISpaceEntered

    g_eventBus.removeListener(XFWCOMMAND.XFW_CMD, g_xvm.onXfwCommand)
    g_eventBus.removeListener(XVM_EVENT.RELOAD_CONFIG, config.load)
    g_eventBus.removeListener(XVM_EVENT.CONFIG_LOADED, g_xvm.onConfigLoaded)
    g_eventBus.removeListener(XVM_EVENT.SYSTEM_MESSAGE, g_xvm.onSystemMessage)
    g_eventBus.removeListener(events.AppLifeCycleEvent.INITIALIZED, g_xvm.onAppInitialized)
    g_eventBus.removeListener(events.AppLifeCycleEvent.DESTROYED, g_xvm.onAppDestroyed)
    g_eventBus.removeListener(XVM_EVENT.XMQP_CONNECTED, xmqp_events.onXmqpConnected)
    g_eventBus.removeListener(XVM_EVENT.XMQP_MESSAGE, xmqp_events.onXmqpMessage)

    filecache.fin()


#####################################################################
# handlers

# GLOBAL

@registerEvent(game, 'handleKeyEvent')
def game_handleKeyEvent(event):
    g_xvm.onKeyEvent(event)

@registerEvent(SFApplication, 'as_updateStageS')
def SFApplication_as_updateStageS(*args, **kwargs):
    g_xvm.onUpdateStage()

@overrideMethod(MessageDecorator, 'getListVO')
def _NotificationDecorator_getListVO(base, self):
    return svcmsg.fixData(base(self))

@overrideMethod(NotificationsActionsHandlers, 'handleAction')
def _NotificationsActionsHandlers_handleAction(base, self, model, typeID, entityID, actionName):
    if typeID == NOTIFICATION_TYPE.MESSAGE and re.match('https?://', actionName, re.I):
        BigWorld.wg_openWebBrowser(actionName)
    else:
        base(self, model, typeID, entityID, actionName)


# LOGIN

def onClientVersionDiffers():
    savedValue = g_replayCtrl.scriptModalWindowsEnabled
    g_replayCtrl.scriptModalWindowsEnabled = savedValue and not config.get('login/confirmOldReplays')
    g_replayCtrl.onClientVersionDiffers()
    g_replayCtrl.scriptModalWindowsEnabled = savedValue

g_replayCtrl._BattleReplay__replayCtrl.clientVersionDiffersCallback = onClientVersionDiffers


# LOBBY

@overrideMethod(ProfileTechniqueWindow, 'requestData')
def ProfileTechniqueWindow_RequestData(base, self, data):
    if data.vehicleId:
        base(self, data)


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

log("xvm %s (%s) for WoT %s" % (XFW_MOD_INFO['VERSION'], XFW_MOD_INFO['URL'], ", ".join(XFW_MOD_INFO['GAME_VERSIONS'])))
try:
    from __version__ import __branch__, __revision__
    log("Branch: %s, Revision: %s" % (__branch__, __revision__))
    xvm_fonts_arr = glob(os.environ['WINDIR'] + '/Fonts/*xvm*')
    if len(xvm_fonts_arr):
        warn('Following XVM fonts installed: %s' % xvm_fonts_arr)
except Exception, ex:
    err(traceback.format_exc())

# load config
config.load(events.HasCtxEvent(XVM_EVENT.RELOAD_CONFIG, {'filename':XVM.CONFIG_FILE}))
