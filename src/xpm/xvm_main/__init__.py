""" XVM (c) www.modxvm.com 2013-2015 """

#####################################################################
# MOD INFO (mandatory)

XFW_MOD_VERSION    = "3.0.0"
XFW_MOD_URL        = "http://www.modxvm.com/"
XFW_MOD_UPDATE_URL = "http://www.modxvm.com/en/download-xvm/"
XFW_GAME_VERSIONS  = ["0.9.7"]

#####################################################################

from pprint import pprint
import os
import time
import traceback
import cPickle

import BigWorld

from xfw import *

import config
from constants import *
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
# event handlers

# INIT

def start():
    debug('start')
    from gui.shared import g_eventBus
    from gui.Scaleform.daapi.settings.views import VIEW_ALIAS
    g_eventBus.addListener(VIEW_ALIAS.LOBBY, g_xvm.onShowLobby)
    g_eventBus.addListener(VIEW_ALIAS.LOGIN, g_xvm.onShowLogin)
    g_eventBus.addListener(XFWCOMMAND.XFW_CMD, g_xvm.onXfwCommand)
    g_websock.start()
    g_websock.on_message += g_xvm.on_websock_message
    g_websock.on_error += g_xvm.on_websock_error

def fini():
    debug('fini')
    from gui.shared import g_eventBus
    from gui.Scaleform.daapi.settings.views import VIEW_ALIAS
    g_eventBus.removeListener(VIEW_ALIAS.LOBBY, g_xvm.onShowLobby)
    g_eventBus.removeListener(VIEW_ALIAS.LOGIN, g_xvm.onShowLogin)
    g_eventBus.removeListener(XFWCOMMAND.XFW_CMD, g_xvm.onXfwCommand)
    g_websock.on_message -= g_xvm.on_websock_message
    g_websock.on_error -= g_xvm.on_websock_error
    g_websock.stop()
    filecache.fin()

def FlashInit(self, swf, className='Flash', args=None, path=None):
    self.swf = swf
    if self.swf not in _SWFS:
        return
    log("FlashInit: " + self.swf)
    self.addExternalCallback('xvm.cmd', lambda *args: g_xvm.onXvmCommand(self, *args))
    if self.swf == _LOBBY_SWF:
        g_xvm.app = self
        g_xvm.initLobby()
    if self.swf == _BATTLE_SWF:
        g_xvm.battleFlashObject = self
        g_xvm.initBattle()
    if self.swf == _VMM_SWF:
        g_xvm.vmmFlashObject = self
        g_xvm.initVmm()

def FlashBeforeDelete(self):
    if self.swf not in _SWFS:
        return
    log("FlashBeforeDelete: " + self.swf)
    self.removeExternalCallback('xvm.cmd')
    if self.swf == _LOBBY_SWF:
        g_xvm.deleteLobby()
        g_xvm.app = None
    if self.swf == _BATTLE_SWF:
        g_xvm.battleFlashObject = None
    if self.swf == _VMM_SWF:
        g_xvm.vmmFlashObject = None

#def Flash_call(base, self, methodName, args=None):
#    # debug("> call: %s, %s" % (methodName, str(args)))
#    base(self, methodName, g_xvm.extendInvokeArgs(self.swf, methodName, args))

def VehicleMarkersManager_invokeMarker(base, self, handle, function, args=None):
    # debug("> invokeMarker: %i, %s, %s" % (handle, function, str(args)))
    base(self, handle, function, g_xvm.extendVehicleMarkerArgs(handle, function, args))

# HANGAR

def ProfileTechniqueWindowRequestData(base, self, data):
    if data.vehicleId:
        base(self, data)
#    else:
#        self.as_responseVehicleDossierS({})

def LoginView_onSetOptions(base, self, optionsList, host):
    # log('LoginView_onSetOptions')
    if config.config is not None and config.config['login']['saveLastServer']:
        self.saveLastSelectedServer(host)
    base(self, optionsList, host)

def onClientVersionDiffers():
    if config.config is None:
        BigWorld.callback(0, onClientVersionDiffers)
        return

    from BattleReplay import g_replayCtrl
    savedValue = g_replayCtrl.scriptModalWindowsEnabled
    g_replayCtrl.scriptModalWindowsEnabled = not config.config['login']['confirmOldReplays']
    g_replayCtrl.onClientVersionDiffers()
    g_replayCtrl.scriptModalWindowsEnabled = savedValue

# BATTLE

def onArenaCreated():
    debug('> onArenaCreated')
    g_xvm.onArenaCreated()

