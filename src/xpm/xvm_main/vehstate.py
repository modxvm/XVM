""" XVM (c) www.modxvm.com 2013-2016 """

# PUBLIC

def getVehicleStateData(vehicleID):
    return _getVehicleStateData(vehicleID)


def updateSpottedStatus(vehicleID, spotted):
    _updateSpottedStatus(vehicleID, spotted)


def getSpottedStatus(vehicleID):
    global _spotted_cache
    return _spotted_cache.get(vehicleID, 'neverSeen')


def cleanupBattleData():
    global _spotted_cache
    _spotted_cache = {}


# PRIVATE

import BigWorld
from gui.battle_control import g_sessionProvider

from xfw import *

from constants import *
from logger import *
import utils

def _getVehicleStateData(vehicleID):
    # log(vars(vehicle))
    # log(vars(vehicle.typeDescriptor))
    # self.maxHealth = vData['vehicleType'].maxHealth

    arenaVehicle = BigWorld.player().arena.vehicles.get(vehicleID, None)
    if arenaVehicle is None:
        return None

    vehicle = BigWorld.entity(vehicleID)

    dead = not arenaVehicle['isAlive']
    if dead:
        global _spotted_cache
        _spotted_cache[vehicleID] = 'dead'

    player = BigWorld.player()
    playerTeam = player.team if hasattr(player, 'team') else 0

    arenaDP = g_sessionProvider.getArenaDP()
    squadIndex = arenaDP.getVehicleInfo(vehicleID).squadIndex
    if arenaDP.isSquadMan(vehicleID):
        squadIndex += 10

    return {
        'playerName': arenaVehicle['name'],
        'clanAbbrev': arenaVehicle['clanAbbrev'],
        'playerId': arenaVehicle['accountDBID'],
        'vehCD': arenaVehicle['vehicleType'].type.compactDescr,
        'team': TEAM.ALLY if arenaVehicle['team'] == playerTeam else TEAM.ENEMY,
        'squad': squadIndex,
        'dead': dead,
        'spotted': getSpottedStatus(vehicleID),
        'curHealth': max(0, vehicle.health) if vehicle else None,
        'maxHealth': vehicle.typeDescriptor.maxHealth if vehicle else None,
        'marksOnGun': vehicle.publicInfo.marksOnGun if vehicle else None,
    }

_spotted_cache = {}

def _updateSpottedStatus(vehicleID, spotted):
    global _spotted_cache

    arena = getattr(BigWorld.player(), 'arena', None)
    if arena is None:
        return

    arenaVehicle = arena.vehicles.get(vehicleID, None)
    if arenaVehicle is None:
        return

    if not arenaVehicle['isAlive']:
        _spotted_cache[vehicleID] = 'dead'
        return

    if spotted:
        _spotted_cache[vehicleID] = 'spotted'
        return

    if vehicleID in _spotted_cache:
        _spotted_cache[vehicleID] = 'lost'
