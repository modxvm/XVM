""" fix waiting bug (c) www.modxvm.com 2014 """

#####################################################################
# MOD INFO (mandatory)

XPM_MOD_VERSION    = "0.3"
XPM_MOD_URL        = "http://www.koreanrandom.com/forum/topic/11630-/#entry151768"
XPM_MOD_UPDATE_URL = ""
XPM_GAME_VERSIONS  = ["0.9.3","0.9.4","0.9.5"]

#####################################################################

from xpm import *

def WaitingViewMeta_fix(base, self, *args):
    try:
        base(self, *args)
        #raise Exception('Test')
    except Exception, ex:
        log('[XPM] kwg_waiting_fix: %s throwed exception: %s' % (base.__name__, ex.message))

def _Register():
    from gui.Scaleform.daapi.view.meta.WaitingViewMeta import WaitingViewMeta
    OverrideMethod(WaitingViewMeta, 'showS', WaitingViewMeta_fix)
    OverrideMethod(WaitingViewMeta, 'hideS', WaitingViewMeta_fix)

BigWorld.callback(0.001, _Register)
