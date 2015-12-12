""" XVM (c) www.modxvm.com 2013-2015 """

#####################################################################
# imports

import Math
import traceback

import BigWorld
from AvatarInputHandler.control_modes import PostMortemControlMode
from gui.Scaleform.Minimap import Minimap, MODE_ARCADE, MODE_SNIPER, _isStrategic
from gui.battle_control import g_sessionProvider
from items.vehicles import VEHICLE_CLASS_TAGS

from xfw import *

from xvm_main.python.logger import *
import xvm_main.python.config as config


#####################################################################
# handlers

@registerEvent(Minimap, 'start')
def Minimap_start(self):
    #log('Minimap_start')
    if config.get('minimap/enabled'):
        try:
            battleCtx = g_sessionProvider.getCtx()
            if not battleCtx.isPlayerObserver():
                player = BigWorld.player()
                arena = player.arena
                id = player.playerVehicleID
                entryVehicle = arena.vehicles[id]
                playerId = entryVehicle['accountDBID']
                vId = entryVehicle['vehicleType'].type.compactDescr
                tags = set(entryVehicle['vehicleType'].type.tags & VEHICLE_CLASS_TAGS)
                vClass = tags.pop() if len(tags) > 0 else ''
                entityName = str(battleCtx.getPlayerGuiProps(id, entryVehicle['team']))
                #BigWorld.callback(0, lambda:
                self._Minimap__callEntryFlash(id, 'init_xvm',
                    [playerId, False, vId, entityName, 'player', vClass, _getMapSize()])

        except Exception as ex:
            if IS_DEVELOPMENT:
                err(traceback.format_exc())


@overrideMethod(Minimap, '_Minimap__callEntryFlash')
def Minimap__callEntryFlash(base, self, id, methodName, args=None):
    #log('id={} method={} args={}'.format(id, methodName, args))

    # TODO: FIXIT: stub to fix 0.9.12 bug
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
                    vId = entryVehicle['vehicleType'].type.compactDescr
                    entityName = str(g_sessionProvider.getCtx().getPlayerGuiProps(id, entryVehicle['team']))
                    base(self, id, 'init_xvm', [entryVehicle['accountDBID'], False, vId, entityName])
        except Exception as ex:
            if IS_DEVELOPMENT:
                err(traceback.format_exc())


@registerEvent(Minimap, '_Minimap__addEntryLit')
def Minimap__addEntryLit(self, vInfo, guiProps, matrix, visible=True):
    if config.get('minimap/enabled'):
        if vInfo.isObserver() or matrix is None:
            return

        try:
            vehId = vInfo.vehicleID
            entry = self._Minimap__entrieLits[vehId]
            entryVehicle = BigWorld.player().arena.vehicles[vehId]
            vId = entryVehicle['vehicleType'].type.compactDescr
            entityName = str(g_sessionProvider.getCtx().getPlayerGuiProps(id, entryVehicle['team']))
            self._Minimap__ownUI.entryInvoke(entry['handle'], ('init_xvm',
                [entryVehicle['accountDBID'], True, vId, entityName]))
        except Exception as ex:
            if IS_DEVELOPMENT:
                err(traceback.format_exc())

# Minimap dead switch
@registerEvent(PostMortemControlMode, 'onMinimapClicked')
def PostMortemControlMode_onMinimapClicked(self, worldPos):
    if config.get('battle/minimapDeadSwitch'):
        try:
            battle = getBattleApp()
            if not battle:
                return

            if isReplay():
                return

            player = BigWorld.player()
            minDistance = None
            toId = None
            for vehId, entry in battle.minimap._Minimap__entries.iteritems():
                vData = player.arena.vehicles[vehId]
                if player.team != vData['team'] or not vData['isAlive']:
                    continue
                pos = Math.Matrix(entry['matrix']).translation
                distance = Math.Vector3(worldPos - pos).length
                if minDistance is None or minDistance > distance:
                    minDistance = distance
                    toId = vehId
            if toId is not None:
                BigWorld.player().positionControl.bindToVehicle(vehicleID=toId)
                self._PostMortemControlMode__switchViewpoint(False, toId)
        except Exception as ex:
            if IS_DEVELOPMENT:
                err(traceback.format_exc())


# PRIVATE

def _getMapSize():
    (b, l), (t, r) = BigWorld.player().arena.arenaType.boundingBox
    return t - b
