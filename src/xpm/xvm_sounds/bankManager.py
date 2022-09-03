"""
SPDX-License-Identifier: GPL-3.0-or-later
Copyright (c) 2016-2022 XVM Contributors
"""

#
# Imports
#

# cpython
import logging

#BigWorld
from gui.shared import g_eventBus

# xfw.loader
import xfw_loader.python as loader

#xvm
import xvm_main.python.config as config
from xvm_main.python.consts import XVM_EVENT



#
# Handlers
#

def _reload_config(e=None):
    """
    Perform config reloading
    """
    logger = logging.getLogger('XVM/Sounds')

    wwise_module = loader.get_mod_module('com.modxvm.xfw.wwise')
    if not wwise_module:
        logger.error("bankManager/reload_config XFW.WWISE is failed to load")

    banks_battle = config.get('sounds/soundBanks/battle')
    if banks_battle:
        for bank in banks_battle:
            if not wwise_module.wwise_bank_add(bank.strip(), True, False):
                logger.warning("bankManager/reload_config: failed to load bank %s" % bank.strip())

    banks_hangar = config.get('sounds/soundBanks/hangar')
    if banks_hangar:
        for bank in banks_hangar:
            if not wwise_module.wwise_bank_add(bank.strip(), False, True):
                logger.warning("bankManager/reload_config: failed to load bank %s" % bank.strip())



#
# Initialization
#

__subscribed = False

def init():
    global __subscribed
    if loader.is_mod_loaded('com.modxvm.xfw.wwise'):
        if config.get('sounds/enabled'):
            if not __subscribed:
                g_eventBus.addListener(XVM_EVENT.CONFIG_LOADED, _reload_config)
                __subscribed = True
            _reload_config()
    else:
        logging.getLogger('XVM/Sounds').warning('bankManager/init: failed to load sound banks because XFW.WWISE is not loaded')


def fini():
    global __subscribed
    if __subscribed:
        g_eventBus.removeListener(XVM_EVENT.CONFIG_LOADED, _reload_config)
        __subscribed = False