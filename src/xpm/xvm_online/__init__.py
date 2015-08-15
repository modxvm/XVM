""" XVM (c) www.modxvm.com 2013-2015 """

#####################################################################
# MOD INFO

XFW_MOD_INFO = {
    # mandatory
    'VERSION':       '3.1.0',
    'URL':           'http://www.modxvm.com/',
    'UPDATE_URL':    'http://www.modxvm.com/en/download-xvm/',
    'GAME_VERSIONS': ['0.9.9','0.9.10'],
    # optional
}

#####################################################################
# constants

class XVM_ONLINE_COMMAND(object):
    ONLINE = "xvm_online.online"
    AS_ONLINEDATA = "xvm_online.as.onlinedata"
    GETCURRENTSERVER = "xvm_online.getcurrentserver"
    AS_CURRENTSERVER = "xvm_online.as.currentserver"

#####################################################################
# includes

import traceback

import BigWorld

import simplejson
from xfw import *
from xvm_main.python.logger import *
import online

#####################################################################
# event handlers

# INIT

def start():
    from gui.shared import g_eventBus
    g_eventBus.addListener(XFWCOMMAND.XFW_CMD, onXfwCommand)

def fini():
    from gui.shared import g_eventBus
    g_eventBus.removeListener(XFWCOMMAND.XFW_CMD, onXfwCommand)

# onXfwCommand

_LOG_COMMANDS = (
    #XVM_PING_COMMAND.PING,
)

# returns: (result, status)
def onXfwCommand(cmd, *args):
    try:
        if IS_DEVELOPMENT and cmd in _LOG_COMMANDS:
            debug("cmd=" + str(cmd) + " args=" + simplejson.dumps(args))
        if cmd == XVM_ONLINE_COMMAND.ONLINE:
            online.online()
            return (None, True)
        if cmd == XVM_ONLINE_COMMAND.GETCURRENTSERVER:
            getCurrentServer()
            return (None, True)
    except Exception, ex:
        err(traceback.format_exc())
        return (None, True)
    return (None, False)

def getCurrentServer(*args, **kwargs):
    from ConnectionManager import connectionManager
    debug('getCurrentServer: %s' %  connectionManager.serverUserName if len(connectionManager.serverUserName) < 13 else connectionManager.serverUserNameShort)
    as_xfw_cmd(XVM_ONLINE_COMMAND.AS_CURRENTSERVER, connectionManager.serverUserName if len(connectionManager.serverUserName) < 13 else connectionManager.serverUserNameShort)

# Delayed registration
def _RegisterEvents():
    start()
    import game
    RegisterEvent(game, 'fini', fini)
    from gui.Scaleform.daapi.view.meta.LobbyHeaderMeta import LobbyHeaderMeta
    RegisterEvent(LobbyHeaderMeta, 'as_setServerS', getCurrentServer)

BigWorld.callback(0, _RegisterEvents)
