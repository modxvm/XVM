"""
SPDX-License-Identifier: GPL-3.0-or-later
Copyright (c) 2013-2025 XVM Contributors
"""

#
# Imports
#

# BigWorld
from Avatar import PlayerAvatar
from Vehicle import Vehicle

# XFW
from xfw.events import registerEvent

# XVM Battle
from xvm_battle.consts import INV

# XVM Battle VM
from .vehicleMarkers import g_markers



#
# Handlers
#

def _PlayerAvatar_vehicle_onAppearanceReady(self, vehicle):
    g_markers.updatePlayerState(vehicle.id, INV.ALL)


def set_isCrewActive(self, _=None):
    g_markers.updatePlayerState(self.id, INV.CREW_ACTIVE)



#
# Initialization
#

def init():
    registerEvent(PlayerAvatar, 'vehicle_onAppearanceReady')(_PlayerAvatar_vehicle_onAppearanceReady)
    registerEvent(Vehicle, 'set_isCrewActive')(set_isCrewActive)


def fini():
    pass
