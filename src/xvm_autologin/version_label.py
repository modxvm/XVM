"""
SPDX-License-Identifier: GPL-3.0-or-later
Copyright (c) 2013-2025 XVM Contributors
"""

#
# Imports
#

# BigWorld
from gui.Scaleform.daapi.view.login.LoginView import LoginView

# XFW
from xfw import *

# XVM Main
import xvm_main.config as config



#
# Handlers
#

def LoginView_as_setVersionS(base, self, version):
    base(self, '{} | XVM {}'.format(version, config.get('__xvmVersion')))



#
# Initialization
#

def init():
    overrideMethod(LoginView, 'as_setVersionS')(LoginView_as_setVersionS)


def fini():
    pass
