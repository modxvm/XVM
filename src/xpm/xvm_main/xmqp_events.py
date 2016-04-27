""" XVM (c) www.modxvm.com 2013-2015 """

class EVENTS(object):
    XMQP_SPOTTED = 'xmqp_spotted'


import traceback
import simplejson

from gui.shared import g_eventBus, events
from gui.battle_control import g_sessionProvider
from gui.Scaleform.Battle import Battle

from xfw import *

from logger import *
import utils
import xmqp

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


# sixth sense indicator

@registerEvent(Battle, '_showSixthSenseIndicator')
def _Battle_showSixthSenseIndicator(self, isShow):
    xmqp.call({'event': EVENTS.XMQP_SPOTTED})

def _onSixthSenseEvent(playerId, data):
    #debug('onSixthSenseEvent: {} {}'.format(playerId, data))
    _as_xmqp_event(playerId, data)

_event_handlers[EVENTS.XMQP_SPOTTED] = _onSixthSenseEvent


###

def _as_xmqp_event(playerId, data):

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
    if not data:
        data = None
    else:
        data = unicode_to_ascii(data)

    movie = battle.movie
    if movie is not None:
        movie.as_xvm_onXmqpEvent(playerId, event, data)

    markersManager = battle.markersManager
    marker = markersManager._MarkersManager__markers.get(vID, None)
    if marker is None:
        if not xmqp.XMQP_DEVELOPMENT:
            return
        marker = markersManager._MarkersManager__markers.itervalues().next()
    if marker is not None:
        jdata = None if data is None else simplejson.dumps(data)
        markersManager.invokeMarker(marker.id, 'as_xvm_onXmqpEvent', [event, jdata])
