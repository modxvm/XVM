""" XVM (c) https://modxvm.com 2013-2020 """

import traceback
import simplejson

from gui.shared import g_eventBus, events
from helpers import dependency
from skeletons.gui.app_loader import IAppLoader, GuiGlobalSpaceID

from xfw import *
from xfw_actionscript.python import *

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
    _sendCapabilities()

def onBattleInit():
    _sendCapabilities()

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

    #debug('_as_xmqp_event: {} => {}'.format(accountDBID, data))

    if xmqp.XMQP_DEVELOPMENT:
        if accountDBID == utils.getAccountDBID():
            accountDBID = getCurrentAccountDBID()

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
    data = None if not data else unicode_to_ascii(data)

    if targets & TARGETS.BATTLE:
        as_xfw_cmd(XVM_BATTLE_COMMAND.AS_XMQP_EVENT, accountDBID, event, data)

    if targets & TARGETS.VMM:
        if g_markers.enabled:
            g_markers.call(XVM_BATTLE_COMMAND.AS_XMQP_EVENT, accountDBID, event, data)

# battle init

def _sendCapabilities():
    for accountDBID, data in list(xmqp.players_capabilities.items()):
        #debug('_sendCapabilities: {} {}'.format(accountDBID, data))
        if xmqp.XMQP_DEVELOPMENT:
            if accountDBID == utils.getAccountDBID():
                accountDBID = getCurrentAccountDBID()
        _as_xmqp_event(accountDBID, {'event': EVENTS.XMQP_HOLA, 'capabilities': data})

# "hola" xmqp event handler

def _onXmqpHola(accountDBID, data):
    accountDBID = int(accountDBID)
    if xmqp.XMQP_DEVELOPMENT:
        if accountDBID == utils.getAccountDBID():
            accountDBID = getCurrentAccountDBID()
    if accountDBID not in xmqp.players_capabilities:
        xmqp.players_capabilities[accountDBID] = data['capabilities']
        #debug('_onXmqpHola: {} {}'.format(accountDBID, data))
        _as_xmqp_event(accountDBID, data)


# WG events hooks

from gui.Scaleform.daapi.view.battle.shared.timers_panel import TimersPanel

# fire in vehicle:
#   enable: True, False

@registerEvent(TimersPanel, '_TimersPanel__setFireInVehicle')
def _TimersPanel__setFireInVehicle(self, isInFire):
    if xmqp.is_active():
        xmqp.call({'event': EVENTS.XMQP_FIRE, 'enable': isInFire})

# vehicle death timer
#   code: drown, overturn, ALL
#   enable: True, False

@registerEvent(TimersPanel, '_showDestroyTimer')
def _TimersPanel_showDestroyTimer(self, value):
    if xmqp.is_active() and dependency.instance(IAppLoader).getSpaceID() == GuiGlobalSpaceID.BATTLE:
        if value.needToCloseAll():
            xmqp.call({
                'event': EVENTS.XMQP_VEHICLE_TIMER,
                'enable': False,
                'code': 'ALL'})
        elif value.needToCloseTimer():
            xmqp.call({
                'event': EVENTS.XMQP_VEHICLE_TIMER,
                'enable': False,
                'code': value.code})
        else:
            xmqp.call({
                'event': EVENTS.XMQP_VEHICLE_TIMER,
                'enable': True,
                'code': value.code,
                'totalTime': value.totalTime,
                'level': value.level})

# death zone timers
#   zoneID: death_zone, gas_attack, ALL
#   enable: True, False

@registerEvent(TimersPanel, '_showDeathZoneTimer')
def _TimersPanel_showDeathZoneTimer(self, value):
    if xmqp.is_active() and dependency.instance(IAppLoader).getSpaceID() == GuiGlobalSpaceID.BATTLE:
        try:
            if value.needToCloseAll():
                xmqp.call({
                    'event': EVENTS.XMQP_DEATH_ZONE_TIMER,
                    'enable': False,
                    'zoneID': 'ALL'})
            elif value.needToCloseTimer():
                xmqp.call({
                    'event': EVENTS.XMQP_DEATH_ZONE_TIMER,
                    'enable': False,
                    'zoneID': value.zoneID})
            elif value.needToShow():
                xmqp.call({
                    'event': EVENTS.XMQP_DEATH_ZONE_TIMER,
                    'enable': True,
                    'zoneID': value.zoneID,
                    'totalTime': value.totalTime,
                    'level': value.level,
                    'finishTime': value.finishTime})
        except Exception as ex:
            err(traceback.format_exc())
            err('value: ' + str(value))

# sixth sense indicator

from gui.Scaleform.daapi.view.battle.shared.indicators import SixthSenseIndicator

@registerEvent(SixthSenseIndicator, 'as_showS')
def _SixthSenseIndicator_as_showS(self):
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
