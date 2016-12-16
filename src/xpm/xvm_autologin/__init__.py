""" XVM (c) www.modxvm.com 2013-2016 """

#####################################################################
# MOD INFO

XFW_MOD_INFO = {
    # mandatory
    'VERSION':       '0.9.17.0.1',
    'URL':           'http://www.modxvm.com/',
    'UPDATE_URL':    'http://www.modxvm.com/en/download-xvm/',
    'GAME_VERSIONS': ['0.9.17.0.1'],
    # optional
}

#####################################################################
# imports

import traceback

import BigWorld
from gui.Scaleform.daapi.view.login.IntroPage import IntroPage
from gui.Scaleform.daapi.view.login.LoginView import LoginView

from xfw import *

from xvm_main.python.logger import *
import xvm_main.python.config as config
import xvm_main.python.userprefs as userprefs


#####################################################################
# handlers

firsttime = True

@overrideMethod(LoginView, 'as_setVersionS')
def LoginView_as_setVersionS(base, self, version):
    base(self, '{} | XVM {} (WoT {})'.format(version, config.get('__xvmVersion'), config.get('__wotVersion')))


@overrideMethod(LoginView, '_populate')
def LoginView_populate(base, self):
    # log('LoginView_populate')

    if isReplay():
        base(self)
        return

    if config.get('login/saveLastServer'):
        if self._servers.selectedServerIdx == 0:
            serverName = userprefs.get('autologin/server', 0)

        for idx, value in enumerate(self._servers.serverList):
            if serverName == value['data']:
                self._servers._selectedServerIdx = idx
                break

    base(self)

    global firsttime
    if firsttime:
        firsttime = False
        if config.get('login/autologin'):
            BigWorld.callback(0, self.as_doAutoLoginS)

@registerEvent(LoginView, 'saveLastSelectedServer')
def LoginView_saveLastSelectedServer(self, server):
    if config.get('login/saveLastServer'):
        userprefs.set('autologin/server', server)
