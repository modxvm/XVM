""" XVM (c) https://modxvm.com 2013-2018 """

#####################################################################
# imports

from xfw_wwise.python import g_wwise as wwise

from gui.shared import g_eventBus

import xvm_main.python.config as config
from xvm_main.python.consts import *
from xvm_main.python.logger import *

def _reload_config(e=None):
    """
    Perform config reloading
    """
    # log('BankManager/reload_config')

    wwise.battle_config.clear()
    wwise.hangar_config.clear()

    banks_battle = config.get('sounds/soundBanks/battle')
    if banks_battle:
        for bank in banks_battle:
            wwise.bank_add(bank.strip(), True, False, True)

    banks_hangar = config.get('sounds/soundBanks/hangar')
    if banks_hangar:
        for bank in banks_hangar:
            wwise.bank_add(bank.strip(), False, True, True)

    wwise.reload_banks()

if config.get('sounds/enabled'):
    g_eventBus.addListener(XVM_EVENT.CONFIG_LOADED, _reload_config)
    _reload_config()