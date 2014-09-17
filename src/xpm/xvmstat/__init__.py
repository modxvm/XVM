""" XVM (c) www.modxvm.com 2013-2014 """

#####################################################################
# MOD INFO (mandatory)

XPM_MOD_VERSION    = "1.4.0"
XPM_MOD_URL        = "http://www.modxvm.com/"
XPM_MOD_UPDATE_URL = "http://www.modxvm.com/en/download-xvm/"
XPM_GAME_VERSIONS  = ["0.9.3"]

#####################################################################

from pprint import pprint
import time

import BigWorld
from gui.shared import events

from xpm import *

from logger import *
from xvm import g_xvm
from websock import g_websock
import utils

_APPLICATION_SWF = 'Application.swf'
_BATTLE_SWF = 'battle.swf'
_VMM_SWF = 'VehicleMarkersManager.swf'
_SWFS = [_APPLICATION_SWF, _BATTLE_SWF, _VMM_SWF]


#####################################################################
# event handlers

def start():
    debug('start')
    from gui.shared import g_eventBus
    g_eventBus.addListener(events.ShowViewEvent.SHOW_LOBBY, g_xvm.onShowLobby)
    g_eventBus.addListener(events.ShowViewEvent.SHOW_LOGIN, g_xvm.onShowLogin)
    g_websock.start()

def fini():
    debug('fini')
    from gui.shared import g_eventBus
    g_eventBus.removeListener(events.ShowViewEvent.SHOW_LOBBY, g_xvm.onShowLobby)
    g_eventBus.removeListener(events.ShowViewEvent.SHOW_LOGIN, g_xvm.onShowLogin)
    g_websock.stop()

def FlashInit(self, swf, className = 'Flash', args = None, path = None):
    self.swf = swf
    if self.swf not in _SWFS:
        return
    log("FlashInit: " + self.swf)
    self.addExternalCallback('xvm.cmd', lambda *args: g_xvm.onXvmCommand(self, *args))
    if self.swf == _APPLICATION_SWF:
        g_xvm.app = self
        g_xvm.initApplication()
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
    if self.swf == _APPLICATION_SWF:
        g_xvm.deleteApplication()
        g_xvm.app = None
    if self.swf == _BATTLE_SWF:
        g_xvm.battleFlashObject = None
    if self.swf == _VMM_SWF:
        g_xvm.vmmFlashObject = None

def Flash_call(base, self, methodName, args = None):
    #debug("> call: %s, %s" % (methodName, str(args)))
    base(self, methodName, g_xvm.extendInvokeArgs(self.swf, methodName, args))

def VehicleMarkersManager_invokeMarker(base, self, handle, function, args = None):
    #debug("> invokeMarker: %i, %s, %s" % (handle, function, str(args)))
    base(self, handle, function, g_xvm.extendVehicleMarkerArgs(handle, function, args))

def ProfileTechniqueWindowRequestData(base, self, data):
    if data.vehicleId:
        base(self, data)
#    else:
#        self.as_responseVehicleDossierS({})

def LoginView_onSetOptions(base, self, optionsList, host):
    #log('LoginView_onSetOptions')
    if g_xvm.config is not None and g_xvm.config['login']['saveLastServer']:
        self.saveLastSelectedServer(host)
    base(self, optionsList, host)

def onArenaCreated():
    #debug('> onArenaCreated')
    g_xvm.updateCurrentVehicle()

# on any player marker appear (spectators only)
def PlayerAvatar_vehicle_onEnterWorld(self, vehicle):
    #debug("> PlayerAvatar_vehicle_onEnterWorld: hp=%i" % vehicle.health)
    g_xvm.invalidateBattleState(vehicle)

# on any player marker lost
def PlayerAvatar_vehicle_onLeaveWorld(self, vehicle):
    #debug("> PlayerAvatar_vehicle_onLeaveWorld: hp=%i" % vehicle.health)
    g_xvm.invalidateBattleState(vehicle)

## on any vehicle health update
#def Vehicle_set_health(self, prev):
#    #debug("> Vehicle_set_health: %i, %i" % (self.health, prev))
#    g_xvm.invalidateBattleState(self)

