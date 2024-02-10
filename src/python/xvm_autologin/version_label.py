"""
SPDX-License-Identifier: GPL-3.0-or-later
Copyright (c) 2013-2024 XVM Contributors
"""

#
# Imports
#

# BigWorld
from gui.Scaleform.daapi.view.login.LoginView import LoginView

# XFW
from xfw.events import overrideMethod

# XVM Main
import xvm_main.python.config as config



#
# Handlers
#

def LoginView_as_setVersionS(base, self, version):
    base(self, '{} | XVM {} (WoT {})'.format(version, config.get('__xvmVersion'), config.get('__wotVersion')))



#
# Initialization
#

def init():
    overrideMethod(LoginView, 'as_setVersionS')(LoginView_as_setVersionS)


def fini():
    pass
