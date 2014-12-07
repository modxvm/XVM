""" XVM (c) www.modxvm.com 2013-2014 """

# PUBLIC

def getVehicleStateData(id, vehicle=None):
    return _getVehicleStateData(id, vehicle)

def updateSpottedStatus(id, spotted):
    _updateSpottedStatus(id, spotted)

def getSpottedStatus(id):
    global _spotted_cache
    return _spotted_cache.get(id, 'neverSeen')

def cleanupBattleData():
    global _spotted_cache
    _spotted_cache = {}

# PRIVATE

from pprint import pprint
import BigWorld
from xpm import *
from logger import *

def _getVehicleStateData(id, vehicle):
    #log(vars(vehicle))
    #log(vars(vehicle.typeDescriptor))
    #self.maxHealth = vData['vehicleType'].maxHealth

    arenaVehicle = BigWorld.player().arena.vehicles.get(id, None)
    if arenaVehicle is None:
        return None

    if vehicle is None:
        vehicle = BigWorld.entities.get(id, None)

    return {
        'playerName': arenaVehicle['name'],
        'playerId': arenaVehicle['accountDBID'],
        'vehId': id,
        'dead': not arenaVehicle['isAlive'],
        'spotted': getSpottedStatus(id),
        'curHealth': max(0, vehicle.health) if vehicle else None,
        'maxHealth': vehicle.typeDescriptor.maxHealth if vehicle else None,
        'marksOnGun': vehicle.publicInfo.marksOnGun if vehicle else None,
    }

_spotted_cache = {}

def _updateSpottedStatus(id, spotted):
    global _spotted_cache

    arenaVehicle = BigWorld.player().arena.vehicles.get(id, None)
    if arenaVehicle is None:
        return

    if not arenaVehicle['isAlive']:
        _spotted_cache[id] = 'dead'
        return

    if spotted:
        _spotted_cache[id] = 'revealed'
        return 

    if id in _spotted_cache:
        _spotted_cache[id] = 'lost'
