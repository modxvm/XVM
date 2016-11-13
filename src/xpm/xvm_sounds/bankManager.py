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
        """
        BankManager initialization
        """
        self.XVMNativeSounds = imp.load_dynamic('XVMNativeSounds','./res_mods/mods/packages/xvm_sounds/native/XVMNativeSounds.pyd')

        self.banks_battle=set()
        extraBanksBattle = config.get('sounds/soundBanks/battle')
        if extraBanksBattle:
            for bank in extraBanksBattle:
                self.bank_add(bank.strip(),True,False)
            
        self.banks_hangar=set()
        extraBanksHangar = config.get('sounds/soundBanks/hangar')
        if extraBanksHangar:
            for bank in extraBanksHangar:
                self.bank_add(bank.strip(),False,True)

        self.banks_loaded=dict()

    def __fini__(self):
        """
        BankManager finalization
        """
        for value in self.banks_loaded.itervalues():
            self.bank_unload(value)


    def bank_add(self,bankName,toBattle,toHangar):
        """
        Add bank to loading list.
        Use reload() to perform bank load.
        """
        if toBattle:
            self.banks_battle.add(self._normalize_path(bankName))

        if toHangar:
            self.banks_hangar.add(self._normalize_path(bankName))

    def bank_remove(self,bankName,fromBattle,fromHangar):
        """
        Remove bank from loading list.
        Use reload() to perform bank unload.
        """
        if fromBattle:
            if self._normalize_name(bankName) in self.banks_battle:
                self.banks_battle.remove(self._normalize_name(bankName))

        if fromHangar:
            if self._normalize_name(bankName) in self.banks_hangar:
                self.banks_hangar.remove(self._normalize_name(bankName))

    def reload(self, loadBattleBanks, loadHangarBanks):
        """
        Perform banks load and unload from banks_battle and/or banks_hangar

        loadBattleBanks -- True to load banks from banks_battle
        loadHangarBanks -- True to load banks from banks_hangar
        """
        #log('BankManager/Reload: battle=%s, hangar=%s' % (loadBattleBanks, loadHangarBanks))

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
            self._bank_unload(x)

        for x in banksToLoad:
            if x not in self.banks_loaded:
                self._bank_load(x)

    def _bank_load(self, bankPath):
        """
        Load bank using WWise Native API.
        Do not use it directly. Add bank with bank_add() and then reload() instead.

        bankPath -- path relative to game root (WorldOfTanks.exe directory)
        """
        #log('BankManager/BankLoad: bankPath=%s' % bankPath)

        try:
            bankID = self.XVMNativeSounds.bank_load(bankPath)
            if bankID:
                self.banks_loaded[bankPath]=bankID
        except Exception, e:
            warn(e)

    def _bank_unload(self, bankPath):
        """
        Unload bank using WWise Native API. 
        Do not use it directly. Remove bank with bank_remove() and then reload() instead.

        bankPath -- path relative to game root (WorldOfTanks.exe directory)
        """
        #log('BankManager/BankUnload: bankPath=%s' % bankPath)

        try:
            bankID = self.banks_loaded.pop(bankPath)
            if bankID:
                self.XVMNativeSounds.bank_unload(bankID)
        except Exception, e:
            warn(e)

    def _normalize_path(self, path):
        """
        Normalize path to sound bank:

        cfg://* -> /res_mods/configs/xvm/*
        xvm://* -> /res_mods/mods/shared_resources/xvm/*
        *       -> /res_mods/x.x.x/audioww/*
        """
        return fixXvmPath(path,PATH.GENERAL_MODS_DIR + '/audioww/').lower()

#####################################################################
# initialization

g_xvmBankManager = None
if config.get('sounds/enabled'):
    g_xvmBankManager = BankManager()
    g_xvmBankManager.reload(False,True)

#####################################################################
# handlers

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