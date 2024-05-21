"""
SPDX-License-Identifier: GPL-3.0-or-later
Copyright (c) 2013-2024 XVM Contributors
Copyright (c) 2020 Andrii Andrushchyshyn
"""

#
# Imports
#

# WoT
from gui.Scaleform.daapi.view.lobby.header import battle_selector_items
from gui.Scaleform.daapi.view.lobby.header.LobbyHeader import LobbyHeader
from gui.shared import g_eventBus, events

# XFW
from xfw_actionscript.python import as_xfw_cmd
from xfw.events import *

# XVM
import xvm_main.python.config as config
import xvm_main.python.userprefs as userprefs



#
# Globals
#

g_controller = None



#
# Classes/BattleType (persist logic)
#

class XVM_Hangar_BattleType(object):

    def __init__(self):
        self._userpref = "users/{accountDBID}/last_battle_type"

    def init(self):
        g_eventBus.addListener(events.GUICommonEvent.LOBBY_VIEW_LOADED, self.changeMode)

    def fini(self):
        g_eventBus.removeListener(events.GUICommonEvent.LOBBY_VIEW_LOADED, self.changeMode)

    def changeMode(self, *a, **kw):
        if config.get('hangar/restoreBattleType', False):
            actionName = userprefs.get(self._userpref, None)
            if actionName is not None:
                battle_selector_items.getItems().select(actionName)


#
# Handlers
#

def select(self, action, onlyActive=False):
    if config.get('hangar/restoreBattleType', False) and self.isSelected(action):
        userprefs.set(g_controller._userpref, action)


# needed for {{battleType}} macro
def _LobbyHeader_as_updateBattleTypeS(base, self, battleTypeName, battleTypeIcon, isEnabled, tooltip, tooltipType, battleTypeID, eventBgEnabled, eventAnimEnabled, showLegacySelector, hasNew):
    base(self, battleTypeName, battleTypeIcon, isEnabled, tooltip, tooltipType, battleTypeID, eventBgEnabled, eventAnimEnabled, showLegacySelector, hasNew)
    as_xfw_cmd('xvm_hangar.as_update_battle_type', battleTypeID)



#
# Submodule lifecycle
#

def init():
    global g_controller

    g_controller = XVM_Hangar_BattleType()
    g_controller.init()
    registerEvent(battle_selector_items._BattleSelectorItems, 'select')(select)
    overrideMethod(LobbyHeader, 'as_updateBattleTypeS')(_LobbyHeader_as_updateBattleTypeS)


def fini():
    global g_controller

    g_controller.fini()
    g_controller = None
