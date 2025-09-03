"""
SPDX-License-Identifier: GPL-3.0-or-later
Copyright (c) 2013-2025 XVM Contributors
"""

# settings
from gui import GUI_SETTINGS
import xvm_main.config as config

sixthSenseDuration = config.get('battle/sixthSense/duration')
GUI_SETTINGS.__dict__['_GuiSettings__settings'].update({'sixthSenseDuration': sixthSenseDuration})
