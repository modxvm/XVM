""" XVM (c) www.modxvm.com 2013-2015 """

# PUBLIC

def start():
    _g_fps.start()

def stop():
    _g_fps.stop()

# PRIVATE

import BigWorld

from xfw import *
from xvm_main.python.logger import *
import xvm_main.python.config as config

class _Fps():

    intervalId = None

    def __init__(self):
        from BattleReplay import g_replayCtrl
        self.replayCtrl = g_replayCtrl
        self.isReplay = g_replayCtrl.isPlaying

    def start(self):
        if not config.config:
            #debug('wait')
            BigWorld.callback(0, self.start)
            return
        if self.intervalId is not None:
            stop()
        if config.config['export']['fps']['enabled']:
            #debug('fps start')
            self.interval = config.config['export']['fps']['interval']
            self.intervalId = BigWorld.callback(self.interval, self.update)

    def stop(self):
        #debug('fps stop')
        if self.intervalId is not None:
            BigWorld.cancelCallback(self.intervalId)
            self.intervalId = None

    def update(self):
        #debug('update')
        period = getArenaPeriod()
        time = max(0, int(BigWorld.time() * 1000))
        fps = BigWorld.getFPS()[1]

        if period == 3:
            self.add_value(period, time, fps)

        self.intervalId = BigWorld.callback(self.interval, self.update)

    def add_value(self, period, time, fps):
        #debug('fps: {0} per: {1} time: {2}'.format(fps, period, time))
        pass

_g_fps = None
def _init():
    global _g_fps
    _g_fps = _Fps()
BigWorld.callback(0, _init)
