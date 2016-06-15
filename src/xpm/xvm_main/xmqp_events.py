""" XVM (c) www.modxvm.com 2013-2016 """

class EVENTS(object):
    XMQP_HOLA = 'xmqp_hola'
    XMQP_FIRE = 'xmqp_fire'
    XMQP_VEHICLE_TIMER = 'xmqp_vehicle_timer'
    XMQP_DEATH_ZONE_TIMER = 'xmqp_death_zone_timer'
    XMQP_SPOTTED = 'xmqp_spotted'
    XMQP_MINIMAP_CLICK = 'xmqp_minimap_click'

class TARGETS(object):
    NONE   = 0x00
    BATTLE = 0x01
    VMM    = 0x02
    ALL    = 0xFF

import traceback
import simplejson

from gui.shared import g_eventBus, events
from gui.app_loader import g_appLoader
from gui.app_loader.settings import GUI_GLOBAL_SPACE_ID
from gui.battle_control import g_sessionProvider
from gui.Scaleform.Battle import Battle
from gui.Scaleform.Minimap import Minimap

from xfw import *

from logger import *
import config
import minimap_circles
import utils
import xmqp

def onXmqpConnected(e):
    global _players_xmqp_status
    _players_xmqp_status = {}
    _send_xmqp_hola()

def onStateBattle():
    global _players_xmqp_status
    for playerId, data in _players_xmqp_status.iteritems():
        _as_xmqp_event(playerId, data)

def onXmqpMessage(e):
    try:
        #debug('onXmqpMessage: ' + str(e.ctx))
        data = e.ctx.get('data', '')
        event_type = data['event']
        global _event_handlers
        if event_type in _event_handlers:
            _event_handlers[event_type](e.ctx.get('playerId', ''), data)
        else:
            debug('unknown XMQP message: {}'.format(data))
    except Exception as ex:
        err(traceback.format_exc())


# XMQP default event handler

_event_handlers = {}

def _as_xmqp_event(playerId, data, targets=TARGETS.ALL):

    if xmqp.XMQP_DEVELOPMENT:
        if playerId == utils.getPlayerId():
            playerId = getCurrentPlayerId()

    arenaDP = g_sessionProvider.getArenaDP()
    vID = arenaDP.getVehIDByAccDBID(playerId)
    if not vID:
        return

    battle = getBattleApp()
    if not battle:
        return

    if not data:
        warn('[XMQP] no data')
        return

    if 'event' not in data:
        warn('[XMQP] no event in data: %s' % str(data))
        return

    event = data['event']
    del data['event']
    data = None if not data else unicode_to_ascii(data)

    if targets & TARGETS.BATTLE:
        movie = battle.movie
        if movie is not None:
            movie.as_xvm_onXmqpEvent(playerId, event, data)

    if targets & TARGETS.VMM:
        markersManager = battle.markersManager
        marker = markersManager._MarkersManager__markers.get(vID, None)
        if marker is None:
            if not xmqp.XMQP_DEVELOPMENT:
                return
            marker = markersManager._MarkersManager__markers.itervalues().next()
        if marker is not None:
            jdata = None if data is None else simplejson.dumps(data)
            markersManager.invokeMarker(marker.id, 'as_xvm_onXmqpEvent', [event, jdata])


# WG events hooks

_players_xmqp_status = {}

def _send_xmqp_hola():
    mcdata = minimap_circles.getMinimapCirclesData()
    if mcdata is None:
        mcdata = {}
    data = {'event': EVENTS.XMQP_HOLA,
            'sixthSense': mcdata.get('commander_sixthSense', None)}
    if xmqp.is_active():
        xmqp.call(data)

    global _players_xmqp_status
    currentPlayerId = getCurrentPlayerId()
    if currentPlayerId not in _players_xmqp_status:
        _players_xmqp_status[currentPlayerId] = data

