# Addons: "totalHp", "avgDamage" and "mainGun"
# night_dragon_on <https://kr.cm/f/p/14897/>
# ktulho <https://kr.cm/f/p/17624/>

import traceback

import BigWorld
from Vehicle import Vehicle
from Avatar import PlayerAvatar
from constants import VEHICLE_HIT_FLAGS
from CurrentVehicle import g_currentVehicle
from gui.Scaleform.daapi.view.battle.shared.frag_correlation_bar import FragCorrelationBar
from gui.Scaleform.daapi.view.lobby.hangar.Hangar import Hangar
from helpers import dependency
from skeletons.gui.game_control import IBootcampController
from skeletons.gui.shared import IItemsCache

from xfw import *
from xfw_actionscript.python import *
import xvm_battle.python.battle as battle
from xvm_main.python import config

#####################################################################
# globals

playerAvgDamage = None
teams_totalhp = [0, 0]
teams_maxhp = [0, 0]
hp_colors = {'bad': 'FF0000', 'neutral': 'FFFFFF', 'good': '00FF00'}
total_hp_color = None
total_hp_sign = None

#####################################################################
# handlers

class PlayerDamages(object):

    def __init__(self):
        self.teamHits = True

    def reset(self):
        self.teamHits = True

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

def update_conf_hp():
    try:
        hp_colors.update(config.get('colors/totalHP', hp_colors))
        for type, color in hp_colors.iteritems():
            color = color[-6:]
            hp_colors[type] = {'red': int(color[0:2], 16), 'green' : int(color[2:4], 16), 'blue': int(color[4:6], 16)}
    except Exception, ex:
        err(traceback.format_exc())

def color_gradient(color1, color2, ratio):
    try:
        ratio_comp = 1.0 - ratio
        return '%0.2X%0.2X%0.2X' % (
                color1['red'] * ratio + color2['red'] * ratio_comp,
                color1['green'] * ratio + color2['green'] * ratio_comp,
                color1['blue'] * ratio + color2['blue'] * ratio_comp,
                )
    except Exception, ex:
        err(traceback.format_exc())
        return 'FFFFFF'

def update_hp():
    try:
        global total_hp_color, total_hp_sign
        if teams_totalhp[0] < teams_totalhp[1]:
            ratio = max(min(2.0 * teams_totalhp[0] / teams_totalhp[1] - 0.9, 1), 0)
            total_hp_color = color_gradient(hp_colors['neutral'], hp_colors['bad'], ratio)
            total_hp_sign = '&lt;'
        elif teams_totalhp[0] > teams_totalhp[1]:
            ratio = max(min(2.0 * teams_totalhp[1] / teams_totalhp[0] - 0.9, 1), 0)
            total_hp_color = color_gradient(hp_colors['neutral'], hp_colors['good'], ratio)
            total_hp_sign = '&gt;'
        else:
            total_hp_color = color_gradient(hp_colors['neutral'], hp_colors['neutral'], 1)
            total_hp_sign = '&equals;'
        as_event('ON_UPDATE_HP')
    except Exception, ex:
        err(traceback.format_exc())


@registerEvent(FragCorrelationBar, 'updateTeamHealth')
def updateTeamHealth(self, alliesHP, enemiesHP, totalAlliesHP, totalEnemiesHP):
    if battle.isBattleTypeSupported:
        global teams_totalhp, teams_maxhp
        teams_totalhp = [alliesHP, enemiesHP]
        teams_maxhp = [float(totalAlliesHP), float(totalEnemiesHP)]
        update_hp()


@registerEvent(Hangar, '_Hangar__updateParams')
def Hangar__updateParams(self):
    global playerAvgDamage
    if dependency.instance(IBootcampController).isInBootcamp() or not g_currentVehicle.isPresent():
        return
    else:
        itemsCache = dependency.instance(IItemsCache)
        playerAvgDamage = itemsCache.items.getVehicleDossier(g_currentVehicle.item.intCD).getRandomStats().getAvgDamage()
        return


@registerEvent(PlayerAvatar, 'showShotResults')
def showShotResults(self, results):
    if battle.isBattleTypeSupported:
        data.showShotResults(self, results)


@registerEvent(Vehicle, 'onEnterWorld')
def onEnterWorld(self, prereqs):
    if self.isPlayerVehicle:
        update_conf_hp()


@registerEvent(PlayerAvatar, '_PlayerAvatar__destroyGUI')
def destroyGUI(self):
    global teams_totalhp, teams_maxhp
    data.reset()
    teams_totalhp = [0, 0]
    teams_maxhp = [0, 0]


def ally(norm=None):
    if (norm is None) or (teams_maxhp[0] == 0):
        return teams_totalhp[0]
    else:
        return int(teams_totalhp[0] * norm / teams_maxhp[0])


def enemy(norm=None):
    if (norm is None) or (teams_maxhp[1] == 0):
        return teams_totalhp[1]
    else:
        return int(teams_totalhp[1] * norm / teams_maxhp[1])


def color():
    return total_hp_color


def sign():
    return total_hp_sign


def text():
    return "<font color='#%s'>&nbsp;%6s %s %-6s&nbsp;</font>" % (color(), ally(), sign(), enemy())


def avgDamage(dmg_total):
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


def mainGun(dmg_total):
    battletype = BigWorld.player().arena.guiType
    if (battletype != 1) or (teams_maxhp[1] == 0):
        return
    else:
        threshold = teams_maxhp[1] * 0.2 if teams_maxhp[1] > 5000 else 1000
        high_caliber = int(threshold - dmg_total)
        if data.teamHits:
            if high_caliber <= 0:
                high_caliber = '<font color="#96FF00">+%s</font>' % (abs(high_caliber))
        else:
            if high_caliber <= 0:
                high_caliber = '<font color="#00EAFF">+%s</font>' % (abs(high_caliber))
            else:
                high_caliber = '<font color="#00EAFF">%s</font>' % (high_caliber)
    if teams_maxhp[1] >= 1000:
        return high_caliber
