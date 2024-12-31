"""
SPDX-License-Identifier: GPL-3.0-or-later
Copyright (c) 2013-2025 XVM Contributors
"""

#
# Imports
#

# stdlib
import logging

# XFW
import xfw_loader.python as loader

# XVM Main
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
                logger.info("remoteCommunication/init: communication with WWISE Authoring Tools is enabled")
            except Exception:
                logger.exception("remoteCommunication/init")
        else:
            logger.warning('remoteCommunication/init: cannot enable communication with WWISE Authoring Tools since XFW.WWISE is not loaded')


def fini():
    pass
