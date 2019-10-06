"""
This file is part of the XVM Framework project.

Copyright (c) 2018-2019 XVM Team.

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

import imp
import os
import traceback
import sys

from xfw.constants import PATH

_filewatcher_native = None

def _native_load():
    """
    Loads FileWatcher C Python extension.

    Do not use this function directly.
    """
    try:
        global _filewatcher_native
        if _filewatcher_native is None:
            
            if "python27" not in sys.modules:
                return False

            path_realfs = PATH.XFWLOADER_PACKAGES_REALFS + '/xfw_filewatcher/native/xfw_filewatcher.pyd'
            path_vfs = PATH.XFWLOADER_PACKAGES_VFS + '/xfw_filewatcher/native/xfw_filewatcher.pyd'

            if os.path.isfile(path_realfs):
                _filewatcher_native = imp.load_dynamic('XFW_FileWatcher', path_realfs)
            else:
                import xfw.vfs as vfs
                _filewatcher_native = vfs.c_extension_load('XFW_FileWatcher', path_vfs, 'com.modxvm.xfw.filewatcher')

        return True
    except Exception:
        print "[XFW/FileWatcher][_native_load] Error when loading native library:"
        traceback.print_exc()
        print "======================="
        return False

def watcher_is_exists(watcher_id):
    """
    Checks if watcher exists

    usage: watcher_is_exists(<watcher_id>):
        watcher_id      : watcher ID

    returns: True/False
    """
    try:
        if not _native_load():
            return
        return _filewatcher_native.watcher_is_exists(watcher_id)
    except Exception:
        print "[XFW/FileWatcher][watcher_is_exists] Error:"
        traceback.print_exc()
        print "======================="


def watcher_is_running(watcher_id):
    """
    Checks if watcher is running

    usage: watcher_is_running(<watcher_id>):
        watcher_id      : watcher ID

    returns: True/False
    """
    try:
        if not _native_load():
            return
        return _filewatcher_native.watcher_is_running(watcher_id)
    except Exception:
        print "[XFW/FileWatcher][watcher_is_running] Error:"
        traceback.print_exc()
        print "======================="


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
        if not _native_load():
            return
        _filewatcher_native.watcher_add(watcher_id, unicode(directory_path), event_call_text, stop_after_event)
    except Exception:
        print "[XFW/FileWatcher][watcher_add] Error:"
        traceback.print_exc()
        print "======================="


def watcher_delete(watcher_id):
    """
    Deletes directory watcher

    usage: watcher_delete(<watcher_id>):
        watcher_id      : watcher ID
    """
    try:
        if not _native_load():
            return
        _filewatcher_native.watcher_delete(watcher_id)
    except Exception:
        print "[XFW/FileWatcher][watcher_delete] Error:"
        traceback.print_exc()
        print "======================="


def watcher_delete_all(watcher_id):
    """
    Deletes all directory watcher

    usage: watcher_delete_all(<watcher_id>):
        watcher_id      : watcher ID
    """
    try:
        if not _native_load():
            return
        _filewatcher_native.watcher_delete_all(watcher_id)
    except Exception:
        print "[XFW/FileWatcher][watcher_delete_all] Error:"
        traceback.print_exc()
        print "======================="


def watcher_start(watcher_id):
    """
    Starts directory watcher

    usage: watcher_start(<watcher_id>):
        watcher_id      : watcher ID
    """
    try:
        if not _native_load():
            return
        _filewatcher_native.watcher_start(watcher_id)
    except Exception:
        print "[XFW/FileWatcher][watcher_start] Error:"
        traceback.print_exc()
        print "======================="


def watcher_start_all():
    """
    Starts all directory watchers

    usage: watcher_start_all():
    """
    try:
        if not _native_load():
            return
        _filewatcher_native.watcher_start_all()
    except Exception:
        print "[XFW/FileWatcher][watcher_start_all] Error:"
        traceback.print_exc()
        print "======================="


def watcher_stop(watcher_id):
    """
    Stops directory watcher

    usage: watcher_stop(<watcher_id>):
        watcher_id      : watcher ID
    """
    try:
        if not _native_load():
            return
        _filewatcher_native.watcher_stop(watcher_id)
    except Exception:
        print "[XFW/FileWatcher][watcher_stop] Error:"
        traceback.print_exc()
        print "======================="


def watcher_stop_all():
    """
    Stops all directory watchers

    usage: watcher_stop_all():
    """
    try:
        if not _native_load():
            return
        _filewatcher_native.watcher_stop_all()
    except Exception:
        print "[XFW/FileWatcher][watcher_stop_all] Error:"
        traceback.print_exc()
        print "======================="
