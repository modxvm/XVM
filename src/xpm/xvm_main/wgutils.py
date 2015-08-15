""" XVM (c) www.modxvm.com 2013-2015 """

import BigWorld

# reload hangar to apply config changes
def reloadHangar():
    from gui.shared import g_eventBus, events
    from gui.app_loader.loader import g_appLoader
    from gui.Scaleform.framework import ViewTypes
    from gui.Scaleform.daapi.settings.views import VIEW_ALIAS
    from gui.prb_control.events_dispatcher import g_eventDispatcher
    app = g_appLoader.getDefLobbyApp()
    if app and app.containerManager:
        container = app.containerManager.getContainer(ViewTypes.LOBBY_SUB)
        if container:
            view = container.getView()
            if view and view.alias == VIEW_ALIAS.LOBBY_HANGAR:
                container.remove(view)
            g_eventDispatcher.loadHangar()
