""" XVM (c) https://modxvm.com 2013-2020 """

#####################################################################
# imports

import simplejson
import traceback

import BigWorld
import game
from Avatar import PlayerAvatar
from BattleReplay import BattleReplay, g_replayCtrl
from PlayerEvents import g_playerEvents
from gui.shared import g_eventBus, events

from xfw import *
import xvm_main.python.config as config
from xvm_main.python.logger import *
import xvm_main.python.minimap_circles as minimap_circles
import xvm_main.python.utils as utils

from consts import *


#####################################################################
# handlers

_xvm_record_data = None
_xvm_play_data = None

@registerEvent(PlayerAvatar, 'onBecomePlayer')
def _PlayerAvatar_onBecomePlayer(self):
    try:
        if not g_replayCtrl.isPlaying:
            global _xvm_record_data
            _xvm_record_data = {
              'ver': '1.0',
              'global': {
                  'minimap_circles': minimap_circles.getMinimapCirclesData()
              },
              'timing': []
            }
        else:
            #log('play: ' + str(fileName))
            arena_json_data = g_replayCtrl._BattleReplay__replayCtrl.getArenaInfoStr()
            xvm_data = simplejson.loads(arena_json_data).get('xvm', None) if arena_json_data else None
            if xvm_data:
                xvm_data = unicode_to_ascii(xvm_data)
                if xvm_data.get('ver', None) == '1.0':
                    minimap_circles.setMinimapCirclesData(xvm_data['global']['minimap_circles'])
                    global _xvm_play_data
                    _xvm_play_data = {
                        'timing': xvm_data['timing'],
                        'value': None,
                        'period': -1
                    }
                    g_playerEvents.onArenaPeriodChange += onArenaPeriodChange
                    next_data_timing()
    except Exception as ex:
        err(traceback.format_exc())


# record

def onXmqpMessage(e):
    try:
        if g_replayCtrl.isRecording:
            global _xvm_record_data
            if _xvm_record_data:
                period = g_replayCtrl._BattleReplay__arenaPeriod
                _xvm_record_data['timing'].append({
                    'p': period,
                    't': float("{0:.3f}".format(g_replayCtrl.currentTime)),
                    'm': 'XMQP',
                    'd': e.ctx
                })
    except Exception as ex:
        err(traceback.format_exc())

g_eventBus.addListener(XVM_BATTLE_EVENT.XMQP_MESSAGE, onXmqpMessage)

@registerEvent(game, 'fini')
def fini():
    g_eventBus.removeListener(XVM_BATTLE_EVENT.XMQP_MESSAGE, onXmqpMessage)

@overrideMethod(BattleReplay, 'stop')
def _BattleReplay_stop(base, self, rewindToTime = None, delete = False, isDestroyed=False):
    try:
        if self.isRecording:
            global _xvm_record_data
            if _xvm_record_data:
                arenaInfoStr = self._BattleReplay__replayCtrl.getArenaInfoStr()
                if arenaInfoStr:
                    arenaInfo = simplejson.loads(arenaInfoStr)
                    arenaInfo.update({"xvm":utils.pretty_floats(_xvm_record_data)})
                    self._BattleReplay__replayCtrl.setArenaInfoStr(simplejson.dumps(arenaInfo, separators=(',',':')))
                _xvm_record_data = None
    except Exception as ex:
        err(traceback.format_exc())

    return base(self, rewindToTime, delete, isDestroyed)


# play

def onArenaPeriodChange(period, periodEndTime, periodLength, periodAdditionalInfo):
    global _xvm_play_data
    _xvm_play_data['period'] = period
    next_data_timing()

def next_data_timing():
    global _xvm_play_data
    if _xvm_play_data['value']:
        if _xvm_play_data['value']['m'] == 'XMQP':
            g_eventBus.handleEvent(events.HasCtxEvent(XVM_BATTLE_EVENT.XMQP_MESSAGE, _xvm_play_data['value']['d']))
        _xvm_play_data['value'] = None
    if _xvm_play_data['timing']:
        if _xvm_play_data['period'] < _xvm_play_data['timing'][0]['p']:
            return
        _xvm_play_data['value'] = _xvm_play_data['timing'].pop(0)
        if _xvm_play_data['period'] > _xvm_play_data['value']['p']:
            BigWorld.callback(0, next_data_timing)
        else:
            BigWorld.callback(_xvm_play_data['value']['t'] - g_replayCtrl.currentTime, next_data_timing)
