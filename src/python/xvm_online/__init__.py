"""
SPDX-License-Identifier: GPL-3.0-or-later
Copyright (c) 2013-2025 XVM Contributors
"""

#####################################################################
# constants

class XVM_ONLINE_COMMAND(object):
    ONLINE = "xvm_online.online"
    AS_ONLINEDATA = "xvm_online.as.onlinedata"
    GETCURRENTSERVER = "xvm_online.getcurrentserver"
    AS_CURRENTSERVER = "xvm_online.as.currentserver"


#
# Imports

# stdlib
import logging

# BigWorld
from gui.shared import g_eventBus
from gui.Scaleform.daapi.view.lobby.header.LobbyHeader import LobbyHeader
from skeletons.connection_mgr import IConnectionManager
from helpers import dependency

# XFW
from xfw import *

# XFW ActionScript
from xfw_actionscript.python import *

# XVM Main
from xvm_main.python.consts import *

# XVM Online
import online



#
# Handlers/XFW
#

# returns: (result, status)
def onXfwCommand(cmd, *args):
    try:
        if cmd == XVM_ONLINE_COMMAND.ONLINE:
            online.online()
            return (None, True)
        elif cmd == XVM_ONLINE_COMMAND.GETCURRENTSERVER:
            getCurrentServer()
            return (None, True)
    except Exception:
        logging.getLogger('XVM/Online').exception('onXfwCommand')
        return (None, True)
    return (None, False)


def getCurrentServer(*args, **kwargs):
    connectionMgr = dependency.instance(IConnectionManager)
    as_xfw_cmd(XVM_ONLINE_COMMAND.AS_CURRENTSERVER, connectionMgr.serverUserName if len(connectionMgr.serverUserName) < 13 else connectionMgr.serverUserNameShort)



#
# Handlers/LobbyHeader
#

def LobbyHeader_as_setServerS(*args, **kwargs):
    getCurrentServer()



#
# XFW API
#

__initialized = False

def xfw_module_init():
    global __initialized
    if not __initialized:
        online.update_config()

        registerEvent(LobbyHeader, 'as_setServerS')(LobbyHeader_as_setServerS)

        g_eventBus.addListener(XFW_COMMAND.XFW_CMD, onXfwCommand)
        g_eventBus.addListener(XVM_EVENT.CONFIG_LOADED, online.update_config)

        __initialized = True


def xfw_module_fini():
    global __initialized
    if __initialized:
        g_eventBus.removeListener(XFW_COMMAND.XFW_CMD, onXfwCommand)
        g_eventBus.removeListener(XVM_EVENT.CONFIG_LOADED, online.update_config)

        __initialized = False


def xfw_is_module_loaded():
    global __initialized
    return __initialized

