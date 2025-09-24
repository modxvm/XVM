"""
SPDX-License-Identifier: GPL-3.0-or-later
Copyright (c) 2013-2025 XVM Contributors
Copyright (c) 2020 Andrii Andrushchyshyn
"""

#
# Imports
#

# stdlib
import logging

# BigWorld
from PlayerEvents import g_playerEvents
from gui.Scaleform.daapi.view.lobby.header import battle_selector_items
from gui.shared import g_eventBus, events

# XFW
from xfw import *

# XVM ActionScript
from xvm_actionscript import as_xfw_cmd

# XVM
import xvm_main.config as config
import xvm_main.userprefs as userprefs

# XVM Hangar
from xvm_hangar.consts import *



#
# Logger
#

_logger = logging.getLogger(__name__)



#
# Globals
#

_inLobby = False



#
# Handlers
#

def onLobbyViewLoaded(_):
    global _inLobby
    _inLobby = True
    if config.get('hangar/restoreBattleType', False):
        action = userprefs.get(USERPREFS.LAST_BATTLE_TYPE, None)
        if action is not None:
            battle_selector_items.getItems().select(action)


def onAccountBecomeNonPlayer():
    global _inLobby
    _inLobby = False


def _BattleSelectorItems_select(self, action, onlyActive=False):
    if config.get('hangar/restoreBattleType', False):
        userprefs.set(USERPREFS.LAST_BATTLE_TYPE, action)


# WG, needed for {{battleType}} macro
def _MainMenuModel_setModeId(self, battleTypeID):
    if config.get('hangar/restoreBattleType', False) and _inLobby:
        userprefs.set(USERPREFS.LAST_BATTLE_TYPE, battleTypeID)
    as_xfw_cmd(XVM_HANGAR_COMMAND.AS_UPDATE_BATTLE_TYPE, battleTypeID)


# Lesta, needed for {{battleType}} macro
def _LobbyHeader_as_updateBattleTypeS(self, battleTypeName, battleTypeIcon, isEnabled, tooltip, tooltipType, battleTypeID, eventBgEnabled, eventAnimEnabled, showLegacySelector, hasNew):
    if config.get('hangar/restoreBattleType', False) and _inLobby:
        userprefs.set(USERPREFS.LAST_BATTLE_TYPE, battleTypeID)
    as_xfw_cmd(XVM_HANGAR_COMMAND.AS_UPDATE_BATTLE_TYPE, battleTypeID)



#
# Submodule lifecycle
#

def init():
    g_eventBus.addListener(events.GUICommonEvent.LOBBY_VIEW_LOADED, onLobbyViewLoaded)
    g_playerEvents.onAccountBecomeNonPlayer += onAccountBecomeNonPlayer
    registerEvent(battle_selector_items._BattleSelectorItems, 'select')(_BattleSelectorItems_select)

    if IS_WG:
        from gui.impl.gen.view_models.views.lobby.hangar.main_menu_model import MainMenuModel

        registerEvent(MainMenuModel, 'setModeId')(_MainMenuModel_setModeId)
    else:
        from gui.Scaleform.daapi.view.lobby.header.LobbyHeader import LobbyHeader

        registerEvent(LobbyHeader, 'as_updateBattleTypeS')(_LobbyHeader_as_updateBattleTypeS)


def fini():
    g_eventBus.removeListener(events.GUICommonEvent.LOBBY_VIEW_LOADED, onLobbyViewLoaded)
    g_playerEvents.onAccountBecomeNonPlayer -= onAccountBecomeNonPlayer
