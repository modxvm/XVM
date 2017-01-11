""" XVM (c) www.modxvm.com 2013-2017 """

import BigWorld

from xfw import *

from xvm_main.python.logger import *
import xvm_main.python.minimap_circles as minimap_circles
import xvm_main.python.utils as utils
import xvm_main.python.vehinfo_xtdb as vehinfo_xtdb


def getGlobalBattleData():
    player = BigWorld.player()
    vehicleID = player.playerVehicleID
    arena = player.arena
    arenaVehicle = arena.vehicles.get(vehicleID)
    vehCD = getVehCD(vehicleID)
    clan = arenaVehicle['clanAbbrev']
    if not clan:
        clan = None
    return (
        vehicleID,                                  # playerVehicleID
        arenaVehicle['name'],                       # playerName
        clan,                                       # playerClan
        vehCD,                                      # playerVehCD
        arena.extraData.get('battleLevel', 0),      # battleLevel
        arena.bonusType,                            # battleType
        arena.guiType,                              # arenaGuiType
        utils.getMapSize(),                         # mapSize
        minimap_circles.getMinimapCirclesData(),    # minimapCirclesData
        vehinfo_xtdb.vehArrayXTDB(vehCD))           # xtdb_data
