""" XVM (c) www.modxvm.com 2013-2017 """

#####################################################################
# imports

import BigWorld
import SoundGroups

from xfw import *
import xvm_main.python.config as config
from xvm_main.python.logger import *

import imp
import traceback

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