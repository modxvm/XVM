"""
SPDX-License-Identifier: GPL-3.0-or-later
Copyright (c) 2013-2025 XVM Contributors
Copyright (c) Maxim Schedriviy
Copyright (c) Seriych
"""

"""
 XVM Scale for ratings
 https://kr.cm/f/t/2625/
"""

import xvm_scale_data

def XvmScaleToSup(x=None):
    if x is None:
        return None
    return xvm_scale_data.xvm2sup[min(100, x)-1] if x > 0 else 0.0
