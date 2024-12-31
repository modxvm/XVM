"""
SPDX-License-Identifier: GPL-3.0-or-later
Copyright (c) 2013-2024 XVM Contributors
"""

#
# Imports
#

# stdlib
import logging

# BigWorld
import BigWorld
from messenger import MessengerEntry
from helpers import dependency
from PlayerEvents import g_playerEvents
from gui import g_keyEventHandlers
from gui.battle_control import avatar_getter
from gui.battle_control.battle_constants import PLAYER_GUI_PROPS
from gui.impl import backport
from gui.impl.gen import R
from gui.shared import g_eventBus, events
from gui.Scaleform.daapi.view.battle.shared.markers2d.manager import MarkersManager
from gui.shared.utils.TimeInterval import TimeInterval
from skeletons.gui.battle_session import IBattleSessionProvider


# XFW
from xfw import *

# XVM Main
from xvm_main.python.consts import XVM_COMMAND, XVM_EVENT, XVM_PROFILER_COMMAND
import xvm_main.python.config as config
import xvm_main.python.pymacro as pymacro
import xvm_main.python.stats as stats
import xvm_main.python.vehinfo as vehinfo

# XVM Battle
from xvm_battle.python.consts import INV, XVM_BATTLE_COMMAND
from xvm_battle.python.shared import getGlobalBattleData

# XVM Battle VM
from .consts import UNSUPPORTED_BATTLE_TYPES, UNSUPPORTED_GUI_TYPES, XVM_VM_COMMAND, DAMAGE_TYPE



#
# Globals
#

g_markers = None



#
# DAAPI
#

def daapi_as2pyS(self, *args, **kwargs):
    if g_markers:
        return g_markers.daapi_as2py(*args, **kwargs)



#
# VehicleMarkers
#

