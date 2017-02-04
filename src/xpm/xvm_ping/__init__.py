""" XVM (c) www.modxvm.com 2013-2017 """

#####################################################################
# MOD INFO

XFW_MOD_INFO = {
    # mandatory
    'VERSION':       '0.9.17.1',
    'URL':           'http://www.modxvm.com/',
    'UPDATE_URL':    'http://www.modxvm.com/en/download-xvm/',
    'GAME_VERSIONS': ['0.9.17.1'],
    # optional
}


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
from ConnectionManager import connectionManager
from gui.shared import g_eventBus
from predefined_hosts import g_preDefinedHosts
from gui.Scaleform.daapi.view.meta.LobbyHeaderMeta import LobbyHeaderMeta

from xfw import *

from xvm_main.python.consts import *
from xvm_main.python.logger import *

import pinger
#import pinger_wg as pinger


#####################################################################
# initialization/finalization

def start():
    g_eventBus.addListener(XFWCOMMAND.XFW_CMD, onXfwCommand)
    g_eventBus.addListener(XVM_EVENT.CONFIG_LOADED, pinger.update_config)
    pinger.update_config()

BigWorld.callback(0, start)


@registerEvent(game, 'fini')
def fini():
    g_eventBus.removeListener(XFWCOMMAND.XFW_CMD, onXfwCommand)
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
    as_xfw_cmd(XVM_PING_COMMAND.AS_CURRENTSERVER, connectionManager.serverUserName if len(connectionManager.serverUserName) < 13 else connectionManager.serverUserNameShort)


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
