""" XVM (c) www.modxvm.com 2013-2016 """

#####################################################################
# imports

import imp
import traceback

import game
import WWISE

from xfw import *

import xvm_main.python.config as config
from xvm_main.python.logger import *

class BankManager(object):
    def __init__(self):
        self.XVMNativeSounds = imp.load_dynamic('XVMNativeSounds','./res_mods/mods/packages/xvm_sounds/native/XVMNativeSounds.pyd')

        extraBanksBattle = config.get('sounds/soundBanks/battle')
        if extraBanksBattle:
            self.banks_battle = extraBanksBattle.split(';')
            self.banks_battle = set([x.strip() for x in self.banks_battle if x and x.strip()])
        else:
            self.banks_battle=set()

        extraBanksHangar = config.get('sounds/soundBanks/hangar')
        if extraBanksBattle:
            self.banks_hangar = extraBanksHangar.split(';')
            self.banks_hangar = set([x.strip() for x in self.banks_hangar if x and x.strip()])
        else:
            self.banks_hangar=set()

        self.banks_loaded=dict()

    def __fini__(self):
        for value in self.banks_loaded.itervalues():
            self.bank_unload(value)

    def bank_load(self, bankName):
        try:
            bankID = self.XVMNativeSounds.bank_load(bankName)
            if bankID:
                self.banks_loaded[bankName]=bankID
        except:
             warn('[Sounds] Error occured when trying to load bank %s' % bankName)

    def bank_unload(self, bankName):
        try:
            bankID = self.banks_loaded.pop(bankName)
            if bankID:
                self.XVMNativeSounds.bank_unload(bankID)
        except:
            warn('[Sounds] Error occured when trying to unload bank %s' % bankName)

    def refresh(self, battle, hangar):
        banksToLoad = set()

        if battle:
            banksToLoad = banksToLoad.union(self.banks_battle)

        if hangar:
            banksToLoad = banksToLoad.union(self.banks_hangar)

        for key, value in self.banks_loaded:
            if key not in banksToLoad:
                self.bank_unload(value)

        for x in banksToLoad:
            if x not in self.banks_loaded:
                self.bank_load(x)


g_xvmBankManager = BankManager()
g_xvmBankManager.refresh(False,True)

@registerEvent(game, 'fini')
def game_fini():
    g_xvmBankManager.__fini__()