""" xvm-stat (c) sirmax 2013 """

import BigWorld
from gui.mods.utils import *
from xvmstat.XvmStat import XvmStat

#####################################################################
# event handlers

xvm = None

def handleKeyEvent(event):
    global xvm
    if xvm is not None:
        return xvm.onKeyDown(event)

def FlashInit(self, swf, *args):
    #log(swf)
    global xvm
    if xvm is None:
        xvm = XvmStat()
    self.addExternalCallback('xvm.cmd', lambda *args: xvm.onXvmCommand(self, *args))

def populateUI(self, *args):
    global xvm
    if xvm is None:
        xvm = XvmStat()
    if self.uiHolder is not None:
        self.uiHolder.addExternalCallback('xvm.cmd',
          lambda *args: log(str(args)))

def dispossessUI(self, *args):
    if self.uiHolder is not None:
        self.uiHolder.removeExternalCallback('xvm.cmd')


#####################################################################
# Register events

# Early registration
#log(">>start")
from gui.Scaleform.Flash import Flash
RegisterEvent(Flash, '__init__', FlashInit)

#from gui.Scaleform.windows import UIInterface
#RegisterEvent(UIInterface, 'populateUI', populateUI)
#RegisterEvent(UIInterface, 'dispossessUI', dispossessUI, True)

# Delayed registration
def _RegisterEvents():
  #log(">>reg")
  import game
  RegisterEvent(game, 'handleKeyEvent', handleKeyEvent)

  #from Avatar import PlayerAvatar
  #RegisterEvent(PlayerAvatar, 'onEnterWorld', onEnterWorld)
  #RegisterEvent(PlayerAvatar, 'onLeaveWorld', onLeaveWorld)

BigWorld.callback(0.001, _RegisterEvents)
