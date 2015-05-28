""" XVM (c) www.modxvm.com 2013-2015 """

#####################################################################
# MOD INFO

XFW_MOD_INFO = {
    # mandatory
    'VERSION':       '3.1.0',
    'URL':           'http://www.modxvm.com/',
    'UPDATE_URL':    'http://www.modxvm.com/en/download-xvm/',
    'GAME_VERSIONS': ['0.9.8'],
    # optional
}

#####################################################################

import BigWorld
from xfw import *
from xvm_main.python.logger import *


# TODO: remove after swf preloading refactoring
def hide_exception(base, self, *args):
    try:
        base(self, *args)
    except Exception, ex:
        log('[XVM][hide_exception]: %s throwed exception: %s' % (base.__name__, ex.message))


# Delayed registration
def _RegisterEvents():
    from gui.Scaleform.daapi.view.meta.WaitingViewMeta import WaitingViewMeta
    OverrideMethod(WaitingViewMeta, 'showS', hide_exception)
    OverrideMethod(WaitingViewMeta, 'hideS', hide_exception)

    from gui.Scaleform.framework.entities.abstract.ContainerManagerMeta import ContainerManagerMeta
    OverrideMethod(ContainerManagerMeta, 'as_showS', hide_exception)

BigWorld.callback(0, _RegisterEvents)
