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
import game
from ConnectionManager import connectionManager
from gui.shared import g_eventBus
from gui.Scaleform.daapi.view.meta.LobbyHeaderMeta import LobbyHeaderMeta

from xfw import *
import simplejson

from xvm_main.python.logger import *

import online


#####################################################################
# initialization/finalization

def start():
    g_eventBus.addListener(XFWCOMMAND.XFW_CMD, onXfwCommand)

BigWorld.callback(0, start)


@registerEvent(game, 'fini')
def fini():
    g_eventBus.removeListener(XFWCOMMAND.XFW_CMD, onXfwCommand)


#####################################################################
# onXfwCommand

# returns: (result, status)
def onXfwCommand(cmd, *args):
    try:
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
    as_xfw_cmd(XVM_ONLINE_COMMAND.AS_CURRENTSERVER, connectionManager.serverUserName if len(connectionManager.serverUserName) < 13 else connectionManager.serverUserNameShort)


#####################################################################
# handlers

@registerEvent(LobbyHeaderMeta, 'as_setServerS')
def LobbyHeaderMeta_as_setServerS(*args, **kwargs):
    getCurrentServer()