def onAvatarBecomePlayer():
    debug('> onAvatarBecomePlayer')
    g_xvm.onAvatarBecomePlayer()

# on current player enters world
def PlayerAvatar_onEnterWorld(self, prereqs):
    debug("> PlayerAvatar_onEnterWorld")
    g_xvm.onEnterWorld()

# on current player leaves world
def PlayerAvatar_onLeaveWorld(self):
    debug("> PlayerAvatar_onLeaveWorld")
    g_xvm.onLeaveWorld()

# on any player marker appear
def PlayerAvatar_vehicle_onEnterWorld(self, vehicle):
    # debug("> PlayerAvatar_vehicle_onEnterWorld: hp=%i" % vehicle.health)
    g_xvm.invalidate(vehicle.id, INV.BATTLE_STATE)

# on any player marker lost
def PlayerAvatar_vehicle_onLeaveWorld(self, vehicle):
    # debug("> PlayerAvatar_vehicle_onLeaveWorld: hp=%i" % vehicle.health)
    g_xvm.invalidate(vehicle.id, INV.BATTLE_STATE)

# on any vehicle hit received
def Vehicle_onHealthChanged(self, newHealth, attackerID, attackReasonID):
    # debug("> Vehicle_onHealthChanged: %i, %i, %i" % (newHealth, attackerID, attackReasonID))
    g_xvm.invalidate(self.id, INV.BATTLE_HP)

# spotted status
def _Minimap__addEntry(self, id, location, doMark):
    # debug('> _Minimap__addEntry: {0}'.format(id))
    vehstate.updateSpottedStatus(id, True)
    g_xvm.invalidate(id, INV.BATTLE_SPOTTED)

def _Minimap__delEntry(self, id, inCallback=False):
    # debug('> _Minimap__delEntry: {0}'.format(id))
    vehstate.updateSpottedStatus(id, False)
    g_xvm.invalidate(id, INV.BATTLE_SPOTTED)

def _Minimap_start(self):
    if config.config is None or not config.config['minimap']['enabled']:
        return
    try:
        from gui.battle_control import g_sessionProvider
        from items.vehicles import VEHICLE_CLASS_TAGS
        if not g_sessionProvider.getCtx().isPlayerObserver():
            player = BigWorld.player()
            id = player.playerVehicleID
            entryVehicle = player.arena.vehicles[id]
            playerId = entryVehicle['accountDBID']
            tags = set(entryVehicle['vehicleType'].type.tags & VEHICLE_CLASS_TAGS)
            vClass = tags.pop() if len(tags) > 0 else ''
            BigWorld.callback(0, lambda:self._Minimap__callEntryFlash(id, 'init_xvm', [playerId, False, 'player', vClass]))

    except Exception, ex:
        if IS_DEVELOPMENT:
            err(traceback.format_exc())

def _Minimap__callEntryFlash(base, self, id, methodName, args=None):
    base(self, id, methodName, args)
    if config.config is None or not config.config['minimap']['enabled']:
        return
    try:
        if self._Minimap__isStarted:
            if methodName == 'init':
                if len(args) != 5:
                    base(self, id, 'init_xvm', [0])
                else:
                    arenaVehicle = BigWorld.player().arena.vehicles.get(id, None)
                    base(self, id, 'init_xvm', [arenaVehicle['accountDBID'], False])
    except Exception, ex:
        if IS_DEVELOPMENT:
            err(traceback.format_exc())

def _Minimap__addEntryLit(self, id, matrix, visible=True):
    if config.config is None or not config.config['minimap']['enabled']:
        return
    from gui.battle_control import g_sessionProvider
    battleCtx = g_sessionProvider.getCtx()
    if battleCtx.isObserver(id) or matrix is None:
        return
    try:
        entry = self._Minimap__entrieLits[id]
        arenaVehicle = BigWorld.player().arena.vehicles.get(id, None)
        self._Minimap__ownUI.entryInvoke(entry['handle'], ('init_xvm', [arenaVehicle['accountDBID'], True]))
    except Exception, ex:
        if IS_DEVELOPMENT:
            err(traceback.format_exc())

# stereoscope
def AmmunitionPanel_highlightParams(self, type):
    # debug('> AmmunitionPanel_highlightParams')
    g_xvm.updateTankParams()

