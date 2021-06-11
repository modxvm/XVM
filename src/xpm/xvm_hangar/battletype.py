"""
This file is part of the XVM project.

Copyright (c) 2013-2021 XVM Team.
Copyright (c) 2020      Andrey Andruschyshyn.

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
