""" XVM (c) www.modxvm.com 2013-2017 """

import traceback

from gui.Scaleform.daapi.view.meta.LobbyHeaderMeta import LobbyHeaderMeta

from xfw import *
from xvm_main.python.logger import *


class COMMANDS(object):
    AS_UPDATE_BATTLE_TYPE = 'xvm_hangar.as_update_battle_type'

@overrideMethod(LobbyHeaderMeta, 'as_updateBattleTypeS')
def _LobbyHeaderMeta_as_updateBattleTypeS(base, self, battleTypeName, battleTypeIcon, isEnabled, tooltip, tooltipType, battleTypeID, eventBgEnabled, eventAnimEnabled):
    base(self, battleTypeName, battleTypeIcon, isEnabled, tooltip, tooltipType, battleTypeID, eventBgEnabled, eventAnimEnabled)
    as_xfw_cmd(COMMANDS.AS_UPDATE_BATTLE_TYPE, battleTypeID)
