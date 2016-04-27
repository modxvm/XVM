""" XVM (c) www.modxvm.com 2013-2015 """

class EVENTS(object):
    SHOW_SIXTH_SENSE_INDICATOR = 'show_sixth_sense'


import traceback

from gui.shared import g_eventBus, events
from gui.battle_control import g_sessionProvider
from gui.Scaleform.Battle import Battle

from xfw import *

from logger import *
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
    xmqp.call({'event': EVENTS.SHOW_SIXTH_SENSE_INDICATOR})

def _onSixthSenseEvent(playerId, data):
    #debug('onSixthSenseEvent: {} {}'.format(playerId, data))
    _as_xmqp_event(playerId, data)

_event_handlers[EVENTS.SHOW_SIXTH_SENSE_INDICATOR] = _onSixthSenseEvent


###

def _as_xmqp_event(playerId, data):

    arenaDP = g_sessionProvider.getArenaDP()
    vID = arenaDP.getVehIDByAccDBID(accDBID)
    if not vID:
        return

    battle = getBattleApp()
    if not battle:
        return

    movie = battle.movie
    if movie is not None:
        movie.as_xvm_onXmqpEvent(playerId, data)

    markersManager = battle.markersManager
    marker = markersManager._MarkersManager__markers.get(vID, None)
    if marker is not None:
        markersManager.invokeMarker(marker.id, 'as_xvm_onXmqpEvent', [data])
