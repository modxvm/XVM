""" XVM (c) www.modxvm.com 2013-2016 """

#####################################################################
# imports

import Math
import traceback

import BigWorld
import constants
import game
from Avatar import PlayerAvatar
from AvatarInputHandler.control_modes import PostMortemControlMode
from items.vehicles import VEHICLE_CLASS_TAGS
from gui.shared import g_eventBus, events
from gui.battle_control import g_sessionProvider
from gui.Scaleform.Minimap import Minimap
from gui.Scaleform.daapi.view.battle.shared.minimap.component import MinimapComponent
from gui.Scaleform.daapi.view.battle.shared.minimap.settings import ENTRY_SYMBOL_NAME, ADDITIONAL_FEATURES
from gui.Scaleform.daapi.view.battle.shared.minimap.plugins import ArenaVehiclesPlugin

from xfw import *

from xvm_main.python.logger import *
from xvm_main.python.consts import *
import xvm_main.python.config as config

from battle import g_battle


#####################################################################
# initialization/finalization

def onConfigLoaded(self, e=None):
    g_minimap.enabled = config.get('minimap/enabled', True)
    g_minimap.useStandardLabels = config.get('minimap/useStandardLabels', False)
    g_minimap.useStandardLines = config.get('minimap/useStandardLines', False)
    g_minimap.useStandardCircles = config.get('minimap/useStandardCircles', False)

g_eventBus.addListener(XVM_EVENT.CONFIG_LOADED, onConfigLoaded)

@registerEvent(game, 'fini')
def fini():
    g_eventBus.removeListener(XVM_EVENT.CONFIG_LOADED, onConfigLoaded)


######################################################################
## handlers

# Minimap

@overrideMethod(MinimapComponent, '_populate')
def _MinimapComponent_populate(base, self):
    g_minimap.init()
    base(self)

@overrideMethod(MinimapComponent, '_dispose')
def _MinimapComponent_dispose(base, self):
    g_minimap.destroy()
    base(self)

@overrideMethod(MinimapComponent, 'addEntry')
def _MinimapComponent_addEntry(base, self, symbol, *args, **kwargs):
    if g_minimap.active:
        if symbol == ENTRY_SYMBOL_NAME.VEHICLE:
            symbol = "com.xvm.battle.minimap.entries.vehicle::UI_VehicleEntry"
        elif symbol == ENTRY_SYMBOL_NAME.VIEW_POINT:
            symbol = "com.xvm.battle.minimap.entries.personal::UI_ViewPointEntry"
        elif symbol == ENTRY_SYMBOL_NAME.DEAD_POINT:
            symbol = "com.xvm.battle.minimap.entries.personal::UI_DeadPointEntry"
        elif symbol == ENTRY_SYMBOL_NAME.VIDEO_CAMERA:
            symbol = "com.xvm.battle.minimap.entries.personal::UI_VideoCameraEntry"
        elif symbol == ENTRY_SYMBOL_NAME.ARCADE_CAMERA:
            symbol = "com.xvm.battle.minimap.entries.personal::UI_ArcadeCameraEntry"
        elif symbol == ENTRY_SYMBOL_NAME.STRATEGIC_CAMERA:
            symbol = "com.xvm.battle.minimap.entries.personal::UI_StrategicCameraEntry"
        elif symbol == ENTRY_SYMBOL_NAME.VIEW_RANGE_CIRCLES:
           symbol = "com.xvm.battle.minimap.entries.personal::UI_ViewRangeCirclesEntry"
        elif symbol == ENTRY_SYMBOL_NAME.MARK_CELL:
            symbol = "com.xvm.battle.minimap.entries.personal::UI_CellFlashEntry"
        #else:
        #    debug('add minimap entry: ' + symbol)
    return base(self, symbol, *args, **kwargs)

@overrideMethod(ArenaVehiclesPlugin, '_ArenaVehiclesPlugin__switchToVehicle')
def _ArenaVehiclesPlugin__switchToVehicle(base, self, prevCtrlID):
    base(self, prevCtrlID)
    if g_minimap.active and not g_minimap.useStandardLabels:
        if prevCtrlID and prevCtrlID != self._getPlayerVehicleID() and prevCtrlID in self._entries:
            self._invoke(self._entries[prevCtrlID].getID(), 'setControlMode', False)
        if self._ctrlVehicleID:
            if self._ctrlVehicleID != self._getPlayerVehicleID() and self._ctrlVehicleID in self._entries:
                self._invoke(self._entries[self._ctrlVehicleID].getID(), 'setControlMode', True)
            if self._getViewPointID():
                self._invoke(self._getViewPointID(), 'setVehicleID', self._ctrlVehicleID)

# Disable standard features if XVM minimap is active

