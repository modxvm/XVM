""" XVM (c) www.modxvm.com 2013-2016 """

#####################################################################
# constants

class XVM_BATTLE_COMMAND(object):
    REQUEST_BATTLE_GLOBAL_DATA = "xvm.request_battle_global_data"
    BATTLE_CTRL_SET_VEHICLE_DATA = "xvm_battle.battle_ctrl_set_vehicle_data"
    CAPTURE_BAR_GET_BASE_NUM_TEXT = "xvm_battle.capture_bar_get_base_num_text"
    MINIMAP_CLICK = "xvm.minimap_click"

    AS_RESPONSE_BATTLE_GLOBAL_DATA = "xvm.as.response_battle_global_data"

#####################################################################
# imports

import traceback

import BigWorld
import game
from gui.shared import g_eventBus
from gui.shared.utils.functions import getBattleSubTypeBaseNumder
from gui.Scaleform.genConsts.BATTLE_VIEW_ALIASES import BATTLE_VIEW_ALIASES

from xfw import *
from xvm_main.python.logger import *
from xvm_main.python.xvm import g_xvm
import xvm_main.python.vehinfo_xtdb as vehinfo_xtdb
import xvm_main.python.xmqp_events as xmqp_events
import xvm_main.python.minimap_circles as minimap_circles
import xvm_main.python.utils as utils

#####################################################################
# initialization/finalization

def start():
    g_eventBus.addListener(XFWCOMMAND.XFW_CMD, onXfwCommand)

BigWorld.callback(0, start)


@registerEvent(game, 'fini')
def fini():
    g_eventBus.removeListener(XFWCOMMAND.XFW_CMD, onXfwCommand)


#####################################################################
# onXfwCommand

# returns: (result, status)
def onXfwCommand(cmd, *args):
    try:
        if cmd == XVM_BATTLE_COMMAND.REQUEST_BATTLE_GLOBAL_DATA:

            player = BigWorld.player()
            vehicleID = player.playerVehicleID
            arena = player.arena
            arenaVehicle = arena.vehicles.get(vehicleID)
            vehCD = getVehCD(vehicleID)
            as_xfw_cmd(XVM_BATTLE_COMMAND.AS_RESPONSE_BATTLE_GLOBAL_DATA,
                vehicleID,					# playerVehicleID
                arenaVehicle['name'],				# playerName
                vehCD,						# playerVehCD
                arena.extraData.get('battleLevel', 0),		# battleLevel
                arena.bonusType,				# battleType
                arena.guiType,					# arenaGuiType
                utils.getMapSize(),				# mapSize
                minimap_circles.getMinimapCirclesData(),	# minimapCirclesData
                vehinfo_xtdb.vehArrayXTDB(vehCD))		# xtdb_data
            return (None, True)

        elif cmd == XVM_BATTLE_COMMAND.BATTLE_CTRL_SET_VEHICLE_DATA:
            if g_xvm.battle_page:
                ctrl = g_xvm.battle_page.getComponent(BATTLE_VIEW_ALIASES.BATTLE_STATISTIC_DATA_CONTROLLER)
                if ctrl:
                    ctrl.invalidateArenaInfo()
            return (None, True)

        elif cmd == XVM_BATTLE_COMMAND.CAPTURE_BAR_GET_BASE_NUM_TEXT:
            n = int(args[0])
            res = getBattleSubTypeBaseNumder(BigWorld.player().arenaTypeID, n & 0x3F, n >> 6)
            return (res, True)

        elif cmd == XVM_BATTLE_COMMAND.MINIMAP_CLICK:
            return (xmqp_events.send_minimap_click(args[0]), True)

    except Exception, ex:
        err(traceback.format_exc())
        return (None, True)
    return (None, False)
