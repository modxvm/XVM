""" XVM (c) www.modxvm.com 2013-2016 """

#####################################################################
# imports

import traceback

from gui.Scaleform.daapi.view.battle.shared.stats_exchage import BattleStatisticsDataController

from xfw import *

from vehicleMarkers import g_markers

#####################################################################
# constants

class BC(object):
    addVehiclesInfo = 'BC_addVehiclesInfo'
    setVehiclesData = 'BC_setVehiclesData'
    setVehicleStats = 'BC_setVehicleStats'
    updateVehicleStatus = 'BC_updateVehicleStatus'
    updateVehiclesInfo = 'BC_updateVehiclesInfo'
    updatePersonalStatus = 'BC_updatePersonalStatus'
    setPersonalStatus = 'BC_setPersonalStatus'
    updateInvitationsStatuses = 'BC_updateInvitationsStatuses'
    updatePlayerStatus = 'BC_updatePlayerStatus'
    updateUserTags = 'BC_updateUserTags'
    updateVehiclesStats = 'BC_updateVehiclesStats'
    setUserTags = 'BC_setUserTags'
    setArenaInfo = 'BC_setArenaInfo'


#####################################################################
# initialization/finalization

@registerEvent(BattleStatisticsDataController, 'as_setVehiclesDataS')
def as_setVehiclesDataS(self, data):
    log(self.__class__)
    g_markers.call(BC.setVehiclesData, data)

@registerEvent(BattleStatisticsDataController, 'as_updatePlayerStatusS')
def as_updatePlayerStatusS(self, data):
    g_markers.call(BC.updatePlayerStatus, data)

@registerEvent(BattleStatisticsDataController, 'as_updateVehiclesInfoS')
def as_updateVehiclesInfoS(self, data):
    g_markers.call(BC.updateVehiclesInfo, data)

@registerEvent(BattleStatisticsDataController, 'as_updateVehiclesStatsS')
def as_updateVehiclesStatsS(self, data):
    g_markers.call(BC.updateVehiclesStats, data)

@registerEvent(BattleStatisticsDataController, 'as_updateVehicleStatusS')
def as_updateVehicleStatusS(self, data):
    g_markers.call(BC.updateVehicleStatus, data)

#def as_refreshS(self):
#def as_addVehiclesInfoS(self, data):
#def as_setVehiclesStatsS(self, data):
#def as_setArenaInfoS(self, data):
#def as_setUserTagsS(self, data):
#def as_updateUserTagsS(self, data):
#def as_updateInvitationsStatusesS(self, data):
#def as_setPersonalStatusS(self, bitmask):
#def as_updatePersonalStatusS(self, added, removed):