@overrideClassMethod(ADDITIONAL_FEATURES, 'isOn')
def _ADDITIONAL_FEATURES_isOn(base, cls, mask):
    return False if g_minimap.active and not g_minimap.useStandardLabels else base(mask)

@overrideClassMethod(ADDITIONAL_FEATURES, 'isChanged')
def _ADDITIONAL_FEATURES_isChanged(base, cls, mask):
    return False if g_minimap.active and not g_minimap.useStandardLabels else base(mask)

#@overrideMethod(ArenaVehiclesPlugin, '_ArenaVehiclesPlugin__createViewPointEntry')
#def _ArenaVehiclesPlugin__createViewPointEntry(base, self, avatar):
#    base(self, avatar)
#    self._invoke(self._getViewPointID(), 'setVehicleID', self._ctrlVehicleID)


#####################################################################
# Minimap

class Minimap(object):

    enabled = True
    initialized = False
    guiType = 0
    useStandardLabels = False
    useStandardLines = False
    useStandardCircles = False

    @property
    def active(self):
        return g_battle.xvm_battle_swf_initialized and \
               self.enabled and \
               self.initialized and \
               (self.guiType != constants.ARENA_GUI_TYPE.TUTORIAL)

    def init(self):
        self.initialized = True
        self.guiType = BigWorld.player().arena.guiType

    def destroy(self):
        self.initialized = False

g_minimap = Minimap()


