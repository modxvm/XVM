""" XVM (c) www.modxvm.com 2013-2015 """

#####################################################################
# MOD INFO

XFW_MOD_INFO = {
    # mandatory
    'VERSION':       '3.1.0',
    'URL':           'http://www.modxvm.com/',
    'UPDATE_URL':    'http://www.modxvm.com/en/download-xvm/',
    'GAME_VERSIONS': ['0.9.9','0.9.10'],
    # optional
}


#####################################################################
# imports

from pprint import pprint
from glob import glob
import os
import time
import traceback

import BigWorld
import game
from Avatar import PlayerAvatar
from BattleReplay import g_replayCtrl
from PlayerEvents import g_playerEvents
from Vehicle import Vehicle
from gui.app_loader import g_appLoader
from gui.battle_control.arena_info.settings import INVALIDATE_OP
from gui.battle_control.battle_arena_ctrl import BattleArenaController
from gui.battle_control.dyn_squad_arena_controllers import DynSquadEntityController
from gui.shared import g_eventBus, events
from gui.Scaleform.Flash import Flash
from gui.Scaleform.daapi.view.login import LoginView
from gui.Scaleform.daapi.view.lobby.profile import ProfileTechniqueWindow
from gui.Scaleform.daapi.view.lobby.hangar.AmmunitionPanel import AmmunitionPanel
from gui.Scaleform.daapi.view.battle.markers import MarkersManager
from gui.Scaleform.Minimap import Minimap
#import account_helpers.CustomFilesCache as cache
#from account_helpers.CustomFilesCache import CustomFilesCache, WorkerThread

from xfw import *

from constants import *
import config
import filecache
from logger import *
import utils
import vehstate
from websock import g_websock
from xvm import g_xvm

_LOBBY_SWF = 'lobby.swf'
_BATTLE_SWF = 'battle.swf'
_VMM_SWF = 'VehicleMarkersManager.swf'
_SWFS = [_LOBBY_SWF, _BATTLE_SWF, _VMM_SWF]


#####################################################################
# initialization/finalization

def start():
    debug('start')

    g_appLoader.onGUISpaceChanged += g_xvm.onGUISpaceChanged

    g_eventBus.addListener(XFWCOMMAND.XFW_CMD, g_xvm.onXfwCommand)
    g_eventBus.addListener(XVM_EVENT.RELOAD_CONFIG, config.load)
    g_eventBus.addListener(XVM_EVENT.CONFIG_LOADED, g_xvm.onConfigLoaded)
    g_eventBus.addListener(XVM_EVENT.SYSTEM_MESSAGE, g_xvm.onSystemMessage)

    g_websock.start()
    g_websock.on_message += g_xvm.on_websock_message
    g_websock.on_error += g_xvm.on_websock_error

    # reload config
    g_eventBus.handleEvent(events.HasCtxEvent(XVM_EVENT.RELOAD_CONFIG, {'filename':XVM.CONFIG_FILE}))

BigWorld.callback(0, start)


@registerEvent(game, 'fini')
def fini():
    debug('fini')

    g_appLoader.onGUISpaceChanged -= g_xvm.onGUISpaceChanged

    g_eventBus.removeListener(XFWCOMMAND.XFW_CMD, g_xvm.onXfwCommand)
    g_eventBus.removeListener(XVM_EVENT.RELOAD_CONFIG, config.load)
    g_eventBus.removeListener(XVM_EVENT.CONFIG_LOADED, g_xvm.onConfigLoaded)
    g_eventBus.removeListener(XVM_EVENT.SYSTEM_MESSAGE, g_xvm.onSystemMessage)

    g_websock.on_message -= g_xvm.on_websock_message
    g_websock.on_error -= g_xvm.on_websock_error
    g_websock.stop()

    filecache.fin()


#####################################################################
# handlers

# GLOBAL

@registerEvent(game, 'handleKeyEvent')
def game_handleKeyEvent(event):
    g_xvm.onKeyEvent(event)


@registerEvent(Flash, '__init__')
def FlashInit(self, swf, className='Flash', args=None, path=None):
    self.swf = swf
    if self.swf not in _SWFS:
        return

    log("FlashInit: " + self.swf)

    self.addExternalCallback('xvm.cmd', lambda *args: g_xvm.onXvmCommand(self, *args))

    if self.swf == _BATTLE_SWF:
        g_xvm.initBattleSwf(self)
    elif self.swf == _VMM_SWF:
        g_xvm.initVmmSwf(self)


@registerEvent(Flash, 'beforeDelete')
def FlashBeforeDelete(self):
    if self.swf not in _SWFS:
        return

    log("FlashBeforeDelete: " + self.swf)

    self.removeExternalCallback('xvm.cmd')

    if self.swf == _LOBBY_SWF: # TODO: replace with AppLifeCycleEvent.DESTROYED event handler
        g_xvm.deleteLobbySwf()
    elif self.swf == _BATTLE_SWF:
        g_xvm.deleteBattleSwf()
    elif self.swf == _VMM_SWF:
        g_xvm.deleteVmmSwf()


