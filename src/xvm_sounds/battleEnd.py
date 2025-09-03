"""
SPDX-License-Identifier: GPL-3.0-or-later
Copyright (c) 2013-2025 XVM Contributors
Copyright (c) 2016-2021 night_dragon_on <https://kr.cm/f/p/14897/>
"""

#
# Imports
#

# stdlib
import logging

# BigWorld
import SoundGroups
from gui.Scaleform.daapi.view.battle.classic.battle_end_warning_panel import BattleEndWarningPanel
from constants import ARENA_PERIOD

# XFW
from xfw.events import registerEvent

# XVM Main
import xvm_main.config as config



#
# Constants
#

class XVM_SOUND_EVENT(object):
    BATTLE_END_300 = "xvm_battleEnd_5_min"
    BATTLE_END_180 = "xvm_battleEnd_3_min"
    BATTLE_END_120 = "xvm_battleEnd_2_min"
    BATTLE_END_60 = "xvm_battleEnd_1_min"
    BATTLE_END_30 = "xvm_battleEnd_30_sec"
    BATTLE_END_5 = "xvm_battleEnd_5_sec"



#
# Handlers
#

def BattleEndWarningPanel_setTotalTime(self, totalTime):
    try:
        if config.get('sounds/enabled'):
            period = self.sessionProvider.arenaVisitor.getArenaPeriod()
            if period == ARENA_PERIOD.BATTLE and totalTime in (300, 180, 120, 60, 30, 5, ):
                soundName = getattr(XVM_SOUND_EVENT, 'BATTLE_END_%s' % totalTime, None)
                if soundName is not None:
                    SoundGroups.g_instance.playSound2D(soundName)
    except Exception:
        logging.getLogger('XVM/Sounds').exception('battleEnd/BattleEndWarningPanel_setTotalTime')



#
# Initialization
#

def init():
    registerEvent(BattleEndWarningPanel, 'setTotalTime')(BattleEndWarningPanel_setTotalTime)


def fini():
    pass
