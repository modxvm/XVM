""" XVM (c) www.modxvm.com 2013-2017 """

#####################################################################
# MOD INFO

XFW_MOD_INFO = {
    # mandatory
    'VERSION':       '0.9.19.1',
    'URL':           'http://www.modxvm.com/',
    'UPDATE_URL':    'http://www.modxvm.com/en/download-xvm/',
    'GAME_VERSIONS': ['0.9.19.1'],
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
# Disable bootcamp button

from gui.Scaleform.daapi.view.lobby.LobbyMenu import LobbyMenu

@overrideMethod(LobbyMenu,'_populate')
def LobbyMenu__populate(base, self):
    base(self)
    if not self.bootcamp.isInBootcamp():
        self.as_showBootcampButtonS(False)

#####################################################################
