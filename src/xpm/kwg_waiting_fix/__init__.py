""" fix 0.8.11 waiting bug (c) sirmax 2014 """

#####################################################################
# MOD INFO (mandatory)

XPM_MOD_VERSION    = "0.1"
XPM_MOD_URL        = "http://www.koreanrandom.com/forum/topic/11630-/#entry151768"
XPM_MOD_UPDATE_URL = ""
XPM_GAME_VERSIONS  = ["0.8.11"]

#####################################################################

from gui.mods.xpm import *

def WaitingView_close(base, self):
    #log('WaitingView_close')
    try:
        base(self)
    except:
        logtrace(__file__)

def _Register():
    from gui.Scaleform.framework.WaitingView import WaitingView
    OverrideMethod(WaitingView, 'close', WaitingView_close)

BigWorld.callback(0.001, _Register)
