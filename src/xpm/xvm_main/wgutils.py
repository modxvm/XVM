""" XVM (c) https://modxvm.com 2013-2020 """

import traceback

from gui.Scaleform.framework import ViewTypes
from gui.Scaleform.framework.managers.containers import POP_UP_CRITERIA
from gui.Scaleform.daapi.settings.views import VIEW_ALIAS
from gui.prb_control.events_dispatcher import g_eventDispatcher
from helpers import dependency
from skeletons.gui.shared.utils import IHangarSpace

from xfw import *


# reload hangar to apply config changes
def reloadHangar():
    try:
        hangarSpace = dependency.instance(IHangarSpace)
        if hangarSpace.inited:
            lobby = getLobbyApp()
            if lobby and lobby.containerManager:
                view = lobby.containerManager.getView(ViewTypes.LOBBY_SUB, {POP_UP_CRITERIA.VIEW_ALIAS: VIEW_ALIAS.LOBBY_HANGAR})
                if view is not None:
                    view.destroy()
                g_eventDispatcher.loadHangar()
    except Exception, ex:
        err(traceback.format_exc())