# on any vehicle hit received
def Vehicle_onHealthChanged(self, newHealth, attackerID, attackReasonID):
    #debug("> Vehicle_onHealthChanged: %i, %i, %i" % (newHealth, attackerID, attackReasonID))
    g_xvm.invalidateBattleState(self)

def BattleArenaController_invalidateVehicleStatus(self, flags, vo, arenaDP):
    g_xvm.updateVehicleStatus(vo)

def BattleArenaController_invalidateVehicleStats(self, flags, vo, arenaDP):
    g_xvm.updateVehicleStats(vo)

def PreDefinedHostList_autoLoginQuery(base, callback):
    #debug('> PreDefinedHostList_autoLoginQuery')
    import pinger_wg
    if pinger_wg.request_sent:
        BigWorld.callback(0, lambda: PreDefinedHostList_autoLoginQuery(base, callback))
    else:
        #debug('login ping: start')
        pinger_wg.request_sent = True
        BigWorld.WGPinger.setOnPingCallback(PreDefinedHostList_onPingPerformed)
        base(callback)

def PreDefinedHostList_onPingPerformed(result):
    #debug('login ping: end')
    pinger_wg.request_sent = False
    from predefined_hosts import g_preDefinedHosts
    g_preDefinedHosts._PreDefinedHostList__onPingPerformed(result)

def AmmunitionPanel_highlightParams(self, type):
    #debug('> AmmunitionPanel_highlightParams')
    g_xvm.updateTankParams()

#####################################################################
# Register events

# Early registration
from gui.Scaleform.Flash import Flash
RegisterEvent(Flash, '__init__', FlashInit)
RegisterEvent(Flash, 'beforeDelete', FlashBeforeDelete)
OverrideMethod(Flash, 'call', Flash_call)

# Delayed registration
def _RegisterEvents():
    start()

    import game
    RegisterEvent(game, 'fini', fini)
    RegisterEvent(game, 'handleKeyEvent', g_xvm.onKeyEvent)

    from gui.Scaleform.Battle import VehicleMarkersManager
    OverrideMethod(VehicleMarkersManager, 'invokeMarker', VehicleMarkersManager_invokeMarker)

    from gui.Scaleform.daapi.view.lobby.profile import ProfileTechniqueWindow
    OverrideMethod(ProfileTechniqueWindow, 'requestData', ProfileTechniqueWindowRequestData)

    from gui.Scaleform.daapi.view.login import LoginView
    OverrideMethod(LoginView, 'onSetOptions', LoginView_onSetOptions)

    from PlayerEvents import g_playerEvents
    g_playerEvents.onArenaCreated += onArenaCreated

    from Avatar import PlayerAvatar
    RegisterEvent(PlayerAvatar, 'vehicle_onEnterWorld', PlayerAvatar_vehicle_onEnterWorld)
    RegisterEvent(PlayerAvatar, 'vehicle_onLeaveWorld', PlayerAvatar_vehicle_onLeaveWorld)

    from Vehicle import Vehicle
    #RegisterEvent(Vehicle, 'set_health', Vehicle_set_health, True)
    RegisterEvent(Vehicle, 'onHealthChanged', Vehicle_onHealthChanged)

    from gui.battle_control.battle_arena_ctrl import BattleArenaController
    RegisterEvent(BattleArenaController, 'invalidateVehicleStatus', BattleArenaController_invalidateVehicleStatus)
    RegisterEvent(BattleArenaController, 'invalidateVehicleStats', BattleArenaController_invalidateVehicleStats)

    # enable for pinger_wg
    #from predefined_hosts import g_preDefinedHosts
    #OverrideMethod(g_preDefinedHosts, 'autoLoginQuery', PreDefinedHostList_autoLoginQuery)

    from gui.Scaleform.daapi.view.lobby.hangar.AmmunitionPanel import AmmunitionPanel
    RegisterEvent(AmmunitionPanel, 'highlightParams', AmmunitionPanel_highlightParams)

BigWorld.callback(0, _RegisterEvents)
