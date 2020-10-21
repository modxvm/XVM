""" XVM (c) https://modxvm.com 2013-2020 """

# PUBLIC

def getTiers(level, cls, key):
    return _getTiers(level, cls, key)


# PRIVATE

from logger import *
from gui.shared.utils.requesters import REQ_CRITERIA
from helpers import dependency
from skeletons.gui.shared import IItemsCache

_special = {
    # Data from https://forum.worldoftanks.ru/index.php?/topic/1894923-
    # Last update: 21.10.2020

    # level 2
    'germany:G53_PzI':                     [ 2, 2 ],
    'uk:GB76_Mk_VIC':                      [ 2, 2 ],
    'usa:A93_T7_Combat_Car':               [ 2, 2 ],

    # level 4
    'germany:G35_B-1bis_captured':         [ 4, 4 ],
    'ussr:R31_Valentine_LL':               [ 4, 4 ],
    'ussr:R31_Valentine_LL_IGR':           [ 4, 4 ],
    'ussr:R68_A-32':                       [ 4, 5 ],

    # level 5
    'germany:G104_Stug_IV':                [ 5, 6 ],
    'germany:G32_PzV_PzIV':                [ 5, 6 ],
    'germany:G32_PzV_PzIV_ausf_Alfa':      [ 5, 6 ],
    'germany:G70_PzIV_Hydro':              [ 5, 6 ],
    'uk:GB51_Excelsior':                   [ 5, 6 ],
    'uk:GB68_Matilda_Black_Prince':        [ 5, 6 ],
    'usa:A21_T14':                         [ 5, 6 ],
    'usa:A44_M4A2E4':                      [ 5, 6 ],
    'ussr:R32_Matilda_II_LL':              [ 5, 6 ],
    'ussr:R33_Churchill_LL':               [ 5, 6 ],
    'ussr:R38_KV-220':                     [ 5, 6 ],
    'ussr:R38_KV-220_beta':                [ 5, 6 ],
    'ussr:R78_SU_85I':                     [ 5, 6 ],

    # level 6
    'germany:G32_PzV_PzIV_CN':             [ 6, 7 ],
    'germany:G32_PzV_PzIV_ausf_Alfa_CN':   [ 6, 7 ],
    'uk:GB63_TOG_II':                      [ 6, 7 ],

    # level 7
    'germany:G48_E-25':                    [ 7, 8 ],
    'germany:G48_E-25_IGR':                [ 7, 8 ],
    'germany:G78_Panther_M10':             [ 7, 8 ],
    'uk:GB71_AT_15A':                      [ 7, 8 ],
    'usa:A86_T23E3':                       [ 7, 8 ],
    'ussr:R99_T44_122':                    [ 7, 8 ],

    # level 8
    'china:Ch01_Type59':                   [ 8, 9 ],
    'china:Ch01_Type59_Gold':              [ 8, 9 ],
    'china:Ch03_WZ-111':                   [ 8, 9 ],
    'china:Ch03_WZ_111_A':                 [ 8, 9 ],
    'china:Ch14_T34_3':                    [ 8, 9 ],
    'china:Ch23_112':                      [ 8, 9 ],
    'china:Ch23_112_FL':                   [ 8, 9 ],
    'france:F65_FCM_50t':                  [ 8, 9 ],
    'germany:G65_JagdTiger_SdKfz_185':     [ 8, 9 ],
    'germany:G65_JagdTiger_SdKfz_185_IGR': [ 8, 9 ],
    'usa:A45_M6A2E1':                      [ 8, 9 ],
    'usa:A80_T26_E4_SuperPershing':        [ 8, 9 ],
    'usa:A80_T26_E4_SuperPershing_FL':     [ 8, 9 ],
    'ussr:R54_KV-5':                       [ 8, 9 ],
    'ussr:R54_KV-5_IGR':                   [ 8, 9 ],
    'ussr:R61_Object252':                  [ 8, 9 ],
    'ussr:R61_Object252_BF':               [ 8, 9 ],
    'ussr:R61_Object252_FL':               [ 8, 9 ],
}

def _getTiers(level, cls, key):
    if key in _special:
        return _special[key]

    # HT: (=T4 max+1)
    if level == 4 and cls == 'heavyTank':
        return (4, 5)

    # Since update 0.9.18
    # default: (<=T3 max+1) & (>=T4 max+2) & (>T9 max=11)
    return (level, level + 1 if level < 4 else 11 if level > 9 else level + 2)

def _test_specials():
    for veh_name in _special.keys():
        itemsCache = dependency.instance(IItemsCache)
        if not itemsCache.items.getVehicles(REQ_CRITERIA.VEHICLE.SPECIFIC_BY_NAME(veh_name)):
            warn('vehinfo_tiers: vehicle %s declared in _special does not exist!' % veh_name)
