""" XVM (c) www.modxvm.com 2013-2015 """

# PUBLIC

def getVehicleStateData(vID):
    return _getVehicleStateData(vID)


def updateSpottedStatus(vID, spotted):
    _updateSpottedStatus(vID, spotted)


def getSpottedStatus(vID):
    global _spotted_cache
    return _spotted_cache.get(vID, 'neverSeen')


def cleanupBattleData():
    global _spotted_cache
    _spotted_cache = {}


# PRIVATE

from pprint import pprint

import BigWorld

from xfw import *

from logger import *


def _getVehicleStateData(vID):
    # log(vars(vehicle))
    # log(vars(vehicle.typeDescriptor))
    # self.maxHealth = vData['vehicleType'].maxHealth

    arenaVehicle = BigWorld.player().arena.vehicles.get(vID, None)
    if arenaVehicle is None:
        return None

    vehicle = BigWorld.entity(vID)

    dead = not arenaVehicle['isAlive']
    if dead:
        global _spotted_cache
        _spotted_cache[vID] = 'dead'

    return {
        'playerName': arenaVehicle['name'],
        'playerId': arenaVehicle['accountDBID'],
        'vId': vID,
        'dead': dead,
        'spotted': getSpottedStatus(vID),
        'curHealth': max(0, vehicle.health) if vehicle else None,
        'maxHealth': vehicle.typeDescriptor.maxHealth if vehicle else None,
        'marksOnGun': vehicle.publicInfo.marksOnGun if vehicle else None,
    }

_spotted_cache = {}

def _updateSpottedStatus(vID, spotted):
    global _spotted_cache

    arena = getattr(BigWorld.player(), 'arena', None)
    if arena is None:
        return

    arenaVehicle = arena.vehicles.get(vID, None)
    if arenaVehicle is None:
        return

    if not arenaVehicle['isAlive']:
        _spotted_cache[vID] = 'dead'
        return

    if spotted:
        _spotted_cache[vID] = 'spotted'
        return

    if vID in _spotted_cache:
        _spotted_cache[vID] = 'lost'
