""" XVM (c) https://modxvm.com 2013-2021 """

import traceback

from predefined_hosts import g_preDefinedHosts

from consts import *
from logger import *
import config

# process disabled servers
def initialize():
    _disabledServers = config.get('login/disabledServers', [])
    if _disabledServers:
        g_preDefinedHosts._nameMap.clear()
        g_preDefinedHosts._peripheryMap.clear()
        g_preDefinedHosts._urlMap.clear()
        g_preDefinedHosts._hosts = [x for x in g_preDefinedHosts._hosts if x.shortName not in _disabledServers]
        for idx, host in enumerate(g_preDefinedHosts._hosts):
            g_preDefinedHosts._nameMap[host.name] = idx
            g_preDefinedHosts._peripheryMap[host.peripheryID] = idx
            g_preDefinedHosts._urlMap[host.url] = idx
            if host.urlToken:
                g_preDefinedHosts._urlMap[host.urlToken] = idx
