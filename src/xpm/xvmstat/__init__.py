""" xvm (c) sirmax 2013-2014 """

#####################################################################
# MOD INFO (mandatory)

XPM_MOD_VERSION    = "1.3.0"
XPM_MOD_URL        = "http://www.modxvm.com/"
XPM_MOD_UPDATE_URL = "http://www.modxvm.com/en/download-xvm/"
XPM_GAME_VERSIONS  = ["0.9.0"]

#####################################################################

from pprint import pprint
import time

import BigWorld
import GUI
from gui.shared import events

from xpm import *

from logger import *
from xvm import g_xvm
from websock import g_websock
import utils

_SWFS = [
    'Application.swf',
    'battle.swf',
    'VehicleMarkersManager.swf',
    ]

#####################################################################
# event handlers

def start():
    debug('start')
    import appstart
    from gui.shared import g_eventBus
    g_eventBus.addListener(events.GUICommonEvent.APP_STARTED, appstart.AppStarted)
    g_eventBus.addListener(events.ShowViewEvent.SHOW_LOBBY, g_xvm.onShowLobby)
    g_eventBus.addListener(events.ShowViewEvent.SHOW_LOGIN, g_xvm.onShowLogin)
    g_websock.start()

def fini():
    debug('fini')
    from gui.shared import g_eventBus
    g_eventBus.removeListener(events.GUICommonEvent.APP_STARTED, appstart.AppStarted)
    g_eventBus.removeListener(events.ShowViewEvent.SHOW_LOBBY, g_xvm.onShowLobby)
    g_eventBus.removeListener(events.ShowViewEvent.SHOW_LOGIN, g_xvm.onShowLogin)
    g_websock.stop()

def FlashInit(self, swf, className = 'Flash', args = None, path = None):
    self.swf = swf
    if self.swf not in _SWFS:
        return
    log("FlashInit: " + self.swf)
    self.addExternalCallback('xvm.cmd', lambda *args: g_xvm.onXvmCommand(self, *args))

def FlashBeforeDelete(self):
    if self.swf not in _SWFS:
        return
    log("FlashBeforeDelete: " + self.swf)
    self.removeExternalCallback('xvm.cmd')


def ProfileTechniqueWindowRequestData(base, self, data):
    if data.vehicleId:
        base(self, data)
#    else:
#        self.as_responseVehicleDossierS({})

def LoginView_onSetOptions(base, self, optionsList, host):
    log('LoginView_onSetOptions')
    if g_xvm.config os None or not g_xvm.config['login']['saveLastServer']:
        base(self, optionsList, host)
    else:
        options = []
        selectedId = 0
        searchForHost = host
        for idx, (key, name) in enumerate(optionsList):
            if key == searchForHost:
                selectedId = idx
            options.append({'data': key, 'label': name})
        self.as_setServersListS(options, selectedId)

#####################################################################
# Register events

# Early registration
from gui.Scaleform.Flash import Flash
RegisterEvent(Flash, '__init__', FlashInit)
RegisterEvent(Flash, 'beforeDelete', FlashBeforeDelete)

# Delayed registration
def _RegisterEvents():
    import game
    start()
    RegisterEvent(game, 'fini', fini)
    RegisterEvent(game, 'handleKeyEvent', g_xvm.onKeyDown)

    from gui.Scaleform.daapi.view.lobby.profile import ProfileTechniqueWindow
    OverrideMethod(ProfileTechniqueWindow, 'requestData', ProfileTechniqueWindowRequestData)

    from gui.Scaleform.daapi.view.login import LoginView
    OverrideMethod(LoginView, 'onSetOptions', LoginView_onSetOptions)

BigWorld.callback(0.001, _RegisterEvents)
