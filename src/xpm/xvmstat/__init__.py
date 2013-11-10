""" xvm-stat (c) sirmax 2013 """

#####################################################################
# MOD INFO (mandatory)

XPM_MOD_VERSION    = "1.0.2"
XPM_MOD_URL        = "http://www.modxvm.com/"
XPM_MOD_UPDATE_URL = "http://www.modxvm.com/en/download-xvm/"
XPM_GAME_VERSIONS  = ["0.8.9"]

#####################################################################

import BigWorld
import GUI

from gui.mods.xpm import *
from logger import *
from XvmStat import g_xvm

_SWFS = [
    'Application.swf',
    'battle.swf',
    'VehicleMarkersManager.swf',
    ]

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

def FlashBeforeDelete(self):
    if self.swf not in _SWFS:
        return
    debug("FlashBeforeDelete: " + self.swf)

def AppAfterCreate(self):
    #debug('AppAfterCreate')
    from gui.Scaleform.framework.entities.View import View
    class XvmViewStub(View):
        pass
    from gui.Scaleform.framework import VIEW_TYPE, VIEW_SCOPE, g_entitiesFactories, ViewSettings
    g_entitiesFactories.addSettings(
        ViewSettings('xvm', XvmViewStub, '../../../xvm/mods/xvm.swf', VIEW_TYPE.SERVICE_LAYOUT, None, VIEW_SCOPE.DEFAULT))
    self.loadView('xvm')

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

    from gui.Scaleform.framework.application import App
    RegisterEvent(App, 'afterCreate', AppAfterCreate)

    #from Avatar import PlayerAvatar
    #RegisterEvent(PlayerAvatar, 'onEnterWorld', onEnterWorld)
    #RegisterEvent(PlayerAvatar, 'onLeaveWorld', onLeaveWorld)

BigWorld.callback(0.001, _RegisterEvents)
