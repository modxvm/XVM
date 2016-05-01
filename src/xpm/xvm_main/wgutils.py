""" XVM (c) www.modxvm.com 2013-2016 """

import BigWorld
from gui.shared import g_eventBus, events
from gui.Scaleform.framework import ViewTypes
from gui.Scaleform.daapi.settings.views import VIEW_ALIAS
from gui.prb_control.events_dispatcher import g_eventDispatcher

from xfw import *


# reload hangar to apply config changes
def reloadHangar():
    lobby = getLobbyApp()
    if lobby and lobby.containerManager:
        container = lobby.containerManager.getContainer(ViewTypes.LOBBY_SUB)
        if container:
            view = container.getView()
            if view and view.alias == VIEW_ALIAS.LOBBY_HANGAR:
                container.remove(view)
            g_eventDispatcher.loadHangar()
