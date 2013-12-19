""" xvm (c) sirmax 2013 """

#####################################################################
# MOD INFO (mandatory)

XPM_MOD_VERSION    = "1.0.3"
XPM_MOD_URL        = "http://www.modxvm.com/"
XPM_MOD_UPDATE_URL = "http://www.modxvm.com/en/download-xvm/"
XPM_GAME_VERSIONS  = ["0.8.10"]

#####################################################################

import BigWorld
import GUI
from gui.shared import events

from gui.mods.xpm import *
from logger import *
from xvm import g_xvm

_SWFS = [
    'Application.swf',
    'battle.swf',
    'VehicleMarkersManager.swf',
    ]

_APP_SWF = 'Application.swf'

#####################################################################
# event handlers

def handleKeyEvent(event):
    g_xvm.onKeyDown(event)


def FlashInit(self, swf, className = 'Flash', args = None, path = None):
    self.swf = swf
    if self.swf not in _SWFS:
        return
    debug("FlashInit: " + self.swf)
    self.addExternalCallback('xvm.cmd', lambda *args: g_xvm.onXvmCommand(self, *args))
    if self.swf == _APP_SWF:
        import appstart
        self.addListener(events.GUICommonEvent.APP_STARTED, lambda e: appstart.AppStarted(self, e))


def FlashBeforeDelete(self):
    if self.swf not in _SWFS:
        return
    debug("FlashBeforeDelete: " + self.swf)


#####################################################################
# Register events

# Early registration
from gui.Scaleform.Flash import Flash
RegisterEvent(Flash, '__init__', FlashInit)
RegisterEvent(Flash, 'beforeDelete', FlashBeforeDelete)

# Delayed registration
def _RegisterEvents():
    import game
    RegisterEvent(game, 'handleKeyEvent', handleKeyEvent)

BigWorld.callback(0.001, _RegisterEvents)
