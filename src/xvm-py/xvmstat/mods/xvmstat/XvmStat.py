""" xvm-stat (c) sirmax 2013 """

import json
import BigWorld
from messenger.gui import MessengerDispatcher

from gui.mods.utils import *

from constants import *
from ping import ping

class XvmStat(object):
    def __init__(self):
        pass

    def onXvmCommand(self, proxy, id, cmd, *args):
        res = None
        if cmd == COMMAND_PING:
            res = ping(*args)
            #pprint(res)
        else:
            log("cmd=" + str(cmd) + " args=" + json.dumps(args))
        proxy.respond([id, json.dumps(res)])

    def onKeyDown(self, event):
        # do not handle keys when chat is active
        if MessengerDispatcher.g_instance.battleMessenger.isFocused():
            return
        key = event.key
        if event.isKeyDown() and not event.isRepeatedEvent():
            #log("key=" + str(key))
            #return True
            pass
        return False
