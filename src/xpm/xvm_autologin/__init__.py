""" XVM (c) www.modxvm.com 2013-2015 """

#####################################################################
# MOD INFO

XFW_MOD_INFO = {
    # mandatory
    'VERSION':       '3.1.0',
    'URL':           'http://www.modxvm.com/',
    'UPDATE_URL':    'http://www.modxvm.com/en/download-xvm/',
    'GAME_VERSIONS': ['0.9.9','0.9.10'],
    # optional
}

#####################################################################
# imports

import traceback

import BigWorld

from xfw import *

from xvm_main.python.logger import *
import xvm_main.python.config as config


#####################################################################
# handlers

firsttime = True

def IntroPage_showMovie(base, self, movie):
    if config.get('login/skipIntro'):
        self.stopVideo()
    return base(self, movie)


def LoginView_onSetOptions(self, optionsList, host):
    global firsttime
    if firsttime:
        firsttime = False
        if config.get('login/autologin'):
            BigWorld.callback(0, self.onDoAutoLogin)


def LoginView_as_setVersionS(base, self, version):
    base(self, '{} | XVM {} (WoT {})'.format(version, config.get('__xvmVersion'), config.get('__wotVersion')))


#####################################################################
# hooks

from gui.Scaleform.daapi.view.IntroPage import IntroPage
OverrideMethod(IntroPage, '_IntroPage__showMovie', IntroPage_showMovie)

from gui.Scaleform.daapi.view.login import LoginView
RegisterEvent(LoginView, 'onSetOptions', LoginView_onSetOptions)
OverrideMethod(LoginView, 'as_setVersionS', LoginView_as_setVersionS)
