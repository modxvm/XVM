import BigWorld
from Vehicle import Vehicle
from gui.Scaleform.daapi.view.battle.shared.battle_timers import PreBattleTimer

from xfw.events import registerEvent
from xfw_actionscript.python import *
from xvm_main.python.logger import *

battleBegin = None


@registerEvent(Vehicle, 'onEnterWorld')
def Vehicle_onEnterWorld(self, prereqs):
    global battleBegin
    if self.isPlayerVehicle:
        arenaPeriod = BigWorld.player().guiSessionProvider.shared.arenaPeriod
        startBattle = arenaPeriod.getPeriod() if arenaPeriod is not None else 0
        battleBegin = 'battle' if startBattle >= 3 else None
        as_event('ON_BEGIN_BATTLE')


@registerEvent(PreBattleTimer, 'hideCountdown')
def hideCountdown(self, state, speed):
    global battleBegin
    if state == 3:
        battleBegin = 'battle'
        as_event('ON_BEGIN_BATTLE')


@xvm.export('isBattle', deterministic=False)
def sight_cameraHeight():
    return battleBegin
