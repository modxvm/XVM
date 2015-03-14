""" XVM (c) www.modxvm.com 2013-2015 """

#####################################################################
# MOD INFO (mandatory)

XFW_MOD_VERSION    = "2.0.0"
XFW_MOD_URL        = "http://www.modxvm.com/"
XFW_MOD_UPDATE_URL = "http://www.modxvm.com/en/download-xvm/"
XFW_GAME_VERSIONS  = ["0.9.6","0.9.7"]

#####################################################################

import BigWorld

from xfw import *
import xvm_main.python.config as config
from xvm_main.python.logger import *

#####################################################################
# event handlers

def ItemsData_getAllPossibleXP(base, self, nodeCD, unlockStats):
    if not config.config['hangar']['allowExchangeXPInTechTree']:
        return unlockStats.getVehTotalXP(nodeCD)
    return base(self, nodeCD, unlockStats)

#####################################################################
# Register events

def _RegisterEvents():
    from gui.Scaleform.daapi.view.lobby.techtree.data import _ItemsData
    OverrideMethod(_ItemsData, '_getAllPossibleXP', ItemsData_getAllPossibleXP)

BigWorld.callback(0, _RegisterEvents)
