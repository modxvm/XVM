""" XVM (c) https://modxvm.com 2013-2020 """

# Authors:
# night_dragon_on <https://kr.cm/f/p/14897/>

#####################################################################
# imports

import SoundGroups
from constants import ARENA_PERIOD
from gui.Scaleform.daapi.view.battle.classic.battle_end_warning_panel import BattleEndWarningPanel
from gui.battle_control import avatar_getter
import traceback

from xfw import *
import xvm_main.python.config as config
from xvm_main.python.logger import *

#####################################################################
# constants

class XVM_SOUND_EVENT(object):
    BATTLE_END_300 = "xvm_battleEnd_5_min"
    BATTLE_END_180 = "xvm_battleEnd_3_min"
    BATTLE_END_120 = "xvm_battleEnd_2_min"
    BATTLE_END_60 = "xvm_battleEnd_1_min"
    BATTLE_END_30 = "xvm_battleEnd_30_sec"
    BATTLE_END_5 = "xvm_battleEnd_5_sec"

#####################################################################
# handlers

@registerEvent(BattleEndWarningPanel, 'setTotalTime')
def BattleEndWarningPanel_setTotalTime(self, totalTime):
    try:
        if config.get('sounds/enabled'):
            period = avatar_getter.getArena().period
            if period == ARENA_PERIOD.BATTLE:
                if totalTime == 300:
                    SoundGroups.g_instance.playSound2D(XVM_SOUND_EVENT.BATTLE_END_300)
                elif totalTime == 180:
                    SoundGroups.g_instance.playSound2D(XVM_SOUND_EVENT.BATTLE_END_180)
                elif totalTime == 120:
                    SoundGroups.g_instance.playSound2D(XVM_SOUND_EVENT.BATTLE_END_120)
                elif totalTime == 60:
                    SoundGroups.g_instance.playSound2D(XVM_SOUND_EVENT.BATTLE_END_60)
                elif totalTime == 30:
                    SoundGroups.g_instance.playSound2D(XVM_SOUND_EVENT.BATTLE_END_30)
                elif totalTime == 5:
                    SoundGroups.g_instance.playSound2D(XVM_SOUND_EVENT.BATTLE_END_5)
    except:
        err(traceback.format_exc())
