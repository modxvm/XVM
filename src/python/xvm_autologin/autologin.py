"""
SPDX-License-Identifier: GPL-3.0-or-later
Copyright (c) 2013-2025 XVM Contributors
"""

#
# Imports
#

# BigWorld
import BigWorld
from gui.Scaleform.daapi.view.login.LoginView import LoginView

# XFW
from xfw import *

# XVM Main
import xvm_main.python.config as config



#
# Globals
#

__firsttime = True



#
# Handlers
#

def LoginView_populate(base, self):
    base(self)
    gcAvailable = self.loginManager.wgcAvailable if IS_WG else self.loginManager.lgcAvailable
    if not isReplay() and not gcAvailable:
        global __firsttime
        if __firsttime:
            __firsttime = False
            if config.get('login/autologin'):
                BigWorld.callback(0, self.as_doAutoLoginS)



#
# Initialization
#

def init():
    overrideMethod(LoginView, '_populate')(LoginView_populate)

def fini():
    pass
