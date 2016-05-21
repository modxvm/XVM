""" XVM (c) www.modxvm.com 2013-2016 """

# Authors:
# night_dragon_on <http://www.koreanrandom.com/forum/user/14897-night-dragon-on/>
# Ekspoint <http://www.koreanrandom.com/forum/user/24406-ekspoint/>

#####################################################################
# imports

import SoundGroups
from Avatar import PlayerAvatar
from gui.Scaleform.Minimap import Minimap
from gui.battle_control import g_sessionProvider

from xfw import *
import xvm_main.python.config as config
from xvm_main.python.logger import *
import traceback

#####################################################################
# constants

class XVM_SOUND_EVENT(object):
    ENEMY_SIGHTED = "xvm_enemySighted"

enemyList = {}

#####################################################################
# handlers

@registerEvent(PlayerAvatar, '_PlayerAvatar__destroyGUI')
def PlayerAvatar_PlayerAvatar__destroyGUI(self):
    global enemyList
    enemyList.clear()


@overrideMethod(Minimap, '_Minimap__addEntry')
def Minimap_Minimap__addEntry(base, self, vInfo, guiProps, location, doMark):
    base(self, vInfo, guiProps, location, doMark)
    try:
        if config.get('sounds/enabled'):
            if vInfo.vehicleID not in enemyList and not guiProps.isFriend:
                enemyList[vInfo.vehicleID] = True
                if doMark and not g_sessionProvider.getCtx().isPlayerObserver():
                    SoundGroups.g_instance.playSound2D(XVM_SOUND_EVENT.ENEMY_SIGHTED)
    except:
        err(traceback.format_exc())