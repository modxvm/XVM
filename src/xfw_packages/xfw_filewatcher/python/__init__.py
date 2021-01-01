"""
This file is part of the XVM Framework project.

Copyright (c) 2018-2021 XVM Team.

XVM Framework is free software: you can redistribute it and/or modify
it under the terms of the GNU Lesser General Public License as
published by the Free Software Foundation, version 3.

XVM Framework is distributed in the hope that it will be useful, but
WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License
along with this program. If not, see <http://www.gnu.org/licenses/>.
"""

#cpython
import logging

#xfw.loader
import xfw_loader.python as loader


__native = None


def watcher_is_exists(watcher_id):
    """
    Checks if watcher exists

    usage: watcher_is_exists(<watcher_id>):
        watcher_id      : watcher ID

    returns: True/False
    """
    try:
        if not __native:
            return None
        return __native.watcher_is_exists(watcher_id)
    except Exception:
        logging.exception("[XFW/FileWatcher][watcher_is_exists] Error:")


def watcher_is_running(watcher_id):
    """
    Checks if watcher is running

    usage: watcher_is_running(<watcher_id>):
        watcher_id      : watcher ID

    returns: True/False
    """
    try:
        if not __native:
            return None
        return __native.watcher_is_running(watcher_id)
    except Exception:
        logging.exception("[XFW/FileWatcher][watcher_is_running] Error:")


def watcher_add(watcher_id, directory_path, event_call_text, stop_after_event=False):
    """
    Adds new directory watcher

    usage: watcher_add(<watcher_id>, <directory_path>, <event_call_text>, <stop_after_event>):
        watcher_id      : watcher ID
        directory_path  : string with directory path
        event_call_text : g_eventBus.handeEvent() function argument
        stop_after_event: stop watcher after event, False by default
    """
    try:
        if not __native:
            return None
        return __native.watcher_add(watcher_id, unicode(directory_path), event_call_text, stop_after_event)
    except Exception:
        logging.exception("[XFW/FileWatcher][watcher_add] Error:")


def watcher_delete(watcher_id):
    """
    Deletes directory watcher

    usage: watcher_delete(<watcher_id>):
        watcher_id      : watcher ID
    """
    try:
        if not __native:
            return None
        return __native.watcher_delete(watcher_id)
    except Exception:
        logging.exception("[XFW/FileWatcher][watcher_delete] Error:")


def watcher_delete_all(watcher_id):
    """
    Deletes all directory watcher

    usage: watcher_delete_all(<watcher_id>):
        watcher_id      : watcher ID
    """
    try:
        if not __native:
            return None
        return __native.watcher_delete_all(watcher_id)
    except Exception:
        logging.exception("[XFW/FileWatcher][watcher_delete_all] Error:")


def watcher_start(watcher_id):
    """
    Starts directory watcher

    usage: watcher_start(<watcher_id>):
        watcher_id      : watcher ID
    """
    try:
        if not __native:
            return None
        return __native.watcher_start(watcher_id)
    except Exception:
        logging.exception("[XFW/FileWatcher][watcher_start] Error:")


def watcher_start_all():
    """
    Starts all directory watchers

    usage: watcher_start_all():
    """
    try:
        if not __native:
            return None
        return __native.watcher_start_all()
    except Exception:
        logging.exception("[XFW/FileWatcher][watcher_start_all] Error:")


def watcher_stop(watcher_id):
    """
    Stops directory watcher

    usage: watcher_stop(<watcher_id>):
        watcher_id      : watcher ID
    """
    try:
        if not __native:
            return None
        return __native.watcher_stop(watcher_id)
    except Exception:
        logging.exception("[XFW/FileWatcher][watcher_stop] Error:")


def watcher_stop_all():
    """
    Stops all directory watchers

    usage: watcher_stop_all():
    """
    try:
        if not __native:
            return None
        return __native.watcher_stop_all()
    except Exception:
        logging.exception("[XFW/FileWatcher][watcher_stop_all] Error:")


def xfw_is_module_loaded():
    return __native is not None

def __init():
    global __native
    package_name = 'com.modxvm.xfw.filewatcher'

    try:
        xfwnative = loader.get_mod_module('com.modxvm.xfw.native')
        if not xfwnative:
            logging.error('[XFW/FileWatcher] Failed to load native module. XFW Native is not available')
            return

        if not xfwnative.unpack_native(package_name):
            logging.error('[XFW/FileWatcher] Failed to load native module. Failed to unpack native module')
            return

        __native = xfwnative.load_native(package_name, 'xfw_filewatcher.pyd', 'XFW_FileWatcher')
        if not __native:
            logging.error("[XFW/FileWatcher] Failed to load native module. Crash report were not enabled")
            return

    except Exception:
        logging.exception("[XFW/FileWatcher] Error when loading native library:")

__init()
