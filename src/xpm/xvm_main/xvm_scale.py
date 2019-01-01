""" XVM (c) https://modxvm.com 2013-2019 """
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
    return xvm_scale_data.xvm2sup[min(100, x)-1] if x>0 else 0.0
