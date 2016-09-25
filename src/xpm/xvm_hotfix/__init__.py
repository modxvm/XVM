""" XVM (c) www.modxvm.com 2013-2016 """

#####################################################################
# MOD INFO

XFW_MOD_INFO = {
    # mandatory
    'VERSION':       '0.9.16',
    'URL':           'http://www.modxvm.com/',
    'UPDATE_URL':    'http://www.modxvm.com/en/download-xvm/',
    'GAME_VERSIONS': ['0.9.16'],
    # optional
}


#####################################################################
#imports

import BigWorld
from AvatarInputHandler import AvatarInputHandler
from gui.Scaleform.CursorDelegator import g_cursorDelegator
from gui.Scaleform.framework.entities.abstract.ContainerManagerMeta import ContainerManagerMeta

from xfw import *

from xvm_main.python.logger import *


#####################################################################

import update_arenas_data
update_arenas_data.run()

# cursor bug 0.9.15.1
@overrideMethod(AvatarInputHandler, 'setForcedGuiControlMode')
def _AvatarInputHandler_setForcedGuiControlMode(base, self, flags):
    base(self, flags)
    g_cursorDelegator._CursorDelegator__activated = self._AvatarInputHandler__isDetached
