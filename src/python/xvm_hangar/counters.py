"""
SPDX-License-Identifier: GPL-3.0-or-later
Copyright (c) 2013-2024 XVM Contributors
"""

#
# Imports
#

# WoT
from gui.Scaleform.daapi.view.lobby.customization.customization_bottom_panel import CustomizationBottomPanel
from gui.Scaleform.daapi.view.lobby.hangar.ammunition_panel import AmmunitionPanel
from gui.Scaleform.daapi.view.lobby.header.LobbyHeader import LobbyHeader
from gui.Scaleform.daapi.view.lobby.messengerBar.NotificationListButton import NotificationListButton
from notification.NotificationListView import NotificationListView

# XFW
from xfw import *

# XVM.Main
from xvm_main.python.logger import *
import xvm_main.python.config as config



#
# Handlers/Counters
#

def _LobbyHeader__setCounter(base, self, alias, counter=None):
    if config.get('hangar/notificationCounter/{0}'.format(alias), True):
        base(self, alias, counter)


def _AmmunitionPanel__applyCustomizationNewCounter(base, self, vehicle):
    if not config.get('hangar/showCustomizationCounter', True):
        return self.as_setCustomizationBtnCounterS(0)
    base(self, vehicle)


def _CustomizationBottomPanel__setNotificationCounters(base, self):
    if not config.get('hangar/showCustomizationCounter', True):
        tabsCounters = []
        return self.as_setNotificationCountersS({'tabsCounters': tabsCounters, 'switchersCounter': 0})
    base(self)


def _NotificationListButton__setState(base, self, count):
    if not config.get('hangar/showNotificationButtonCounter', True):
        return
    return base(self, count)


def _NotificationListView__updateCounters(base, self):
    if not config.get('hangar/showNotificationListCounters', True):
        return
    base(self)



#
# Submodule lifecycle
#

def init():
    overrideMethod(LobbyHeader, '_LobbyHeader__setCounter')(_LobbyHeader__setCounter)
    overrideMethod(AmmunitionPanel, '_AmmunitionPanel__applyCustomizationNewCounter')(_AmmunitionPanel__applyCustomizationNewCounter)
    overrideMethod(CustomizationBottomPanel, '_CustomizationBottomPanel__setNotificationCounters')(_CustomizationBottomPanel__setNotificationCounters)
    overrideMethod(NotificationListButton, '_NotificationListButton__setState')(_NotificationListButton__setState)
    overrideMethod(NotificationListView, '_NotificationListView__updateCounters')(_NotificationListView__updateCounters)


def fini():
    pass
