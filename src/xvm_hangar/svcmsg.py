"""
SPDX-License-Identifier: GPL-3.0-or-later
Copyright (c) 2013-2025 XVM Contributors
"""

#
# Imports
#

# XFW
from xfw import *

# XVM.Main
import xvm_main.config as config
from xvm_main.logger import *



#
# Handlers
#

def _NotificationListButton_as_setStateS(base, self, isBlinking, counterValue):
    if not config.get('hangar/allowNotificationsButtonBlinking', True):
        isBlinking = False
    base(self, isBlinking, counterValue)



#
# Submodule lifecycle
#

def init():
    if IS_LESTA:
        from gui.Scaleform.daapi.view.lobby.messengerBar.NotificationListButton import NotificationListButton

        overrideMethod(NotificationListButton, 'as_setStateS')(_NotificationListButton_as_setStateS)


def fini():
    pass
