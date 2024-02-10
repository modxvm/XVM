"""
SPDX-License-Identifier: GPL-3.0-or-later
Copyright (c) 2013-2024 XVM Contributors
"""

#
# Imports
#

# stdlib
import logging

# xfw.loader
import xfw_loader.python as loader

# xvm.main
import xvm_main.python.config as config



#
# Initialization
# 

def init():
    if config.get('sounds/remote_communication', False):
        logger = logging.getLogger('XVM/Sounds')
        if loader.is_mod_loaded('com.modxvm.xfw.wwise'):
            try:
                wwise_module = loader.get_mod_module('com.modxvm.xfw.wwise')
                wwise_module.wwise_communication_init()
                logger.info("remoteCcommunication/init: communication with WWISE Authoring Tools is enabled")

            except Exception:
                logger.exception("remoteCcommunication/init:")
        else:
            logger.warning('[XVM/Sounds] [remote_communication] failed to load sound banks because XFW.WWISE is not loaded')


def fini():
    pass
