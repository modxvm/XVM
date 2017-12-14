""" XVM (c) https://modxvm.com 2013-2017 """

#####################################################################
# imports

from xfw import *
from xvm_main.python.logger import *


from gui.shared import EVENT_BUS_SCOPE
from gui.shared.events import AppLifeCycleEvent, GameEvent, DirectLoadViewEvent
from gui.Scaleform.Flash import Flash
from gui.Scaleform.framework.application import SFApplication

@overrideMethod(SFApplication, 'beforeDelete')
def SFApplication_beforeDelete(base, self):
    log('SFApplication_beforeDelete: start')
    self._SFApplication__viewEventsListener.destroy()
    log('SFApplication_beforeDelete: 1')
    self.removeListener(GameEvent.CHANGE_APP_RESOLUTION, self._SFApplication__onAppResolutionChanged, scope=EVENT_BUS_SCOPE.GLOBAL)
    log('SFApplication_beforeDelete: 2')
    self._removeGameCallbacks()
    log('SFApplication_beforeDelete: 3')
    if self._containerMgr is not None:
        self._containerMgr.destroy()
        self._containerMgr = None
    log('SFApplication_beforeDelete: 4')
    if self._loaderMgr is not None:
        self._loaderMgr.destroy()
        self._loaderMgr = None
    log('SFApplication_beforeDelete: 5')
    if self._cacheMgr is not None:
        self._cacheMgr.destroy()
        self._cacheMgr = None
    log('SFApplication_beforeDelete: 6')
    if self._contextMgr is not None:
        self._contextMgr.destroy()
        self._contextMgr = None
    log('SFApplication_beforeDelete: 7')
    if self._popoverManager is not None:
        self._popoverManager.destroy()
        self._popoverManager = None
    log('SFApplication_beforeDelete: 8')
    if self._soundMgr is not None:
        self._soundMgr.destroy()
        self._soundMgr = None
    log('SFApplication_beforeDelete: 9')
    if self._varsMgr is not None:
        self._varsMgr.destroy()
        self._varsMgr = None
    log('SFApplication_beforeDelete: 10')
    if self._toolTip is not None:
        self._toolTip.destroy()
        self._toolTip = None
    log('SFApplication_beforeDelete: 11')
    if self._colorSchemeMgr is not None:
        self._colorSchemeMgr.destroy()
        self._colorSchemeMgr = None
    log('SFApplication_beforeDelete: 12')
    if self._eventLogMgr is not None:
        self._eventLogMgr.destroy()
        self._eventLogMgr = None
    log('SFApplication_beforeDelete: 13')
    if self._tweenMgr is not None:
        self._tweenMgr.destroy()
        self._tweenMgr = None
    log('SFApplication_beforeDelete: 14')
    if self._voiceChatMgr is not None:
        self._voiceChatMgr.destroy()
        self._voiceChatMgr = None
    log('SFApplication_beforeDelete: 15')
    if self._gameInputMgr is not None:
        self._gameInputMgr.destroy()
        self._gameInputMgr = None
    log('SFApplication_beforeDelete: 16')
    if self._utilsMgr is not None:
        self._utilsMgr.destroy()
        self._utilsMgr = None
    log('SFApplication_beforeDelete: 17')
    if self._tutorialMgr is not None:
        self._tutorialMgr.destroy()
        self._tutorialMgr = None
    log('SFApplication_beforeDelete: 18')
    if self._bootcampMgr is not None:
        self._bootcampMgr.destroy()
        self._bootcampMgr = None
    log('SFApplication_beforeDelete: 19')
    if self._SFApplication__daapiBridge is not None:
        self._SFApplication__daapiBridge.clear()
        self._SFApplication__daapiBridge = None
    log('SFApplication_beforeDelete: 20')
    if self._imageManager is not None:
        self._imageManager.destroy()
        self._imageManager = None
    log('SFApplication_beforeDelete: 21')
    super(SFApplication, self).beforeDelete()
    self.proxy = None
    log('SFApplication_beforeDelete: 22')
    self.fireEvent(AppLifeCycleEvent(self._SFApplication__ns, AppLifeCycleEvent.DESTROYED))
    log('SFApplication_beforeDelete: end')

@overrideMethod(Flash, 'beforeDelete')
def Flash_beforeDelete(base, self):
    log('Flash_beforeDelete: %s' % str(self))
    self.removeAllCallbacks()
    log('Flash_beforeDelete: 1')
    self._Flash__fsCbs.clear()
    log('Flash_beforeDelete: 2')
    self._Flash__exCbs.clear()
    log('Flash_beforeDelete: 3')
    self.flashSize = None
    log('Flash_beforeDelete: 4')
    del self.component
    log('Flash_beforeDelete: end')
    return


#####################################################################
# fix WG's bug with markers appearing in the top corner on battle start
# https://koreanrandom.com/forum/topic/32423-/page-86#entry395145

import BigWorld
from gui.Scaleform.daapi.view.battle.shared.markers2d.manager import MarkersManager

markersVisibleCallbackID = None

@overrideMethod(MarkersManager, 'createMarker')
def _MarkersManager_createMarker(base, self, *args, **kwargs):
    global markersVisibleCallbackID
    self.movie.visible = False
    if markersVisibleCallbackID is not None:
        BigWorld.cancelCallback(markersVisibleCallbackID)
    markersVisibleCallbackID = BigWorld.callback(0, lambda: _set_canvas_visible_true(self))
    return base(self, *args, **kwargs)

def _set_canvas_visible_true(self):
    global markersVisibleCallbackID
    markersVisibleCallbackID = None
    self.movie.visible = True

#####################################################################
# Restart client without mods for bootcamp mode
"""
from gui.Scaleform.daapi.view.lobby.LobbyMenu import LobbyMenu
@overrideMethod(LobbyMenu,'bootcampClick')
def LobbyMenu_bootcampClick(base, self):
    if not self.bootcamp.isInBootcamp():
        from gui.Scaleform.daapi.view.dialogs import SimpleDialogMeta, I18nConfirmDialogButtons
        from gui.DialogsInterface import showDialog
        from xvm_main.python.xvm import l10n
        showDialog(SimpleDialogMeta(l10n("bootcamp_workaround_title"), l10n("bootcamp_workaround_message"), I18nConfirmDialogButtons()), LobbyMenu_bootcampClick_dialogAction)

def LobbyMenu_bootcampClick_dialogAction(result):
    if result:
        from xfw.mutex import restart_without_mods
        restart_without_mods()

from helpers import dependency
from skeletons.gui.game_control import IBootcampController
from xvm_main.python.xvm import Xvm
@registerEvent(Xvm, 'hangarInit')
def onHangarInit(self):
    bootcampController = dependency.instance(IBootcampController)
    if bootcampController.isInBootcamp():
        bootcampController.stopBootcamp(False)
"""
#####################################################################
