""" fix waiting bug (c) www.modxvm.com 2014 """

#####################################################################
# MOD INFO (mandatory)

XFW_MOD_VERSION    = "0.3"
XFW_MOD_URL        = "http://www.koreanrandom.com/forum/topic/11630-/#entry151768"
XFW_MOD_UPDATE_URL = ""
XFW_GAME_VERSIONS  = ["0.9.3","0.9.4","0.9.5"]

#####################################################################

from xfw import *

def WaitingViewMeta_fix(base, self, *args):
    try:
        base(self, *args)
        #raise Exception('Test')
    except Exception, ex:
        log('[XVM][Waiting fix]: %s throwed exception: %s' % (base.__name__, ex.message))

def _Register():
    from gui.Scaleform.daapi.view.meta.WaitingViewMeta import WaitingViewMeta
    OverrideMethod(WaitingViewMeta, 'showS', WaitingViewMeta_fix)
    OverrideMethod(WaitingViewMeta, 'hideS', WaitingViewMeta_fix)

BigWorld.callback(0.001, _Register)