def BattleResultsCache_get(base, self, arenaUniqueID, callback):
    try:
        filename = '{0}.dat'.format(arenaUniqueID)
        if not os.path.exists(filename):
            base(self, arenaUniqueID, callback)
        else:
            fileHandler = open(filename, 'rb')
            (version, battleResults) = cPickle.load(fileHandler)
            if battleResults is not None:
                if callback is not None:
                    import AccountCommands
                    from account_helpers.BattleResultsCache import convertToFullForm
                    callback(AccountCommands.RES_CACHE, convertToFullForm(battleResults))
    except Exception, ex:
        err(traceback.format_exc())
        base(self, arenaUniqueID, callback)

# stub for fixing waiting bug

def WaitingViewMeta_fix(base, self, *args):
    try:
        base(self, *args)
        # raise Exception('Test')
    except Exception, ex:
        log('[XVM][Waiting fix]: %s throwed exception: %s' % (base.__name__, ex.message))

'''#def _CustomFilesCache__get(base, self, url, showImmediately, checkedInCache):
#    debug('_CustomFilesCache__get')
#    base(self, url, showImmediately, checkedInCache)
#def _CustomFilesCache__readLocalFile(base, self, url, showImmediately):
#    debug('_CustomFilesCache__readLocalFile')
#    base(self, url, showImmediately)
#def _CustomFilesCache__onReadLocalFile(base, self, url, showImmediately, file, d1, d2):
#    debug('_CustomFilesCache__onReadLocalFile')
#    base(self, url, showImmediately, file, d1, d2)
#def _CustomFilesCache__checkFile(base, self, url, showImmediately):
#    debug('_CustomFilesCache__checkFile')
#    base(self, url, showImmediately)
#def _CustomFilesCache__onCheckFile(base, self, url, showImmediately, res, d1, d2):
#    debug('_CustomFilesCache__onCheckFile')
#    base(self, url, showImmediately, res, d1, d2)
#def _CustomFilesCache__readRemoteFile(base, self, url, modified_time, showImmediately):
#    debug('_CustomFilesCache__readRemoteFile')
#    base(self, url, modified_time, showImmediately)
#def _CustomFilesCache__onReadRemoteFile(base, self, url, showImmediately, file, last_modified, expires):
#    debug('_CustomFilesCache__onReadRemoteFile')
#    base(self, url, showImmediately, file, last_modified, expires)
#def _CustomFilesCache__prepareCache(base, self):
#    debug('_CustomFilesCache__prepareCache')
#    base(self)
#def _CustomFilesCache__writeCache(base, self, name, packet):
#    debug('_CustomFilesCache__writeCache')
#    base(self, name, packet)
#def _CustomFilesCache__onWriteCache(base, self, name, d1, d2, d3):
#    debug('_CustomFilesCache__onWriteCache')
#    base(self, name, d1, d2, d3)
#def _CustomFilesCache__postTask(base, self, url, file, invokeAndReleaseCallbacks):
#    debug('_CustomFilesCache__postTask')
#    base(self, url, file, invokeAndReleaseCallbacks)
#def _CustomFilesCache__onPostTask(base, self, url, invokeAndReleaseCallbacks, file):
#    debug('_CustomFilesCache__onPostTask')
#    base(self, url, invokeAndReleaseCallbacks, file)
#def _WorkerThread__run_download(base, self, url, modified_time, callback, **params):
#    debug('_WorkerThread__run_download')
#    base(self, url, modified_time, callback, **params)'''


#####################################################################
# Register events

# Early registration
from gui.Scaleform.Flash import Flash
RegisterEvent(Flash, '__init__', FlashInit)
RegisterEvent(Flash, 'beforeDelete', FlashBeforeDelete)
#OverrideMethod(Flash, 'call', Flash_call)

