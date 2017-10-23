""" XVM (c) https://modxvm.com 2013-2017 """

#####################################################################
# MOD INFO

XFW_MOD_INFO = {
    # mandatory
    'VERSION':       '0.9.20.1',
    'URL':           'https://modxvm.com/',
    'UPDATE_URL':    'https://modxvm.com/en/download-xvm/',
    'GAME_VERSIONS': ['0.9.20.1'],
    # optional
}


#####################################################################
# imports

from xfw import *
from xvm_main.python.logger import *


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
