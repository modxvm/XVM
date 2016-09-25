""" XVM (c) www.modxvm.com 2013-2016 """

# PUBLIC

def getTiers(level, cls, key):
    return _getTiers(level, cls, key)


# PRIVATE

from logger import *
from gui.shared import g_itemsCache
from gui.shared.utils.requesters import REQ_CRITERIA

_special = {
    # Data from http://forum.worldoftanks.ru/index.php?/topic/41221-
    # Last update: 25.09.2016

    # level 2
    'germany:G53_PzI':                   [ 2, 2 ],
    'uk:GB76_Mk_VIC':                    [ 2, 2 ],
    'usa:A19_T2_lt':                     [ 2, 4 ],
    'usa:A93_T7_Combat_Car':             [ 2, 2 ],

    # level 3
    'germany:G36_PzII_J':                [ 3, 4 ],
    'japan:J05_Ke_Ni_B':                 [ 3, 4 ],
    'ussr:R34_BT-SV':                    [ 3, 4 ],
    'ussr:R50_SU76I':                    [ 3, 4 ],
    'ussr:R56_T-127':                    [ 3, 4 ],
    'ussr:R67_M3_LL':                    [ 3, 4 ],
    'ussr:R86_LTP':                      [ 3, 4 ],

    # level 4
    'germany:G35_B-1bis_captured':       [ 4, 4 ],
    'france:F14_AMX40':                  [ 4, 6 ],
    'japan:J06_Ke_Ho':                   [ 4, 6 ],
    'uk:GB04_Valentine':                 [ 4, 6 ],
    'uk:GB60_Covenanter':                [ 4, 6 ],
    'ussr:R12_A-20':                     [ 4, 6 ],
    'ussr:R31_Valentine_LL':             [ 4, 4 ],
    'ussr:R44_T80':                      [ 4, 6 ],
    'ussr:R68_A-32':                     [ 4, 5 ],

    # level 5
    'germany:G104_Stug_IV':              [ 5, 6 ],
    'germany:G32_PzV_PzIV':              [ 5, 6 ],
    'germany:G32_PzV_PzIV_ausf_Alfa':    [ 5, 6 ],
    'germany:G70_PzIV_Hydro':            [ 5, 6 ],
    'uk:GB20_Crusader':                  [ 5, 7 ],
    'uk:GB51_Excelsior':                 [ 5, 6 ],
    'uk:GB68_Matilda_Black_Prince':      [ 5, 6 ],
    'usa:A21_T14':                       [ 5, 6 ],
    'usa:A44_M4A2E4':                    [ 5, 6 ],
    'ussr:R32_Matilda_II_LL':            [ 5, 6 ],
    'ussr:R33_Churchill_LL':             [ 5, 6 ],
    'ussr:R38_KV-220':                   [ 5, 6 ],
    'ussr:R38_KV-220_beta':              [ 5, 6 ],
    'ussr:R78_SU_85I':                   [ 5, 6 ],

    # level 6
    'germany:G32_PzV_PzIV_CN':           [ 6, 7 ],
    'germany:G32_PzV_PzIV_ausf_Alfa_CN': [ 6, 7 ],
    'uk:GB63_TOG_II':                    [ 6, 7 ],

    # level 7
    'germany:G48_E-25':                  [ 7, 8 ],
    'germany:G78_Panther_M10':           [ 7, 8 ],
    'uk:GB71_AT_15A':                    [ 7, 8 ],
    'usa:A86_T23E3':                     [ 7, 8 ],
    'ussr:R98_T44_85':                   [ 7, 8 ],
    'ussr:R99_T44_122':                  [ 7, 8 ],

    # level 8
    'china:Ch01_Type59':                 [ 8, 9 ],
    'china:Ch03_WZ-111':                 [ 8, 9 ],
    'china:Ch14_T34_3':                  [ 8, 9 ],
    'china:Ch23_112':                    [ 8, 9 ],
    'france:F65_FCM_50t':                [ 8, 9 ],
    'germany:G65_JagdTiger_SdKfz_185':   [ 8, 9 ],
    'usa:A45_M6A2E1':                    [ 8, 9 ],
    'usa:A80_T26_E4_SuperPershing':      [ 8, 9 ],
    'ussr:R54_KV-5':                     [ 8, 9 ],
    'ussr:R61_Object252':                [ 8, 9 ],
}

def _getTiers(level, cls, key):
    if key in _special:
        return _special[key]

    # HT: (=T4 max+1)
    if level == 4 and cls == 'heavyTank':
        return (4, 5)

    # LT: (=T4 max+4) & (>T4 min+1 max+3) & (>T7 min+1 max=11)
    if level >= 4 and cls == 'lightTank':
        return (level if level == 4 else level + 1, 11 if level > 7 else level + 3)

    # default: (<T3 max+1) & (>=T3 max+2) & (>T9 max=11)
    return (level, level + 1 if level < 3 else 11 if level > 9 else level + 2)

def _test_specials():
    for veh_name in _special.keys():
        if not g_itemsCache.items.getVehicles(REQ_CRITERIA.VEHICLE.SPECIFIC_BY_NAME(veh_name)):
            warn('vehinfo_tiers: vehicle %s declared in _special does not exist!' % veh_name)
