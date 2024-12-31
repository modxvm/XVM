"""
SPDX-License-Identifier: GPL-3.0-or-later
Copyright (c) 2013-2025 XVM Contributors
"""

#
# Imports
#

# stdlib
import logging

# BigWorld
import BigWorld
from gui.shared import g_eventBus
from predefined_hosts import g_preDefinedHosts
from gui.Scaleform.daapi.view.lobby.header.LobbyHeader import LobbyHeader
from skeletons.connection_mgr import IConnectionManager
from helpers import dependency

# XFW
from xfw import *

# XFW ActionScript
from xfw_actionscript.python import *

# XVM Main
from xvm_main.python.consts import *

# XVM Ping
import pinger



#
# Constants
#

class XVM_PING_COMMAND(object):
    PING = "xvm_ping.ping"
    AS_PINGDATA = "xvm_ping.as.pingdata"
    GETCURRENTSERVER = "xvm_ping.getcurrentserver"
    AS_CURRENTSERVER = "xvm_ping.as.currentserver"



#
# Handlers/XFW
#

# returns: (result, status)
def onXfwCommand(cmd, *args):
    try:
        if cmd == XVM_PING_COMMAND.PING:
            pinger.ping()
            return (None, True)
        elif cmd == XVM_PING_COMMAND.GETCURRENTSERVER:
            getCurrentServer()
            return (None, True)
    except Exception:
        logging.getLogger('XVM/Ping').exception('onXfwCommand')
        return (None, True)
    return (None, False)


def getCurrentServer(*args, **kwargs):
    connectionMgr = dependency.instance(IConnectionManager)
    as_xfw_cmd(XVM_PING_COMMAND.AS_CURRENTSERVER, connectionMgr.serverUserName if len(connectionMgr.serverUserName) < 13 else connectionMgr.serverUserNameShort)



#
# Handlers/LobbyHeader
#

def LobbyHeader_as_setServerS(*args, **kwargs):
    getCurrentServer()



#
# Handlers/WGPinger
#

# WGPinger (WARNING: bugs with the multiple hosts)
def PreDefinedHostList_autoLoginQuery(base, callback):
    # debug('> PreDefinedHostList_autoLoginQuery')
    import pinger_wg
    if pinger_wg.request_sent:
        BigWorld.callback(0, lambda: PreDefinedHostList_autoLoginQuery(base, callback))
    else:
        # debug('login ping: start')
        pinger_wg.request_sent = True
        BigWorld.WGPinger.setOnPingCallback(PreDefinedHostList_onPingPerformed)
        base(callback)


def PreDefinedHostList_onPingPerformed(result):
    # debug('login ping: end')
    import pinger_wg
    pinger_wg.request_sent = False
    g_preDefinedHosts._PreDefinedHostList__onPingPerformed(result)



#
# XFW API
#

__initialized = False

def xfw_module_init():
    global __initialized
    if not __initialized:
        pinger.update_config()

        registerEvent(LobbyHeader, 'as_setServerS')(LobbyHeader_as_setServerS)
        # Read the comment for handler
        # overrideMethod(g_preDefinedHosts, 'autoLoginQuery')(PreDefinedHostList_autoLoginQuery)

        g_eventBus.addListener(XFW_COMMAND.XFW_CMD, onXfwCommand)
        g_eventBus.addListener(XVM_EVENT.CONFIG_LOADED, pinger.update_config)

        __initialized = True


def xfw_module_fini():
    global __initialized
    if __initialized:
        g_eventBus.removeListener(XFW_COMMAND.XFW_CMD, onXfwCommand)
        g_eventBus.removeListener(XVM_EVENT.CONFIG_LOADED, pinger.update_config)

        __initialized = False


def xfw_is_module_loaded():
    global __initialized
    return __initialized
