""" XVM (c) www.modxvm.com 2013-2017 """
"""
 XVM Scale for ratings
 http://www.koreanrandom.com/forum/topic/2625-/
 @author seriych <seriych(at)modxvm.com>
 @author Maxim Schedriviy <max(at)modxvm.com>
"""

import xvm_scale_data

def XvmScaleToSup(x=None):
    if x is None:
        return None
    return xvm_scale_data.xvm2sup[max(0, min(100, x-1))]