class VehicleMarkers(object):
    sessionProvider = dependency.descriptor(IBattleSessionProvider)
    enabled = True
    allyVehicleDistEnabled = False
    enemyVehicleDistEnabled = False
    initialized = False
    populated = False
    guiType = None
    battleType = None
    playerVehicleID = 0
    manager = None
    vehiclePlugin = None
    distanceInterval = None
    pending_commands = []

    @property
    def active(self):
        return self.enabled \
            and self.initialized \
            and self.battleType not in UNSUPPORTED_BATTLE_TYPES \
            and self.guiType not in UNSUPPORTED_GUI_TYPES \

    @property
    def distanceBackportEnabled(self):
        return getRegion() != 'RU' \
            and self.active \
            and (self.allyVehicleDistEnabled or self.enemyVehicleDistEnabled)

    #
    # Initialization
    #

    def __init__(self):
        self._logger = logging.getLogger('XVM/Battle/VM')
        g_eventBus.addListener(XVM_EVENT.CONFIG_LOADED, self.onConfigLoaded)
        g_keyEventHandlers.add(self.onKeyEvent)
        g_playerEvents.onAvatarBecomePlayer += self.onBecomePlayer
        g_playerEvents.onAvatarBecomeNonPlayer += self.onBecomeNonPlayer

    @staticmethod
    def isValidManager(manager):
        return type(manager).__name__ != 'KillCamMarkersManager'

    def init(self, manager):
        self.manager = manager
        self.playerVehicleID = self.sessionProvider.getArenaDP().getPlayerVehicleID()

    def fini(self):
        g_eventBus.removeListener(XVM_EVENT.CONFIG_LOADED, self.onConfigLoaded)
        g_keyEventHandlers.remove(self.onKeyEvent)
        g_playerEvents.onAvatarBecomePlayer -= self.onBecomePlayer
        g_playerEvents.onAvatarBecomeNonPlayer -= self.onBecomeNonPlayer

    def populate(self):
        self.getVehiclePlugin()
        self.respondConfig()
        self.process_pending_commands()
        self.updatePlayerStates()
        self.startDistanceInterval()
        self.populated = True

    def destroy(self):
        self.stopDistanceInterval()
        self.pending_commands = []
        self.initialized = False
        self.populated = False
        self.guiType = None
        self.battleType = None
        self.playerVehicleID = 0
        self.vehiclePlugin = None
        self.manager = None
        self.distanceInterval = None


    #
    # DAAPI
    #

    def daapi_py2as(self, *args):
        try:
            if self.manager:
                if self.manager._isDAAPIInited():
                    # during the battle->lobby transition there is a narrow time window in which the DAAPI connection is closed, but `_isDAAPIInited` is still true
                    try:
                        return self.manager.flashObject.daapi_py2as(*args)
                    except AttributeError:
                        pass
                else:
                    self.pending_commands.append(args)
            return None
        except Exception:
            self._logger.exception('daapi_py2as')

    def daapi_as2py(self, cmd, *args):
        try:
            if cmd == XVM_VM_COMMAND.LOG:
                self._logger.info('[VM] %s', *args)
            elif cmd == XVM_VM_COMMAND.INITIALIZED:
                arena = avatar_getter.getArena()
                self.guiType = arena.guiType
                self.battleType = arena.bonusType
                self.initialized = True
            elif cmd == XVM_COMMAND.REQUEST_CONFIG:
                pass
            elif cmd == XVM_BATTLE_COMMAND.REQUEST_BATTLE_GLOBAL_DATA:
                self.respondGlobalBattleData()
            elif cmd == XVM_COMMAND.PYTHON_MACRO:
                return pymacro.process_python_macro(args[0])
            elif cmd == XVM_COMMAND.GET_CLAN_ICON:
                return stats.getClanIcon(int(args[0]))
            elif cmd == XVM_COMMAND.LOAD_STAT_BATTLE:
                stats.getBattleStat(args, self.daapi_py2as)
            # profiler
            elif cmd in (XVM_PROFILER_COMMAND.BEGIN, XVM_PROFILER_COMMAND.END):
                g_eventBus.handleEvent(events.HasCtxEvent(cmd, args[0]))
            else:
                self._logger.warning('daapi_as2py: Unknown command: %s', cmd)
        except Exception:
            self._logger.exception('daapi_as2py')
        return None


    #
    # Event handlers
    #

    def onBecomePlayer(self, *args, **kwargs):
        try:
            arena = avatar_getter.getArena()
            if arena:
                arena.onVehicleStatisticsUpdate += self.onVehicleStatisticsUpdate
        except Exception:
            self._logger.exception('onBecomePlayer')

    def onBecomeNonPlayer(self, *args, **kwargs):
        try:
            arena = avatar_getter.getArena()
            if arena:
                arena.onVehicleStatisticsUpdate -= self.onVehicleStatisticsUpdate
        except Exception:
            self._logger.exception('onBecomeNonPlayer')

    def onConfigLoaded(self, *args, **kwargs):
        self.enabled = config.get('markers/enabled', True)
        self.allyVehicleDistEnabled = any((config.get('markers/ally/alive/{0}/vehicleDist/enabled'.format(mode), False) for mode in ('normal', 'extended')))
        self.enemyVehicleDistEnabled = any((config.get('markers/enemy/alive/{0}/vehicleDist/enabled'.format(mode), False) for mode in ('normal', 'extended')))
        self.respondConfig()

    def onVehicleStatisticsUpdate(self, vehicleID):
        self.updatePlayerState(vehicleID, INV.FRAGS)

    def getVehiclePlugin(self):
        if self.manager is None:
            return
        self.vehiclePlugin = self.manager.getPlugin('vehicles')

    def respondConfig(self):
        try:
            if self.initialized:
                if self.active:
                    self.daapi_py2as(
                        XVM_COMMAND.AS_SET_CONFIG,
                        config.config_data,
                        config.lang_data,
                        vehinfo.getVehicleInfoDataArray(),
                        config.networkServicesSettings.__dict__,
                        IS_DEVELOPMENT)
                else:
                    self.daapi_py2as(
                        XVM_COMMAND.AS_SET_CONFIG,
                        {'markers': {'enabled': False}},
                        {'locale': {}},
                        None,
                        None,
                        IS_DEVELOPMENT)
                self.recreateMarkers()
        except Exception:
            self._logger.exception('respondConfig')

    def respondGlobalBattleData(self):
        try:
            if self.active:
                self.daapi_py2as(XVM_BATTLE_COMMAND.AS_RESPONSE_BATTLE_GLOBAL_DATA, *getGlobalBattleData())
        except Exception:
            self._logger.exception('respondGlobalBattleData')

    def process_pending_commands(self):
        for args in self.pending_commands:
            self.daapi_py2as(*args)
        self.pending_commands = []

    def onKeyEvent(self, event):
        try:
            if not event.isRepeatedEvent():
                if self.active and not MessengerEntry.g_instance.gui.isFocused():
                    self.daapi_py2as(XVM_COMMAND.AS_ON_KEY_EVENT, event.key, event.isKeyDown())
        except Exception:
            self._logger.exception('onKeyEvent')

    def updatePlayerStates(self):
        for vehicleID, vData in avatar_getter.getArena().vehicles.iteritems():
            self.updatePlayerState(vehicleID, INV.ALL)

    def updatePlayerState(self, vehicleID, targets, userData=None):
        try:
            if self.active:
                data = {}

                if targets & INV.ALL_ENTITY:
                    entity = BigWorld.entity(vehicleID)

                    if targets & INV.MARKS_ON_GUN:
                        if entity and hasattr(entity, 'publicInfo'):
                            data['marksOnGun'] = entity.publicInfo.marksOnGun

                    if targets & INV.TURRET:
                        if entity and hasattr(entity, 'typeDescriptor'):
                            data['turretCD'] = entity.typeDescriptor.turret.compactDescr

                    if targets & INV.CREW_ACTIVE:
                        if entity and hasattr(entity, 'isCrewActive'):
                            data['isCrewActive'] = bool(entity.isCrewActive)

                if targets & (INV.ALL_VINFO | INV.ALL_VSTATS):
                    arenaDP = self.sessionProvider.getArenaDP()
                    if targets & INV.ALL_VSTATS:
                        vStatsVO = arenaDP.getVehicleStats(vehicleID)

                        if targets & INV.FRAGS:
                            data['frags'] = vStatsVO.frags

                if data:
                    self.daapi_py2as(XVM_BATTLE_COMMAND.AS_UPDATE_PLAYER_STATE, vehicleID, data)
        except Exception:
            self._logger.exception('updatePlayerState')

    def startDistanceInterval(self):
        if not self.distanceBackportEnabled:
            return

        if self.distanceInterval is None:
            self.distanceInterval = TimeInterval(.2, self, 'updateVehicleDistance')

        self.distanceInterval.start()

    def stopDistanceInterval(self):
        if self.distanceInterval is None:
            return

        self.distanceInterval.stop()

    def updateVehicleDistance(self):
        try:
            if self.vehiclePlugin is None:
                self.stopDistanceInterval()
                return

            player = BigWorld.player()
            ownVehicle = player.getVehicleAttached()
            ownPosition = player.position
            # Get real vehicle position
            if ownVehicle is not None and ownVehicle.isAlive():
                ownPosition = player.getOwnVehiclePosition()

            markers = self.vehiclePlugin._markers
            metersString = R.strings.ingame_gui.distance.meters()

            for marker in markers.itervalues():
                vehicle = marker.getVehicleEntity()
                if vehicle is None:
                    continue

                isPlayerTeam = marker.getIsPlayerTeam()
                processAlly = self.allyVehicleDistEnabled and isPlayerTeam
                processEnemy = self.enemyVehicleDistEnabled and not isPlayerTeam
                if not (processAlly or processEnemy):
                    continue

                distance = (vehicle.position - ownPosition).length
                text = backport.text(metersString, meters=distance)
                self.vehiclePlugin._invokeMarker(marker.getMarkerID(), 'xvm_setDistance', text)
        except:
            self._logger.exception('updateVehicleDistance')

    def recreateMarkers(self):
        try:
            if self.vehiclePlugin:
                arenaDP = self.sessionProvider.getArenaDP()
                for vInfo in arenaDP.getVehiclesInfoIterator():
                    vehicleID = vInfo.vehicleID
                    if vehicleID == self.playerVehicleID or vInfo.isObserver():
                        continue
                    self.vehiclePlugin._destroyVehicleMarker(vInfo.vehicleID)
                    self.vehiclePlugin.addVehicleInfo(vInfo, arenaDP)
        except Exception:
            self._logger.exception('recreateMarkers')

    def getVehicleDamageType(self, attackerInfo):
        if not attackerInfo:
            return DAMAGE_TYPE.FROM_UNKNOWN
        attackerID = attackerInfo.vehicleID
        if attackerID == self.playerVehicleID:
            return DAMAGE_TYPE.FROM_PLAYER
        entityName = self.sessionProvider.getCtx().getPlayerGuiProps(attackerID, attackerInfo.team)
        if entityName == PLAYER_GUI_PROPS.squadman:
            return DAMAGE_TYPE.FROM_SQUAD
        if entityName == PLAYER_GUI_PROPS.ally:
            return DAMAGE_TYPE.FROM_ALLY
        if entityName == PLAYER_GUI_PROPS.enemy:
            return DAMAGE_TYPE.FROM_ENEMY
        return DAMAGE_TYPE.FROM_UNKNOWN



#
# Initialization
#

def init():
    MarkersManager.daapi_as2py  = daapi_as2pyS

    global g_markers
    g_markers = VehicleMarkers()


def fini():
    global g_markers
    g_markers.fini()
    g_markers = None
