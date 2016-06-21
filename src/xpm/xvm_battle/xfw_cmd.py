""" XVM (c) www.modxvm.com 2013-2016 """

#####################################################################
# constants

class XVM_BATTLE_COMMAND(object):
    CAPTURE_BAR_GET_BASE_NUM_TEXT = "xvm_battle.captureBarGetBaseNumText"
    BATTLE_CTRL_SET_VEHICLE_DATA = "xvm_battle.battleCtrlSetVehicleData"


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
        if cmd == XVM_BATTLE_COMMAND.CAPTURE_BAR_GET_BASE_NUM_TEXT:
            n = int(args[0])
            res = getBattleSubTypeBaseNumder(BigWorld.player().arenaTypeID, n & 0x3F, n >> 6)
            return (res, True)
        elif cmd == XVM_BATTLE_COMMAND.BATTLE_CTRL_SET_VEHICLE_DATA:
            if g_xvm.battle_page:
                ctrl = g_xvm.battle_page.getComponent(BATTLE_VIEW_ALIASES.BATTLE_STATISTIC_DATA_CONTROLLER)
                if ctrl:
                    ctrl.invalidateArenaInfo()
            return (None, True)
    def py_xvm_loadBattleStat(self):
        stats.getBattleStat(None, self.flashObject)

    def py_xvm_pythonMacro(self, arg):
        #log('py_xvm_pythonMacro: {}'.format(arg))
        return python_macro.process_python_macro(arg)

    def py_xvm_minimapClick(self, path):
        #log('py_xvm_minimapClick: {}'.format(path))
        return xmqp_events.send_minimap_click(path)
    except Exception, ex:
        err(traceback.format_exc())
        return (None, True)
    return (None, False)
