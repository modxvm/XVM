"""
SPDX-License-Identifier: GPL-3.0-or-later
Copyright (c) 2013-2025 XVM Contributors
"""

#
# Imports
#

# BigWorld
from gui.impl.gen.view_models.views.lobby.crew.common.crew_books_button_model import CrewBooksButtonModel
from gui.Scaleform.daapi.view.lobby.customization.customization_bottom_panel import CustomizationBottomPanel
from gui.Scaleform.daapi.view.lobby.hangar.ammunition_panel import AmmunitionPanel
from gui.Scaleform.daapi.view.lobby.header.battle_selector_items import SelectorItem
from gui.Scaleform.daapi.view.lobby.LobbyMenu import LobbyMenu
from notification.NotificationListView import NotificationListView

# XFW
from xfw import *

# XVM.Main
from xvm_main.logger import *
import xvm_main.config as config



#
# Handlers/Counters
#

def _LobbyMenu__updateNewSettingsCount(base, self):
    if config.get('hangar/showLobbyMenuCounter', True):
        return base(self)


def LobbyHeader_as_updateBattleTypeS(base, self, battleTypeName, battleTypeIcon, isEnabled, tooltip, tooltipType, battleTypeID, eventAnimEnabled, eventBgLinkage, showLegacySelector, hasNew):
    if not config.get('hangar/showBattleSelectorCounter', True):
        hasNew = False
    return base(self, battleTypeName, battleTypeIcon, isEnabled, tooltip, tooltipType, battleTypeID, eventAnimEnabled, eventBgLinkage, showLegacySelector, hasNew)


def SelectorItem_isShowNewIndicator(base, self):
    if not config.get('hangar/showBattleSelectorCounter', True):
        return False
    return base(self)


def CrewBooksButtonModel_setNewAmount(base, self, value):
    # WG uses string to pass amount of new crew books
    # while Lesta uses number so lets deal with it smart way
    if not config.get('hangar/showNewCrewBooksCounter', True):
        value = '0' if isinstance(value, basestring) else 0
    base(self, value)


def _LobbyHeader__setCounter(base, self, alias, counter=None):
    if config.get('hangar/notificationCounter/{0}'.format(alias), True):
        base(self, alias, counter)


def _AmmunitionPanel__applyCustomizationNewCounter(base, self, vehicle):
    if not config.get('hangar/showCustomizationCounter', True):
        return self.as_setCustomizationBtnCounterS(0)
    base(self, vehicle)


def _CustomizationBottomPanel__setNotificationCounters(base, self):
    if not config.get('hangar/showCustomizationCounter', True):
        if IS_WG:
            return self.as_setNotificationCountersS({'tabsCounters': [], 'unseenTabs': []})
        else:
            return self.as_setNotificationCountersS({'tabsCounters': []})
    base(self)


def _NotificationsCenterPresenter__updateNotifiedMessagesCount(base, self):
    if not config.get('hangar/showNotificationButtonCounter', True):
        return
    base(self)


def _NotificationsCenterPresenter__onNotificationReceived(base, self, notification):
    if not config.get('hangar/showNotificationButtonCounter', True):
        return
    base(self, notification)


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
    overrideMethod(LobbyMenu, '_LobbyMenu__updateNewSettingsCount')(_LobbyMenu__updateNewSettingsCount)
    overrideMethod(SelectorItem, 'isShowNewIndicator')(SelectorItem_isShowNewIndicator)
    overrideMethod(CrewBooksButtonModel, 'setNewAmount')(CrewBooksButtonModel_setNewAmount)
    overrideMethod(AmmunitionPanel, '_AmmunitionPanel__applyCustomizationNewCounter')(_AmmunitionPanel__applyCustomizationNewCounter)
    overrideMethod(CustomizationBottomPanel, '_CustomizationBottomPanel__setNotificationCounters')(_CustomizationBottomPanel__setNotificationCounters)
    overrideMethod(NotificationListView, '_NotificationListView__updateCounters')(_NotificationListView__updateCounters)

    if IS_WG:
        from gui.impl.lobby.page.notifications_center_presenter import NotificationsCenterPresenter

        overrideMethod(NotificationsCenterPresenter, '_NotificationsCenterPresenter__updateNotifiedMessagesCount')(_NotificationsCenterPresenter__updateNotifiedMessagesCount)
        overrideMethod(NotificationsCenterPresenter, '_NotificationsCenterPresenter__onNotificationReceived')(_NotificationsCenterPresenter__onNotificationReceived)
    else:
        from gui.Scaleform.daapi.view.lobby.header.LobbyHeader import LobbyHeader
        from gui.Scaleform.daapi.view.lobby.messengerBar.NotificationListButton import NotificationListButton

        overrideMethod(LobbyHeader, 'as_updateBattleTypeS')(LobbyHeader_as_updateBattleTypeS)
        overrideMethod(LobbyHeader, '_LobbyHeader__setCounter')(_LobbyHeader__setCounter)
        overrideMethod(NotificationListButton, '_NotificationListButton__setState')(_NotificationListButton__setState)


def fini():
    pass
