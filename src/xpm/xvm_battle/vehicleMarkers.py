""" XVM (c) www.modxvm.com 2013-2017 """

#####################################################################
# imports

import traceback
import weakref
import time

import BigWorld
import constants
import game
from Avatar import PlayerAvatar
from messenger import MessengerEntry
from helpers import dependency
from skeletons.gui.battle_session import IBattleSessionProvider
from gui.shared import g_eventBus, events
from gui.app_loader.settings import GUI_GLOBAL_SPACE_ID
from gui.Scaleform.daapi.view.battle.shared.markers2d.manager import MarkersManager

from xfw import *
from xvm_main.python.consts import *
from xvm_main.python.logger import *
import xvm_main.python.config as config
import xvm_main.python.python_macro as python_macro
import xvm_main.python.stats as stats
import xvm_main.python.utils as utils
import xvm_main.python.vehinfo as vehinfo

from consts import *
import shared


#####################################################################
# initialization/finalization

def onConfigLoaded(e=None):
    g_markers.enabled = config.get('markers/enabled', True)
    g_markers.respondConfig()

def onArenaInfoInvalidated(e=None):
    g_markers.updatePlayerStates()

g_eventBus.addListener(XVM_EVENT.CONFIG_LOADED, onConfigLoaded)
g_eventBus.addListener(XVM_BATTLE_EVENT.ARENA_INFO_INVALIDATED, onArenaInfoInvalidated)

@registerEvent(game, 'fini')
def fini():
    g_eventBus.removeListener(XVM_EVENT.CONFIG_LOADED, onConfigLoaded)
    g_eventBus.removeListener(XVM_BATTLE_EVENT.ARENA_INFO_INVALIDATED, onArenaInfoInvalidated)

@registerEvent(game, 'handleKeyEvent')
def game_handleKeyEvent(event):
    g_markers.onKeyEvent(event)

@overrideMethod(PlayerAvatar, 'onBecomePlayer')
def _PlayerAvatar_onBecomePlayer(base, self):
    base(self)
    try:
        player = BigWorld.player()
        if player is not None and hasattr(player, 'arena'):
            arena = BigWorld.player().arena
            if arena:
                arena.onVehicleStatisticsUpdate += g_markers.onVehicleStatisticsUpdate
    except Exception, ex:
        err(traceback.format_exc())

@overrideMethod(PlayerAvatar, 'onBecomeNonPlayer')
def _PlayerAvatar_onBecomeNonPlayer(base, self):
    try:
        player = BigWorld.player()
        if player is not None and hasattr(player, 'arena'):
            arena = BigWorld.player().arena
            if arena:
                arena.onVehicleStatisticsUpdate -= g_markers.onVehicleStatisticsUpdate
    except Exception, ex:
        err(traceback.format_exc())
    base(self)

# on any player marker appear
@registerEvent(PlayerAvatar, 'vehicle_onEnterWorld')
def _PlayerAvatar_vehicle_onEnterWorld(self, vehicle):
    g_markers.updatePlayerState(vehicle.id, INV.ALL)


#####################################################################
# handlers

# VMM

@overrideMethod(MarkersManager, '__init__')
def _MarkersManager__init__(base, self):
    base(self)
    g_markers.init(self)

@overrideMethod(MarkersManager, 'beforeDelete')
def _MarkersManager_beforeDelete(base, self):
    g_markers.destroy()
    base(self)

@overrideMethod(MarkersManager, 'createMarker')
def _MarkersManager_createMarker(base, self, symbol, *args, **kwargs):
    if g_markers.active:
        if symbol == 'VehicleMarker':
            symbol = 'com.xvm.vehiclemarkers.ui::XvmVehicleMarker'
    #debug('createMarker: ' + str(symbol))
    handle = base(self, symbol, *args, **kwargs)
    return handle

_exInfo = False
@overrideMethod(MarkersManager, 'as_setShowExInfoFlagS')
def _MarkersManager_as_setShowExInfoFlagS(base, self, flag):
    if g_markers.active and config.get('hotkeys/markersAltMode/enabled'):
        global _exInfo
        if config.get('hotkeys/markersAltMode/onHold'):
            _exInfo = flag
        elif flag:
            _exInfo = not _exInfo
        base(self, _exInfo)
    else:
        base(self, flag)

def as_xvm_cmdS(self, *args):
    if self._isDAAPIInited():
        return self.flashObject.as_xvm_cmd(*args)
MarkersManager.as_xvm_cmdS = as_xvm_cmdS

#####################################################################
# VehicleMarkers

