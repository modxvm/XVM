""" XVM (c) www.modxvm.com 2013-2016 """

#####################################################################
# imports

import Math
import traceback

import BigWorld
from Avatar import PlayerAvatar
from AvatarInputHandler.control_modes import PostMortemControlMode
from gui.Scaleform.Minimap import Minimap
from gui.battle_control import g_sessionProvider
from items.vehicles import VEHICLE_CLASS_TAGS

from xfw import *

from xvm_main.python.logger import *
import xvm_main.python.config as config


#####################################################################
# handlers

# TODO:0.9.15.1
#@registerEvent(Minimap, 'start')
def _Minimap_start(self):
    #log('Minimap_start')
    if config.get('minimap/enabled'):
        _init_player(self)


# TODO:0.9.15.1
#@overrideMethod(Minimap, '_Minimap__callEntryFlash')
def _Minimap__callEntryFlash(base, self, id, methodName, args=None):
    #log('id={} method={} args={}'.format(id, methodName, args))

    if methodName == 'update' and not args:
        args = [0]

    base(self, id, methodName, args)

    if self._Minimap__isStarted and config.get('minimap/enabled'):
        try:
            if methodName == 'init':
                if len(args) != 5:
                    base(self, id, 'init_xvm', [0])
                else:
                    entryVehicle = BigWorld.player().arena.vehicles[id]
                    entityName = str(g_sessionProvider.getCtx().getPlayerGuiProps(id, entryVehicle['team']))
                    base(self, id, 'init_xvm', [entryVehicle['accountDBID'], False, getVehCD(id), entityName])
        except Exception as ex:
            if IS_DEVELOPMENT:
                err(traceback.format_exc())


# TODO:0.9.15.1
#@registerEvent(Minimap, '_Minimap__addEntryLit')
def _Minimap__addEntryLit(self, vInfo, guiProps, matrix, visible=True):
    if config.get('minimap/enabled'):
        if vInfo.isObserver() or matrix is None:
            return

        try:
            vehicleID = vInfo.vehicleID
            entry = self._Minimap__entrieLits[vehicleID]
            entryVehicle = BigWorld.player().arena.vehicles[vehicleID]
            entityName = str(g_sessionProvider.getCtx().getPlayerGuiProps(id, entryVehicle['team']))
            self._Minimap__ownUI.entryInvoke(entry['handle'], ('init_xvm',
                [entryVehicle['accountDBID'], True, getVehCD(vehicleID), entityName]))
        except Exception as ex:
            if IS_DEVELOPMENT:
                err(traceback.format_exc())


# Minimap dead switch
# TODO:0.9.15.1
#@registerEvent(PostMortemControlMode, 'onMinimapClicked')
def _PostMortemControlMode_onMinimapClicked(self, worldPos):
    if config.get('battle/minimapDeadSwitch'):
        try:
            battle = getBattleApp()
            if not battle:
                return

            if isReplay():
                return

            player = BigWorld.player()
            minDistance = None
            toID = None
            for vehicleID, entry in battle.minimap._Minimap__entries.iteritems():
                vData = player.arena.vehicles[vehicleID]
                if player.team != vData['team'] or not vData['isAlive']:
                    continue
                pos = Math.Matrix(entry['matrix']).translation
                distance = Math.Vector3(worldPos - pos).length
                if minDistance is None or minDistance > distance:
                    minDistance = distance
                    toID = vehicleID
            if toID is not None:
                BigWorld.player().positionControl.bindToVehicle(vehicleID=toID)
                self._PostMortemControlMode__switchViewpoint(False, toID)
        except Exception as ex:
            if IS_DEVELOPMENT:
                err(traceback.format_exc())


# on map load (battle loading)
# TODO:0.9.15.1
#@registerEvent(PlayerAvatar, 'updateVehicleHealth')
def _PlayerAvatar_updateVehicleHealth(self, vehicleID, health, deathReasonID, isCrewActive, isRespawn):
    #log('PlayerAvatar_updateVehicleHealth: {} {} {} {} {}'.format(vehicleID, health, deathReasonID, isCrewActive, isRespawn))
    if config.get('minimap/enabled'):
        if isRespawn and health > 0:
            _init_player(getBattleApp().minimap, True)


# PRIVATE

def _init_player(minimap, isRespawn=False):
    try:
        battleCtx = g_sessionProvider.getCtx()
        if not battleCtx.isPlayerObserver():
            player = BigWorld.player()
            arena = player.arena
            vehicleID = player.playerVehicleID
            entryVehicle = arena.vehicles[vehicleID]
            playerId = entryVehicle['accountDBID']
            vehCD = getVehCD(vehicleID)
            tags = set(entryVehicle['vehicleType'].type.tags & VEHICLE_CLASS_TAGS)
            vClass = tags.pop() if len(tags) > 0 else ''
            entityName = str(battleCtx.getPlayerGuiProps(vehicleID, entryVehicle['team']))
            minimap._Minimap__callEntryFlash(vehicleID, 'init_xvm',
                [playerId, False, vehCD, entityName, 'player', vClass, isRespawn])
    except Exception as ex:
        if IS_DEVELOPMENT:
            err(traceback.format_exc())
