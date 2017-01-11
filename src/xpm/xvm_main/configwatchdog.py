""" XVM (c) www.modxvm.com 2013-2017 """

__all__ = ['startConfigWatchdog', 'stopConfigWatchdog']

# PUBLIC

def startConfigWatchdog():
    # debug('startConfigWatchdog')
    _g_configWatchdog.stopConfigWatchdog()
    _g_configWatchdog.configWatchdog()


def stopConfigWatchdog():
    # debug('stopConfigWatchdog')
    _g_configWatchdog.stopConfigWatchdog()


# PRIVATE

import os
import traceback

import BigWorld
from gui.shared import g_eventBus, events

from consts import *
from logger import *

class _ConfigWatchdog(object):

    configWatchdogTimerId = None
    lastConfigDirState = None

    def configWatchdog(self):
        # debug('configWatchdog(): {0}'.format(XVM.CONFIG_DIR))

        self.configWatchdogTimerId = None

        try:
            x = [(nm, os.path.getmtime(nm))
                 for nm in [os.path.join(p, f)
                            for p, n, fn in os.walk(XVM.CONFIG_DIR)
                            for f in fn]
                 if nm[-4:].lower() != '.pyc']
            if self.lastConfigDirState is None:
                self.lastConfigDirState = x
            elif self.lastConfigDirState != x:
                self.lastConfigDirState = x
                debug('configWatchdog(): reload config')
                g_eventBus.handleEvent(events.HasCtxEvent(XVM_EVENT.RELOAD_CONFIG, {'filename':XVM.CONFIG_FILE}))
                return

        except Exception, ex:
            err(traceback.format_exc())

        self.configWatchdogTimerId = BigWorld.callback(1, self.configWatchdog)


    def stopConfigWatchdog(self):
        # debug('stopConfigWatchdog')
        if self.configWatchdogTimerId is not None:
            BigWorld.cancelCallback(self.configWatchdogTimerId)
            self.configWatchdogTimerId = None


_g_configWatchdog = _ConfigWatchdog()
