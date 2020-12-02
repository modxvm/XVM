""" XVM (c) https://modxvm.com 2013-2020 """

#####################################################################
# imports

from gui.Scaleform.daapi.view.battle.shared.stats_exchange import BattleStatisticsDataController

from xfw import *

from vehicleMarkers import g_markers

#####################################################################
# constants

class BC(object):
    setVehiclesData = 'BC_setVehiclesData'
    addVehiclesInfo = 'BC_addVehiclesInfo'
    updateVehiclesData = 'BC_updateVehiclesData'
    updateVehicleStatus = 'BC_updateVehicleStatus'
    updatePlayerStatus = 'BC_updatePlayerStatus'
    setFrags = 'BC_setFrags'
    updateVehiclesStat = 'BC_updateVehiclesStat'
    updatePersonalStatus = 'BC_updatePersonalStatus'
    setUserTags = 'BC_setUserTags'
    updateUserTags = 'BC_updateUserTags'
    setPersonalStatus = 'BC_setPersonalStatus'
    updateInvitationsStatuses = 'BC_updateInvitationsStatuses'


#####################################################################
# initialization/finalization

@registerEvent(BattleStatisticsDataController, 'as_setVehiclesDataS')
def as_setVehiclesDataS(self, data):
    g_markers.call(BC.setVehiclesData, data)

@registerEvent(BattleStatisticsDataController, 'as_addVehiclesInfoS')
def as_addVehiclesInfoS(self, data):
    g_markers.call(BC.addVehiclesInfo, data)

@registerEvent(BattleStatisticsDataController, 'as_updateVehiclesInfoS')
def as_updateVehiclesInfoS(self, data):
    g_markers.call(BC.updateVehiclesData, data)

@registerEvent(BattleStatisticsDataController, 'as_updateVehicleStatusS')
def as_updateVehicleStatusS(self, data):
    g_markers.call(BC.updateVehicleStatus, data)

@registerEvent(BattleStatisticsDataController, 'as_updatePlayerStatusS')
def as_updatePlayerStatusS(self, data):
    g_markers.call(BC.updatePlayerStatus, data)

@registerEvent(BattleStatisticsDataController, 'as_setFragsS')
def as_setFragsS(self, data):
    g_markers.call(BC.setFrags, data)

@registerEvent(BattleStatisticsDataController, 'as_updateVehiclesStatsS')
def as_updateVehiclesStatsS(self, data):
    g_markers.call(BC.updateVehiclesStat, data)

@registerEvent(BattleStatisticsDataController, 'as_updatePersonalStatusS')
def as_updatePersonalStatusS(self, added, removed):
    g_markers.call(BC.updatePersonalStatus, added, removed)

@registerEvent(BattleStatisticsDataController, 'as_setUserTagsS')
def as_setUserTagsS(self, data):
    g_markers.call(BC.setUserTags, data)

@registerEvent(BattleStatisticsDataController, 'as_updateUserTagsS')
def as_updateUserTagsS(self, data):
    g_markers.call(BC.updateUserTags, data)

@registerEvent(BattleStatisticsDataController, 'as_setPersonalStatusS')
def as_setPersonalStatusS(self, data):
    g_markers.call(BC.setPersonalStatus, data)

@registerEvent(BattleStatisticsDataController, 'as_updateInvitationsStatusesS')
def as_updateInvitationsStatusesS(self, data):
    g_markers.call(BC.updateInvitationsStatuses, data)
