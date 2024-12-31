"""
SPDX-License-Identifier: GPL-3.0-or-later
Copyright (c) 2013-2025 XVM Contributors
"""

import xvm_main.python.xvm_scale_data as xvm_scale_data

def xvm2sup(x=None):
    if x is None or x == '':
        return None
    x = 100 if x == 'XX' else int(x)
    return xvm_scale_data.xvm2sup[max(0, min(100, x-1))]
