"""
SPDX-License-Identifier: GPL-3.0-or-later
Copyright (c) 2013-2025 XVM Contributors
"""

#
# Imports
#

# BigWorld
from messenger.gui.Scaleform.data.ChannelsCarouselHandler import ChannelsCarouselHandler

# XFW
from xfw import *

# XVM.Main
import xvm_main.config as config
from xvm_main.logger import *



#
# Handlers
#

def _ChannelsCarouselHandler_addChannel(base, self, channel, lazy=False, isNotified=False):
    if not config.get('hangar/allowChannelButtonBlinking', True):
        isNotified = False
    base(self, channel, lazy, isNotified)


def _ChannelsCarouselHandler__setItemField(base, self, clientID, key, value):
    if not config.get('hangar/allowChannelButtonBlinking', True) and key == 'isNotified':
        value = False
    return base(self, clientID, key, value)



#
# Submodule lifecycle
#

def init():
    overrideMethod(ChannelsCarouselHandler, 'addChannel')(_ChannelsCarouselHandler_addChannel)
    overrideMethod(ChannelsCarouselHandler, '_ChannelsCarouselHandler__setItemField')(_ChannelsCarouselHandler__setItemField)


def fini():
    pass
