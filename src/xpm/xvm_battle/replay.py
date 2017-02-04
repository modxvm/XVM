""" XVM (c) www.modxvm.com 2013-2017 """

#####################################################################
# imports

import datetime
import io
import os
import simplejson
import traceback

import BigWorld
from constants import ARENA_PERIOD
import game
from Avatar import PlayerAvatar
from BattleReplay import BattleReplay, g_replayCtrl
from PlayerEvents import g_playerEvents
from gui.shared import g_eventBus, events

from xfw import *
import xvm_main.python.config as config
from xvm_main.python.logger import *
import xvm_main.python.minimap_circles as minimap_circles

from consts import *


#####################################################################
# handlers

# record

_resultingFileName = None
_fileName = None
_data = None

@registerEvent(PlayerAvatar, 'onBecomePlayer')
def _PlayerAvatar_onBecomePlayer(self):
    if not g_replayCtrl.isPlaying:
        global _resultingFileName, _fileName, _data
        _data = {
          'ver': '1.0',
          'global': {
              'minimap_circles': minimap_circles.getMinimapCirclesData()
          },
          'timing': []
        }
        _fileName = _resultingFileName
    else:
        #log('play: ' + str(fileName))
        try:
            fileName = g_replayCtrl._BattleReplay__fileName + '.xvm'
            if os.path.isfile(fileName):
                with io.open(fileName, 'r', encoding='utf-8') as f:
                    data = simplejson.loads(f.read())
                    if data:
                        data = unicode_to_ascii(data)
                        if data.get('ver', None) == '1.0':
                            minimap_circles.setMinimapCirclesData(data['global']['minimap_circles'])
                            global _playdata
                            _playdata = {
                                'timing': data['timing'],
                                'value': None,
                                'period': -1
                            }
                            g_playerEvents.onArenaPeriodChange += onArenaPeriodChange
                            next_data_timing()
        except Exception as ex:
            err(traceback.format_exc())

def onXmqpMessage(e):
    if g_replayCtrl.isRecording:
        global _data
        if _data:
            period = g_replayCtrl._BattleReplay__arenaPeriod
            _data['timing'].append({
                'p': period,
                't': g_replayCtrl.currentTime,
                'm': 'XMQP',
                'd': e.ctx
            })

g_eventBus.addListener(XVM_BATTLE_EVENT.XMQP_MESSAGE, onXmqpMessage)

@registerEvent(game, 'fini')
def fini():
    g_eventBus.removeListener(XVM_BATTLE_EVENT.XMQP_MESSAGE, onXmqpMessage)

@registerEvent(BattleReplay, 'setResultingFileName')
def _BattleReplay_setResultingFileName(self, fileName, overwriteExisting = False):
    global _resultingFileName
    _resultingFileName = fileName

@registerEvent(BattleReplay, 'onClientReady')
def _BattleReplay_onClientReady(self):
    if self.isRecording:
        global _fileName
        if not _fileName:
            #20170203_1809_czech-Cz03_LT_vz35_100_thepit.wotreplay
            now = datetime.datetime.now().strftime("%Y%m%d_%H%M")
            player = BigWorld.player()
            vehicleName = BigWorld.entities[player.playerVehicleID].typeDescriptor.name.replace(':', '-')
            arenaName = player.arena.arenaType.geometry
            i = arenaName.find('/')
            if i != -1:
                arenaName = arenaName[i + 1:]
            _fileName = '{}_{}_{}.wotreplay'.format(now, vehicleName, arenaName)
            _fileName = os.path.join(self._BattleReplay__replayDir, _fileName)
        _fileName += '.xvm'

@overrideMethod(BattleReplay, 'stop')
def _BattleReplay_stop(base, self, rewindToTime = None, delete = False):
    try:
        if self.isRecording:
            global _fileName, _data
            if _fileName and _data:
                with io.open(_fileName, 'w', encoding='utf-8') as f:
                    f.write(unicode(simplejson.dumps(_data, ensure_ascii=False)))
                _fileName = None
                _data = None
    except Exception as ex:
        err(traceback.format_exc())

    return base(self, rewindToTime, delete)


# play

_playdata = None

def onArenaPeriodChange(period, periodEndTime, periodLength, periodAdditionalInfo):
    global _playdata
    _playdata['period'] = period
    next_data_timing()

def next_data_timing():
    global _playdata
    if _playdata['value']:
        if _playdata['value']['m'] == 'XMQP':
            g_eventBus.handleEvent(events.HasCtxEvent(XVM_BATTLE_EVENT.XMQP_MESSAGE, _playdata['value']['d']))
        _playdata['value'] = None
    if _playdata['timing']:
        if _playdata['period'] < _playdata['timing'][0]['p']:
            return
        _playdata['value'] = _playdata['timing'].pop(0)
        if _playdata['period'] > _playdata['value']['p']:
            BigWorld.callback(0, next_data_timing)
        else:
            BigWorld.callback(_playdata['value']['t'] - g_replayCtrl.currentTime, next_data_timing)
