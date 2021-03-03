"""
This file is part of the XVM Framework project.

Copyright (c) 2017 Andrey Andruschyshyn.
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

import os
import traceback

from ResMgr import openSection, isDir, isFile

def file_exists(vfs_path):
    """
    Check file exists in VFS

    vfs_path: path in VFS, for example, 'gui/flash/battle.swf'
    """
    vfs_file = openSection(vfs_path)
    return vfs_file is not None and isFile(vfs_path)

def file_read(vfs_path, as_binary=True):
    """
    Reads file from VFS

    vfs_path: path in VFS, for example, 'scripts/client/gui/mods/mod_.pyc'
    as_binary: set to True if file is binary
    """
    vfs_file = openSection(vfs_path)
    if vfs_file is not None and isFile(vfs_path):
        if as_binary:
            return str(vfs_file.asBinary)
        else:
            return str(vfs_file.asString)
    return None

def file_copy(vfs_path, realfs_path):
    """
    Copy file from VFS to RealFS

    vfs_path: path to file in VFS relative to root
    realfs_path: path to file in RealFS relative to WorldOfTanks.exe or absolute path

    returns True if copy was successful
    """

    try:
        try:
            realfs_dir = os.path.dirname(realfs_path)
            if not os.path.exists(realfs_dir):
                os.makedirs(realfs_dir)
        except Exception:
            pass

        vfs_data = file_read(vfs_path)
        if vfs_data:
            try:
                with open(realfs_path, 'wb') as realfs_file:
                    realfs_file.write(vfs_data)
            except IOError, e:
                import errno
                if e.errno == errno.EACCES: #permission error i.e. file in use
                    pass
        else:
            return False
    except Exception:
        print "[XFW/VFS][file_copy] Error on file copy:"
        traceback.print_exc()
        print "============================="
        return False

    return True

def directory_exists(vfs_path):
    """
    Check if directory exists in VFS

    vfs_path: path in VFS, for example, 'gui/flash/'
    """
    vfs_file = openSection(vfs_path)
    return vfs_file is not None and isDir(vfs_path)

def directory_list(vfs_path):
    """
    Lists files in directory from VFS

    vfs_path: path in VFS, for example, 'scripts/client/gui/mods/'
    """
    result = []
    folder = openSection(vfs_path)
    if folder is not None and isDir(vfs_path):
        for name in folder.keys():
            if name not in result:
                result.append(name)
    return sorted(result)

def directory_list_subdirs(vfs_path):
    """
    Lists subdirectories in directory from VFS

    vfs_path: path in VFS, for example, 'scripts/client/gui/mods/'
    """
    vfs_path = vfs_path.rstrip('/')

    result = []
    folder = openSection(vfs_path)
    if folder is not None and isDir(vfs_path):
        for name in folder.keys():
            if (name not in result) and (isDir(vfs_path + '/' + name)):
                result.append(name)
    return sorted(result)

def directory_list_files(vfs_path, full_paths = False):
    """
    Lists files in directory from VFS

    vfs_path  : path in VFS, for example, 'scripts/client/gui/mods/'
    full_paths: set to True to get full VFS paths instead of file names
    """
    vfs_path = vfs_path.rstrip('/')

    result = []
    folder = openSection(vfs_path)
    if folder is not None and isDir(vfs_path):
        for name in folder.keys():
            if (name not in result) and (isFile(vfs_path + '/' + name)):
                if full_paths:
                    result.append(vfs_path + '/' + name)
                else:
                    result.append(name)
    return sorted(result)

def directory_copy(vfs_path, realfs_path, recursive=True):
    """
    Copy files to RealFS directory from VFS directory

    vfs_path: path to file in VFS relative to root
    realfs_path: path to file in RealFS relative to WorldOfTanks.exe or absolute path
    recursive: set to False to disable recursive copy
    """
    vfs_path = vfs_path.rstrip('/')

    folder = openSection(vfs_path)
    try:
        if folder is not None and isDir(vfs_path):
            for key in folder.keys():
                if isDir(vfs_path + '/' + key) and recursive is True:
                    directory_copy(vfs_path + '/' + key, realfs_path + '/' + key, recursive)
                if isFile(vfs_path + '/' + key):
                    file_copy(vfs_path + '/' + key, realfs_path + '/' + key)
        return True
    except Exception:
        print "[XFW/VFS][directory_copy] Error on directory copy:"
        traceback.print_exc()
        print "================="
        return False

