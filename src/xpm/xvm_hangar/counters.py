""" XVM (c) https://modxvm.com 2013-2018 """

import traceback

from gui.Scaleform.daapi.view.lobby.header.LobbyHeader import LobbyHeader

from xfw import *
from xvm_main.python.logger import *
import xvm_main.python.config as config

@overrideMethod(LobbyHeader, '_LobbyHeader__setCounter')
def _LobbyHeader__setCounter(base, self, alias, counter=None):
    if config.get('hangar/notificationCounter/{0}'.format(alias), True):
        base(self, alias, counter)
