""" xvm (c) sirmax 2013 """

# PUBLIC

def getTiers(level, cls, key):
    return _getTiers(level, cls, key)

# PRIVATE

# Data from http://forum.worldoftanks.ru/index.php?/topic/41221-
_special = {
    # level 2
    'usa:T2_lt':                    [ 2, 4 ],
    'usa:T7_Combat_Car':            [ 2, 2 ],
    'uk:GB76_Mk_VIC':               [ 2, 2 ],
    'germany:PzI':                  [ 2, 2 ],

    # level 3
    'ussr:M3_Stuart_LL':            [ 3, 4 ],
    'ussr:LTP':                     [ 3, 4 ],
    'ussr:BT-SV':                   [ 3, 4 ],
    'ussr:T-127':                   [ 3, 4 ],
    'germany:PzII_J':               [ 3, 4 ],
    'ussr:SU76I':                   [ 3, 4 ],
    'japan:Ke_Ni_B':                [ 3, 4 ],

    # level 4
    'ussr:Valentine_LL':            [ 4, 4 ],
    'germany:B-1bis_captured':      [ 4, 4 ],
    'ussr:A-32':                    [ 4, 5 ],
    'france:AMX40':                 [ 4, 6 ],
    'uk:GB04_Valentine':            [ 4, 6 ],
    'uk:GB60_Covenanter':           [ 4, 6 ],
    'ussr:T80':                     [ 4, 6 ],
    'japan:Ke_Ho':                  [ 4, 6 ],

    # level 5
    'germany:PzIV_Hydro':           [ 5, 6 ],
    'ussr:Churchill_LL':            [ 5, 6 ],
    'ussr:SU_85I':                  [ 5, 6 ],
    'ussr:Matilda_II_LL':           [ 5, 6 ],
    'usa:T14':                      [ 5, 6 ],
    'ussr:KV-220':                  [ 5, 6 ],
    'ussr:KV-220_action':           [ 5, 6 ],
    'usa:M4A2E4':                   [ 5, 6 ],
    'uk:GB51_Excelsior':            [ 5, 6 ],
    'uk:GB68_Matilda_Black_Prince': [ 5, 6 ],
    'uk:GB20_Crusader':             [ 5, 7 ],
    'usa:M24_Chaffee':              [ 7, 12 ],

    # level 6
    'germany:PzV_PzIV':             [ 6, 7 ],
    'germany:PzV_PzIV_ausf_Alfa':   [ 6, 7 ],
    'uk:GB63_TOG_II':               [ 6, 7 ],

    # level 7
    'germany:Panther_M10':          [ 7, 8 ],
    'ussr:T44_85':                  [ 7, 8 ],
    'ussr:T44_122':                 [ 7, 8 ],
    'germany:E-25':                 [ 7, 8 ],

    # level 8
    'ussr:KV-5':                    [ 8, 9 ],
    'ussr:Object252':               [ 8, 9 ],
    'france:FCM_50t':               [ 8, 9 ],
    'usa:T26_E4_SuperPershing':     [ 8, 9 ],
    'china:Ch23_112':               [ 8, 9 ],
    'china:Ch14_T34_3':             [ 8, 9 ],
    'china:Ch01_Type59':            [ 8, 9 ],
    'china:Ch01_Type59_Gold':       [ 8, 9 ],
    'germany:JagdTiger_SdKfz_185':  [ 8, 9 ],
}

def _getTiers(level, cls, key):
    if key in _special:
        return _special[key]

    # T4 HT max+1
    if level == 4 and cls == 'heavyTank':
        return (4, 5)

    # LT: =T4 max+4  & >T4  min+1 max+4
    if level >= 4 and cls == 'lightTank':
        return (level if level == 4 else level + 1, level + 4)

    # default: <T3 max+1 & >T3 max+2
    return (level, level + 1 if level < 3 else level + 2)
