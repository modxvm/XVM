""" XVM (c) https://modxvm.com 2013-2018 """

#####################################################################
# imports

from pprint import pprint
from glob import glob
import os
import re
import time
import traceback

import BigWorld
import ResMgr
import game
from account_helpers.settings_core import settings_constants
from account_helpers.settings_core.options import SettingsContainer
from Avatar import PlayerAvatar
from BattleReplay import g_replayCtrl
from PlayerEvents import g_playerEvents
from notification.actions_handlers import NotificationsActionsHandlers
from notification.decorators import MessageDecorator
from notification.settings import NOTIFICATION_TYPE
from gui.app_loader import g_appLoader
from gui.app_loader.settings import GUI_GLOBAL_SPACE_ID
from gui.shared import g_eventBus, events
from gui.Scaleform.framework.application import AppEntry
from gui.Scaleform.daapi.view.lobby.profile.ProfileTechniqueWindow import ProfileTechniqueWindow
from gui.Scaleform.daapi.view.lobby.hangar.AmmunitionPanel import AmmunitionPanel
from helpers import dependency, VERSION_FILE_PATH

from xfw import *

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

    g_appLoader.onGUISpaceEntered += g_xvm.onGUISpaceEntered

    g_eventBus.addListener(XFW_COMMAND.XFW_CMD, g_xvm.onXfwCommand)
    g_eventBus.addListener(XFW_EVENT.APP_INITIALIZED, g_xvm.onAppInitialized)
    g_eventBus.addListener(XFW_EVENT.APP_DESTROYED, g_xvm.onAppDestroyed)
    g_eventBus.addListener(XVM_EVENT.RELOAD_CONFIG, config.load)
    g_eventBus.addListener(XVM_EVENT.CONFIG_LOADED, g_xvm.onConfigLoaded)
    g_eventBus.addListener(XVM_EVENT.SYSTEM_MESSAGE, g_xvm.onSystemMessage)

    # config already loaded, just send event to apply required code
    g_eventBus.handleEvent(events.HasCtxEvent(XVM_EVENT.CONFIG_LOADED, {'fromInitStage':True}))

BigWorld.callback(0, start)

@registerEvent(game, 'fini')
def fini():
    debug('fini')

    g_appLoader.onGUISpaceEntered -= g_xvm.onGUISpaceEntered

    g_eventBus.removeListener(XFW_COMMAND.XFW_CMD, g_xvm.onXfwCommand)
    g_eventBus.removeListener(XFW_EVENT.APP_INITIALIZED, g_xvm.onAppInitialized)
    g_eventBus.removeListener(XFW_EVENT.APP_DESTROYED, g_xvm.onAppDestroyed)
    g_eventBus.removeListener(XVM_EVENT.RELOAD_CONFIG, config.load)
    g_eventBus.removeListener(XVM_EVENT.CONFIG_LOADED, g_xvm.onConfigLoaded)
    g_eventBus.removeListener(XVM_EVENT.SYSTEM_MESSAGE, g_xvm.onSystemMessage)


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
    if typeID == NOTIFICATION_TYPE.MESSAGE and re.match('https?://', actionName, re.I):
        BigWorld.wg_openWebBrowser(actionName)
    else:
        base(self, model, typeID, entityID, actionName)


# LOGIN

def onClientVersionDiffers():
    if BigWorld.wg_isFpsInfoStoreEnabled():
        BigWorld.wg_markFpsStoreFileAsFailed(g_replayCtrl._BattleReplay__fileName)
        g_replayCtrl._BattleReplay__onClientVersionConfirmDlgClosed(False)
        return
    if not (g_replayCtrl.scriptModalWindowsEnabled and not config.get('login/confirmOldReplays')):
        g_replayCtrl._BattleReplay__onClientVersionConfirmDlgClosed(True)
        return
    g_appLoader.onGUISpaceEntered += g_replayCtrl._BattleReplay__onGUISpaceEntered
    g_appLoader.showLogin()

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

log("XVM: eXtended Visualization Mod ( https://modxvm.com/ )")

try:
    from datetime import datetime
    from __version__ import __branch__, __revision__, __node__

    wot_ver = ResMgr.openSection(VERSION_FILE_PATH).readString('version')
    if 'Supertest v.ST ' in wot_ver:
        wot_ver = wot_ver.replace('Supertest v.ST ', 'v.')
    wot_ver = wot_ver[2:wot_ver.index('#') - 1]
    wot_ver = wot_ver if not ' ' in wot_ver else wot_ver[:wot_ver.index(' ')]  # X.Y.Z or X.Y.Z.a

    log("    XVM Version   : %s" % XVM.XVM_VERSION)
    log("    XVM Revision  : %s" % __revision__)
    log("    XVM Branch    : %s" % __branch__)
    log("    XVM Hash      : %s" % __node__)
#    log("    WoT Supported : %s" % ", ".join(XFW_MOD_INFO['GAME_VERSIONS']))
    log("    WoT Current   : %s" % wot_ver)
    log("    Current Time  : %s %+05d" % (datetime.now().strftime('%Y-%m-%d %H:%M:%S'),
        round((round((datetime.now()-datetime.utcnow()).total_seconds())/1800)/2) * 100))

    xvm_fonts_arr = glob(os.environ['WINDIR'] + '/Fonts/*xvm*')
    if len(xvm_fonts_arr):
        warn('Following XVM fonts installed: %s' % xvm_fonts_arr)

    log("---------------------------")
except Exception, ex:
    err(traceback.format_exc())

# load config
config.load(events.HasCtxEvent(XVM_EVENT.RELOAD_CONFIG, {'filename':XVM.CONFIG_FILE}))
