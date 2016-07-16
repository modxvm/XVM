""" XVM (c) www.modxvm.com 2013-2016 """

#####################################################################
# imports

import traceback

import BigWorld
import game
from Avatar import PlayerAvatar
from gui import g_guiResetters
from gui.shared import g_eventBus, events, EVENT_BUS_SCOPE
from gui.battle_control import g_sessionProvider
from gui.battle_control.battle_constants import FEEDBACK_EVENT_ID
from gui.Scaleform.Battle import Battle
from gui.Scaleform.daapi.view.battle.classic.stats_exchange import FragsCollectableStats
from gui.Scaleform.daapi.view.battle.shared.markers2d.plugins import VehicleMarkerPlugin

from xfw import *

from xvm_main.python.consts import *
from xvm_main.python.logger import *
from xvm_main.python import config

from commands import *


#####################################################################
# initialization/finalization

def start():
    g_eventBus.addListener(XVM_EVENT.CONFIG_LOADED, update_conf_hp)
    update_conf_hp()

BigWorld.callback(0, start)

@registerEvent(game, 'fini')
def fini():
    g_eventBus.removeListener(XVM_EVENT.CONFIG_LOADED, update_conf_hp)

#####################################################################
# globals

ally_frags = 0
enemy_frags = 0
ally_vehicles = 0
enemy_vehicles = 0

teams_vehicles = [{}, {}]
teams_totalhp = [0, 0]
hp_colors = {}

total_hp_color = None
total_hp_sign = None

#####################################################################
# handlers

# show quantity of alive instead of dead in frags panel
# night_dragon_on <http://www.koreanrandom.com/forum/user/14897-night-dragon-on/>

# PRE-BATTLE

@overrideMethod(PlayerAvatar, 'onBecomePlayer')
def _PlayerAvatar_onBecomePlayer(base, self):
    base(self)
    try:
        player = BigWorld.player()
        if player is not None and hasattr(player, 'arena'):
            arena = BigWorld.player().arena
            if arena:
                arena.onVehicleKilled += onVehicleKilled
        ctrl = g_sessionProvider.shared.feedback
        if ctrl:
            ctrl.onVehicleFeedbackReceived += onVehicleFeedbackReceived
        g_guiResetters.add(update_conf_hp)
    except Exception, ex:
        err(traceback.format_exc())

@overrideMethod(PlayerAvatar, 'onBecomeNonPlayer')
def _PlayerAvatar_onBecomeNonPlayer(base, self):
    try:
        player = BigWorld.player()
        if player is not None and hasattr(player, 'arena'):
            arena = BigWorld.player().arena
            if arena:
                arena.onVehicleKilled -= onVehicleKilled
        ctrl = g_sessionProvider.shared.feedback
        if ctrl:
            ctrl.onVehicleFeedbackReceived -= onVehicleFeedbackReceived
        g_guiResetters.discard(update_conf_hp)
        teams_vehicles[:] = [{}, {}]
        teams_totalhp[:] = [0, 0]
    except Exception, ex:
        err(traceback.format_exc())
    base(self)

# BATTLE

@registerEvent(Battle, 'afterCreate')
def _Battle_afterCreate(self):
    try:
        for vehicleID, vData in BigWorld.player().arena.vehicles.iteritems():
            update_hp(vehicleID, vData['vehicleType'].maxHealth)
    except Exception, ex:
        err(traceback.format_exc())

@registerEvent(Battle, 'beforeDelete')
def _Battle_beforeDelete(self):
    global ally_frags, enemy_frags, ally_vehicles, enemy_vehicles
    ally_frags = 0
    enemy_frags = 0
    ally_vehicles = 0
    enemy_vehicles = 0

@overrideMethod(FragsCollectableStats, 'getTotalStats')
def _FragCorrelationPanel_getTotalStats(base, self, arenaDP):
    try:
        global ally_frags, enemy_frags, ally_vehicles, enemy_vehicles
        isEnemyTeam = arenaDP.isEnemyTeam

        ally_frags, enemy_frags = (0, 0)
        for teamIdx, vehicleIDs in self._FragsCollectableStats__teamsDeaths.iteritems():
            score = len(vehicleIDs)
            if isEnemyTeam(teamIdx):
                ally_frags += score
            else:
                enemy_frags += score

        ally_vehicles = arenaDP.getAlliesVehiclesNumber()
        enemy_vehicles = arenaDP.getEnemiesVehiclesNumber()

        if config.get('fragCorrelation/showAliveNotFrags'):
            allyScope = ally_vehicles - enemy_frags
            enemyScope = enemy_vehicles - ally_frags
        else:
            allyScope = ally_frags
            enemyScope = enemy_frags

        self._setTotalScore(allyScope, enemyScope)
        if allyScope or enemyScope:
            return {'leftScope': allyScope,
             'rightScope': enemyScope}
        else:
            return {}
    except Exception, ex:
        err(traceback.format_exc())
    base(self)

@registerEvent(PlayerAvatar, 'updateVehicleHealth')
def setVehicleNewHealth(self, vehicleID, health, *args, **kwargs):
    update_hp(vehicleID, health)

@registerEvent(VehicleMarkerPlugin, '_VehicleMarkerPlugin__addOrUpdateVehicleMarker')
def _VehicleMarkerPlugin__addOrUpdateVehicleMarker(self, vProxy, vInfo, *args, **kwargs):
    update_hp(vProxy.id, vProxy.health)

def onVehicleKilled(self, targetID, *args, **kwargs):
    update_hp(targetID, 0)

def onVehicleFeedbackReceived(eventID, vehicleID, value, *args, **kwargs):
    try:
        if eventID == FEEDBACK_EVENT_ID.VEHICLE_HEALTH:
            update_hp(vehicleID, value[0])
        elif eventID == FEEDBACK_EVENT_ID.VEHICLE_DEAD:
            update_hp(vehicleID, 0)
    except Exception, ex:
        err(traceback.format_exc())

def update_conf_hp(*args, **kwargs):
    try:
        hp_colors.update({'bad': 'FF0000', 'neutral': 'FFFFFF', 'good': '00FF00'})
        hp_colors.update(config.get('colors/totalHP', {}))
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

def update_hp(vehicleID, hp, *args, **kwargs):
    try:
        if BigWorld.player().team == BigWorld.player().arena.vehicles[vehicleID]['team']:
            team = 0
        else:
            team = 1

        global teams_vehicles, teams_totalhp, total_hp_color, total_hp_sign

        teams_vehicles[team][vehicleID] = max(hp, 0)
        teams_totalhp[team] = sum(teams_vehicles[team].values())

        if teams_totalhp[0] < teams_totalhp[1]:
            ratio = max(min(2.0 * teams_totalhp[0] / teams_totalhp[1] - 0.9, 1), 0)
            total_hp_color = color_gradient(hp_colors['neutral'], hp_colors['bad'], ratio)
            total_hp_sign = '<'
        elif teams_totalhp[0] > teams_totalhp[1]:
            ratio = max(min(2.0 * teams_totalhp[1] / teams_totalhp[0] - 0.9, 1), 0)
            total_hp_color = color_gradient(hp_colors['neutral'], hp_colors['good'], ratio)
            total_hp_sign = '>'
        else:
            total_hp_color = color_gradient(hp_colors['neutral'], hp_colors['neutral'], 1)
            total_hp_sign = '='

        as_xfw_cmd(XVM_BATTLE_COMMAND.AS_TEAMS_HP_CHANGED)
    except Exception, ex:
        err(traceback.format_exc())
