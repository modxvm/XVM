""" XVM (c) https://modxvm.com 2013-2021 """

#####################################################################
# imports

import traceback

import BigWorld
from gui.Scaleform.daapi.view.login.LoginView import LoginView
from gui.login.Manager import Manager
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
    if not isReplay():
        global firsttime
        if firsttime:
            firsttime = False
            if config.get('login/autologin'):
                BigWorld.callback(0, self.as_doAutoLoginS)

@overrideMethod(Manager, 'tryWgcLogin')
def tryWgcLogin(base, self, serverName=None):
    if not serverName and not config.get('login/autologin'):
        return
    base(self, serverName)
