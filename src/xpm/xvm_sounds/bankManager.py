""" XVM (c) www.modxvm.com 2013-2016 """

#####################################################################
# imports

import imp
import traceback

from Avatar import PlayerAvatar

from xfw import *
from xfw.constants import PATH

import xvm_main.python.config as config
from xvm_main.python.logger import *
from xvm_main.python.utils import fixXvmPath

#####################################################################
# bank manager
 
class BankManager(object):
    def __init__(self):
        self.XVMNativeSounds = imp.load_dynamic('XVMNativeSounds','./res_mods/mods/packages/xvm_sounds/native/XVMNativeSounds.pyd')

        extraBanksBattle = config.get('sounds/soundBanks/battle')
        if extraBanksBattle:
            self.banks_battle = set([x.strip() for x in extraBanksBattle if x and x.strip()])
        else:
            self.banks_battle=set()

        extraBanksHangar = config.get('sounds/soundBanks/hangar')
        if extraBanksHangar:
            self.banks_hangar = set([x.strip() for x in extraBanksHangar if x and x.strip()])
        else:
            self.banks_hangar=set()

        self.banks_loaded=dict()

    def __fini__(self):
        for value in self.banks_loaded.itervalues():
            self.bank_unload(value)

    def bank_load(self, bankName):
        #log('BankManager/BankLoad: bankName=%s' % bankName)
        bankName=fixXvmPath(bankName,PATH.GENERAL_MODS_DIR + '/audioww/').lower()

        try:
            bankID = self.XVMNativeSounds.bank_load(bankName)
            if bankID:
                self.banks_loaded[bankName]=bankID
        except Exception, e:
            warn(e)

    def bank_unload(self, bankName):
        #log('BankManager/BankUnload: bankName=%s' % bankName)
        bankName=fixXvmPath(bankName,PATH.GENERAL_MODS_DIR + '/audioww/').lower()

        try:
            bankID = self.banks_loaded.pop(bankName)
            if bankID:
                self.XVMNativeSounds.bank_unload(bankID)
        except Exception, e:
            warn(e)

    def reload(self, loadBattleBanks, loadHangarBanks):
        #log('BankManager/Reload: battle=%s, hangar=%s' % (loadBattleBanks, loadHangarBanks) )
        banksToLoad = set()
        banksToUnload = set()

        if loadBattleBanks:
            banksToLoad = banksToLoad.union(self.banks_battle)

        if loadHangarBanks:
            banksToLoad = banksToLoad.union(self.banks_hangar)

        for key in self.banks_loaded.iterkeys():
            if key not in banksToLoad:
                banksToUnload.add(key)

        for x in banksToUnload:
            self.bank_unload(x)

        for x in banksToLoad:
            if x not in self.banks_loaded:
                self.bank_load(x)

#####################################################################
# handlers

g_xvmBankManager = None
if config.get('sounds/enabled'):
    g_xvmBankManager = BankManager()
    g_xvmBankManager.reload(False,True)

@overrideMethod(PlayerAvatar, 'onBecomePlayer')
def _PlayerAvatar_onBecomePlayer(base, self):
    if config.get('sounds/enabled'):
        g_xvmBankManager.reload(True,False)

    base(self)

@overrideMethod(PlayerAvatar, 'onBecomeNonPlayer')
def _PlayerAvatar_onBecomeNonPlayer(base, self):
    if config.get('sounds/enabled'):
        g_xvmBankManager.reload(False,True)

    base(self)