#@overrideMethod(Flash, 'call')
def Flash_call(base, self, methodName, args=None):
    debug("> call: %s, %s" % (methodName, str(args)))


def onClientVersionDiffers():
    savedValue = g_replayCtrl.scriptModalWindowsEnabled
    g_replayCtrl.scriptModalWindowsEnabled = savedValue and not config.get('login/confirmOldReplays')
    g_replayCtrl.onClientVersionDiffers()
    g_replayCtrl.scriptModalWindowsEnabled = savedValue

g_replayCtrl._BattleReplay__replayCtrl.clientVersionDiffersCallback = onClientVersionDiffers


# LOGIN

@overrideMethod(LoginView, 'onSetOptions')
def LoginView_onSetOptions(base, self, optionsList, host):
    # log('LoginView_onSetOptions')
    if config.get('login/saveLastServer'):
        self.saveLastSelectedServer(host)
    base(self, optionsList, host)


# LOBBY

@overrideMethod(ProfileTechniqueWindow, 'requestData')
def ProfileTechniqueWindow_RequestData(base, self, data):
    if data.vehicleId:
        base(self, data)
#    else:
#        self.as_responseVehicleDossierS({})

# stereoscope
@registerEvent(AmmunitionPanel, 'highlightParams')
def AmmunitionPanel_highlightParams(self, type):
    # debug('> AmmunitionPanel_highlightParams')
    g_xvm.updateTankParams()


# PRE-BATTLE

def onArenaCreated():
    g_xvm.onArenaCreated()

g_playerEvents.onArenaCreated += onArenaCreated


def onAvatarBecomePlayer():
    g_xvm.onAvatarBecomePlayer()

g_playerEvents.onAvatarBecomePlayer += onAvatarBecomePlayer


# BATTLE

# on current player enters world
@registerEvent(PlayerAvatar, 'onEnterWorld')
def PlayerAvatar_onEnterWorld(self, prereqs):
    g_xvm.onEnterWorld()


# on current player leaves world
@registerEvent(PlayerAvatar, 'onLeaveWorld')
def PlayerAvatar_onLeaveWorld(self):
    g_xvm.onLeaveWorld()


# on any player marker appear
@registerEvent(PlayerAvatar, 'vehicle_onEnterWorld')
def PlayerAvatar_vehicle_onEnterWorld(self, vehicle):
    # debug("> PlayerAvatar_vehicle_onEnterWorld: hp=%i" % vehicle.health)
    g_xvm.invalidate(vehicle.id, INV.BATTLE_STATE)


# on any player marker lost
@registerEvent(PlayerAvatar, 'vehicle_onLeaveWorld')
def PlayerAvatar_vehicle_onLeaveWorld(self, vehicle):
    # debug("> PlayerAvatar_vehicle_onLeaveWorld: hp=%i" % vehicle.health)
    g_xvm.invalidate(vehicle.id, INV.BATTLE_STATE)


# on any vehicle hit received
@registerEvent(Vehicle, 'onHealthChanged')
def Vehicle_onHealthChanged(self, newHealth, attackerID, attackReasonID):
    # debug("> Vehicle_onHealthChanged: %i, %i, %i" % (newHealth, attackerID, attackReasonID))
    g_xvm.invalidate(self.id, INV.BATTLE_HP)


# add vid to players panel data
@overrideMethod(BattleArenaController, '_makeHash')
def BattleArenaController_makeHash(base, self, index, playerFullName, vInfoVO, *args):
    res = base(self, index, playerFullName, vInfoVO, *args)
    res['vid'] = vInfoVO.vehicleType.compactDescr
    return res


# spotted status
@registerEvent(Minimap, '_Minimap__addEntry')
def _Minimap__addEntry(self, vInfo, guiProps, location, doMark):
    # debug('> _Minimap__addEntry: {0}'.format(vInfo.vehicleID))
    vehstate.updateSpottedStatus(vInfo.vehicleID, True)
    g_xvm.invalidate(vInfo.vehicleID, INV.BATTLE_SPOTTED)


@registerEvent(Minimap, '_Minimap__delEntry')
def _Minimap__delEntry(self, id, inCallback=False):
    # debug('> _Minimap__delEntry: {0}'.format(id))
    vehstate.updateSpottedStatus(id, False)
    g_xvm.invalidate(id, INV.BATTLE_SPOTTED)


@overrideMethod(MarkersManager, 'invokeMarker')
def MarkersManager_invokeMarker(base, self, handle, function, args=None):
    # debug("> invokeMarker: %i, %s, %s" % (handle, function, str(args)))
    base(self, handle, function, g_xvm.extendVehicleMarkerArgs(handle, function, args))
    

