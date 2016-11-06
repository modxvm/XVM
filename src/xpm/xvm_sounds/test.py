""" XVM (c) www.modxvm.com 2013-2016 """

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

try:
    XVMNativeSounds = imp.load_dynamic('XVMNativeSounds','./res_mods/mods/packages/xvm_sounds/native/XVMNativeSounds.pyd')
    
    #method 1: using filename
    #bankID = XVMNativeSounds.bank_load_by_filename('XVM.bnk')
    #XVMNativeSounds.bank_unload_by_filename('XVM.bnk')

    #method 2: using memory and bankID
    bankID = XVMNativeSounds.bank_load_by_memory('./res_mods/0.9.16/audioww/XVM.bnk')
    #XVMNativeSounds.bank_unload_by_bankid(bankID)

    BigWorld.callback(10, _test)
except Exception:
    print("=============================")
    traceback.print_exc()
    print("=============================")