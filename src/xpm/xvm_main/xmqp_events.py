""" XVM (c) www.modxvm.com 2013-2015 """

class EVENTS(object):
    XMQP_HOLA = 'xmqp_hola'
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
from gui.battle_control import g_sessionProvider
from gui.Scaleform.Battle import Battle
from gui.Scaleform.Minimap import Minimap

from xfw import *

from logger import *
import config
import utils
import xmqp

def onXmqpConnected(e):
    _send_xmqp_hola()

def onStateBattle():
    global _players_xmqp_status
    for playerId in _players_xmqp_status.iterkeys():
        _as_xmqp_event(playerId, {'event': EVENTS.XMQP_HOLA})

_event_handlers = {}
def onXmqpMessage(e):
    try:
        body = e.ctx.get('body', '')
        event_type = body['event']
        if event_type in _event_handlers:
            _event_handlers[event_type](e.ctx.get('playerId', ''), body)
        else:
            debug('unknown XMQP message: {}'.format(body))
    except Exception as ex:
        err(traceback.format_exc())


# hola

_players_xmqp_status = {}

def _send_xmqp_hola():
    global _players_xmqp_status
    _players_xmqp_status = {getCurrentPlayerId():True}
    if xmqp.is_active():
        xmqp.call({'event': EVENTS.XMQP_HOLA})

def _onXmqpHola(playerId, data):
    if xmqp.XMQP_DEVELOPMENT:
        if playerId == utils.getPlayerId():
            playerId = getCurrentPlayerId()
    #debug('_onXmqpHola: {} {}'.format(playerId, data))
    if playerId not in _players_xmqp_status:
        _players_xmqp_status[playerId] = True
        xmqp.call({'event': EVENTS.XMQP_HOLA})
        _as_xmqp_event(playerId, data)

_event_handlers[EVENTS.XMQP_HOLA] = _onXmqpHola


# sixth sense indicator

@registerEvent(Battle, '_showSixthSenseIndicator')
def _Battle_showSixthSenseIndicator(self, isShow):
    if xmqp.is_active():
        xmqp.call({'event': EVENTS.XMQP_SPOTTED})

def _onSixthSenseEvent(playerId, data):
    #debug('_onSixthSenseEvent: {} {}'.format(playerId, data))
    _as_xmqp_event(playerId, data)

_event_handlers[EVENTS.XMQP_SPOTTED] = _onSixthSenseEvent


# minimap click

@registerEvent(Minimap, '_onMapClicked')
def _Minimap_onMapClicked(self, _, x, y, bHighlightCellNVehicleSpecific = True):
    #debug('_Minimap_onMapClicked')
    if xmqp.is_active():
        if bHighlightCellNVehicleSpecific:
            xmqp.call({
                'event': EVENTS.XMQP_MINIMAP_CLICK,
                'x': x,
                'y': y,
                'color': config.networkServicesSettings.x_minimap_clicks_color})

def _onMinimapClick(playerId, data):
    #debug('_onMinimapClick: {} {}'.format(playerId, data))
    _as_xmqp_event(playerId, data, targets=TARGETS.BATTLE)

_event_handlers[EVENTS.XMQP_MINIMAP_CLICK] = _onMinimapClick


###

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
