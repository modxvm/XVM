""" XVM (c) www.modxvm.com 2013-2014 """

# PUBLIC

def getVehicleStateData(vehicle, playerId):
    return _getVehicleStateData(vehicle)

# PRIVATE

from pprint import pprint
import BigWorld
from xpm import *
from logger import *

def _getVehicleStateData(vehicle, playerId):
    #log(vars(vehicle))
    #log(vars(vehicle.typeDescriptor))
    #self.maxHealth = vData['vehicleType'].maxHealth
    return {
        'playerName': vehicle.publicInfo.name,
        'playerId': playerId,
        'vehId': vehicle.id,
        'dead': not vehicle.isAlive(),
        'curHealth': vehicle.health,
        'maxHealth': vehicle.typeDescriptor.maxHealth,
    }
