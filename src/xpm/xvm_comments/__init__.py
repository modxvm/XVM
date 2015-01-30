""" XVM (c) www.modxvm.com 2013-2015 """

#####################################################################
# MOD INFO (mandatory)

XFW_MOD_VERSION    = "2.0.0"
XFW_MOD_URL        = "http://www.modxvm.com/"
XFW_MOD_UPDATE_URL = "http://www.modxvm.com/en/download-xvm/"
XFW_GAME_VERSIONS  = ["0.9.6"]

#####################################################################
# constants

# for AS3
XPM_COMMAND_GET_COMMENTS = "xpm.get_comments"
XPM_COMMAND_SET_COMMENTS = "xpm.set_comments"

# for AS2
COMMAND_GETCOMMENTS = "getComments"


#####################################################################
# includes

import traceback

import BigWorld

from xfw import *
import simplejson

from xvm_main.python.logger import *

import comments

#####################################################################
# event handlers

# INIT

def start():
    from gui.shared import g_eventBus
    g_eventBus.addListener(XPM_CMD, onXpmCommand)

def fini():
    from gui.shared import g_eventBus
    g_eventBus.removeListener(XPM_CMD, onXpmCommand)

_BATTLE_SWF = 'battle.swf'
_VMM_SWF = 'VehicleMarkersManager.swf'
_SWFS = [_BATTLE_SWF, _VMM_SWF]

def FlashInit(self, swf, className = 'Flash', args = None, path = None):
    self.swf = swf
    if self.swf not in _SWFS:
        return
    #log("FlashInit: " + self.swf)
    self.addExternalCallback('xvm.cmd', lambda *args: onXvmCommand(self, *args))

def FlashBeforeDelete(self):
    if self.swf not in _SWFS:
        return
    #log("FlashBeforeDelete: " + self.swf)
    self.removeExternalCallback('xvm.cmd')

# onXpmCommand

_LOG_COMMANDS = (
    XPM_COMMAND_GET_COMMENTS,
    XPM_COMMAND_SET_COMMENTS,
    #COMMAND_GETCOMMENTS,
    )
# returns: (result, status)
def onXpmCommand(cmd, *args):
    try:
        if (cmd in _LOG_COMMANDS):
            debug("cmd=" + str(cmd) + " args=" + simplejson.dumps(args))
        if cmd == XPM_COMMAND_GET_COMMENTS:
            return (comments.getXvmUserComments(args[0] if len(args) else False), True)
        elif cmd == XPM_COMMAND_SET_COMMENTS:
            return (comments.setXvmUserComments(args[0]), True)
    except Exception, ex:
        err(traceback.format_exc())
        return (None, True)
    return (None, False)

def onXvmCommand(proxy, id, cmd, *args):
    try:
        if (cmd in _LOG_COMMANDS):
            debug("cmd=" + str(cmd) + " args=" + simplejson.dumps(args))
        res = None

        if cmd == COMMAND_GETCOMMENTS:
            res = comments.getXvmUserComments(args[0])
        else:
            return

        proxy.movie.invoke(('xvm.respond', [id] + res if isinstance(res, list) else [id, res]))
    except Exception, ex:
        err(traceback.format_exc())

#####################################################################
# Register events

# Early registration
from gui.Scaleform.Flash import Flash
RegisterEvent(Flash, '__init__', FlashInit)
RegisterEvent(Flash, 'beforeDelete', FlashBeforeDelete)

# Delayed registration
def _RegisterEvents():
    start()

    import game
    RegisterEvent(game, 'fini', fini)

BigWorld.callback(0, _RegisterEvents)
