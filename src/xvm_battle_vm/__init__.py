"""
SPDX-License-Identifier: GPL-3.0-or-later
Copyright (c) 2013-2025 XVM Contributors
"""

#
# OpenWG API
#

__initialized = False

def owg_module_init():
    global __initialized
    if not __initialized:
        import vehicleMarkers
        vehicleMarkers.init()

        import eventsAvatar
        eventsAvatar.init()

        import eventsBSDC
        eventsBSDC.init()

        import eventsMM
        eventsMM.init()

        __initialized = True


def owg_module_fini():
    global __initialized
    if __initialized:
        import vehicleMarkers
        vehicleMarkers.fini()

        import eventsAvatar
        eventsAvatar.fini()

        import eventsBSDC
        eventsBSDC.fini()

        import eventsMM
        eventsMM.fini()

        __initialized = False


def owg_module_loaded():
    global __initialized
    return __initialized


def owg_module_event(eventName, *args, **kwargs):
    pass
