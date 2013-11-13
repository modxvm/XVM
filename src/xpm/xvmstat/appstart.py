""" xvm (c) sirmax 2013 """

from gui.Scaleform.framework import g_entitiesFactories, ViewSettings, VIEW_TYPE, VIEW_SCOPE
from gui.Scaleform.framework.entities.View import View

from logger import *

_alias = 'xvm'
_url = '../../../xvm/mods/xvm.swf'
_viewType = VIEW_TYPE.SERVICE_LAYOUT
_settings = ViewSettings(_alias, View, _url, _viewType, None, VIEW_SCOPE.GLOBAL)

g_entitiesFactories.addSettings(_settings)


def AppStarted(self, event):
    #debug('AppStarted')

    self.containerManager.onViewAddedToContainer += lambda container, pyView: \
        onViewAddedToContainer(self, container, pyView)

    self.loadView(_alias)


def onViewAddedToContainer(self, container, pyView):
    #debug("onViewAddedToContainer: " + pyView.settings.alias)
    if pyView.settings.alias == _alias:
        container = self.containerManager.getContainer(_viewType)
        if container is not None:
            container.remove(pyView)
