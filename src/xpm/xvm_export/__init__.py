""" XVM (c) https://modxvm.com 2013-2021 """

#####################################################################
# imports

from Avatar import PlayerAvatar

from xfw import *
from xvm_main.python.logger import *

import fps


#####################################################################
# handlers

# on map load (battle loading)
@registerEvent(PlayerAvatar, 'onEnterWorld')
def PlayerAvatar_onEnterWorld(self, *args):
    fps.start()


# on map close
@registerEvent(PlayerAvatar, 'onLeaveWorld')
def PlayerAvatar_onLeaveWorld(self, *args):
    fps.stop()