## TODO:0.9.15.1
##@overrideMethod(Minimap, '_Minimap__callEntryFlash')
#def _Minimap__callEntryFlash(base, self, id, methodName, args=None):
#    #log('id={} method={} args={}'.format(id, methodName, args))
#
#    if methodName == 'update' and not args:
#        args = [0]
#
#    base(self, id, methodName, args)
#
#    if self._Minimap__isStarted and config.get('minimap/enabled'):
#        try:
#            if methodName == 'init':
#                if len(args) != 5:
#                    base(self, id, 'init_xvm', [0])
#                else:
#                    entryVehicle = BigWorld.player().arena.vehicles[id]
#                    entityName = str(g_sessionProvider.getCtx().getPlayerGuiProps(id, entryVehicle['team']))
#                    base(self, id, 'init_xvm', [entryVehicle['accountDBID'], False, getVehCD(id), entityName])
#        except Exception as ex:
#            if IS_DEVELOPMENT:
#                err(traceback.format_exc())
#
#
## TODO:0.9.15.1
##@registerEvent(Minimap, '_Minimap__addEntryLit')
#def _Minimap__addEntryLit(self, vInfo, guiProps, matrix, visible=True):
#    if config.get('minimap/enabled'):
#        if vInfo.isObserver() or matrix is None:
#            return
#
#        try:
#            vehicleID = vInfo.vehicleID
#            entry = self._Minimap__entrieLits[vehicleID]
#            entryVehicle = BigWorld.player().arena.vehicles[vehicleID]
#            entityName = str(g_sessionProvider.getCtx().getPlayerGuiProps(id, entryVehicle['team']))
#            self._Minimap__ownUI.entryInvoke(entry['handle'], ('init_xvm',
#                [entryVehicle['accountDBID'], True, getVehCD(vehicleID), entityName]))
#        except Exception as ex:
#            if IS_DEVELOPMENT:
#                err(traceback.format_exc())
#
#
## Minimap dead switch
## TODO:0.9.15.1
##@registerEvent(PostMortemControlMode, 'onMinimapClicked')
#def _PostMortemControlMode_onMinimapClicked(self, worldPos):
#    if config.get('battle/minimapDeadSwitch'):
#        try:
#            battle = getBattleApp()
#            if not battle:
#                return
#
#            if isReplay():
#                return
#
#            player = BigWorld.player()
#            minDistance = None
#            toID = None
#            for vehicleID, entry in battle.minimap._Minimap__entries.iteritems():
#                vData = player.arena.vehicles[vehicleID]
#                if player.team != vData['team'] or not vData['isAlive']:
#                    continue
#                pos = Math.Matrix(entry['matrix']).translation
#                distance = Math.Vector3(worldPos - pos).length
#                if minDistance is None or minDistance > distance:
#                    minDistance = distance
#                    toID = vehicleID
#            if toID is not None:
#                BigWorld.player().positionControl.bindToVehicle(vehicleID=toID)
#                self._PostMortemControlMode__switchViewpoint(False, toID)
#        except Exception as ex:
#            if IS_DEVELOPMENT:
#                err(traceback.format_exc())
#
#
## on map load (battle loading)
## TODO:0.9.15.1
##@registerEvent(PlayerAvatar, 'updateVehicleHealth')
#def _PlayerAvatar_updateVehicleHealth(self, vehicleID, health, deathReasonID, isCrewActive, isRespawn):
#    #log('PlayerAvatar_updateVehicleHealth: {} {} {} {} {}'.format(vehicleID, health, deathReasonID, isCrewActive, isRespawn))
#    if config.get('minimap/enabled'):
#        if isRespawn and health > 0:
#            _init_player(getBattleApp().minimap, True)
#
#
## Minimap settings
#in_setupMinimapSettings = False
#in_updateSettings = False
#
## TODO:0.9.15.1
##@overrideMethod(Minimap, 'setupMinimapSettings')
#def _Minimap_setupMinimapSettings(base, self, diff=None):
#    global in_setupMinimapSettings
#    in_setupMinimapSettings = True
#    base(self, diff)
#    in_setupMinimapSettings = False
#
#
## TODO:0.9.15.1
##@overrideMethod(Minimap, '_Minimap__updateSettings')
#def _Minimap__updateSettings(base, self):
#    global in_updateSettings
#    in_updateSettings = True
#    base(self)
#    in_updateSettings = False
#
#
## TODO:0.9.15.1
##@overrideMethod(g_settingsCore, 'getSetting')
#def __g_settingsCore_getSetting(base, name):
#    value = base(name)
#    if config.get('minimap/enabled'):
#        global in_setupMinimapSettings
#        global in_updateSettings
#        if in_setupMinimapSettings or in_updateSettings:
#            if name == settings_constants.GAME.MINIMAP_DRAW_RANGE:
#                if not config.get('minimap/useStandardCircles'):
#                    value = False
#            elif name == settings_constants.GAME.MINIMAP_MAX_VIEW_RANGE:
#                if not config.get('minimap/useStandardCircles'):
#                    value = False
#            elif name == settings_constants.GAME.MINIMAP_VIEW_RANGE:
#                if not config.get('minimap/useStandardCircles'):
#                    value = False
#            elif name == settings_constants.GAME.SHOW_VECTOR_ON_MAP:
#                if not config.get('minimap/useStandardLines'):
#                    value = False
#            elif name == settings_constants.GAME.SHOW_SECTOR_ON_MAP:
#                if not config.get('minimap/useStandardCircles'):
#                if not config.get('minimap/useStandardLines'):
#                    value = False
#            #debug('getSetting: {} = {}'.format(name, value))
#    return value
#
#
## TODO:0.9.15.1
##@overrideMethod(SettingsContainer, 'getSetting')
#def __SettingsContainer_getSetting(base, self, name):
#    value = base(self, name)
#    if config.get('minimap/enabled'):
#        global in_setupMinimapSettings
#        global in_updateSettings
#        if in_setupMinimapSettings or in_updateSettings:
#            if name == settings_constants.GAME.SHOW_VEH_MODELS_ON_MAP:
#                if not config.get('minimap/useStandardLabels'):
#                    value._set(0)
#            #debug('getSetting: {} = {}'.format(name, value))
#    return value
#
#
## PRIVATE
#
#def _init_player(minimap, isRespawn=False):
#    try:
#        battleCtx = g_sessionProvider.getCtx()
#        if not battleCtx.isPlayerObserver():
#            player = BigWorld.player()
#            arena = player.arena
#            vehicleID = player.playerVehicleID
#            entryVehicle = arena.vehicles[vehicleID]
#            accountDBID = entryVehicle['accountDBID']
#            vehCD = getVehCD(vehicleID)
#            tags = set(entryVehicle['vehicleType'].type.tags & VEHICLE_CLASS_TAGS)
#            vClass = tags.pop() if len(tags) > 0 else ''
#            entityName = str(battleCtx.getPlayerGuiProps(vehicleID, entryVehicle['team']))
#            minimap._Minimap__callEntryFlash(vehicleID, 'init_xvm',
#                [accountDBID, False, vehCD, entityName, 'player', vClass, isRespawn])
#    except Exception as ex:
#        if IS_DEVELOPMENT:
#            err(traceback.format_exc())
#
##    def updateMinimapEntry(self, vehicleID, targets):
##        #trace('updateMinimapEntry: {0} {1}'.format(targets, vehicleID))
##
##        battle = getBattleApp()
##        if not battle:
##            return
##
##        minimap = battle.minimap
##
##        if targets & INV.MINIMAP_SQUAD:
##            arenaDP = g_sessionProvider.getArenaDP()
##            if vehicleID != BigWorld.player().playerVehicleID and arenaDP.isSquadMan(vehicleID):
##                minimap._Minimap__callEntryFlash(vehicleID, 'setEntryName', [PLAYER_GUI_PROPS.squadman.name()])
##                g_xvm.invalidate(vehicleID, INV.BATTLE_SQUAD)
##            else:
##                minimap._Minimap__callEntryFlash(vehicleID, 'update')
