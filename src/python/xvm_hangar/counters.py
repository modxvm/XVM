"""
SPDX-License-Identifier: GPL-3.0-or-later
Copyright (c) 2013-2024 XVM Contributors
"""

import traceback

from gui.Scaleform.daapi.view.lobby.header.LobbyHeader import LobbyHeader
from gui.Scaleform.daapi.view.lobby.hangar.ammunition_panel import AmmunitionPanel
from gui.Scaleform.daapi.view.lobby.customization.customization_bottom_panel import CustomizationBottomPanel

from xfw import *
from xvm_main.python.logger import *
import xvm_main.python.config as config

@overrideMethod(LobbyHeader, '_LobbyHeader__setCounter')
def _LobbyHeader__setCounter(base, self, alias, counter=None):
    if config.get('hangar/notificationCounter/{0}'.format(alias), True):
        base(self, alias, counter)

@overrideMethod(AmmunitionPanel, '_AmmunitionPanel__applyCustomizationNewCounter')
def __applyCustomizationNewCounter(base, self, vehicle):
    if not config.get('hangar/showCustomizationCounter', True):
        return self.as_setCustomizationBtnCounterS(0)
    base(self, vehicle)

@overrideMethod(CustomizationBottomPanel, '_CustomizationBottomPanel__setNotificationCounters')
def __setNotificationCounters(base, self):
    if not config.get('hangar/showCustomizationCounter', True):
        tabsCounters = []
        return self.as_setNotificationCountersS({'tabsCounters': tabsCounters, 'switchersCounter': 0})
    base(self)
