"""
SPDX-License-Identifier: GPL-3.0-or-later
Copyright (c) 2013-2025 XVM Contributors
"""

import xvm_battle.fragCorrelationPanel as panel

@xvm.export('sp.allyFrags', deterministic=False)
def ally_frags():
    return panel.ally_frags

@xvm.export('sp.enemyFrags', deterministic=False)
def enemy_frags():
    return panel.enemy_frags

@xvm.export('sp.allyVeh', deterministic=False)
def ally_vehicles():
    return panel.ally_vehicles

@xvm.export('sp.enemyVeh', deterministic=False)
def enemy_vehicles():
    return panel.enemy_vehicles

@xvm.export('sp.allyAlive', deterministic=False)
def ally_alive():
    return ally_vehicles() - enemy_frags()

@xvm.export('sp.enemyAlive', deterministic=False)
def enemy_alive():
    return enemy_vehicles() - ally_frags()

@xvm.export('sp.signScore', deterministic=False)
def sign_score():
    if panel.ally_frags > panel.enemy_frags:
        return '&#62;'
    elif panel.ally_frags < panel.enemy_frags:
        return '&#60;'
    else:
        return '&#61;'