class VehicleMarkers(object):

    enabled = True
    initialized = False
    guiType = None
    playerVehicleID = None
    manager = None
    vehiclesData = None
    sessionProvider = dependency.descriptor(IBattleSessionProvider)
    pending_commands = []

    @property
    def active(self):
        return self.enabled and self.initialized and (self.guiType != constants.ARENA_GUI_TYPE.TUTORIAL)

    @property
    def plugins(self):
        return self.manager._MarkersManager__plugins if self.manager else None

    def init(self, manager):
        self.manager = manager
        self.manager.addExternalCallback('xvm.cmd', self.onVMCommand)
        self.playerVehicleID = self.sessionProvider.getArenaDP().getPlayerVehicleID()

    def destroy(self):
        self.pending_commands = []
        self.initialized = False
        self.guiType = None
        self.playerVehicleID = None
        self.manager.removeExternalCallback('xvm.cmd')
        self.manager = None

    #####################################################################
    # event handlers

    def onVehicleStatisticsUpdate(self, vehicleID):
        # HACK: add delay to make statistics update after health update
        BigWorld.callback(0.01, lambda: self.updatePlayerState(vehicleID, INV.FRAGS))


    #####################################################################
    # onVMCommand

    # returns: (result, status)
    def onVMCommand(self, cmd, *args):
        try:
            if cmd == XVM_VM_COMMAND.LOG:
                log(*args)
            elif cmd == XVM_VM_COMMAND.INITIALIZED:
                self.initialized = True
                self.guiType = BigWorld.player().arena.guiType
                log('[VM]    initialized')
            elif cmd == XVM_COMMAND.REQUEST_CONFIG:
                self.respondConfig()
            elif cmd == XVM_BATTLE_COMMAND.REQUEST_BATTLE_GLOBAL_DATA:
                self.respondGlobalBattleData()
            elif cmd == XVM_COMMAND.PYTHON_MACRO:
                self.call(XVM_VM_COMMAND.AS_CMD_RESPONSE, python_macro.process_python_macro(args[0]))
            elif cmd == XVM_COMMAND.GET_CLAN_ICON:
                self.call(XVM_VM_COMMAND.AS_CMD_RESPONSE, stats.getClanIcon(int(args[0])))
            elif cmd == XVM_COMMAND.LOAD_STAT_BATTLE:
                stats.getBattleStat(args, self.call)
            # profiler
            elif cmd in (XVM_PROFILER_COMMAND.BEGIN, XVM_PROFILER_COMMAND.END):
                g_eventBus.handleEvent(events.HasCtxEvent(cmd, args[0]))
            else:
                warn('Unknown command: {}'.format(cmd))
        except Exception, ex:
            err(traceback.format_exc())
        return None

    def call(self, *args):
        try:
            if self.manager and self.initialized:
                self.manager.as_xvm_cmdS(*args)
            elif self.enabled:
                self.pending_commands.append(args)
        except Exception, ex:
            err(traceback.format_exc())

    def respondConfig(self):
        #debug('vm:respondConfig')
        #s = time.clock()
        try:
            if self.initialized:
                if self.active:
                    self.call(
                        XVM_COMMAND.AS_SET_CONFIG,
                        config.config_data,
                        config.lang_data,
                        vehinfo.getVehicleInfoDataArray(),
                        config.networkServicesSettings.__dict__,
                        IS_DEVELOPMENT)
                else:
                    self.call(
                        XVM_COMMAND.AS_SET_CONFIG,
                        {'markers':{'enabled':False}},
                        {'locale':{}},
                        None,
                        None,
                        IS_DEVELOPMENT)
                self.recreateMarkers()
        except Exception, ex:
            err(traceback.format_exc())
        #debug('vm:respondConfig: {:>8.3f} s'.format(time.clock() - s))

    def respondGlobalBattleData(self):
        #s = time.clock()
        try:
            if self.active:
                self.call(XVM_BATTLE_COMMAND.AS_RESPONSE_BATTLE_GLOBAL_DATA, *shared.getGlobalBattleData())
                self.process_pending_commands()
                self.updatePlayerStates()
        except Exception, ex:
            err(traceback.format_exc())
        #debug('vm:respondGlobalBattleData: {:>8.3f} s'.format(time.clock() - s))

    def process_pending_commands(self):
        for args in self.pending_commands:
            #debug('pending_command: ' + str(args))
            self.call(*args)
        self.pending_commands = []

    def onKeyEvent(self, event):
        try:
            if not event.isRepeatedEvent():
                if self.active and not MessengerEntry.g_instance.gui.isFocused():
                    self.call(XVM_COMMAND.AS_ON_KEY_EVENT, event.key, event.isKeyDown())
        except Exception, ex:
            err(traceback.format_exc())

    def updatePlayerStates(self):
        for vehicleID, vData in BigWorld.player().arena.vehicles.iteritems():
            g_markers.updatePlayerState(vehicleID, INV.ALL)

    def updatePlayerState(self, vehicleID, targets, userData=None):
        try:
            if self.active:
                data = {}

                if targets & INV.ALL_ENTITY:
                    entity = BigWorld.entity(vehicleID)

                    if targets & INV.MARKS_ON_GUN:
                        if entity and hasattr(entity, 'publicInfo'):
                            data['marksOnGun'] = entity.publicInfo.marksOnGun

                if targets & (INV.ALL_VINFO | INV.ALL_VSTATS):
                    arenaDP = self.sessionProvider.getArenaDP()
                    if targets & INV.ALL_VSTATS:
                        vStatsVO = arenaDP.getVehicleStats(vehicleID)

                    if targets & INV.FRAGS:
                        data['frags'] = vStatsVO.frags

                if data:
                    self.call(XVM_BATTLE_COMMAND.AS_UPDATE_PLAYER_STATE, vehicleID, data)
        except Exception, ex:
            err(traceback.format_exc())

    def recreateMarkers(self):
        #s = time.clock()
        try:
            if self.plugins:
                plugin = self.plugins.getPlugin('vehicles')
                if plugin:
                    arenaDP = self.sessionProvider.getArenaDP()
                    for vInfo in arenaDP.getVehiclesInfoIterator():
                        vehicleID = vInfo.vehicleID
                        if vehicleID == self.playerVehicleID or vInfo.isObserver():
                            continue
                        plugin._destroyVehicleMarker(vInfo.vehicleID)
                        plugin.addVehicleInfo(vInfo, arenaDP)
        except Exception, ex:
            err(traceback.format_exc())
        #debug('vm:recreateMarkers: {:>8.3f} s'.format(time.clock() - s))

g_markers = VehicleMarkers()
