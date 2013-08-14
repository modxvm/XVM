""" xvm-stat (c) sirmax 2013 """

from predefined_hosts import g_preDefinedHosts

from gui.mods.utils import *

#############################
# Command

def ping(*args):
    g_preDefinedHosts._PreDefinedHostList__ping()
    pings = g_preDefinedHosts._PreDefinedHostList__pingResult
    try:
        return dict(map(lambda item: (item.name, pings[item.url]), g_preDefinedHosts._hosts))
    except:
        return None
