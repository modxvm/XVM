"""
SPDX-License-Identifier: GPL-3.0-or-later
Copyright (c) 2013-2025 XVM Contributors
"""

#
# Imports
#

# stdlib
import logging

# BigWorld
from gui.battle_control import avatar_getter
from gui.shared import g_eventBus
from PlayerEvents import g_playerEvents

# XFW
from xfw.constants import XFW_COMMAND

# XVM Battle
from xvm_battle.consts import XVM_BATTLE_COMMAND, XVM_BATTLE_EVENT

# XVM Battle XMQP
import xmqp
import xmqp_events  



#
# Handlers
#

def onAvatarBecomePlayer(*args, **kwargs):
    try:
        arena = avatar_getter.getArena()
        if arena:
            arena.onNewVehicleListReceived += xmqp.start
    except Exception:
        logging.getLogger('XVM/Battle/XMQP').exception('onAvatarBecomePlayer')


def onAvatarBecomeNonPlayer(*args, **kwargs):
    try:
        arena = avatar_getter.getArena()
        if arena:
            arena.onNewVehicleListReceived -= xmqp.start
        xmqp.stop()
    except Exception:
        logging.getLogger('XVM/Battle/XMQP').exception('onAvatarBecomeNonPlayer')


def onXfwCommand(cmd, *args):
    if cmd == XVM_BATTLE_COMMAND.XMQP_INIT:
        xmqp_events.onBattleInit()
        return (None, True)
    elif cmd == XVM_BATTLE_COMMAND.MINIMAP_CLICK:
        return (xmqp_events.send_minimap_click(args[0]), True)

    return (None, False)



#
# OpenWG API
#

__initialized = False

def owg_module_init():
    global __initialized
    if not __initialized:
        g_eventBus.addListener(XFW_COMMAND.XFW_CMD, onXfwCommand)
        g_eventBus.addListener(XVM_BATTLE_EVENT.XMQP_CONNECTED, xmqp_events.onXmqpConnected)
        g_eventBus.addListener(XVM_BATTLE_EVENT.XMQP_MESSAGE, xmqp_events.onXmqpMessage)
        g_playerEvents.onAvatarBecomePlayer += onAvatarBecomePlayer
        g_playerEvents.onAvatarBecomeNonPlayer += onAvatarBecomeNonPlayer
        __initialized = True
    

def owg_module_fini():
    global __initialized
    if __initialized:
        g_eventBus.removeListener(XFW_COMMAND.XFW_CMD, onXfwCommand)
        g_eventBus.removeListener(XVM_BATTLE_EVENT.XMQP_CONNECTED, xmqp_events.onXmqpConnected)
        g_eventBus.removeListener(XVM_BATTLE_EVENT.XMQP_MESSAGE, xmqp_events.onXmqpMessage)
        g_playerEvents.onAvatarBecomePlayer -= onAvatarBecomePlayer
        g_playerEvents.onAvatarBecomeNonPlayer -= onAvatarBecomeNonPlayer
        __initialized = False


def owg_module_loaded():
    global __initialized
    return __initialized


def owg_module_event(eventName, *args, **kwargs):
    pass
