"""
SPDX-License-Identifier: GPL-3.0-or-later
Copyright (c) 2013-2024 XVM Contributors
"""

import xvm_main.python.config as config

if config.get('hangar/carousel/enabled'):
    import tankcarousel
    import filter_popover
