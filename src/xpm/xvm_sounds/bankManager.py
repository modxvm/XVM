""" XVM (c) www.modxvm.com 2013-2016 """

#####################################################################
# imports

import imp
import traceback

from Avatar import PlayerAvatar
from gui.shared import g_eventBus

from xfw import *
from xfw.constants import PATH

import xvm_main.python.config as config
from xvm_main.python.consts import *
from xvm_main.python.logger import *
from xvm_main.python.utils import fixXvmPath

#####################################################################
# bank manager


class BankManager(object):
    def __init__(self):
        """
        BankManager initialization
        """
        # log('BankManager/__init__')

        self.XVMNativeSounds = imp.load_dynamic('XVMNativeSounds', './res_mods/mods/packages/xvm_sounds/native/XVMNativeSounds.pyd')

        self.battle_config = set()
        self.hangar_config = set()

        self.battle_runtime = set()
        self.hangar_runtime = set()

        self.battle_load = False
        self.hangar_load = True

        self.banks_loaded = dict()

        self.reload_config()

    def bank_add(self, bankPath, toBattle, toHangar, toConfig=False):
        """
        Add bank to loading list.
        Use reload() to perform bank load.

        bankPath -- path to bank relative to res_mods/x.x.x/audioww/
        toBattle -- true to load bank in battle
        toHangar -- true to load bank in hangar
        toConfig -- do not use this
        """
        # log('BankManager/bank_add')

        if toBattle:
            if toConfig:
                self.battle_config.add(self._normalize_path(bankPath))
            else:
                self.battle_runtime.add(self._normalize_path(bankPath))

        if toHangar:
            if toConfig:
                self.hangar_config.add(self._normalize_path(bankPath))
            else:
                self.hangar_runtime.add(self._normalize_path(bankPath))

    def bank_remove(self, bankName, fromBattle, fromHangar, fromConfig=False):
        """
        Remove bank from loading list.
        Use reload() to perform bank unload.

        bankPath -- path to bank relative to res_mods/x.x.x/audioww/
        fromBattle -- true to unload bank from battle
        fromHangar -- true to unload bank from hangar
        fromConfig -- do not use this
        """
        # log('BankManager/bank_remove')

        if fromBattle:
            if fromConfig:
                if self._normalize_name(bankName) in self.battle_config:
                    self.battle_config.remove(self._normalize_name(bankName))
            else:
                if self._normalize_name(bankName) in self.battle_runtime:
                    self.battle_runtime.remove(self._normalize_name(bankName))

        if fromHangar:
            if fromConfig:
                if self._normalize_name(bankName) in self.hangar_config:
                    self.hangar_config.remove(self._normalize_name(bankName))
            else:
                if self._normalize_name(bankName) in self.hangar_runtime:
                    self.hangar_runtime.remove(self._normalize_name(bankName))

    def set_mode(self, loadBattle, loadHangar):
        """
        Set bank loading mode
        Use reload() to perform bank load/unload.

        loadBattle -- true to load battle banks
        loadHangar -- true to load hangar banks
        """
        if loadBattle:
            self.battle_load = True
        else:
            self.battle_load = False

        if loadHangar:
            self.hangar_load = True
        else:
            self.hangar_load = False

    def reload_banks(self):
        """
        Perform banks load and unload
        """
        # log('BankManager/reload_banks')

        banksToLoad = set()
        banksToUnload = set()

        if self.battle_load:
            banksToLoad = banksToLoad.union(self.battle_config).union(self.battle_runtime)

        if self.hangar_load:
            banksToLoad = banksToLoad.union(self.hangar_config).union(self.hangar_runtime)

        for key in self.banks_loaded.iterkeys():
            if key not in banksToLoad:
                banksToUnload.add(key)

        for x in banksToUnload:
            self._bank_unload(x)

        for x in banksToLoad:
            if x not in self.banks_loaded:
                self._bank_load(x)

    def reload_config(self, e=None):
        """
        Perform config reloading
        """
        # log('BankManager/reload_config')

        self.battle_config.clear()
        self.hangar_config.clear()

        extraBanksBattle = config.get('sounds/soundBanks/battle')
        if extraBanksBattle:
            for bank in extraBanksBattle:
                self.bank_add(bank.strip(), True, False, True)

        extraBanksHangar = config.get('sounds/soundBanks/hangar')
        if extraBanksHangar:
            for bank in extraBanksHangar:
                self.bank_add(bank.strip(), False, True, True)

        self.reload_banks()

    def _bank_load(self, bankPath):
        """
        Load bank using WWise Native API.
        Do not use it directly. Add bank with bank_add() and then reload() instead.

        bankPath -- path relative to game root (WorldOfTanks.exe directory)
        """
        # log('BankManager/_bank_load: bankPath=%s' % bankPath)

        try:
            bankID = self.XVMNativeSounds.bank_load(bankPath)
            if bankID:
                self.banks_loaded[bankPath] = bankID
        except Exception, e:
            warn(e)

    def _bank_unload(self, bankPath):
        """
        Unload bank using WWise Native API.
        Do not use it directly. Remove bank with bank_remove() and then reload() instead.

        bankPath -- path relative to game root (WorldOfTanks.exe directory)
        """
        # log('BankManager/_bank_unload: bankPath=%s' % bankPath)

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
        return fixXvmPath(path, PATH.GENERAL_MODS_DIR + '/audioww/').lower()

#####################################################################
# initialization

g_xvmBankManager = None
if config.get('sounds/enabled'):
    g_xvmBankManager = BankManager()
    g_eventBus.addListener(XVM_EVENT.CONFIG_LOADED, g_xvmBankManager.reload_config)

#####################################################################
# handlers


@overrideMethod(PlayerAvatar, 'onBecomePlayer')
def _PlayerAvatar_onBecomePlayer(base, self):
    if config.get('sounds/enabled'):
        g_xvmBankManager.set_mode(True, False)
        g_xvmBankManager.reload_banks()

    base(self)


@overrideMethod(PlayerAvatar, 'onBecomeNonPlayer')
def _PlayerAvatar_onBecomeNonPlayer(base, self):
    if config.get('sounds/enabled'):
        g_xvmBankManager.set_mode(False, True)
        g_xvmBankManager.reload_banks()

    base(self)
