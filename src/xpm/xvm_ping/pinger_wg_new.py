""" XVM (c) www.modxvm.com 2013-2015 """

#############################
# Command

def ping():
    _ping.get_ping()

#############################
# Private

import traceback
import BigWorld
from xvm_main.python.logger import *
from . import XVM_PING_COMMAND

#############################

class _Ping(object):

    def __init__(self):
        self.url_to_serverName = {}

    def get_ping(self):
        try:
            from predefined_hosts import g_preDefinedHosts
            if not self.url_to_serverName:
                self.url_to_serverName = {host.url:host.shortName for host in g_preDefinedHosts.hosts()}
            BigWorld.WGPinger.ping(self.url_to_serverName.keys())
            ping_results = {}
            best_ping = 999
            for url, ping in g_preDefinedHosts._PreDefinedHostList__pingResult.iteritems():
                ping_results[self.url_to_serverName[url]] = ping
                best_ping = min(best_ping, ping)
            if not len(ping_results):
                return
            ping_results['###best_ping###'] = best_ping # will be first in sorting by server, key is replaced by localized "Ping"
            as_xfw_cmd(XVM_PING_COMMAND.AS_PINGDATA, ping_results)
        except Exception as ex:
            err('get_ping() exception: ' + traceback.format_exc())
            as_xfw_cmd(XVM_PING_COMMAND.AS_PINGDATA, {'Error': ex})

_ping = _Ping()
