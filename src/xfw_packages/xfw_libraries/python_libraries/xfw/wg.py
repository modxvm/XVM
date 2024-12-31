"""
SPDX-License-Identifier: LGPL-3.0-or-later
Copyright (c) 2013-2025 XVM Contributors
"""

#################################################################
# WG-Specific

import importlib

import game
import BigWorld

from gui.battle_control import avatar_getter
from gui.shared.utils import getPlayerDatabaseID
from helpers import dependency, getClientLanguage
from skeletons.gui.app_loader import IAppLoader

def getLobbyApp():
    return dependency.instance(IAppLoader).getDefLobbyApp()

def getBattleApp():
    return dependency.instance(IAppLoader).getDefBattleApp()

def getCurrentAccountDBID():
    # return 2178413 # DEBUG
    return getPlayerDatabaseID()

_isReplay = None
_replayCtrl = None

def isReplay():
    global _isReplay
    if _isReplay is None:
        import BattleReplay
        global _replayCtrl
        _replayCtrl = BattleReplay.g_replayCtrl
        _isReplay = _replayCtrl.isPlaying
    return _isReplay

def getArenaPeriod():
    try:
        if isReplay():
            global _replayCtrl
            return _replayCtrl.getArenaPeriod()
        else:
            player = BigWorld.player()
            return 4 if player is None or player.arena is None else player.arena.period
    except:
        # err(traceback.format_exc())
        return 4

def getCurrentBattleInfo():
    try:
        arena = avatar_getter.getArena()
        if not arena:
            return None
        return {
            'arena_unique_id': arena.arenaUniqueID,
            'realm': game.getAuthRealm(),
            'arena_gui_type': arena.guiType,
            'arena_bonus_type': arena.bonusType,
            'arena_gameplay_id': arena.arenaType.id >> 16,
            'arena_type_id': arena.arenaType.id,
            'arena_name': arena.arenaType.geometryName}
    except Exception:
        return None

def getVehCD(vehicleID):
    return avatar_getter.getArena().vehicles[vehicleID]['vehicleType'].type.compactDescr


# Region and language

def getRegion():
    return importlib.import_module('realm').CURRENT_REALM

def getLanguage():
    return getClientLanguage()
