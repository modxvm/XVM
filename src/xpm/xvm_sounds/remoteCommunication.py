""" XVM (c) https://modxvm.com 2013-2017 """

from xfw_wwise.python import g_wwise as wwise
import xvm_main.python.config as config

if config.get('sounds/remote_communication', False):
    try:
        wwise.comm_init()
    except Exception:
        print "xvm_sounds/remotecommunication: failed to start remote communication"
