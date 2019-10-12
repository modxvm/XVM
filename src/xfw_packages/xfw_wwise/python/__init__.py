"""
This file is part of the XVM Framework project.

Copyright (c) 2013-2019 XVM Team.

XVM Framework is free software: you can redistribute it and/or modify
it under the terms of the GNU Lesser General Public License as
published by the Free Software Foundation, version 3.

XVM Framework is distributed in the hope that it will be useful, but
WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License
along with this program. If not, see <http://www.gnu.org/licenses/>.
"""

#cpython
import logging

#BigWorld
from Avatar import PlayerAvatar

#xfw.loader
import xfw_loader.python as loader

#xfw.libraries
from xfw.events import overrideMethod
from xfw.utils import resolve_path


g_wwise = None

class XFWWWise(object):
    """
    Class that helps to load/unload WWise banks to World of Tanks
    Use g_wwise object for interaction with this class.

    Example:
        from xfw.wwise import g_wwise as wwise
        wwise.bank_add("../res_mods/audioww/mybank.bnk,True,True)
        wwise.reload_banks()
    """

    def __init__(self):
        """
        XFW_WWISE initialization
        """
        #print('XFW_WWISE/__init__')

        self.__native = None
        self.__package_name = 'com.modxvm.xfw.wwise'

        try:
            xfwnative = loader.get_mod_module('com.modxvm.xfw.native')
            if not xfwnative:
                logging.error('[XFW/WWISE] Failed to load native module. XFW Native is not available')
                return

            if not xfwnative.unpack_native(self.__package_name):
                logging.error('[XFW/WWISE] Failed to load native module. Failed to unpack native module')
                return

            self.__native = xfwnative.load_native(self.__package_name, 'xfw_wwise.pyd', 'XFW_WWISE')
            if not self.__native:
                logging.error("[XFW/WWISE] Failed to load native module. Crash report were not enabled")   
                return
        except Exception:
            logging.exception("[XFW/WWISE] Error when loading native library:")

        self.battle_config = set()
        self.hangar_config = set()

        self.battle_runtime = set()
        self.hangar_runtime = set()

        self.battle_load = False
        self.hangar_load = True

        self.banks_loaded = dict()

    def is_initialized(self):
        return self.__native is not None

    def bank_add(self, bank_path, add_to_battle, add_to_hangar, _from_config=False):
        """
        Add bank to loading list.
        Use reload() to perform bank load.

        bank_path     -- path to bank relative to ../res_mods/x.x.x/audioww/
        add_to_battle -- true to load bank in battle
        add_to_hangar -- true to load bank in hangar
        _from_config  -- do not use this
        """
        normalized_path = self.__normalize_path(bank_path)
        if add_to_battle:
            if _from_config:
                self.battle_config.add(normalized_path)
            else:
                self.battle_runtime.add(normalized_path)

        if add_to_hangar:
            if _from_config:
                self.hangar_config.add(normalized_path)
            else:
                self.hangar_runtime.add(normalized_path)

    def bank_remove(self, bank_path, remove_from_battle, remove_from_hangar, _from_config=False):
        """
        Remove bank from loading list.
        Use reload() to perform bank unload.

        bank_path          -- path to bank relative to ../res_mods/x.x.x/audioww/
        remove_from_battle -- true to unload bank from battle
        remove_from_hangar -- true to unload bank from hangar
        _from_config       -- do not use this
        """
        #print('XFW_WWISE/bank_remove')

        normalized_path = self.__normalize_path(bank_path)
        if remove_from_battle:
            if _from_config:
                if normalized_path in self.battle_config:
                    self.battle_config.remove(normalized_path)
            else:
                if normalized_path in self.battle_runtime:
                    self.battle_runtime.remove(normalized_path)

        if remove_from_battle:
            if _from_config:
                if normalized_path in self.hangar_config:
                    self.hangar_config.remove(normalized_path)
            else:
                if normalized_path in self.hangar_runtime:
                    self.hangar_runtime.remove(normalized_path)

    def set_mode(self, load_battle_banks, load_hangar_banks):
        """
        Set bank loading mode
        Use reload() to perform bank load/unload.

        load_battle_banks -- true to load battle banks
        load_hangar_banks -- true to load hangar banks
        """
        #print('XFW_WWISE/set_mode')

        if load_battle_banks:
            self.battle_load = True
        else:
            self.battle_load = False

        if load_hangar_banks:
            self.hangar_load = True
        else:
            self.hangar_load = False

    def reload_banks(self):
        """
        Perform banks load and unload
        """
        #print('XFW_WWISE/reload_banks')

        banks_to_load = set()
        banks_to_unload = set()

        if self.battle_load:
            banks_to_load = banks_to_load.union(self.battle_config).union(self.battle_runtime)

        if self.hangar_load:
            banks_to_load = banks_to_load.union(self.hangar_config).union(self.hangar_runtime)

        for key in self.banks_loaded.iterkeys():
            if key not in banks_to_load:
                banks_to_unload.add(key)

        for bank in banks_to_unload:
            self.__bank_unload(bank)

        for bank in banks_to_load:
            if bank not in self.banks_loaded:
                self.__bank_load(bank)

    def comm_init(self):
        """
        Enable WWISE Remote communication.
        """
        try:
            if self.__native is None:
                return
            self.__native.comm_init()
        except Exception:
            logging.exception("[XFW/WWISE] [comm_init]")


    def __bank_load(self, bank_path):
        """
        Load bank using WWise Native API.
        Do not use it directly. Add bank with bank_add() and then reload() instead.

        bank_path -- path relative to game root (WorldOfTanks.exe directory)
        """
        try:
            if self.__native is None:
                return

            bank_id = self.__native.bank_load(unicode(bank_path), unicode(loader.WOT_RESMODS_DIR + '/audioww/'))
            if bank_id:
                self.banks_loaded[bank_path] = bank_id
        except Exception:
            logging.exception("[XFW/WWISE] [__bank_load]")

    def __bank_unload(self, bank_path):
        """
        Unload bank using WWise Native API.
        Do not use it directly. Remove bank with bank_remove() and then reload() instead.

        bank_path -- path relative to game root (WorldOfTanks.exe directory)
        """
        try:
            bank_id = self.banks_loaded.pop(bank_path)
            if bank_id:
                if self.__native is None:
                    return
                self.__native.bank_unload(bank_id)
        except Exception:
            logging.exception("[XFW/WWISE] [__bank_unload]")

    def __normalize_path(self, path):
        """
        Normalize path to sound bank:

        cfg://* -> ../res_mods/configs/xvm/*
        res://* -> ../res_mods/mods/shared_resources/*
        xvm://* -> ../res_mods/mods/shared_resources/xvm/*
        *       -> ../res_mods/x.x.x/audioww/*
        """
        return resolve_path(path, loader.WOT_RESMODS_DIR + '/audioww/').lower()


#####################################################################
# initialization

def xfw_is_module_loaded():
    if not g_wwise:
        return False

    return g_wwise.is_initialized()

g_wwise = XFWWWise()


#####################################################################
# handlers

@overrideMethod(PlayerAvatar, 'onBecomePlayer')
def _PlayerAvatar_onBecomePlayer(base, self):
    g_wwise.set_mode(True, False)
    g_wwise.reload_banks()

    base(self)


@overrideMethod(PlayerAvatar, 'onBecomeNonPlayer')
def _PlayerAvatar_onBecomeNonPlayer(base, self):
    g_wwise.set_mode(False, True)
    g_wwise.reload_banks()

    base(self)
