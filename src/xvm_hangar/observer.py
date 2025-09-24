"""
SPDX-License-Identifier: GPL-3.0-or-later
Copyright (c) 2013-2025 XVM Contributors
"""

#
# Imports
#

# stdlib
import logging

# BigWorld
from PlayerEvents import g_playerEvents
from gui.impl.lobby.maps_training.states import MapsTrainingState
from gui.lobby_state_machine.states import LobbyStateFlags
from gui.Scaleform.lobby_entry import getLobbyStateMachine
from gui.shared import g_eventBus
from gui.shared.events import GUICommonEvent
from last_stand.gui.impl.lobby.states import LastStandHangarState
from story_mode.gui.impl.lobby.states import StoryModeState
from white_tiger.gui.impl.lobby.states import WTHangarState

# XFW
from xfw import *

# XVM Actionscript
from xvm_actionscript import *

# XVM Main
from xvm_main.logger import *

# XVM Hangar
from xvm_hangar.consts import XVM_HANGAR_COMMAND



#
# Logger
#

_logger = logging.getLogger(__name__)



#
# Globals
#

g_observer = None



#
# Constants
#

EVENT_HANGAR_STATES = (
    StoryModeState,
    MapsTrainingState,
    LastStandHangarState,
    WTHangarState,
)



#
# Classes
#

class HangarStateObserver(object):

    def __init__(self):
        self._lsm = None
        self._isInHangar = False

    def init(self):
        self._lsm = getLobbyStateMachine()
        self._update(self._lsm.visibleRouteInfo)
        self._lsm.onVisibleRouteChanged += self.__onVisibleRouteChanged

    def fini(self):
        if self._lsm is not None:
            self._lsm.onVisibleRouteChanged -= self.__onVisibleRouteChanged
            self._lsm = None
        self._isInHangar = False

    def _update(self, routeInfo):
        state = routeInfo.state
        if state is None:
            return
        isInHangar = state.getFlags() & LobbyStateFlags.HANGAR
        isEvent = isinstance(state, EVENT_HANGAR_STATES)
        if isInHangar != self._isInHangar:
            self._isInHangar = isInHangar
            as_xfw_cmd(XVM_HANGAR_COMMAND.AS_UPDATE_HANGAR_STATE, self._isInHangar, isEvent)

    def __onVisibleRouteChanged(self, routeInfo):
        self._update(routeInfo)



#
# Handlers
#

def onLobbyViewLoaded(event):
    global g_observer
    g_observer.init()


def onAccountBecomeNonPlayer():
    global g_observer
    g_observer.fini()



#
# Submodule lifecycle
#

def init():
    global g_observer
    g_observer = HangarStateObserver()

    g_eventBus.addListener(GUICommonEvent.LOBBY_VIEW_LOADED, onLobbyViewLoaded)
    g_playerEvents.onAccountBecomeNonPlayer += onAccountBecomeNonPlayer


def fini():
    global g_observer

    g_eventBus.removeListener(GUICommonEvent.LOBBY_VIEW_LOADED, onLobbyViewLoaded)
    g_playerEvents.onAccountBecomeNonPlayer -= onAccountBecomeNonPlayer

    g_observer.fini()
    g_observer = None