def _onXmqpHola(playerId, data):
    if xmqp.XMQP_DEVELOPMENT:
        if playerId == utils.getPlayerId():
            playerId = getCurrentPlayerId()
    #debug('_onXmqpHola: {} {}'.format(playerId, data))
    #if playerId not in _players_xmqp_status:
    #    _players_xmqp_status[playerId] = data
    #    _send_xmqp_hola()
    #    _as_xmqp_event(playerId, data)

_event_handlers[EVENTS.XMQP_HOLA] = _onXmqpHola


# fire in vehicle:
#   enable: True, False

@registerEvent(Battle, '_setFireInVehicle')
def _Battle_setFireInVehicle(self, isFire):
    if xmqp.is_active():
        xmqp.call({'event':EVENTS.XMQP_FIRE,'enable':isFire})

_event_handlers[EVENTS.XMQP_FIRE] = _as_xmqp_event


# vehicle death timer
#   code: drown, overturn, ALL
#   enable: True, False

@registerEvent(Battle, '_showVehicleTimer')
def _Battle_showVehicleTimer(self, value):
    if xmqp.is_active() and g_appLoader.getSpaceID() == GUI_GLOBAL_SPACE_ID.BATTLE:
        code, time, warnLvl = value
        xmqp.call({
            'event':EVENTS.XMQP_VEHICLE_TIMER,
            'enable':True,
            'code':code,
            'time':time,
            'warnLvl':warnLvl})

@registerEvent(Battle, '_hideVehicleTimer')
def _Battle_hideVehicleTimer(self, code = None):
    if xmqp.is_active() and g_appLoader.getSpaceID() == GUI_GLOBAL_SPACE_ID.BATTLE:
        if code is None:
            code = 'ALL'
        xmqp.call({
            'event':EVENTS.XMQP_VEHICLE_TIMER,
            'enable':False,
            'code':code})

_event_handlers[EVENTS.XMQP_VEHICLE_TIMER] = _as_xmqp_event


# death zone timers
#   zoneID: death_zone, gas_attack, ALL
#   enable: True, False

@registerEvent(Battle, 'showDeathzoneTimer')
def _Battle_showDeathzoneTimer(self, value):
    if xmqp.is_active() and g_appLoader.getSpaceID() == GUI_GLOBAL_SPACE_ID.BATTLE:
        zoneID, time, warnLvl = value
        xmqp.call({
            'event':EVENTS.XMQP_DEATH_ZONE_TIMER,
            'enable':True,
            'zoneID':zoneID,
            'time':time,
            'warnLvl':warnLvl})

@registerEvent(Battle, 'hideDeathzoneTimer')
def _Battle_hideDeathzoneTimer(self, zoneID = None):
    if xmqp.is_active() and g_appLoader.getSpaceID() == GUI_GLOBAL_SPACE_ID.BATTLE:
        if zoneID is None:
            zoneID = 'ALL'
        xmqp.call({
            'event':EVENTS.XMQP_DEATH_ZONE_TIMER,
            'enable':False,
            'zoneID':zoneID})

_event_handlers[EVENTS.XMQP_DEATH_ZONE_TIMER] = _as_xmqp_event


# sixth sense indicator

@registerEvent(Battle, '_showSixthSenseIndicator')
def _Battle_showSixthSenseIndicator(self, isShow):
    if xmqp.is_active():
        xmqp.call({'event': EVENTS.XMQP_SPOTTED})

_event_handlers[EVENTS.XMQP_SPOTTED] = _as_xmqp_event


# minimap click

def send_minimap_click(path):
    #debug('send_minimap_click: [...]')
    if xmqp.is_active():
        path = [[int(x), int(y)] for x,y in path]
        #debug('send_minimap_click: {}'.format(path))
        xmqp.call({
            'event': EVENTS.XMQP_MINIMAP_CLICK,
            'path': path,
            'color': config.networkServicesSettings.x_minimap_clicks_color})

_event_handlers[EVENTS.XMQP_MINIMAP_CLICK] = lambda id, data: \
    _as_xmqp_event(id, data, targets=TARGETS.BATTLE)
