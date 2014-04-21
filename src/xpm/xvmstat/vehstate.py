""" xvm (c) sirmax 2013-2014 """

# PUBLIC

def getVehicleStateData(vehicle):
    return _getVehicleStateData(vehicle)

# PRIVATE

from pprint import pprint
import BigWorld
from xpm import *
from logger import *

def _getVehicleStateData(vehicle):
    #log(vars(vehicle))
    #log(vars(vehicle.typeDescriptor))
    #self.maxHealth = vData['vehicleType'].maxHealth
    return {
        'playerName': vehicle.publicInfo.name,
        'vehId': vehicle.id,
        'dead': not vehicle.isAlive(),
        'curHealth': vehicle.health,
        'maxHealth': vehicle.typeDescriptor.maxHealth,
    }
