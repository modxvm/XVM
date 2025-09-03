"""
SPDX-License-Identifier: GPL-3.0-or-later
Copyright (c) 2013-2025 XVM Contributors
"""

#
# Imports
#

# cpython
import logging

#BigWorld
from gui.shared import g_eventBus

# xfw.loader
import openwg_audio

#xvm
import xvm_main.config as config
from xvm_main.consts import XVM_EVENT



#
# Handlers
#

def _reload_config(e=None):
    """
    Perform config reloading
    """
    logger = logging.getLogger('XVM/Sounds')

    banks_battle = config.get('sounds/soundBanks/battle')
    if banks_battle:
        for bank in banks_battle:
            if not openwg_audio.wwise_bank_add(bank.strip(), True, False):
                logger.warning("bankManager/reload_config: failed to load bank %s" % bank.strip())

    banks_hangar = config.get('sounds/soundBanks/hangar')
    if banks_hangar:
        for bank in banks_hangar:
            if not openwg_audio.wwise_bank_add(bank.strip(), False, True):
                logger.warning("bankManager/reload_config: failed to load bank %s" % bank.strip())



#
# Initialization
#

__subscribed = False

def init():
    global __subscribed
    if config.get('sounds/enabled'):
        if not __subscribed:
            g_eventBus.addListener(XVM_EVENT.CONFIG_LOADED, _reload_config)
            __subscribed = True
        _reload_config()


def fini():
    global __subscribed
    if __subscribed:
        g_eventBus.removeListener(XVM_EVENT.CONFIG_LOADED, _reload_config)
        __subscribed = False
