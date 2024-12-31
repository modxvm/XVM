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
import xvm_main.python.config as config
from xvm_main.python.__version__ import __flavor__



#
# Handlers
#

def LoginView_as_setVersionS(base, self, version):
    targetGameShortName = 'WoT' if __flavor__ == 'wg' else 'MT'
    base(self, '{} | XVM {} ({} {})'.format(version, config.get('__xvmVersion'), targetGameShortName, config.get('__wotVersion')))



#
# Initialization
#

def init():
    overrideMethod(LoginView, 'as_setVersionS')(LoginView_as_setVersionS)


def fini():
    pass
