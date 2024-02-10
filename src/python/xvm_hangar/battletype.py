"""
SPDX-License-Identifier: GPL-3.0-or-later
Copyright (c) 2013-2024 XVM Contributors
Copyright (c) 2020 Andrii Andrushchyshyn
"""

#Python
import logging

# WoT
from gui.Scaleform.daapi.view.lobby.header import battle_selector_items
from gui.Scaleform.daapi.view.lobby.header.LobbyHeader import LobbyHeader
from gui.shared import g_eventBus, events

#XFW
from xfw_actionscript.python import as_xfw_cmd
from xfw.events import *

#XVM
import xvm_main.python.config as config
import xvm_main.python.userprefs as userprefs


class XVM_Hangar_BattleType(object):

    def __init__(self):
        self._userpref = "users/{accountDBID}/last_battle_type"
        g_eventBus.addListener(events.GUICommonEvent.LOBBY_VIEW_LOADED, self.changeMode)

    def changeMode(self, *a, **kw):
        if config.get('hangar/restoreBattleType', False):
            actionName = userprefs.get(self._userpref, None)
            if actionName is not None:
                battle_selector_items.getItems().select(actionName)

g_xvm_hangar_battle_type = XVM_Hangar_BattleType()

@registerEvent(battle_selector_items._BattleSelectorItems, 'select')
def select(self, action, onlyActive=False):
    if config.get('hangar/restoreBattleType', False) and self.isSelected(action):
        userprefs.set(g_xvm_hangar_battle_type._userpref, action)

#needed for {{battleType}} macro
@overrideMethod(LobbyHeader, 'as_updateBattleTypeS')
def _LobbyHeader_as_updateBattleTypeS(base, self, battleTypeName, battleTypeIcon, isEnabled, tooltip, tooltipType, battleTypeID, eventBgEnabled, eventAnimEnabled, showLegacySelector, hasNew):
    base(self, battleTypeName, battleTypeIcon, isEnabled, tooltip, tooltipType, battleTypeID, eventBgEnabled, eventAnimEnabled, showLegacySelector, hasNew)
    as_xfw_cmd('xvm_hangar.as_update_battle_type', battleTypeID)
