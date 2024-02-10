"""
SPDX-License-Identifier: GPL-3.0-or-later
Copyright (c) 2013-2024 XVM Contributors
"""

#
# imports
#

# BigWorld
from gui.Scaleform.daapi.view.battle.shared.stats_exchange import BattleStatisticsDataController

# XFW
from xfw.events import registerEvent

# XVM Battle VM
from .vehicleMarkers import g_markers
from .consts import BC



#
# Handlers
#

def as_setVehiclesDataS(self, data):
    g_markers.daapi_py2as(BC.setVehiclesData, data)


def as_addVehiclesInfoS(self, data):
    g_markers.daapi_py2as(BC.addVehiclesInfo, data)


def as_updateVehiclesInfoS(self, data):
    g_markers.daapi_py2as(BC.updateVehiclesData, data)


def as_updateVehicleStatusS(self, data):
    g_markers.daapi_py2as(BC.updateVehicleStatus, data)


def as_updatePlayerStatusS(self, data):
    g_markers.daapi_py2as(BC.updatePlayerStatus, data)


def as_setFragsS(self, data):
    g_markers.daapi_py2as(BC.setFrags, data)


def as_updateVehiclesStatsS(self, data):
    g_markers.daapi_py2as(BC.updateVehiclesStat, data)


def as_updatePersonalStatusS(self, added, removed):
    g_markers.daapi_py2as(BC.updatePersonalStatus, added, removed)


def as_setUserTagsS(self, data):
    g_markers.daapi_py2as(BC.setUserTags, data)


def as_updateUserTagsS(self, data):
    g_markers.daapi_py2as(BC.updateUserTags, data)


def as_setPersonalStatusS(self, data):
    g_markers.daapi_py2as(BC.setPersonalStatus, data)


def as_updateInvitationsStatusesS(self, data):
    g_markers.daapi_py2as(BC.updateInvitationsStatuses, data)



#
# initialization
#

def init():
    registerEvent(BattleStatisticsDataController, 'as_setVehiclesDataS')(as_setVehiclesDataS)
    registerEvent(BattleStatisticsDataController, 'as_addVehiclesInfoS')(as_addVehiclesInfoS)
    registerEvent(BattleStatisticsDataController, 'as_updateVehiclesInfoS')(as_updateVehiclesInfoS)
    registerEvent(BattleStatisticsDataController, 'as_updateVehicleStatusS')(as_updateVehicleStatusS)
    registerEvent(BattleStatisticsDataController, 'as_updatePlayerStatusS')(as_updatePlayerStatusS)
    registerEvent(BattleStatisticsDataController, 'as_setFragsS')(as_setFragsS)
    registerEvent(BattleStatisticsDataController, 'as_updateVehiclesStatsS')(as_updateVehiclesStatsS)
    registerEvent(BattleStatisticsDataController, 'as_updatePersonalStatusS')(as_updatePersonalStatusS)
    registerEvent(BattleStatisticsDataController, 'as_setUserTagsS')(as_setUserTagsS)
    registerEvent(BattleStatisticsDataController, 'as_updateUserTagsS')(as_updateUserTagsS)
    registerEvent(BattleStatisticsDataController, 'as_setPersonalStatusS')(as_setPersonalStatusS)
    registerEvent(BattleStatisticsDataController, 'as_updateInvitationsStatusesS')(as_updateInvitationsStatusesS)


def fini():
    pass
