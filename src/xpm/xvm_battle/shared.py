""" XVM (c) www.modxvm.com 2013-2016 """

import BigWorld

from xfw import *

import xvm_main.python.minimap_circles as minimap_circles
import xvm_main.python.utils as utils
import xvm_main.python.vehinfo_xtdb as vehinfo_xtdb


def getGlobalBattleData():
    player = BigWorld.player()
    vehicleID = player.playerVehicleID
    arena = player.arena
    arenaVehicle = arena.vehicles.get(vehicleID)
    vehCD = getVehCD(vehicleID)
    return (
        vehicleID,                                  # playerVehicleID
        arenaVehicle['name'],                       # playerName
        vehCD,                                      # playerVehCD
        arena.extraData.get('battleLevel', 0),      # battleLevel
        arena.bonusType,                            # battleType
        arena.guiType,                              # arenaGuiType
        utils.getMapSize(),                         # mapSize
        minimap_circles.getMinimapCirclesData(),    # minimapCirclesData
        vehinfo_xtdb.vehArrayXTDB(vehCD))           # xtdb_data