# Delayed registration
def _RegisterEvents():
    start()

    import game
    RegisterEvent(game, 'fini', fini)
    RegisterEvent(game, 'handleKeyEvent', g_xvm.onKeyEvent)

    from gui.Scaleform.Battle import VehicleMarkersManager
    OverrideMethod(VehicleMarkersManager, 'invokeMarker', VehicleMarkersManager_invokeMarker)

    from gui.Scaleform.daapi.view.lobby.profile import ProfileTechniqueWindow
    OverrideMethod(ProfileTechniqueWindow, 'requestData', ProfileTechniqueWindowRequestData)

    from gui.Scaleform.daapi.view.login import LoginView
    OverrideMethod(LoginView, 'onSetOptions', LoginView_onSetOptions)

    from PlayerEvents import g_playerEvents
    g_playerEvents.onArenaCreated += onArenaCreated
    g_playerEvents.onAvatarBecomePlayer += onAvatarBecomePlayer

    from Avatar import PlayerAvatar
    RegisterEvent(PlayerAvatar, 'onEnterWorld', PlayerAvatar_onEnterWorld)
    RegisterEvent(PlayerAvatar, 'onLeaveWorld', PlayerAvatar_onLeaveWorld)
    RegisterEvent(PlayerAvatar, 'vehicle_onEnterWorld', PlayerAvatar_vehicle_onEnterWorld)
    RegisterEvent(PlayerAvatar, 'vehicle_onLeaveWorld', PlayerAvatar_vehicle_onLeaveWorld)

    from Vehicle import Vehicle
    RegisterEvent(Vehicle, 'onHealthChanged', Vehicle_onHealthChanged)

    from gui.Scaleform.Minimap import Minimap
    RegisterEvent(Minimap, '_Minimap__addEntry', _Minimap__addEntry)
    RegisterEvent(Minimap, '_Minimap__delEntry', _Minimap__delEntry)
    RegisterEvent(Minimap, 'start', _Minimap_start)
    OverrideMethod(Minimap, '_Minimap__callEntryFlash', _Minimap__callEntryFlash)
    RegisterEvent(Minimap, '_Minimap__addEntryLit', _Minimap__addEntryLit)

    from gui.Scaleform.daapi.view.lobby.hangar.AmmunitionPanel import AmmunitionPanel
    RegisterEvent(AmmunitionPanel, 'highlightParams', AmmunitionPanel_highlightParams)

    from BattleReplay import g_replayCtrl
    g_replayCtrl._BattleReplay__replayCtrl.clientVersionDiffersCallback = onClientVersionDiffers

    from account_helpers.BattleResultsCache import BattleResultsCache
    OverrideMethod(BattleResultsCache, 'get', BattleResultsCache_get)

    from gui.Scaleform.daapi.view.meta.WaitingViewMeta import WaitingViewMeta
    OverrideMethod(WaitingViewMeta, 'showS', WaitingViewMeta_fix)
    OverrideMethod(WaitingViewMeta, 'hideS', WaitingViewMeta_fix)

    # import account_helpers.CustomFilesCache as cache
    # cache._MIN_LIFE_TIME = 15
    # cache._MAX_LIFE_TIME = 24
    # from account_helpers.CustomFilesCache import CustomFilesCache, WorkerThread
    # OverrideMethod(CustomFilesCache, '_CustomFilesCache__get', _CustomFilesCache__get)
    # OverrideMethod(CustomFilesCache, '_CustomFilesCache__readLocalFile', _CustomFilesCache__readLocalFile)
    # OverrideMethod(CustomFilesCache, '_CustomFilesCache__onReadLocalFile', _CustomFilesCache__onReadLocalFile)
    # OverrideMethod(CustomFilesCache, '_CustomFilesCache__checkFile', _CustomFilesCache__checkFile)
    # OverrideMethod(CustomFilesCache, '_CustomFilesCache__onCheckFile', _CustomFilesCache__onCheckFile)
    # OverrideMethod(CustomFilesCache, '_CustomFilesCache__readRemoteFile', _CustomFilesCache__readRemoteFile)
    # OverrideMethod(CustomFilesCache, '_CustomFilesCache__onReadRemoteFile', _CustomFilesCache__onReadRemoteFile)
    # OverrideMethod(CustomFilesCache, '_CustomFilesCache__prepareCache', _CustomFilesCache__prepareCache)
    # OverrideMethod(CustomFilesCache, '_CustomFilesCache__writeCache', _CustomFilesCache__writeCache)
    # OverrideMethod(CustomFilesCache, '_CustomFilesCache__onWriteCache', _CustomFilesCache__onWriteCache)
    # OverrideMethod(CustomFilesCache, '_CustomFilesCache__postTask', _CustomFilesCache__postTask)
    # OverrideMethod(CustomFilesCache, '_CustomFilesCache__onPostTask', _CustomFilesCache__onPostTask)
    # OverrideMethod(WorkerThread, '_WorkerThread__run_download', _WorkerThread__run_download)

BigWorld.callback(0, _RegisterEvents)


#####################################################################
# Log version info

log("xvm %s (%s) for WoT %s" % (XFW_MOD_VERSION, XFW_MOD_URL, ", ".join(XFW_GAME_VERSIONS)))
try:
    from __version__ import __branch__, __revision__
    log("Branch: %s, Revision: %s" % (__branch__, __revision__))
except Exception, ex:
    err(traceback.format_exc())
