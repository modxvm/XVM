""" xvm (c) sirmax 2013-2014 """

#####################################################################
# MOD INFO (mandatory)

XPM_MOD_VERSION    = "1.2.1"
XPM_MOD_URL        = "http://www.modxvm.com/"
XPM_MOD_UPDATE_URL = "http://www.modxvm.com/en/download-xvm/"
XPM_GAME_VERSIONS  = ["0.9.0"]

#####################################################################

from pprint import pprint
import time

import BigWorld
import GUI
from gui.shared import events
from gui.shared.event_bus import EVENT_BUS_SCOPE

from xpm import *

from logger import *
from xvm import g_xvm
from websock import g_webSock
import utils

_SWFS = [
    'Application.swf',
    'battle.swf',
    'VehicleMarkersManager.swf',
    ]

_APP_SWF = 'Application.swf'

#####################################################################
# event handlers

def start():
    debug('start')
    import appstart
    from gui.shared import g_eventBus
    g_eventBus.addListener(events.GUICommonEvent.APP_STARTED, appstart.AppStarted)
    g_eventBus.addListener(events.ShowViewEvent.SHOW_LOBBY, g_webSock.init)
    g_eventBus.addListener(events.ShowViewEvent.SHOW_LOGIN, g_webSock.stop)

def fini():
    debug('fini')
    from gui.shared import g_eventBus
    g_eventBus.removeListener(events.GUICommonEvent.APP_STARTED, appstart.AppStarted)
    g_eventBus.removeListener(events.ShowViewEvent.SHOW_LOBBY, g_webSock.init)
    g_eventBus.removeListener(events.ShowViewEvent.SHOW_LOGIN, g_webSock.stop)
    g_webSock.stop()

def handleKeyEvent(event):
    g_xvm.onKeyDown(event)

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
    RegisterEvent(game, 'handleKeyEvent', handleKeyEvent)

    from gui.scaleform.daapi.view.lobby.profile import ProfileTechniqueWindow
    OverrideMethod(ProfileTechniqueWindow, 'requestData', ProfileTechniqueWindowRequestData)

BigWorld.callback(0.001, _RegisterEvents)
