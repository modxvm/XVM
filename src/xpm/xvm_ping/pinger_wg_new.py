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
# consts
SMOOTHNESS = 4 # we will take minimal of results (WGPinger might return higher than actual results, but not less than actual)

#############################

class _Ping(object):

    def __init__(self):
        self.url_to_serverName = {}
        self.hooks_set = False
        self.ping_history = {}
        self.autoLoginQuery_performed = False

    def ping_request(self):
        try:
            from predefined_hosts import g_preDefinedHosts
            if not self.hooks_set:
                RegisterEvent(g_preDefinedHosts, 'autoLoginQuery', self.autoLoginQuery_event, True)
                BigWorld.WGPinger.setOnPingCallback(self.results_arrived)
                self.hooks_set = True
            if not self.url_to_serverName:
                self.url_to_serverName = {host.url:host.name if len(host.name) < 13 else host.shortName for host in g_preDefinedHosts.hosts()}
            BigWorld.WGPinger.ping(self.url_to_serverName.keys())
        except Exception as ex:
            err('ping_request() exception: ' + traceback.format_exc())

    def results_arrived(self, results):
        try:
            if self.autoLoginQuery_performed:
                from predefined_hosts import g_preDefinedHosts
                g_preDefinedHosts._PreDefinedHostList__onPingPerformed(results)
                self.autoLoginQuery_performed = False
            if not len(results) or not len(self.url_to_serverName):
                return
            ping_results = {}
            best_ping = 999
            for url, ping in results:
                server_name = self.url_to_serverName[url]
                smoothed_ping = self.smooth_ping(server_name, ping)
                if smoothed_ping <= 0:
                    ping_results[server_name] = 'Error'
                else:
                    ping_results[server_name] = smoothed_ping
                    best_ping = min(best_ping, smoothed_ping)
            from ConnectionManager import connectionManager
            if (connectionManager.isConnected() and config.get('hangar/pingServers/showTitle')) or (not connectionManager.isConnected() and config.get('login/pingServers/showTitle')):
                ping_results['###best_ping###'] = best_ping # will be first in sorting by server, key is replaced by localized "Ping"
            as_xfw_cmd(XVM_PING_COMMAND.AS_PINGDATA, ping_results)
        except Exception as ex:
            err('results_arrived() exception: ' + traceback.format_exc())
            as_xfw_cmd(XVM_PING_COMMAND.AS_PINGDATA, {'Error': ex})

    def autoLoginQuery_event(*args, **kwargs):
        _ping.autoLoginQuery_performed = True

    def smooth_ping(self, server_name, new_value = 0):
        try:
            if server_name not in self.ping_history:
                self.ping_history[server_name] = []
            if new_value:
                self.ping_history[server_name].append(new_value)
                if len(self.ping_history[server_name]) > SMOOTHNESS:
                    self.ping_history[server_name].pop(0)
            return min(self.ping_history[server_name])
        except:
            err('smooth_ping() exception: ' + traceback.format_exc())
            return new_value

_ping = _Ping()