@registerEvent(DynSquadEntityController, 'invalidateVehicleInfo')
def DynSquadEntityController_invalidateVehicleInfo(self, flags, playerVehVO, arenaDP):
    #log(playerVehVO)
    if BigWorld.player().arena.guiType == 1: # ARENA_GUI_TYPE.RANDOM
        if flags & INVALIDATE_OP.PREBATTLE_CHANGED and playerVehVO.squadIndex > 0:
            isEnemy = playerVehVO.team != arenaDP.getNumberOfTeam()
            for index, (vInfoVO, vStatsVO, viStatsVO) in enumerate(arenaDP.getTeamIterator(isEnemy)):
                if vInfoVO.squadIndex > 0:
                    g_xvm.invalidate(vInfoVO.vehicleID, INV.MARKER_SQUAD)


#cache._MIN_LIFE_TIME = 15
#cache._MAX_LIFE_TIME = 24
#
#@overrideMethod(CustomFilesCache, '_CustomFilesCache__get')
#def _CustomFilesCache__get(base, self, url, showImmediately, checkedInCache):
#    debug('_CustomFilesCache__get')
#    base(self, url, showImmediately, checkedInCache)
#@overrideMethod(CustomFilesCache, '_CustomFilesCache__readLocalFile')
#def _CustomFilesCache__readLocalFile(base, self, url, showImmediately):
#    debug('_CustomFilesCache__readLocalFile')
#    base(self, url, showImmediately)
#@overrideMethod(CustomFilesCache, '_CustomFilesCache__onReadLocalFile')
#def _CustomFilesCache__onReadLocalFile(base, self, url, showImmediately, file, d1, d2):
#    debug('_CustomFilesCache__onReadLocalFile')
#    base(self, url, showImmediately, file, d1, d2)
#@overrideMethod(CustomFilesCache, '_CustomFilesCache__checkFile')
#def _CustomFilesCache__checkFile(base, self, url, showImmediately):
#    debug('_CustomFilesCache__checkFile')
#    base(self, url, showImmediately)
#@overrideMethod(CustomFilesCache, '_CustomFilesCache__onCheckFile')
#def _CustomFilesCache__onCheckFile(base, self, url, showImmediately, res, d1, d2):
#    debug('_CustomFilesCache__onCheckFile')
#    base(self, url, showImmediately, res, d1, d2)
#@overrideMethod(CustomFilesCache, '_CustomFilesCache__readRemoteFile')
#def _CustomFilesCache__readRemoteFile(base, self, url, modified_time, showImmediately):
#    debug('_CustomFilesCache__readRemoteFile')
#    base(self, url, modified_time, showImmediately)
#@overrideMethod(CustomFilesCache, '_CustomFilesCache__onReadRemoteFile')
#def _CustomFilesCache__onReadRemoteFile(base, self, url, showImmediately, file, last_modified, expires):
#    debug('_CustomFilesCache__onReadRemoteFile')
#    base(self, url, showImmediately, file, last_modified, expires)
#@overrideMethod(CustomFilesCache, '_CustomFilesCache__prepareCache')
#def _CustomFilesCache__prepareCache(base, self):
#    debug('_CustomFilesCache__prepareCache')
#    base(self)
#@overrideMethod(CustomFilesCache, '_CustomFilesCache__writeCache')
#def _CustomFilesCache__writeCache(base, self, name, packet):
#    debug('_CustomFilesCache__writeCache')
#    base(self, name, packet)
#@overrideMethod(CustomFilesCache, '_CustomFilesCache__onWriteCache')
#def _CustomFilesCache__onWriteCache(base, self, name, d1, d2, d3):
#    debug('_CustomFilesCache__onWriteCache')
#    base(self, name, d1, d2, d3)
#@overrideMethod(CustomFilesCache, '_CustomFilesCache__postTask')
#def _CustomFilesCache__postTask(base, self, url, file, invokeAndReleaseCallbacks):
#    debug('_CustomFilesCache__postTask')
#    base(self, url, file, invokeAndReleaseCallbacks)
#@overrideMethod(CustomFilesCache, '_CustomFilesCache__onPostTask')
#def _CustomFilesCache__onPostTask(base, self, url, invokeAndReleaseCallbacks, file):
#    debug('_CustomFilesCache__onPostTask')
#    base(self, url, invokeAndReleaseCallbacks, file)
#@overrideMethod(WorkerThread, '_WorkerThread__run_download')
#def _WorkerThread__run_download(base, self, url, modified_time, callback, **params):
#    debug('_WorkerThread__run_download')
#    base(self, url, modified_time, callback, **params)


#####################################################################
# Log version info + warn about installed XVM fonts

log("xvm %s (%s) for WoT %s" % (XFW_MOD_INFO['VERSION'], XFW_MOD_INFO['URL'], ", ".join(XFW_MOD_INFO['GAME_VERSIONS'])))
try:
    from __version__ import __branch__, __revision__
    log("Branch: %s, Revision: %s" % (__branch__, __revision__))
    xvm_fonts_arr = glob(os.environ['WINDIR'] + '/Fonts/*xvm*')
    if len(xvm_fonts_arr):
        warn('Following XVM fonts installed: %s' % xvm_fonts_arr)
except Exception, ex:
    err(traceback.format_exc())
