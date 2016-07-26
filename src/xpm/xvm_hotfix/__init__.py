""" XVM (c) www.modxvm.com 2013-2016 """

#####################################################################
# MOD INFO

XFW_MOD_INFO = {
    # mandatory
    'VERSION':       '0.9.15.1',
    'URL':           'http://www.modxvm.com/',
    'UPDATE_URL':    'http://www.modxvm.com/en/download-xvm/',
    'GAME_VERSIONS': ['0.9.15.1'],
    # optional
}


#####################################################################
#imports

import BigWorld
from gui.Scaleform.framework.entities.abstract.ContainerManagerMeta import ContainerManagerMeta

from xfw import *

from xvm_main.python.logger import *


#####################################################################

import update_arenas_data
update_arenas_data.run()
