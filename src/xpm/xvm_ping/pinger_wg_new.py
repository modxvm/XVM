""" XVM (c) www.modxvm.com 2013-2015 """

#############################
# Command

def ping():
    _ping.ping_request()

#############################
# Private

import traceback
import BigWorld
from xfw import *
from xvm_main.python.logger import *
from . import XVM_PING_COMMAND
import xvm_main.python.config as config

#############################

class _Ping(object):

    def __init__(self):
        self.url_to_serverName = {}
        self.callback_set = False

    def ping_request(self):
        try:
            from predefined_hosts import g_preDefinedHosts
            if not self.callback_set:
                RegisterEvent(g_preDefinedHosts, '_PreDefinedHostList__onPingPerformed', self.results_arrived)
                BigWorld.WGPinger.setOnPingCallback(g_preDefinedHosts._PreDefinedHostList__onPingPerformed) # set with attached event
                self.callback_set = True
            if not self.url_to_serverName:
                self.url_to_serverName = {host.url:host.shortName for host in g_preDefinedHosts.hosts()}
            BigWorld.WGPinger.ping(self.url_to_serverName.keys())
        except Exception as ex:
            err('ping_request() exception: ' + traceback.format_exc())
    
    def results_arrived(self, results):
        try:
            from predefined_hosts import g_preDefinedHosts
            if not len(results):
                return
            ping_results = {}
            best_ping = 999
            for url, ping in results:
                if ping <= 0:
                    ping_results[self.url_to_serverName[url]] = 'Error'
                else:
                    ping_results[self.url_to_serverName[url]] = ping
                    best_ping = min(best_ping, ping)
            from ConnectionManager import connectionManager
            if (connectionManager.isConnected() and config.get('hangar/pingServers/showTitle')) or (not connectionManager.isConnected() and config.get('login/pingServers/showTitle')):
                ping_results['###best_ping###'] = best_ping # will be first in sorting by server, key is replaced by localized "Ping"
            as_xfw_cmd(XVM_PING_COMMAND.AS_PINGDATA, ping_results)
        except Exception as ex:
            err('results_arrived() exception: ' + traceback.format_exc())
            as_xfw_cmd(XVM_PING_COMMAND.AS_PINGDATA, {'Error': ex})

_ping = _Ping()
