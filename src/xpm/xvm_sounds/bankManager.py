"""
This file is part of the XVM project.

Copyright (c) 2013-2021 XVM Team.

XVM is free software: you can redistribute it and/or modify
it under the terms of the GNU Lesser General Public License as
published by the Free Software Foundation, version 3.

XVM is distributed in the hope that it will be useful, but
WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License
along with this program. If not, see <http://www.gnu.org/licenses/>.
"""

#cpython
import logging

#BigWorld
from gui.shared import g_eventBus

#xfw.loader
import xfw_loader.python as loader

#xvm
import xvm_main.python.config as config
from xvm_main.python.consts import *
from xvm_main.python.logger import *

def _reload_config(e=None):
    """
    Perform config reloading
    """
    wwise_module = loader.get_mod_module('com.modxvm.xfw.wwise')
    if not wwise_module:
        logging.error("[XVM/Sounds] [bankmanager/reload_config] XFW.WWISE is failed to load")

    banks_battle = config.get('sounds/soundBanks/battle')
    if banks_battle:
        for bank in banks_battle:
            wwise_module.wwise_bank_add(bank.strip(), True, False)

    banks_hangar = config.get('sounds/soundBanks/hangar')
    if banks_hangar:
        for bank in banks_hangar:
            wwise_module.wwise_bank_add(bank.strip(), False, True)


if loader.is_mod_loaded('com.modxvm.xfw.wwise'):
    if config.get('sounds/enabled'):
        g_eventBus.addListener(XVM_EVENT.CONFIG_LOADED, _reload_config)
        _reload_config()
else:
    logging.warning('[XVM/Sounds] [bank_loader] failed to load sound banks because XFW.WWISE is not loaded')
