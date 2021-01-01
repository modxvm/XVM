""" XVM (c) https://modxvm.com 2013-2021 """

from gui.battle_control import avatar_getter

from xfw import *

from xvm_main.python.logger import *
import xvm_main.python.minimap_circles as minimap_circles
import xvm_main.python.utils as utils
import xvm_main.python.vehinfo as vehinfo


def getGlobalBattleData():
    vehicleID = avatar_getter.getPlayerVehicleID()
    arena = avatar_getter.getArena()
    arenaVehicle = arena.vehicles.get(vehicleID)
    vehCD = getVehCD(vehicleID)
    clan = arenaVehicle['clanAbbrev']
    vInfoVO = utils.getVehicleInfo(vehicleID)
    if not clan:
        clan = None
    return (
        vehicleID,                                  # playerVehicleID
        arenaVehicle['name'],                       # playerName
        vInfoVO.player.fakeName,                    # playerFakeName
        clan,                                       # playerClan
        vehCD,                                      # playerVehCD
        arena.extraData.get('battleLevel', 0),      # battleLevel
        arena.bonusType,                            # battleType
        arena.guiType,                              # arenaGuiType
        utils.getMapSize(),                         # mapSize
        minimap_circles.getMinimapCirclesData(),    # minimapCirclesData
        vehinfo.getXtdbDataArray(vehCD))            # xtdb_data
