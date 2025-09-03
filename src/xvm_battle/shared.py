"""
SPDX-License-Identifier: GPL-3.0-or-later
Copyright (c) 2013-2025 XVM Contributors
"""

#
# Imports
#

# BigWorld
from gui.battle_control import avatar_getter

# XVM Main
import xvm_main.minimap_circles as minimap_circles
import xvm_main.vehinfo as vehinfo
import xvm_main.utils as utils



#
# Public
#

def getGlobalBattleData():
    vehicleID = avatar_getter.getPlayerVehicleID()
    arena = avatar_getter.getArena()
    arenaVehicle = arena.vehicles.get(vehicleID, None)
    if arenaVehicle is not None:
        vehCD = arenaVehicle['vehicleType'].type.compactDescr
        clan = arenaVehicle['clanAbbrev']
        playerName = arenaVehicle['name']
    else:
        vehCD = 0
        clan = None
        playerName = None
    vInfoVO = utils.getVehicleInfo(vehicleID)
    if not clan:
        clan = None
    return (
        vehicleID,                                  # playerVehicleID
        playerName,                                 # playerName
        vInfoVO.player.fakeName,                    # playerFakeName
        clan,                                       # playerClan
        vehCD,                                      # playerVehCD
        arena.extraData.get('battleLevel', 0),      # battleLevel
        arena.bonusType,                            # battleType
        arena.guiType,                              # arenaGuiType
        utils.getMapSize(),                         # mapSize
        minimap_circles.getMinimapCirclesData(),    # minimapCirclesData
        vehinfo.getXtdbDataArray(vehCD))            # xtdb_data
