import xvm_battle.python.fragCorrelationPanel as panel
from xfw import *

def ally():
    return panel.teams_totalhp[0]

def enemy():
    return panel.teams_totalhp[1]

def color():
    return panel.total_hp_color

def sign():
    return '&lt;' if panel.total_hp_sign == '<' else '&gt;' if panel.total_hp_sign == '>' else panel.total_hp_sign

def text():
    return "<font color='#%s'>&nbsp;%6s %s %-6s&nbsp;</font>" % (color(), ally(), sign(), enemy())

@registerEvent(panel, 'update_hp')
def update_hp(vehicleID, hp):
    as_event('ON_UPDATE_HP')
	
# Addons: "avgDamage" and "mainGun"
# night_dragon_on <http://www.koreanrandom.com/forum/user/14897-night-dragon-on/>
# ktulho <http://www.koreanrandom.com/forum/user/17624-ktulho/>

import BigWorld
from CurrentVehicle import g_currentVehicle
from gui.Scaleform.daapi.view.lobby.hangar.Hangar import Hangar
from gui.shared import g_itemsCache
import traceback

playerAvgDamage = None

@registerEvent(Hangar, '_Hangar__updateParams')
def Hangar__updateParams(self):
    try:
        global playerAvgDamage
        playerAvgDamage = g_itemsCache.items.getVehicleDossier(g_currentVehicle.item.intCD).getRandomStats().getAvgDamage()
        return playerAvgDamage
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
max_hp_enemy = 0

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
            if playerAvatar.team == arenaVehicles[vehicleID]['team'] and playerAvatar.playerVehicleID != vehicleID:
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
    if actual_arenaUniqueID != arenaUniqueID:
      actual_arenaUniqueID = arenaUniqueID
      max_hp_enemy = None
    if max_hp_enemy is None:
        max_hp_enemy = panel.teams_totalhp[1] if panel.teams_totalhp[1] != 0 else None
    battletype = BigWorld.player().arena.guiType
    if (battletype != 1) and (max_hp_enemy is None):
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
