""" XVM (c) www.modxvm.com 2013-2015 """

import traceback

import BigWorld
from gui.Scaleform.Minimap import MODE_ARCADE, MODE_SNIPER, _isStrategic

from xfw import *
from xvm_main.python.logger import *
import xvm_main.python.config as config


def Minimap_start(self):
    if config.get('minimap/enabled'):
        try:
            from gui.battle_control import g_sessionProvider
            from items.vehicles import VEHICLE_CLASS_TAGS
            if not g_sessionProvider.getCtx().isPlayerObserver():
                player = BigWorld.player()
                id = player.playerVehicleID
                entryVehicle = player.arena.vehicles[id]
                playerId = entryVehicle['accountDBID']
                tags = set(entryVehicle['vehicleType'].type.tags & VEHICLE_CLASS_TAGS)
                vClass = tags.pop() if len(tags) > 0 else ''
                BigWorld.callback(0, lambda:self._Minimap__callEntryFlash(id, 'init_xvm', [playerId, False, 'player', vClass]))

        except Exception, ex:
            if IS_DEVELOPMENT:
                err(traceback.format_exc())


def Minimap__callEntryFlash(base, self, id, methodName, args=None):
    base(self, id, methodName, args)

    if config.get('minimap/enabled'):
        try:
            if self._Minimap__isStarted:
                if methodName == 'init':
                    if len(args) != 5:
                        base(self, id, 'init_xvm', [0])
                    else:
                        arenaVehicle = BigWorld.player().arena.vehicles.get(id, None)
                        base(self, id, 'init_xvm', [arenaVehicle['accountDBID'], False])
        except Exception, ex:
            if IS_DEVELOPMENT:
                err(traceback.format_exc())


def Minimap__addEntryLit(self, id, matrix, visible=True):
    if config.get('minimap/enabled'):
        from gui.battle_control import g_sessionProvider
        battleCtx = g_sessionProvider.getCtx()
        if battleCtx.isObserver(id) or matrix is None:
            return

        try:
            entry = self._Minimap__entrieLits[id]
            arenaVehicle = BigWorld.player().arena.vehicles.get(id, None)
            self._Minimap__ownUI.entryInvoke(entry['handle'], ('init_xvm', [arenaVehicle['accountDBID'], True]))
        except Exception, ex:
            if IS_DEVELOPMENT:
                err(traceback.format_exc())
