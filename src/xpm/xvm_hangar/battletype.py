""" XVM (c) https://modxvm.com 2013-2020 """

import traceback

import BigWorld
from gui.prb_control.settings import PREBATTLE_ACTION_NAME
from gui.Scaleform.daapi.view.lobby.header import battle_selector_items
from gui.Scaleform.daapi.view.lobby.header.LobbyHeader import LobbyHeader

from xfw import *
from xfw_actionscript.python import *

from xvm_main.python.logger import *
import xvm_main.python.config as config
import xvm_main.python.userprefs as userprefs

class USERPREFS(object):
    BATTLE_TYPE = "users/{accountDBID}/last_battle_type"

XVM_RESTORE_BATTLE_TYPES = [PREBATTLE_ACTION_NAME.RANDOM,
                            PREBATTLE_ACTION_NAME.RANKED,
                            PREBATTLE_ACTION_NAME.EPIC]

class COMMAND(object):
    AS_UPDATE_BATTLE_TYPE = 'xvm_hangar.as_update_battle_type'

_populated = False

@overrideMethod(LobbyHeader, '_populate')
def _LobbyHeader_populate(base, self):

    def _restore_battle_type(item):
        if not item.isDisabled() and not item.isSelected():
            debug('restore battle type: ' + item.getData())
            item.select()
        global _populated
        _populated = True

    base(self)

    if config.get('hangar/restoreBattleType', False):
        self._updatePrebattleControls()
        actionName = userprefs.get(USERPREFS.BATTLE_TYPE, None)
        if actionName and actionName in XVM_RESTORE_BATTLE_TYPES:
            _items = battle_selector_items.getItems()._BattleSelectorItems__items
            _extraItems = battle_selector_items.getItems()._BattleSelectorItems__extraItems
            items = dict(_items.items() + _extraItems.items())
            if actionName in items:
                item = items[actionName]
                BigWorld.callback(0, lambda: _restore_battle_type(item))
                return

    global _populated
    _populated = True

@overrideMethod(LobbyHeader, '_dispose')
def _LobbyHeader_dispose(base, self):
    global _populated
    _populated = False
    base(self)

@overrideMethod(LobbyHeader, '_LobbyHeader__handleFightButtonUpdated')
def _LobbyHeader__handleFightButtonUpdated(base, self, _):
    base(self, _)
    global _populated
    if _populated:
        if config.get('hangar/restoreBattleType', False):
            if self.prbDispatcher:
                selected = battle_selector_items.getItems().update(self.prbDispatcher.getFunctionalState())
                actionName = selected.getData()
                if actionName != userprefs.get(USERPREFS.BATTLE_TYPE, None):
                    debug('save battle type: ' + actionName)
                    userprefs.set(USERPREFS.BATTLE_TYPE, actionName)

#TODO: 1.10.0.4: Looks like it is needed and causes crashes
#@overrideMethod(LobbyHeader, 'as_updateBattleTypeS')
#def _LobbyHeader_as_updateBattleTypeS(base, self, battleTypeName, battleTypeIcon, isEnabled, tooltip, tooltipType, battleTypeID, eventBgEnabled, eventAnimEnabled):
#    base(self, battleTypeName, battleTypeIcon, isEnabled, tooltip, tooltipType, battleTypeID, eventBgEnabled, eventAnimEnabled)
#    as_xfw_cmd(COMMAND.AS_UPDATE_BATTLE_TYPE, battleTypeID)
