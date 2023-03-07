"""
SPDX-License-Identifier: GPL-3.0-or-later
Copyright (c) 2016-2023 XVM Contributors
"""

#
# imports
#

# BigWorld
import BigWorld
from gui.Scaleform.daapi.view.battle.shared.crosshair.plugins import TargetDistancePlugin

# XFW
from xfw.events import overrideMethod


#
# Avatar
#

def _TargetDistancePlugin__startTrack(base, self, vehicleIDs):
    try:
        self._TargetDistancePlugin__stopTrack(immediate=True)
        target = BigWorld.entity(vehicleID)
        if target is not None:
            self._TargetDistancePlugin__trackID = vehicleID
            self._TargetDistancePlugin__updateDistance(target)
            self._interval.start()
    except Exception:
        logging.getLogger('XVM/Battle/Crosshair').exception('_TargetDistancePlugin__startTrack')



#
# Initialization
#

def init():
    # TargetDistancePlugin
    overrideMethod(TargetDistancePlugin, '_TargetDistancePlugin__startTrack')(_TargetDistancePlugin__startTrack)


def fini():
    pass
