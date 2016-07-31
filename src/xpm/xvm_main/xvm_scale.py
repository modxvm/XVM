""" XVM (c) www.modxvm.com 2013-2016 """
"""
 XVM Scale for ratings
 http://www.koreanrandom.com/forum/topic/2625-/
 @author seriych <seriych(at)modxvm.com>
 @author Maxim Schedriviy <max(at)modxvm.com>
"""

import xvm_scale_data

def XEFF(x):
    return 100 if x > 2300 else     \
        round(max(0, min(100,       \
            x*(x*(x*(x*(x*(x*       \
            0.000000000000000006449 \
            - 0.00000000000004089)  \
            + 0.00000000008302) \
            - 0.00000004433)        \
            - 0.0000482)        \
            + 0.1257)           \
            - 40.42)))

def XWN6(x):
    return 100 if x > 2350 else     \
        round(max(0, min(100,       \
            x*(x*(x*(x*(x*(-x*      \
            0.000000000000000000852 \
            + 0.000000000000008649) \
            - 0.000000000039744)    \
            + 0.00000008406)        \
            - 0.00007446)       \
            + 0.06904)          \
            - 6.19)))

def XWN8(x):
    return 100 if x > 3800 else     \
        round(max(0, min(100,       \
            x*(x*(x*(x*(x*(-x*      \
            0.00000000000000000009762   \
            + 0.0000000000000016221)    \
            - 0.00000000001007) \
            + 0.000000027916)       \
            - 0.000036982)      \
            + 0.05577)          \
            - 1.3)))

def XWGR(x):
    return 100 if x > 11200 else    \
        round(max(0, min(100,       \
            x*(x*(x*(x*(x*(-x*      \
            0.000000000000000000001185  \
            + 0.00000000000000004468)   \
            - 0.000000000000681)    \
            + 0.000000005378)       \
            - 0.00002302)       \
            + 0.05905)          \
            - 48.93)))

def XvmScaleToSup(x=None):
    if x is None:
        return None
    return xvm_scale_data.xvm2sup[max(0, min(100, x-1))]
