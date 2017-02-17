from Avatar import PlayerAvatar
from xfw import registerEvent, as_event
from gui.battle_control.battle_constants import VEHICLE_DEVICES
from gui.shared.utils.TimeInterval import TimeInterval
from gui.Scaleform.daapi.view.battle.shared.damage_panel import DamagePanel

ENGINE = VEHICLE_DEVICES[0]
GUN = VEHICLE_DEVICES[2]
TURRET = VEHICLE_DEVICES[3]
LEFTTRACK = VEHICLE_DEVICES[4]
RIGHTTRACK = VEHICLE_DEVICES[5]
SURVEYING = VEHICLE_DEVICES[6]
RADIO = VEHICLE_DEVICES[7]

DEVICES = {
    ENGINE, GUN, TURRET, LEFTTRACK, RIGHTTRACK, SURVEYING, RADIO
}

EVENTS = {
    ENGINE: 'ON_ENGINE_UPDATE',
    GUN: 'ON_GUN_UPDATE',
    TURRET: 'ON_TURRET_UPDATE',
    LEFTTRACK: 'ON_TRACKS_UPDATE',
    RIGHTTRACK: 'ON_TRACKS_UPDATE',
    SURVEYING: 'ON_SURVEYING_UPDATE',
    RADIO: 'ON_RADIO_UPDATE'
}

def resetAll():
    for device in DEVICES:
        RepairTimers.stopTimer(device)
        as_event(EVENTS[device])

#TIMERS

class RepairTimers(object):
    
    def __init__(self):
        self.TIMERS = {
            ENGINE: {
                'timer': None,
                'duration': None
            },
            GUN: {
                'timer': None,
                'duration': None
            },
            TURRET: {
                'timer': None,
                'duration': None
            },
            LEFTTRACK: {
                'timer': None,
                'duration': None
            },
            RIGHTTRACK: {
                'timer': None,
                'duration': None
            },
            SURVEYING: {
                'timer': None,
                'duration': None
            },
            RADIO: {
                'timer': None,
                'duration': None
            }
        }
    
    def startTimer(self, device, duration):
        self.TIMERS[device]['duration'] = duration
        if self.TIMERS[device]['timer'] is not None:
            return
        self.TIMERS[device]['timer'] = TimeInterval(0.1, self, '{}OnTimer'.format(device))
        self.TIMERS[device]['timer'].start()
        as_event(EVENTS[device])
    
    def stopTimer(self, device):
        if self.TIMERS[device]['timer'] is None:
            return
        self.TIMERS[device]['timer'].stop()
        self.TIMERS[device]['timer'] = None
        self.TIMERS[device]['duration'] = None
    
    def onTimer(self, device):
        self.TIMERS[device]['duration'] -= 0.1
        as_event(EVENTS[device])
    
    def engineOnTimer(self):
        self.onTimer(ENGINE)
    
    def gunOnTimer(self):
        self.onTimer(GUN)
    
    def turretRotatorOnTimer(self):
        self.onTimer(TURRET)
    
    def leftTrackOnTimer(self):
        self.onTimer(LEFTTRACK)
        if self.TIMERS[RIGHTTRACK]['timer'] is not None and self.TIMERS[LEFTTRACK]['duration'] > self.TIMERS[RIGHTTRACK]['duration']:
            self.stopTimer(RIGHTTRACK)
    
    def rightTrackOnTimer(self):
        self.onTimer(RIGHTTRACK)
        if self.TIMERS[LEFTTRACK]['timer'] is not None and self.TIMERS[RIGHTTRACK]['duration'] > self.TIMERS[LEFTTRACK]['duration']:
            self.stopTimer(LEFTTRACK)
    
    def surveyingDeviceOnTimer(self):
        self.onTimer(SURVEYING)
    
    def radioOnTimer(self):
        self.onTimer(RADIO)
    
    def getLastTrack(self):
        return LEFTTRACK if self.TIMERS[LEFTTRACK]['duration'] > self.TIMERS[RIGHTTRACK]['duration'] else RIGHTTRACK

RepairTimers = RepairTimers()

#EXPORTS

@xvm.export('repairTimeEngine', deterministic=False)
def repairTimeEngine():
    return RepairTimers.TIMERS[ENGINE]['duration']

@xvm.export('repairTimeGun', deterministic=False)
def repairTimeGun():
    return RepairTimers.TIMERS[GUN]['duration']

@xvm.export('repairTimeTurret', deterministic=False)
def repairTimeTurret():
    return RepairTimers.TIMERS[TURRET]['duration']

@xvm.export('repairTimeTracks', deterministic=False)
def repairTimeTracks():
    return RepairTimers.TIMERS[RepairTimers.getLastTrack()]['duration']

@xvm.export('repairTimeSurveying', deterministic=False)
def repairTimeSurveying():
    return RepairTimers.TIMERS[SURVEYING]['duration']

@xvm.export('repairTimeRadio', deterministic=False)
def repairTimeRadio():
    return RepairTimers.TIMERS[RADIO]['duration']

#REGISTERS

@registerEvent(DamagePanel, '_updateRepairingDevice')
def _updateRepairingDevice(self, value):
    device = value[0]
    if device in DEVICES:
        RepairTimers.startTimer(device, float(value[2]))

@registerEvent(DamagePanel, '_updateDeviceState')
def _updateDeviceState(self, value):
    device = value[0]
    state = value[2]
    if device in DEVICES:
        if 'destroyed' != state:
            RepairTimers.stopTimer(device)
        as_event(EVENTS[device])

@registerEvent(DamagePanel, '_updateCrewDeactivated')
def _updateCrewDeactivated(self, _):
    resetAll()

@registerEvent(DamagePanel, '_updateDestroyed')
def _updateDestroyed(self, _ = None):
    resetAll()

@registerEvent(PlayerAvatar, '_PlayerAvatar__destroyGUI')
def __destroyGUI(self):
    resetAll()
