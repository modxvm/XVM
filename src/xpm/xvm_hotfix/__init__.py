"""
This file is part of the XVM project.

Copyright (c) 2013-2018 XVM Team

XVM is free software: you can redistribute it and/or modify
it under the terms of the GNU Lesser General Public License as
published by the Free Software Foundation, version 3.

XVM is distributed in the hope that it will be useful, but
WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License
along with this program. If not, see <http://www.gnu.org/licenses/>.
"""

#####################################################################
# imports

import traceback
from xfw import *
from xvm_main.python.logger import *


#####################################################################
# fix WG's bug with markers appearing in the top corner on battle start
# https://koreanrandom.com/forum/topic/32423-/page-86#entry395145

import BigWorld
from gui.Scaleform.daapi.view.battle.shared.markers2d.manager import MarkersManager

markersVisibleCallbackID = None

def _set_canvas_visible_true(self):
    global markersVisibleCallbackID
    markersVisibleCallbackID = None
    self.movie.visible = True

@overrideMethod(MarkersManager, 'createMarker')
def _MarkersManager_createMarker(base, self, *args, **kwargs):
    global markersVisibleCallbackID
    self.movie.visible = False
    if markersVisibleCallbackID is not None:
        BigWorld.cancelCallback(markersVisibleCallbackID)
    markersVisibleCallbackID = BigWorld.callback(0, lambda: _set_canvas_visible_true(self))
    return base(self, *args, **kwargs)


######################

from account_helpers.CustomFilesCache import CustomFilesCache
@overrideMethod(CustomFilesCache, '_CustomFilesCache__onReadLocalFile')
def _CustomFilesCache__onReadLocalFile(base, self, url, showImmediately):
    try:
        base(self, url, showImmediately)
    except Exception:
        err('CustomFilesCache.__onReadLocalFile: url="{0}", showImmediately={1}'.format(url, showImmediately))
        err(traceback.format_exc())
