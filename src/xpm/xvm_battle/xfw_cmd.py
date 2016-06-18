""" XVM (c) www.modxvm.com 2013-2016 """

#####################################################################
# constants

class XVM_BATTLE_COMMAND(object):
    CAPTURE_BAR_GET_BASE_NUM_TEXT = "xvm_battle.captureBarGetBaseNumText"


#####################################################################
# imports

import traceback

import BigWorld
import game
from gui.shared import g_eventBus
from gui.shared.utils.functions import getBattleSubTypeBaseNumder

from xfw import *
from xvm_main.python.logger import *


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
    except Exception, ex:
        err(traceback.format_exc())
        return (None, True)
    return (None, False)


