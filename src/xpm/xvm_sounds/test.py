""" XVM (c) https://modxvm.com 2013-2021 """

#####################################################################
# imports

import traceback

import BigWorld
import SoundGroups

from xfw import *
from xvm_main.python.logger import *


#####################################################################
# constants

class XVM_SOUND_EVENT(object):
    SIXTH_SENSE_RUDY = "xvm_sixthSenseRudy"

#####################################################################
# handlers

def _test():
    log('test')
    SoundGroups.g_instance.playSound2D(XVM_SOUND_EVENT.SIXTH_SENSE_RUDY)
    BigWorld.callback(3, _test)

#try:
#    BigWorld.callback(10, _test)
#except Exception:
#    print("=============================")
#    traceback.print_exc()
#    print("=============================")