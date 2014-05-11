""" XVM (c) www.modxvm.com 2013-2014 """

#####################################################################
# MOD INFO (mandatory)

XPM_MOD_VERSION    = "1.3.1"
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

_BATTLE_SWF = 'battle.swf'
_VMM_SWF = 'VehicleMarkersManager.swf'

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
    if self.swf == _BATTLE_SWF:
        g_xvm.battleFlashObject = self
        g_xvm.initBattle()
    if self.swf == _VMM_SWF:
        g_xvm.vmmFlashObject = self
        g_xvm.initVmm()

def FlashBeforeDelete(self):
    if self.swf not in _SWFS:
        return
    log("FlashBeforeDelete: " + self.swf)
    self.removeExternalCallback('xvm.cmd')
    if self.swf == _BATTLE_SWF:
        g_xvm.battleFlashObject = None
    if self.swf == _VMM_SWF:
        g_xvm.vmmFlashObject = None


def ProfileTechniqueWindowRequestData(base, self, data):
    if data.vehicleId:
        base(self, data)
#    else:
#        self.as_responseVehicleDossierS({})

def LoginView_onSetOptions(base, self, optionsList, host):
    #log('LoginView_onSetOptions')
    if g_xvm.config is None or not g_xvm.config['login']['saveLastServer']:
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

# on any player marker appear (spectators only)
def PlayerAvatar_vehicle_onEnterWorld(self, vehicle):
    #debug("> PlayerAvatar_vehicle_onEnterWorld: hp=%i" % vehicle.health)
    g_xvm.updateBattleState(vehicle)

# on any player marker lost
def PlayerAvatar_vehicle_onLeaveWorld(self, vehicle):
    #debug("> PlayerAvatar_vehicle_onLeaveWorld: hp=%i" % vehicle.health)
    g_xvm.updateBattleState(vehicle)

# on any vehicle health update
def Vehicle_set_health(self, prev):
    #debug("> Vehicle_set_health: %i, %i" % (self.health, prev))
    g_xvm.updateBattleState(self)

# on any vehicle hit received
def Vehicle_onHealthChanged(self, newHealth, attackerID, attackReasonID):
    #debug("> Vehicle_onHealthChanged: %i, %i, %i" % (newHealth, attackerID, attackReasonID))
    g_xvm.updateBattleState(self)

def onArenaCreated():
    #debug('> onArenaCreated')
    g_xvm.updateCurrentVehicle()

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

    from Avatar import PlayerAvatar
    RegisterEvent(PlayerAvatar, 'vehicle_onEnterWorld', PlayerAvatar_vehicle_onEnterWorld)
    RegisterEvent(PlayerAvatar, 'vehicle_onLeaveWorld', PlayerAvatar_vehicle_onLeaveWorld)

    from PlayerEvents import g_playerEvents
    g_playerEvents.onArenaCreated += onArenaCreated

    from Vehicle import Vehicle
    #RegisterEvent(Vehicle, 'set_health', Vehicle_set_health, True)
    RegisterEvent(Vehicle, 'onHealthChanged', Vehicle_onHealthChanged)

BigWorld.callback(0, _RegisterEvents)
