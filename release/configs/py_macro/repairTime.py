from Avatar import PlayerAvatar
from xfw.events import registerEvent
from xfw_actionscript.python import as_event
from gui.shared.utils.TimeInterval import TimeInterval
from gui.Scaleform.daapi.view.battle.shared.damage_panel import DamagePanel

ENGINE     = 'engine'
GUN        = 'gun'
TURRET     = 'turretRotator'
SURVEYING  = 'surveyingDevice'
RADIO      = 'radio'
COMPLEX    = 'complex' #custom
LEFTTRACK  = 'leftTrack'
RIGHTTRACK = 'rightTrack'
WHEEL      = 'wheel' #custom

DEVICES = {
    ENGINE, GUN, TURRET, SURVEYING, RADIO,
    LEFTTRACK, RIGHTTRACK,
    WHEEL
}

EVENT_TEMPLATE = 'ON_{}_UPDATE'

#TIMERS

class RepairTimers(object):

    def __init__(self):
        self.timers = {}
        self.isWheeledTech = False

    def reset(self):
        if self.timers:
            for device in self.timers.copy():
                self.delTimer(device)
                self.eventHandler(device)
            self.timers = {}
        self.isWheeledTech = False

    def eventHandler(self, device):
        if device in (LEFTTRACK, RIGHTTRACK, WHEEL):
            event = EVENT_TEMPLATE.format(COMPLEX)
        else:
            event = EVENT_TEMPLATE.format(device)
        as_event(event.upper())

    def addTimer(self, device, duration):
        if device in self.timers:
            self.timers[device]['timer'].stop()

        self.timers.update({
            device: {
                'duration': duration,
                'timer': TimeInterval(0.1, self, '{}OnTimer'.format(device))
            }
        })
        self.timers[device]['timer'].start()
        self.eventHandler(device)

    def delTimer(self, device):
        self.timers[device]['timer'].stop()
        del self.timers[device]

    def onTimer(self, device):
        self.timers[device]['duration'] -= 0.1
        self.eventHandler(device)

    def engineOnTimer(self):
        self.onTimer(ENGINE)

    def gunOnTimer(self):
        self.onTimer(GUN)

    def turretRotatorOnTimer(self):
        self.onTimer(TURRET)

    def leftTrackOnTimer(self):
        self.onTimer(LEFTTRACK)
        if RIGHTTRACK in self.timers:
            if self.timers[RIGHTTRACK]['timer'] is not None and self.timers[LEFTTRACK]['duration'] > self.timers[RIGHTTRACK]['duration']:
                self.delTimer(RIGHTTRACK)

    def rightTrackOnTimer(self):
        self.onTimer(RIGHTTRACK)
        if LEFTTRACK in self.timers:
            if self.timers[LEFTTRACK]['timer'] is not None and self.timers[RIGHTTRACK]['duration'] > self.timers[LEFTTRACK]['duration']:
                self.delTimer(LEFTTRACK)

    def wheelOnTimer(self):
        self.onTimer(WHEEL)

    def surveyingDeviceOnTimer(self):
        self.onTimer(SURVEYING)

    def radioOnTimer(self):
        self.onTimer(RADIO)

    def getTime(self, device):
        if not self.timers:
            return None
        elif device == COMPLEX:
            if self.isWheeledTech:
                result = self.timers.get(WHEEL, {}).get('duration', None)
            else:
                isLeftTrackInTimers = LEFTTRACK in self.timers
                isRightTrackInTimers = RIGHTTRACK in self.timers
                if isLeftTrackInTimers and not isRightTrackInTimers:
                    result = self.timers[LEFTTRACK].get('duration', None)
                elif isRightTrackInTimers and not isLeftTrackInTimers:
                    result = self.timers[RIGHTTRACK].get('duration', None)
                elif isRightTrackInTimers and isLeftTrackInTimers:
                    device = LEFTTRACK if self.timers.get(LEFTTRACK, {}).get('duration', 0.0) > self.timers.get(RIGHTTRACK, {}).get('duration', 0.0) else RIGHTTRACK
                    result = self.timers[device].get('duration', None)
                else:
                    return None
        elif device in self.timers:
            result = self.timers[device].get('duration', None)
        else:
            result = None
        return '%.1f' % result if result is not None else None

RepairTimers = RepairTimers()

#REGISTERS

@registerEvent(PlayerAvatar, 'onVehicleChanged')
def onVehicleChanged(self):
    RepairTimers.isWheeledTech = getattr(self.vehicle, 'isWheeledTech', False)

@registerEvent(DamagePanel, '_switching')
def _switching(self, _):
    RepairTimers.reset()

@registerEvent(DamagePanel, '_updateRepairingDevice')
def _updateRepairingDevice(self, value):
    device = value[0]

    if device.find('wheel') > -1: #remove all indices, e.g.: "wheel0", "wheel1" etc.
        device = 'wheel'

    if device in DEVICES:
        RepairTimers.addTimer(device, float(value[2]))

@registerEvent(DamagePanel, '_updateDeviceState')
def _updateDeviceState(self, value):
    device = value[0]
    state = value[2]

    if device.find('wheel') > -1: #remove all indices, e.g.: "wheel0", "wheel1" etc.
        device = 'wheel'

    if device in DEVICES:
        if ('destroyed' != state) and (device in RepairTimers.timers):
            RepairTimers.delTimer(device)
        RepairTimers.eventHandler(device)

@registerEvent(DamagePanel, '_updateCrewDeactivated')
def _updateCrewDeactivated(self, _):
    RepairTimers.reset()

@registerEvent(DamagePanel, '_updateDestroyed')
def _updateDestroyed(self, _ = None):
    RepairTimers.reset()

@registerEvent(PlayerAvatar, '_PlayerAvatar__destroyGUI')
def __destroyGUI(self):
    RepairTimers.reset()

#EXPORTS

@xvm.export('repairTimeEngine', deterministic=False)
def repairTimeEngine():
    return RepairTimers.getTime(ENGINE)

@xvm.export('repairTimeGun', deterministic=False)
def repairTimeGun():
    return RepairTimers.getTime(GUN)

@xvm.export('repairTimeTurret', deterministic=False)
def repairTimeTurret():
    return RepairTimers.getTime(TURRET)

@xvm.export('repairTimeComplex', deterministic=False)
def repairTimeComplex():
    return RepairTimers.getTime(COMPLEX)

@xvm.export('repairTimeSurveying', deterministic=False)
def repairTimeSurveying():
    return RepairTimers.getTime(SURVEYING)

@xvm.export('repairTimeRadio', deterministic=False)
def repairTimeRadio():
    return RepairTimers.getTime(RADIO)
