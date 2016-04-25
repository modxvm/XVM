""" XVM (c) www.modxvm.com 2013-2015 """

class EVENTS(object):
    SHOW_SIXTH_SENSE_INDICATOR = 'show_sixth_sense'


import traceback

from gui.shared import g_eventBus, events
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
def Battle_showSixthSenseIndicator(self, isShow):
    xmqp.call({'event': EVENTS.SHOW_SIXTH_SENSE_INDICATOR})

def onSixthSenseEvent(playerId, body):
    debug('onSixthSenseEvent: {} {}'.format(playerId, body))

_event_handlers[EVENTS.SHOW_SIXTH_SENSE_INDICATOR] = onSixthSenseEvent


###
