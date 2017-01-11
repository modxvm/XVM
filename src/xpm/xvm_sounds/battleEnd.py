""" XVM (c) www.modxvm.com 2013-2017 """

# Authors:
# night_dragon_on <http://www.koreanrandom.com/forum/user/14897-night-dragon-on/>
# Ekspoint <http://www.koreanrandom.com/forum/user/24406-ekspoint/>

#####################################################################
# imports

import BigWorld
import SoundGroups
from gui.Scaleform.daapi.view.battle.classic.battle_end_warning_panel import BattleEndWarningPanel
from constants import ARENA_PERIOD

from xfw import *
import xvm_main.python.config as config
from xvm_main.python.logger import *
import traceback

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

@registerEvent(BattleEndWarningPanel, 'setCurrentTimeLeft')
def BattleEndWarningPanel_setCurrentTimeLeft(self, totalTime):
    try:
        if config.get('sounds/enabled'):
          period = BigWorld.player().arena.period
          if period == ARENA_PERIOD.BATTLE and totalTime == 300:
              SoundGroups.g_instance.playSound2D(XVM_SOUND_EVENT.BATTLE_END_300)
          elif period == ARENA_PERIOD.BATTLE and totalTime == 180:
              SoundGroups.g_instance.playSound2D(XVM_SOUND_EVENT.BATTLE_END_180)
          elif period == ARENA_PERIOD.BATTLE and totalTime == 120:
              SoundGroups.g_instance.playSound2D(XVM_SOUND_EVENT.BATTLE_END_120)
          elif period == ARENA_PERIOD.BATTLE and totalTime == 60:
              SoundGroups.g_instance.playSound2D(XVM_SOUND_EVENT.BATTLE_END_60)
          elif period == ARENA_PERIOD.BATTLE and totalTime == 30:
              SoundGroups.g_instance.playSound2D(XVM_SOUND_EVENT.BATTLE_END_30)
          elif period == ARENA_PERIOD.BATTLE and totalTime == 5:
              SoundGroups.g_instance.playSound2D(XVM_SOUND_EVENT.BATTLE_END_5)
    except:
        err(traceback.format_exc())
