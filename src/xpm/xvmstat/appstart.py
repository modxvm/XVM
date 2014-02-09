""" xvm (c) sirmax 2013-2014 """

from gui.Scaleform.framework import g_entitiesFactories, ViewSettings, ViewTypes, ScopeTemplates
from gui.Scaleform.framework.entities.View import View

from logger import *

_alias = 'xvm'
_url = '../../../xvm/mods/xvm.swf'
_viewType = ViewTypes.SERVICE_LAYOUT
_scopeTemplate = ScopeTemplates.GLOBAL_SCOPE
_settings = ViewSettings(_alias, View, _url, _viewType, None, _scopeTemplate)
g_entitiesFactories.addSettings(_settings)

def AppStarted(self, event):
    #debug('AppStarted')
    self.loadView(_alias)
