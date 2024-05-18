"""
SPDX-License-Identifier: GPL-3.0-or-later
Copyright (c) 2013-2024 XVM Contributors
"""

from gui.Scaleform.daapi.view.lobby.messengerBar.NotificationListButton import NotificationListButton

from xfw import *
import xvm_main.python.config as config
from xvm_main.python.logger import *


def _NotificationListButton_as_setStateS(base, self, isBlinking, counterValue):
    if not config.get('hangar/allowNotificationsButtonBlinking', True):
        isBlinking = False
    base(self, isBlinking, counterValue)


def init():
    overrideMethod(NotificationListButton, 'as_setStateS')(_NotificationListButton_as_setStateS)


def fini():
    pass
