""" XVM (c) www.modxvm.com 2013-2016 """

import traceback
import simplejson

from gui.shared import g_eventBus, events
from gui.app_loader import g_appLoader
from gui.app_loader.settings import GUI_GLOBAL_SPACE_ID
from gui.battle_control import g_sessionProvider

from xfw import *

import xvm_main.python.config as config
from xvm_main.python.logger import *
import xvm_main.python.utils as utils

from consts import *
import xmqp
from vehicleMarkers import g_markers


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


def onXmqpConnected(e):
    #debug('onXmqpConnected')
    # send "hola" broadcast
    data = {'event': EVENTS.XMQP_HOLA, 'capabilities': xmqp.getCapabilitiesData()}
    if xmqp.is_active():
        xmqp.call(data)

def onBattleInit():
    _sendCapabilities(TARGETS.BATTLE)

def onVehicleMarkersInit():
    _sendCapabilities(TARGETS.VMM)

def onXmqpMessage(e):
    try:
        #debug('onXmqpMessage: ' + str(e.ctx))
        data = e.ctx.get('data', '')
        event_type = data['event']
        global _event_handlers
        if event_type in _event_handlers:
            _event_handlers[event_type](e.ctx.get('accountDBID', ''), data)
        else:
            debug('unknown XMQP message: {}'.format(data))
    except Exception as ex:
        err(traceback.format_exc())


# XMQP default event handler

def _as_xmqp_event(accountDBID, data, targets=TARGETS.ALL):

    log('_as_xmqp_event: {} => {}'.format(accountDBID, data))

    if xmqp.XMQP_DEVELOPMENT:
        if accountDBID == utils.getAccountDBID():
            accountDBID = getCurrentAccountDBID()

    #arenaDP = g_sessionProvider.getArenaDP()
    #vehicleID = arenaDP.getVehIDByAccDBID(accountDBID)
    #if not vehicleID:
    #    return

    battle = getBattleApp()
    if not battle:
        return

    if not data:
        warn('[XMQP] no data')
        return

    if 'event' not in data:
        warn('[XMQP] no "event" field in data: %s' % str(data))
        return

    event = data['event']
    del data['event']
    data = None if not data else unicode_to_ascii(data)

    if targets & TARGETS.BATTLE:
        as_xfw_cmd(XVM_BATTLE_COMMAND.AS_XMQP_EVENT, accountDBID, event, data)

    if targets & TARGETS.VMM:
        if g_markers.active:
            g_markers.call(XVM_BATTLE_COMMAND.AS_XMQP_EVENT, accountDBID, event, data)

# battle init

def _sendCapabilities(targets):
    for accountDBID, data in xmqp.players_capabilities.iteritems():
        _as_xmqp_event(accountDBID, {'event': EVENTS.XMQP_HOLA, 'capabilities': data}, targets)

# "hola" xmqp event handler

def _onXmqpHola(accountDBID, data):
    if xmqp.XMQP_DEVELOPMENT:
        if accountDBID == utils.getAccountDBID():
            accountDBID = getCurrentAccountDBID()
    #debug('_onXmqpHola: {} {}'.format(accountDBID, data))
    if accountDBID not in xmqp.players_capabilities:
        xmqp.players_capabilities[accountDBID] = data['capabilities']
        _as_xmqp_event(accountDBID, data)


# WG events hooks

# fire in vehicle:
#   enable: True, False

# TODO:0.9.16
#@registerEvent(Battle, '_setFireInVehicle')
def _Battle_setFireInVehicle(self, isFire):
    if xmqp.is_active():
        xmqp.call({'event':EVENTS.XMQP_FIRE,'enable':isFire})

# vehicle death timer
#   code: drown, overturn, ALL
#   enable: True, False

# TODO:0.9.16
#@registerEvent(Battle, '_showVehicleTimer')
def _Battle_showVehicleTimer(self, value):
    if xmqp.is_active() and g_appLoader.getSpaceID() == GUI_GLOBAL_SPACE_ID.BATTLE:
        code, time, warnLvl = value
        xmqp.call({
            'event':EVENTS.XMQP_VEHICLE_TIMER,
            'enable':True,
            'code':code,
            'time':time,
            'warnLvl':warnLvl})

# TODO:0.9.16
#@registerEvent(Battle, '_hideVehicleTimer')
def _Battle_hideVehicleTimer(self, code = None):
    if xmqp.is_active() and g_appLoader.getSpaceID() == GUI_GLOBAL_SPACE_ID.BATTLE:
        if code is None:
            code = 'ALL'
        xmqp.call({
            'event':EVENTS.XMQP_VEHICLE_TIMER,
            'enable':False,
            'code':code})

# death zone timers
#   zoneID: death_zone, gas_attack, ALL
#   enable: True, False

# TODO:0.9.16
#@registerEvent(Battle, 'showDeathzoneTimer')
def _Battle_showDeathzoneTimer(self, value):
    if xmqp.is_active() and g_appLoader.getSpaceID() == GUI_GLOBAL_SPACE_ID.BATTLE:
        zoneID, time, warnLvl = value
        xmqp.call({
            'event':EVENTS.XMQP_DEATH_ZONE_TIMER,
            'enable':True,
            'zoneID':zoneID,
            'time':time,
            'warnLvl':warnLvl})

# TODO:0.9.16
#@registerEvent(Battle, 'hideDeathzoneTimer')
def _Battle_hideDeathzoneTimer(self, zoneID = None):
    if xmqp.is_active() and g_appLoader.getSpaceID() == GUI_GLOBAL_SPACE_ID.BATTLE:
        if zoneID is None:
            zoneID = 'ALL'
        xmqp.call({
            'event':EVENTS.XMQP_DEATH_ZONE_TIMER,
            'enable':False,
            'zoneID':zoneID})

# sixth sense indicator

# TODO:0.9.16
#@registerEvent(Battle, '_showSixthSenseIndicator')
def _Battle_showSixthSenseIndicator(self, isShow):
    if xmqp.is_active():
        xmqp.call({'event': EVENTS.XMQP_SPOTTED})

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


# register event handlers

_event_handlers = {
    EVENTS.XMQP_HOLA: _onXmqpHola,
    EVENTS.XMQP_FIRE: _as_xmqp_event,
    EVENTS.XMQP_VEHICLE_TIMER: _as_xmqp_event,
    EVENTS.XMQP_DEATH_ZONE_TIMER: _as_xmqp_event,
    EVENTS.XMQP_SPOTTED: _as_xmqp_event,
    EVENTS.XMQP_MINIMAP_CLICK: lambda id, data: _as_xmqp_event(id, data, targets=TARGETS.BATTLE)}
