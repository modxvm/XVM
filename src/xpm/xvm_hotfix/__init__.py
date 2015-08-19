""" XVM (c) www.modxvm.com 2013-2015 """

#####################################################################
# MOD INFO

XFW_MOD_INFO = {
    # mandatory
    'VERSION':       '3.1.0',
    'URL':           'http://www.modxvm.com/',
    'UPDATE_URL':    'http://www.modxvm.com/en/download-xvm/',
    'GAME_VERSIONS': ['0.9.9','0.9.10'],
    # optional
}


#####################################################################
#imports

import BigWorld
from gui.Scaleform.framework.entities.abstract.ContainerManagerMeta import ContainerManagerMeta

from xfw import *

from xvm_main.python.logger import *


#####################################################################
# handlers

# TODO: remove after swf preloading refactoring
#@overrideMethod(ContainerManagerMeta, 'as_showS')
def hide_exception(base, self, *args):
    try:
        base(self, *args)
    except Exception, ex:
        log('[XVM][hide_exception]: %s throwed exception: %s' % (base.__name__, ex.message))
