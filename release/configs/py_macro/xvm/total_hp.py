import xvm_battle.python.fragCorrelationPanel as panel
from xfw import *
from xfw_actionscript.python import *

max_hp_enemy = 0
max_hp_ally = 0


def ally(norm=None):
    global max_hp_ally
    if panel.teams_totalhp[0] > max_hp_ally:
        max_hp_ally = panel.teams_totalhp[0]
    if (norm is None) or (max_hp_ally == 0):
        return panel.teams_totalhp[0]
    else:
        return int(panel.teams_totalhp[0] * norm / max_hp_ally)


def enemy(norm=None):
    global max_hp_enemy
    if panel.teams_totalhp[1] > max_hp_enemy:
        max_hp_enemy = panel.teams_totalhp[1]
    if (norm is None) or (max_hp_enemy == 0):
        return panel.teams_totalhp[1]
    else:
        return int(panel.teams_totalhp[1] * norm / max_hp_enemy)


def color():
    return panel.total_hp_color


def sign():
    if panel.total_hp_sign == '<':
        return '&lt;'
    elif panel.total_hp_sign == '>':
        return '&gt;'
    elif panel.total_hp_sign is None:
        return ''
    else:
        return panel.total_hp_sign


def text():
    return "<font color='#%s'>&nbsp;%6s %s %-6s&nbsp;</font>" % (color(), ally(), sign(), enemy())


@registerEvent(panel, 'update_hp')
def update_hp(vehicleID, hp):
    as_event('ON_UPDATE_HP')


# Addons: "avgDamage" and "mainGun"
# night_dragon_on <https://kr.cm/f/p/14897/>
# ktulho <https://kr.cm/f/p/17624/>

import traceback
import BigWorld
from CurrentVehicle import g_currentVehicle
from gui.Scaleform.daapi.view.lobby.hangar.Hangar import Hangar
from helpers import dependency
from skeletons.gui.game_control import IBootcampController
from skeletons.gui.shared import IItemsCache

playerAvgDamage = None


@registerEvent(Hangar, '_Hangar__updateParams')
def Hangar__updateParams(self):
    try:
        if dependency.instance(IBootcampController).isInBootcamp() or not g_currentVehicle.isPresent():
            return
        global playerAvgDamage
        itemsCache = dependency.instance(IItemsCache)
        playerAvgDamage = itemsCache.items.getVehicleDossier(g_currentVehicle.item.intCD).getRandomStats().getAvgDamage()
        return
    except:
        err(traceback.format_exc())


def avgDamage(dmg_total):
    global playerAvgDamage
    battletype = BigWorld.player().arena.guiType
    if battletype != 1:
        return
    elif playerAvgDamage == None:
        return
    else:
        avgDamage = int(playerAvgDamage - dmg_total)
        if avgDamage <= 0:
            avgDamage = '<font color="#96FF00">+%s</font>' % (abs(avgDamage))
    return avgDamage


from Avatar import PlayerAvatar
from constants import VEHICLE_HIT_FLAGS

actual_arenaUniqueID = None


class PlayerDamages(object):
    def __init__(self):
        self.teamHits = True

    def reset(self):
        global max_hp_enemy, max_hp_ally
        self.teamHits = True
        max_hp_enemy = 0
        max_hp_ally = 0

    def showShotResults(self, playerAvatar, results):
        arenaVehicles = playerAvatar.arena.vehicles
        VHF = VEHICLE_HIT_FLAGS
        for r in results:
            vehicleID = r & 4294967295L
            flags = r >> 32 & 4294967295L
            if playerAvatar.team == arenaVehicles[vehicleID]['team'] and playerAvatar.playerVehicleID != vehicleID and arenaVehicles[vehicleID]['isAlive']:
                if flags & (VHF.IS_ANY_DAMAGE_MASK | VHF.ATTACK_IS_DIRECT_PROJECTILE):
                    self.teamHits = False


data = PlayerDamages()


@registerEvent(PlayerAvatar, 'showShotResults')
def showShotResults(self, results):
    data.showShotResults(self, results)


@registerEvent(PlayerAvatar, '_PlayerAvatar__destroyGUI')
def destroyGUI(self):
    data.reset()


def mainGun(dmg_total):
    global actual_arenaUniqueID, max_hp_enemy
    arenaUniqueID = BigWorld.player().arenaUniqueID

    if panel.teams_totalhp[1] > max_hp_enemy:
        max_hp_enemy = panel.teams_totalhp[1]
    battletype = BigWorld.player().arena.guiType
    if (battletype != 1) or (max_hp_enemy == 0):
        return
    else:
        threshold = max_hp_enemy * 0.2 if max_hp_enemy > 5000 else 1000
        high_caliber = int(threshold - dmg_total)
        if data.teamHits:
            if high_caliber <= 0:
                high_caliber = '<font color="#96FF00">+%s</font>' % (abs(high_caliber))
        else:
            if high_caliber <= 0:
                high_caliber = '<font color="#00EAFF">+%s</font>' % (abs(high_caliber))
            else:
                high_caliber = '<font color="#00EAFF">%s</font>' % (high_caliber)
    if max_hp_enemy >= 1000:
        return high_caliber
