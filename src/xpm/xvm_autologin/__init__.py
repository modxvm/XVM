""" XVM (c) https://modxvm.com 2013-2021 """

#####################################################################
# imports

import traceback

import BigWorld
from gui.Scaleform.daapi.view.login.LoginView import LoginView
from xfw import *

from xvm_main.python.logger import *
import xvm_main.python.config as config


#####################################################################
# handlers

firsttime = True

@overrideMethod(LoginView, 'as_setVersionS')
def LoginView_as_setVersionS(base, self, version):
    base(self, '{} | XVM {} (WoT {})'.format(version, config.get('__xvmVersion'), config.get('__wotVersion')))

@overrideMethod(LoginView, '_populate')
def LoginView_populate(base, self):
    base(self)
    if not isReplay() and not self.loginManager.wgcAvailable:
        global firsttime
        if firsttime:
            firsttime = False
            if config.get('login/autologin'):
                BigWorld.callback(0, self.as_doAutoLoginS)
