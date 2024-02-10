"""
SPDX-License-Identifier: GPL-3.0-or-later
Copyright (c) 2013-2024 XVM Contributors
"""

#####################################################################
# constants

class XVM_PING_COMMAND(object):
    PING = "xvm_ping.ping"
    AS_PINGDATA = "xvm_ping.as.pingdata"
    GETCURRENTSERVER = "xvm_ping.getcurrentserver"
    AS_CURRENTSERVER = "xvm_ping.as.currentserver"


#####################################################################
# includes

import traceback

import BigWorld
import game
from gui.shared import g_eventBus
from predefined_hosts import g_preDefinedHosts
from gui.Scaleform.daapi.view.meta.LobbyHeaderMeta import LobbyHeaderMeta
from helpers import dependency
from skeletons.connection_mgr import IConnectionManager

from xfw import *
from xfw_actionscript.python import *

from xvm_main.python.consts import *
from xvm_main.python.logger import *

import pinger
#import pinger_wg as pinger


#####################################################################
# initialization/finalization

def start():
    g_eventBus.addListener(XFW_COMMAND.XFW_CMD, onXfwCommand)
    g_eventBus.addListener(XVM_EVENT.CONFIG_LOADED, pinger.update_config)
    pinger.update_config()

BigWorld.callback(0, start)


@registerEvent(game, 'fini')
def fini():
    g_eventBus.removeListener(XFW_COMMAND.XFW_CMD, onXfwCommand)
    g_eventBus.removeListener(XVM_EVENT.CONFIG_LOADED, pinger.update_config)

#####################################################################
# onXfwCommand

# returns: (result, status)
def onXfwCommand(cmd, *args):
    try:
        if cmd == XVM_PING_COMMAND.PING:
            pinger.ping()
            return (None, True)
        if cmd == XVM_PING_COMMAND.GETCURRENTSERVER:
            getCurrentServer()
            return (None, True)
    except Exception, ex:
        err(traceback.format_exc())
        return (None, True)
    return (None, False)


def getCurrentServer(*args, **kwargs):
    connectionMgr = dependency.instance(IConnectionManager)
    as_xfw_cmd(XVM_PING_COMMAND.AS_CURRENTSERVER, connectionMgr.serverUserName if len(connectionMgr.serverUserName) < 13 else connectionMgr.serverUserNameShort)


#####################################################################
# handlers

@registerEvent(LobbyHeaderMeta, 'as_setServerS')
def LobbyHeaderMeta_as_setServerS(*args, **kwargs):
    getCurrentServer()


#####################################################################
# WGPinger (WARNING: bugs with the multiple hosts)

#@overrideMethod(g_preDefinedHosts, 'autoLoginQuery')
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
    pinger_wg.request_sent = False
    g_preDefinedHosts._PreDefinedHostList__onPingPerformed(result)
