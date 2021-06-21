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

#
# Imports
#

import re

import BigWorld

from Avatar import PlayerAvatar
from BattleReplay import g_replayCtrl
import game
from gui.Scaleform.daapi.view.lobby.profile.ProfileTechniqueWindow import ProfileTechniqueWindow
from gui.shared import g_eventBus, events
from notification.actions_handlers import NotificationsActionsHandlers
from notification.decorators import MessageDecorator
from notification.settings import NOTIFICATION_TYPE
from PlayerEvents import g_playerEvents
from skeletons.gameplay import ReplayEventID

from xfw.events import registerEvent, overrideMethod

import config
from consts import XVM_EVENT
from gui.Scaleform.framework.application import AppEntry
from logger import trace
import svcmsg
from xvm import g_xvm

#
# Handlers
#

trace('xvm_main.python.handlers --> FILE START')

# Handlers / Global

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


# Handlers / Login

def onClientVersionDiffers():
    if not (g_replayCtrl.scriptModalWindowsEnabled and not config.get('login/confirmOldReplays')):
        g_replayCtrl.acceptVersionDiffering()
        return
    g_replayCtrl.gameplay.postStateEvent(ReplayEventID.REPLAY_VERSION_CONFIRMATION)

g_replayCtrl._BattleReplay__replayCtrl.clientVersionDiffersCallback = onClientVersionDiffers


# Handlers / Lobby

@overrideMethod(ProfileTechniqueWindow, 'requestData')
def ProfileTechniqueWindow_RequestData(base, self, vehicleId):
    if vehicleId:
        base(self, vehicleId)


# Handlers / PreBattle

def onArenaCreated():
    # debug('> onArenaCreated')
    g_xvm.onArenaCreated()

g_playerEvents.onArenaCreated += onArenaCreated

@overrideMethod(PlayerAvatar, 'onBecomePlayer')
def _PlayerAvatar_onBecomePlayer(base, self):
    trace('xvm_main.python.handlers::_PlayerAvatar_onBecomePlayer()')
    base(self)
    g_xvm.onBecomePlayer()

@overrideMethod(PlayerAvatar, 'onBecomeNonPlayer')
def _PlayerAvatar_onBecomeNonPlayer(base, self):
    trace('xvm_main.python.handlers::_PlayerAvatar_onBecomeNonPlayer()')
    g_xvm.onBecomeNonPlayer()
    base(self)
