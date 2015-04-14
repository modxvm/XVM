""" XVM (c) www.modxvm.com 2013-2015 """
"""
 XVM Scale for ratings
 http://www.koreanrandom.com/forum/topic/2625-/
 @author seriych <seriych(at)modxvm.com>
 @author Maxim Schedriviy <max(at)modxvm.com>
"""

from logger import *
import vehinfo_xteff

def XEFF(x):
    return 100 if x > 2250 else		\
        round(max(0, min(100,		\
            x*(x*(x*(x*(x*(x*		\
            0.0000000000000000168275	\
            - 0.000000000000119928)	\
            + 0.000000000319149)	\
            - 0.000000396224)		\
            + 0.00022545)		\
            + 0.02274)			\
            - 26.036)))

def XWN6(x):
    return 100 if x > 2300 else		\
        round(max(0, min(100,		\
            x*(x*(x*(x*(x*(x*		\
            0.000000000000000001699	\
            - 0.000000000000011036)	\
            + 0.000000000017108)	\
            + 0.00000000817)		\
            - 0.00002819)		\
            + 0.05856)			\
            - 4.889)))

def XWN8(x):
    return 100 if x > 3500 else		\
        round(max(0, min(100,		\
            x*(x*(x*(x*(x*(-x*		\
            0.00000000000000000000176	\
            + 0.0000000000000008049)	\
            - 0.0000000000079383)	\
            + 0.00000002667)		\
            - 0.0000392)		\
            + 0.05981)			\
            - 0.784)))

def XWGR(x):
    return 100 if x > 11100 else	\
        round(max(0, min(100,		\
            x*(x*(x*(x*(x*(-x*		\
            0.0000000000000000000012957	\
            + 0.0000000000000000472583)	\
            - 0.00000000000069667)	\
            + 0.0000000053351)		\
            - 0.00002225)		\
            + 0.05637)			\
            - 44.443)))

def XE(vehId, x):
    if x < 1:
        return None
    xteff = vehinfo_xteff.getXteffData(vehId)
    if xteff is None:
        return None
    n = next((i for i,v in enumerate(xteff['x']) if v > x), 100)
    return n
