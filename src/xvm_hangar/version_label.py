"""
SPDX-License-Identifier: GPL-3.0-or-later
Copyright (c) 2013-2025 XVM Contributors
"""

#
# Imports
#

# BigWorld
from gui.Scaleform.daapi.view.lobby.LobbyMenu import LobbyMenu
from gui.shared.formatters import text_styles
from helpers import getClientVersion

# XFW
from xfw import *

# XVM Main
import xvm_main.config as config



#
# Handlers
#

def LobbyMenu_as_setVersionMessageS(base, self, version):
    currentGameShortName = 'WoT' if IS_WG else 'MT'
    base(self, text_styles.main('{} {} | XVM {} ( {})'.format(currentGameShortName, getClientVersion(), config.get('__xvmVersion'), config.get('__wotVersion'))))



#
# Initialization
#

def init():
    overrideMethod(LobbyMenu, 'as_setVersionMessageS')(LobbyMenu_as_setVersionMessageS)


def fini():
    pass
